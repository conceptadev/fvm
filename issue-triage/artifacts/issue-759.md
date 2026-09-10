# Issue #759: [Feature Request]: Set as global the Flutter version in .fvmrc file

Current disposition — 2026-09-08: still `need info`, with a [diagnostic response deadline](https://github.com/leoafarias/fvm/issues/759#issuecomment-5593075976) of September 22, 2026. Review new replies on or after September 23 before considering closure as not planned; no automatic closure is scheduled. This supersedes earlier no-deadline notes below and does not establish a fix.

## Metadata
- **Reporter**: @yannatk
- **Created**: 2024-08-07
- **Issue Type**: needs info
- **URL**: https://github.com/conceptadev/fvm/issues/759

## Problem Summary
VSCode launch fails when global Flutter is old and project uses newer `.fvmrc` version. Need more information (VSCode settings, `fvm doctor --verbose`).

## Validation Steps
1. Confirmed current FVM writes a project-specific `dart.flutterSdkPath` when VS Code settings management is enabled.
2. Confirmed the live issue has no `settings.json`, launch configuration, doctor output, or exact failure.
3. Could not determine whether VS Code is using the global SDK, a stale version-specific path, or a workspace override.

## Evidence
```text
lib/src/workflows/update_vscode_settings.workflow.dart writes dart.flutterSdkPath.
Issue supplies reproduction prose but no configuration or error output.
```

## Troubleshooting/Implementation Plan
Request `settings.json`, `.fvmrc`, and exact error.
Also request workspace settings, `fvm doctor --verbose`, and Dart-Code extension version; compare the SDK used by VS Code with `fvm flutter --version`.

## Recommendation
- Folder: `needs_info/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep needs-info: current project SDK docs may help, but no evidence proves the reported VS Code launch/global-SDK mismatch fixed. Need settings and launch output on 4.3.1.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: support_or_unverified_bug / needs_info; GitHub label `need info`.
- **Evidence level**: unverified_report. CLI works but VS Code launch uses a different SDK; no settings/launch logs establish whether FVM or IDE configuration causes it. Retriaged as a support question, not a request to silently change the global SDK.
- **Source**: lib/src/workflows/update_vscode_settings.workflow.dart; https://dartcode.org/docs/sdk-locating/ (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Obtain current FVM/Dart-Code versions, settings, launch output and SDK paths.
- **Age**: opened 2024-08-07; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.


## 2026-09-08 issue cleanup completed

Posted a targeted request for current FVM/editor versions, SDK settings, launch configuration/error and the working FVM invocation. Remains needs-info; no new reporter evidence or closure deadline.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/759#issuecomment-5592553676). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
