# Issue #821: Support Dart VSCode getFlutterSdkCommand

## Metadata
- **Reporter**: @danilofuchs
- **Created**: 2025-02-13
- **Reported Version**: FVM 3.x
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/821

## Problem Summary
The VS Code Dart extension added `getFlutterSdkCommand`/`getDartSdkCommand` hooks. FVM currently rewrites `dart.flutterSdkPath` directly, forcing path updates after every Flutter switch. Integrating with the command-based API could eliminate manual edits.

## Version Context
- Current version: v4.0.0
- Behavior unchanged from v3.x.

## Validation Steps
1. Confirmed `UpdateVsCodeSettingsWorkflow` writes `dart.flutterSdkPath` (string) with no support for command settings.
2. Reviewed Dart-Code change (commit b1f79dbd0d66128059cac40ff0dca01d4dd5dca7) describing the new command contract.

## Evidence
```text
origin/main still writes dart.flutterSdkPath from project.localVersionSymlinkPath.
No FVM path/which/where command exists.
No getFlutterSdkCommand or getDartSdkCommand setting is emitted.
```

## Current Status in v4.1.2
- [x] Still unresolved
- [ ] Already implemented
- [ ] Needs more information

## Troubleshooting/Implementation Plan
1. Introduce a lightweight CLI command, e.g., `fvm path --json`, returning the current project's Flutter/Dart SDK paths.
2. When updating VS Code settings, optionally configure:
   ```json
   {
     "dart.getFlutterSdkCommand": ["fvm", "path", "--json", "flutter"],
     "dart.getDartSdkCommand": ["fvm", "path", "--json", "dart"]
   }
   ```
   The command should output `{ "sdkPath": "<path>" }` as required by Dart-Code.
3. Provide opt-in via `.fvmrc` (e.g., `useGetFlutterSdkCommand: true`) to avoid breaking existing setups.
4. Update docs explaining VS Code integration and fallback to path-based configuration.
5. Add tests ensuring the workflow writes the new settings when enabled.
6. Coordinate with #743 so FVM chooses one stable default rather than maintaining two competing VS Code strategies indefinitely.

## Recommendation
- Priority: **P2 - Medium** (improves IDE integration)
- Suggested Folder: `validated/p2-medium/`

## Notes for Follow-up
- Verify new command works on Windows/macOS/Linux and respects `privilegedAccess` logic.

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: VS Code command-based SDK discovery and a path command remain separate from writing a static dart.flutterSdkPath.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: VS Code command-based SDK discovery and a path command remain separate from writing a static dart.flutterSdkPath.
- **Source**: lib/src/runner.dart command registration; lib/src/workflows/update_vscode_settings.workflow.dart (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2025-02-13; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
