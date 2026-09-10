# Issue #743: [Feature Request] Don't require specifying Flutter version in VS Code `dart.flutterSdkPath`

## Metadata
- **Reporter**: @zeshuaro
- **Created**: 2024-06-22
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/743

## Problem Summary
VS Code integration currently writes the specific version path (`.fvm/versions/<version>`). This breaks Renovate automation because an extra file (.vscode/settings.json) must be updated when the Flutter version changes.

## Validation Steps
1. Inspected current `UpdateVsCodeSettingsWorkflow` on `origin/main`.
2. Confirmed `_resolveSdkPath` still resolves `project.localVersionSymlinkPath`.
3. Confirmed `Project.localVersionSymlinkPath` contains the pinned version name.
4. Searched current commands for `getFlutterSdkCommand` support or an SDK path command; none exists.

## Evidence
```text
lib/src/workflows/update_vscode_settings.workflow.dart:_resolveSdkPath
  uses project.localVersionSymlinkPath

lib/src/models/project_model.dart:localVersionSymlinkPath
  joins .fvm/versions/<pinned-version>

No getFlutterSdkCommand/getDartSdkCommand implementation exists on origin/main.
```

## Current Status in v4.1.2
- [x] Still reproducible by code inspection
- [ ] Already fixed
- [ ] Needs more information

## Troubleshooting/Implementation Plan
- Point `dart.flutterSdkPath` to `.fvm/flutter_sdk` (symlink) instead of version-specific path.
- Alternatively, adopt `dart.getFlutterSdkCommand` integration (see issue #821) so VS Code can dynamically resolve the path.
- Add folder/workspace tests proving a Flutter version change does not require a version-specific settings edit.

## Recommendation
- Priority: **P2 - Medium**
- Suggested Folder: `validated/p2-medium/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: generated VS Code settings still use project.localVersionSymlinkPath, not the stable .fvm/flutter_sdk alias. Manual opt-out is only a workaround.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: generated VS Code settings still use project.localVersionSymlinkPath, not the stable .fvm/flutter_sdk alias. Manual opt-out is only a workaround.
- **Source**: lib/src/workflows/update_vscode_settings.workflow.dart:_resolveSdkPath; lib/src/models/project_model.dart:115 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-06-22; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
