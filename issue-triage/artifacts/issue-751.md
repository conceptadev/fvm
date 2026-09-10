# Issue #751: [Feature Request] Support range versions

## Metadata
- **Reporter**: @MiniSuperDev
- **Created**: 2024-07-10
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/751

## Problem Summary
Request support for version ranges (e.g., `3.22.*`) to avoid installing every patch explicitly.

## Validation Steps
1. Inspected current Flutter version parsing and validation on `origin/main`.
2. Confirmed project config stores one concrete Flutter version/channel/fork reference.
3. Confirmed no command resolves a `pub_semver` range to the newest matching Flutter release.

## Evidence
```text
.fvmrc `flutter` is parsed as one FlutterVersion value.
Current accepted forms are channels, exact versions, commits, and [fork/]version[@channel].
No VersionConstraint-based release resolver is used by install/use.
```

## Current Status in v4.1.2
- [x] Still unresolved
- [ ] Already implemented
- [ ] Needs more information

## Troubleshooting/Implementation Plan

### Proposed Solution
- Allow `.fvmrc` to specify semver constraints (use `pub_semver` constraints) and resolve to the latest installed version or fetch the newest matching release.
- Update `fvm use/install` to accept constraints and expand them.
- Add tests and documentation.

## Recommendation
- Priority: **P3 - Low**
- Suggested Folder: `validated/p3-low/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: semver-range input remains distinct from exact releases/channels; no complete range resolver established.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P3: semver-range input remains distinct from exact releases/channels; no complete range resolver established.
- **Source**: lib/src/workflows/validate_flutter_version.workflow.dart; lib/src/models/flutter_version_model.dart (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-07-10; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

Use as the proposed version-resolution policy discussion lead. #1016 adds minor-only latest-patch installation and an available-patch indicator in fvm list, so it is not fully covered by #751's current body. Link the reports and reconcile closed #421's exact-install decision before approving new behavior. #577, #648 and #583 retain separate input, execution and upgrade-lifecycle requirements.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.


## 2026-09-08 issue cleanup completed

Linked #1016, #577 and #648 with their distinct requirements, and kept #583's upgrade lifecycle separate. The exact-install decision in #421 remains a policy question. No version-resolution feature was approved.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/751#issuecomment-5592552450). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
