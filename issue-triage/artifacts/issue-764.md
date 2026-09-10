# Issue #764: [Feature Request] FVM should automatically switch used Flutter version on git checkout

Current disposition: **closed as consolidated into #681**, not fixed. The [cleanup audit](issue-cleanup-2026-09-08.md) records the preserved requirements and closure. Earlier validation below remains historical evidence.

## Metadata
- **Reporter**: @rasmk
- **Created**: 2024-08-23
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/764

## Problem Summary
`.fvm/versions` symlink is recreated on every `fvm use`, removing previous version symlinks. When switching git branches (with .fvmrc committed), the local `.fvm/versions` folder may point to the wrong cached version until `fvm use` reruns.

## Validation Steps
1. Inspected `UpdateProjectReferencesWorkflow` on current `origin/main`.
2. Confirmed `_updateLocalSdkReference` deletes the local versions directory before creating the selected version link.
3. Confirmed `.fvm/flutter_sdk` is recreated as an absolute link to the selected cache directory.

## Evidence
```text
lib/src/workflows/update_project_references.workflow.dart
  project.localVersionsCachePath.dir
    ..deleteIfExists()
    ..createSync(recursive: true);

The current workflow removes prior per-version project links on every use.
```

## Current Status in v4.1.2
- [x] Still reproducible by code inspection
- [ ] Already fixed
- [ ] Needs more information

## Troubleshooting/Implementation Plan
1. Update `UpdateProjectReferencesWorkflow._updateLocalSdkReference` to retain existing version symlinks and only update the symlink for the current version.
2. Ensure `.fvm/flutter_sdk` points to the selected version via relative link (and avoid deleting the entire folder).
3. Add integration tests covering branch switch scenarios.
4. Run the repository manual branch smoke test because this changes project SDK references and `use` behavior.

## Recommendation
- Priority: **P2 - Medium**
- Suggested Folder: `validated/p2-medium/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: per-version project symlinks are still wiped during reference updates; overlaps #681.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: per-version project symlinks are still wiped during reference updates; overlaps #681.
- **Source**: lib/src/workflows/update_project_references.workflow.dart:68; related #681 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-08-23; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

Conditional consolidation candidate, not a proven duplicate or fixed issue. Retained per-version links overlap #681, but this report also requests relative/removable flutter_sdk and checkout-consistent committed state. Preserve those requirements in #681 before considering closure as consolidated; leave the relative-link solution undecided and defer implementation.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.


## 2026-09-08 issue cleanup completed

Closed as not_planned/consolidated into #681 after its distinct requirements were preserved there. Kept enhancement, added duplicate, and removed the active triage:backlog label. The original report remains unchanged and linked; the SDK-switching behavior is not fixed.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/764#issuecomment-5592548403). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
