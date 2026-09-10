# Issue #767: [BUG] Android Studio cannot change the project's Flutter SDK path

## Metadata
- **Reporter**: @EthanZhuGit
- **Created**: 2024-08-26
- **Reported Version**: FVM 3.1.7; recent confirmations on Android Studio 2025.3.x
- **Issue Type**: bug (IDE integration)
- **URL**: https://github.com/conceptadev/fvm/issues/767

## Problem Summary
Android Studio resolves or rewrites FVM symlink-based SDK paths to another project's or the physical cache SDK path. Users then lose automatic project version switching. Multiple users confirmed the behavior through 2026, including current Android Studio/Flutter plugin versions.

## Validation Steps
1. Reviewed the original Windows report and later cross-platform confirmations.
2. Correlated with #600/#724: IntelliJ's Flutter/Dart plugins resolve symlinks and persist physical SDK paths.
3. Inspected current FVM references: `.fvm/flutter_sdk` is a symlink and FVM does not rewrite IntelliJ-generated `.idea/libraries/*` paths.

## Evidence
```text
Issue updates include confirmations on Android Studio Panda 2025.3.4 Patch 1
and Flutter plugin 92.0.0.

lib/src/workflows/update_project_references.workflow.dart
  recreates .fvm/flutter_sdk as a symlink.

FVM has no workflow that manages IntelliJ .idea/libraries/Dart_SDK.xml.
```

## Current Status in v4.1.2
- [x] Valid current bug/compatibility gap
- [ ] Already fixed
- [ ] Needs more information for classification

## Troubleshooting/Implementation Plan
1. Reproduce with current Android Studio and Flutter plugin using two projects pinned to different Flutter versions.
2. Capture changes to `android/local.properties`, `.idea/libraries/Dart_SDK.xml`, and IDE Flutter SDK settings before/after restart.
3. Decide whether FVM should offer explicit opt-in IntelliJ file management, as discussed in #600, or document the upstream limitation.
4. If implementing file management, preserve unrelated IDE content and add fixtures for multiple plugin versions.
5. Cross-link #600 and #724 and consolidate the eventual fix/closure message.

## Recommendation
- Priority: **P2 - Medium**
- Reason: repeated current confirmations establish a real IDE integration gap; more reproduction detail is needed for implementation, not for validity.

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: Android Studio resolves symlinks to physical SDK paths; May/June 2026 confirmations make this current. New documentation does not implement automatic switching.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: compatibility / upstream; GitHub label `triage:upstream`.
- **Evidence level**: reported_compatibility. May/June 2026 reports confirm physical/cross-project SDK-path substitution in Android Studio. The current guide acknowledges symlink limitations; no local IDE reproduction was performed.
- **Source**: docs/pages/documentation/guides/android-studio.mdx; issue #767 comments (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Reproduce with stated IDE/plugin versions and separate upstream path normalization from FVM reference updates.
- **Age**: opened 2024-08-26; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
