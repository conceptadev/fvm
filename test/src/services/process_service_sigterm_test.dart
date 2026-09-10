import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fvm/src/models/config_model.dart';
import 'package:fvm/src/services/process_service.dart';
import 'package:fvm/src/utils/context.dart';
import 'package:fvm/src/utils/exceptions.dart';
import 'package:fvm/src/workflows/run_configured_flutter.workflow.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

const _roleKey = 'FVM_SIGTERM_TEST_ROLE';
const _directoryKey = 'FVM_SIGTERM_TEST_DIRECTORY';

// A real non-TTY parent exercises the production inherited-stdio path, which
// TestFactory's test context intentionally bypasses.
Future<void> main() async {
  final role = Platform.environment[_roleKey];
  if (role == 'parent') {
    await _runParent();
    return;
  }
  if (role == 'child') {
    await _runChild();
    return;
  }

  for (final useFallback in [false, true]) {
    group(useFallback ? 'system PATH fallback' : 'direct process', () {
      for (final terminate in [true, false]) {
        test(
          terminate
              ? 'SIGTERM to a non-TTY parent reaches its child and waits for cleanup'
              : 'normal inherited-stdio exit releases signal listeners and preserves status',
          () async {
            final directory =
                await Directory.systemTemp.createTemp('fvm_sigterm_');
            final parent = await Process.start(
              Platform.resolvedExecutable,
              [
                p.join(Directory.current.path,
                    'test/src/services/process_service_sigterm_test.dart')
              ],
              environment: {
                ...Platform.environment,
                _roleKey: 'parent',
                _directoryKey: directory.path,
                'FVM_SIGTERM_TEST_COMPLETE': '${!terminate}',
                'FVM_SIGTERM_TEST_FALLBACK': '$useFallback',
              },
            );
            final diagnostics = StringBuffer();
            final ready = Completer<int>();
            final output = parent.stdout
                .transform(utf8.decoder)
                .transform(const LineSplitter())
                .listen((line) {
              diagnostics.writeln(line);
              if (line.startsWith('CHILD_READY:') && !ready.isCompleted) {
                ready
                    .complete(int.parse(line.substring('CHILD_READY:'.length)));
              }
            });
            final errors =
                parent.stderr.transform(utf8.decoder).listen(diagnostics.write);
            int? childPid;
            var childExited = false;
            try {
              parent.stdin.writeln('fixture input');
              await parent.stdin.flush();
              childPid =
                  await ready.future.timeout(const Duration(seconds: 20));
              if (terminate) expect(parent.kill(ProcessSignal.sigterm), isTrue);
              final code =
                  await parent.exitCode.timeout(const Duration(seconds: 10));
              expect(code, terminate ? 143 : 7, reason: diagnostics.toString());
              expect(
                await File(p.join(directory.path, 'events')).readAsLines(),
                [
                  'child cleanup',
                  terminate ? 'parent exit 143' : 'parent result 7'
                ],
              );
              childExited = true;
              expect(diagnostics.toString(), contains('PARENT_NON_TTY:true'));
              expect(diagnostics.toString(), contains('CHILD_STDERR'));
              expect(diagnostics.toString(),
                  contains('CHILD_STDIN:fixture input'));
              if (terminate) {
                expect(diagnostics.toString(),
                    isNot(contains('WORKFLOW_CONTINUED')));
              }
            } finally {
              // Also clean up when run against the broken implementation: only the
              // fixture child whose PID was recorded by this test may be signalled.
              final pidFile = File(p.join(directory.path, 'child.pid'));
              final child = childPid ??
                  (await pidFile.exists()
                      ? int.parse(await pidFile.readAsString())
                      : null);
              if (child != null && !childExited) {
                Process.killPid(child, ProcessSignal.sigkill);
              }
              parent.kill(ProcessSignal.sigkill);
              await parent.exitCode;
              await output.cancel();
              await errors.cancel();
              await directory.delete(recursive: true);
            }
          },
          skip: Platform.isWindows && terminate
              ? 'POSIX SIGTERM required'
              : false,
          timeout: const Timeout(Duration(minutes: 1)),
        );
      }
    });
  }
}

Future<void> _runParent() async {
  final directory = Platform.environment[_directoryKey]!;
  final separator = Platform.isWindows ? ';' : ':';
  final context = FvmContext.create(
    configOverrides: AppConfig(
      cachePath: p.join(directory, 'cache'),
      gitCachePath: p.join(directory, 'cache.git'),
      useGitCache: false,
      privilegedAccess: false,
      disableUpdateCheck: true,
    ),
    appConfigPath: p.join(directory, 'config.json'),
    workingDirectoryOverride: directory,
    environmentOverrides: {
      _roleKey: 'child',
      'PATH': '${p.dirname(Platform.resolvedExecutable)}$separator'
          '${Platform.environment['PATH'] ?? ''}',
    },
    isTest: false,
  );
  stdout.writeln('PARENT_NON_TTY:${!context.stdinHasTerminal}');
  try {
    final command = p.basename(Platform.resolvedExecutable);
    final args = [Platform.script.toFilePath()];
    final result = Platform.environment['FVM_SIGTERM_TEST_FALLBACK'] == 'true'
        ? await RunConfiguredFlutterWorkflow(context).call(command, args: args)
        : await context.get<ProcessService>().run(
              command,
              args: args,
              environment: context.environment,
              echoOutput: true,
              throwOnError: false,
            );
    stdout.writeln('WORKFLOW_CONTINUED');
    await File(p.join(directory, 'events')).writeAsString(
      'parent result ${result.exitCode}\n',
      mode: FileMode.append,
    );
    exitCode = result.exitCode;
  } on ForceExit catch (error) {
    await File(p.join(directory, 'events')).writeAsString(
      'parent exit ${error.exitCode}\n',
      mode: FileMode.append,
    );
    exitCode = error.exitCode;
  }
}

Future<void> _runChild() async {
  final received = Completer<void>();
  final subscription = Platform.isWindows
      ? null
      : ProcessSignal.sigterm.watch().listen((_) {
          if (!received.isCompleted) received.complete();
        });
  try {
    File(p.join(Platform.environment[_directoryKey]!, 'child.pid'))
        .writeAsStringSync('$pid');
    stdout.writeln('CHILD_STDIN:${stdin.readLineSync()}');
    stderr.writeln('CHILD_STDERR');
    await stderr.flush();
    stdout.writeln('CHILD_READY:$pid');
    await stdout.flush();
    if (Platform.environment['FVM_SIGTERM_TEST_COMPLETE'] != 'true') {
      await received.future;
    }
    await Future<void>.delayed(const Duration(milliseconds: 250));
    await File(p.join(Platform.environment[_directoryKey]!, 'events'))
        .writeAsString('child cleanup\n', mode: FileMode.append);
    exitCode = 7;
  } finally {
    await subscription?.cancel();
  }
}
