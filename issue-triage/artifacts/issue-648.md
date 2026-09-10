# Issue #648: Dart Version management improvements

## Metadata
- **Reporter**: Leo Farias (@leoafarias)
- **Created**: 2024-02-23
- **Reported Version**: 3.0.x
- **Issue Type**: enhancement
- **URL**: https://github.com/leoafarias/fvm/issues/648

## Problem Summary
The new constraint checks are helpful, but FVM still lacks higher-level tooling around Dart SDK compatibility:
1. Users cannot ask FVM to pick a Flutter release based on a Dart SDK constraint (e.g., “install the newest Flutter that ships Dart 2.14”).
2. Package authors want a simple way to run commands against both the minimum and maximum SDK constraints defined in `pubspec.yaml`.
3. `fvm dart …` falls back to whatever `dart` is on PATH when no project/global version is configured, instead of using the Dart SDK that ships with Flutter.

## Version Context
- Reported against: 3.0.x
- Current version: v4.0.0
- Version-specific: no — current CLI lacks these capabilities.
- Reason: Flag parsing and fallback logic haven’t been extended to cover constraint-driven workflows.

## Validation Steps
1. Checked `lib/src/commands/use_command.dart` — no flag to select Flutter by Dart constraint; users must provide an explicit Flutter version.
2. Inspected `lib/src/services/releases_service/models/flutter_releases_model.dart` — release metadata already exposes `dartSdkVersion`, so constraint matching is feasible.
3. Searched the command set (`lib/src/commands`) — no tooling to execute commands at min/max constraints; workflows only run against a single configured version.
4. Reviewed `RunConfiguredFlutterWorkflow` (`lib/src/workflows/run_configured_flutter.workflow.dart`) — when no project/global version exists it calls `ProcessService().run(cmd, args)` which resolves `dart`/`flutter` via PATH, ignoring the Flutter distribution.

## Evidence
```
$ sed -n '52,120p' lib/src/commands/use_command.dart
    final forceOption = boolArg('force');
    final skipPubGet = boolArg('skip-pub-get');
    final skipSetup = boolArg('skip-setup');
    ...
    final cacheVersion = await ensureCache(flutterVersion, force: forceOption);

$ sed -n '1,40p' lib/src/services/releases_service/models/version_model.dart
  @MappableField(key: 'dart_sdk_version')
  final String? dartSdkVersion;

$ sed -n '1,80p' lib/src/workflows/run_configured_flutter.workflow.dart
    if (selectedVersion != null) {
      return get<FlutterService>().run(cmd, args, selectedVersion);
    }
    return get<ProcessService>().run(cmd, args: args); // PATH fallback
```

## Current Status in v4.0.0
- [x] Still reproducible (features missing)
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
The CLI only understands explicit Flutter versions. Constraint metadata (`dart_sdk_version`, pubspec environments) is already available, but no commands consume it. The fallback logic for `fvm dart` delegates to PATH, so it can land on the standalone Dart SDK instead of Flutter’s bundled one.

### Proposed Solution
1. **Constraint-driven installs:**
   - Extend `fvm use` with a flag such as `--dart <constraint>` or a dedicated subcommand.
   - Parse the constraint via `VersionConstraint.parse`.
   - Query release metadata using `FlutterReleaseClient` and filter releases whose `dartSdkVersion` satisfies the constraint (choose latest or allow `--latest/--earliest`).
   - Feed the resolved Flutter version back into the existing install workflow and update the output to explain the selection.
2. **Run min/max constraint commands:**
   - Parse `pubspec.environment.flutter` / `pubspec.environment.sdk`.
   - Add options like `fvm exec --min-sdk <command>` and `--max-sdk` (and perhaps `--all-supported`).
   - Internally resolve each constraint to a Flutter version (using the release metadata lookup from step 1), run the command for each, and aggregate exit codes.
   - Provide helpful warnings when the constraint range cannot be satisfied (e.g., outdated floor).
3. **Improve `fvm dart` fallback:**
   - When no project/global version is configured, attempt to locate Flutter on PATH (`which flutter`) and derive its `bin/cache/dart-sdk/bin/dart`.
   - Prefer that Dart binary over the standalone `dart` executable. Only fall back to PATH `dart` if Flutter is unavailable.
   - Log which binary is selected for transparency.

### Alternative Approaches (if applicable)
- Instead of extending `fvm use`, add a new command (`fvm resolve dart <constraint>`) that returns the recommended Flutter version; users could then call `fvm use` manually.
- For min/max testing, integrate with `fvm exec` profiles so users can define named scenarios in `.fvmrc`.

### Dependencies & Risks
- Needs reliable release metadata; ensure mirrored environments (custom `FLUTTER_STORAGE_BASE_URL`) still work.
- Running commands across multiple versions may require installing additional SDKs; provide `--no-install`/`--reuse` flags to control behavior.
- Fallback to Flutter’s Dart must handle Windows symlink requirements and unusual PATH setups gracefully.

### Related Code Locations
- [lib/src/services/releases_service/releases_client.dart](../../lib/src/services/releases_service/releases_client.dart) – Data source for Flutter/Dart mapping.
- [lib/src/commands/exec_command.dart](../../lib/src/commands/exec_command.dart) – Candidate for adding `--min-sdk`/`--max-sdk`.
- [lib/src/workflows/run_configured_flutter.workflow.dart](../../lib/src/workflows/run_configured_flutter.workflow.dart) – Update fallback resolution logic.

## Recommendation
**Action**: validate-p2

**Reason**: Adds powerful workflow improvements (especially for package authors) but requires moderate engineering effort; not a blocker for basic usage.

## Notes
- Coordinate UX with the doc team; these features warrant dedicated documentation/examples.
- Consider caching the Dart→Flutter resolution to avoid repeated release scans for the same constraint.

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: Dart-constraint resolution, min/max commands and Dart fallback are distinct from displaying a Dart SDK column. Interest continued in May 2026.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: Dart-constraint resolution, min/max commands and Dart fallback are distinct from displaying a Dart SDK column. Interest continued in May 2026.
- **Source**: lib/src/commands/dart_command.dart; lib/src/workflows/check_project_constraints.workflow.dart (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-02-23; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

Preserve the three original requests: Dart-constraint resolution, min/max-SDK execution and bundled-Dart fallback. Source recheck confirms fvm list has Dart Version but fvm releases does not. PR #828 was closed unmerged on September 4 by a documented UX/maintenance decision. Do not mark the releases-column suggestion shipped, close #648 on that basis, or reopen #828 automatically.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.


## 2026-09-08 issue cleanup completed

Clarified the three original Dart requirements and the list-versus-releases column distinction. #828 stays closed unmerged; this enhancement remains open and linked to #751.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/648#issuecomment-5592552873). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
