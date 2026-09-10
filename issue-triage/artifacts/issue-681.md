# Issue #681: [Enhancement] Maintain project reference to cache versions after switch

## Metadata
- **Reporter**: Brent Kleineibst (@bkleineibst)
- **Created**: 2024-03-04
- **Reported Version**: 3.0.12
- **Issue Type**: enhancement (project workflow)
- **URL**: https://github.com/leoafarias/fvm/issues/681

## Problem Summary
When switching between branches that pin different Flutter versions, VS Code complains about a missing SDK until `fvm use` is rerun. The `.vscode/settings.json` written by FVM points to `.fvm/versions/<version>`, but each invocation of `fvm use` deletes the entire `.fvm/versions` directory before recreating the new link, so older branch paths break.

## Version Context
- Reported against: FVM 3.0.12
- Current version: v4.0.0
- Version-specific: no — `_updateLocalSdkReference` still wipes the directory on every switch.
- Reason: The workflow intentionally cleans the cache directory, but that conflicts with multi-branch setups that rely on previous symlinks.

## Validation Steps
1. Inspected `lib/src/workflows/update_project_references.workflow.dart`. `_updateLocalSdkReference` calls `project.localVersionsCachePath.dir..deleteIfExists()..createSync(...)`, removing the entire `versions` folder before writing the new symlink.
2. Confirmed `project.localVersionSymlinkPath` only recreates the current version link, leaving former versions absent.
3. Checked VS Code integration in `update_vscode_settings.workflow.dart`; it writes `dart.flutterSdkPath` to `.fvm/versions/<version>`, so removing old symlinks invalidates the stored path.
4. Verified there is no compensating logic to restore previous symlinks on branch checkout, so users must rerun `fvm use` manually.

## Evidence
```
$ sed -n '35,80p' lib/src/workflows/update_project_references.workflow.dart
    project.localVersionsCachePath.dir
      ..deleteIfExists()
      ..createSync(recursive: true);
    ...
    project.localVersionSymlinkPath.link.createLink(version.directory);

$ sed -n '226,234p' lib/src/workflows/update_vscode_settings.workflow.dart
    workspaceSettings['settings']['dart.flutterSdkPath'] = sdkPath;
```

**Files/Code References:**
- [lib/src/workflows/update_project_references.workflow.dart#L35](../../lib/src/workflows/update_project_references.workflow.dart#L35) – Deletes `.fvm/versions` on every switch.
- [lib/src/workflows/update_vscode_settings.workflow.dart#L228](../../lib/src/workflows/update_vscode_settings.workflow.dart#L228) – VS Code path depends on version-specific symlink.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
The project workflow treats `.fvm/versions` as a single-use scratch directory. Deleting it removes symlinks that other branches expect, forcing users to run `fvm use` after every checkout.

### Proposed Solution
1. Update `_updateLocalSdkReference` to stop deleting the directory. Instead:
   - Ensure the folder exists (`createSync` if missing).
   - Remove only the specific symlink for the version being updated (if it exists) and recreate it pointing to the cache.
   - Optionally prune stale symlinks via a separate cleanup command rather than during every switch.
2. Add regression tests covering branch hopping scenarios:
   - Simulate two versions pinned in sequence; verify that after the second switch, the first symlink still exists and resolves correctly.
3. Document best practices in the VS Code guide (mention that `.fvm/versions` keeps historical links; use `fvm cleanup` or a new command to prune old entries as needed).
4. Consider adding an opt-in flag (e.g., `--prune-local-cache`) for teams that prefer the old behavior.

### Alternative Approaches (if applicable)
- Write VS Code settings to `.fvm/flutter_sdk` (branch-agnostic symlink). Already used for Android Studio, but VS Code requires per-version path to detect SDK changes instantly.
- Use versioned `.fvmrc` flavors. Still requires multi-link support because IDE paths persist across branch switches.

### Dependencies & Risks
- Keeping old symlinks means `.fvm/versions` grows over time; need a cleanup mechanism to avoid stale entries referencing removed cache versions.
- Must ensure privilege checks (for symlink creation) remain intact—skip adjustments when `privilegedAccess` is false.
- On Windows, symlink creation requires Developer Mode/admin; behavior should match current flow.

### Related Code Locations
- [lib/src/workflows/update_project_references.workflow.dart#L64](../../lib/src/workflows/update_project_references.workflow.dart#L64) – Creates the per-version symlink.
- [lib/src/commands/remove_command.dart](../../lib/src/commands/remove_command.dart) – Already handles explicit removals; ensure it also removes project symlinks when versions are deleted.

## Recommendation
**Action**: validate-p2

**Reason**: Quality-of-life improvement that unblocks branch-based workflows and removes a common annoyance, but users have a workaround (`fvm use` after checkout), so it’s medium priority.

## Notes
- After implementation, mention in release notes that FVM keeps historical project links and how to prune them.
- Evaluate whether `fvm cleanup` should scan project `.fvm/versions` directories to remove symlinks pointing to missing global caches.

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: UpdateProjectReferencesWorkflow still deletes and recreates .fvm/versions; branch switching can lose versioned links.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: UpdateProjectReferencesWorkflow still deletes and recreates .fvm/versions; branch switching can lose versioned links.
- **Source**: lib/src/workflows/update_project_references.workflow.dart:68 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-03-04; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

Proposed discussion lead for SDK-link consolidation, not an implementation approval. Full live threads show #764 adds relative/removable flutter_sdk and committed-file checkout requirements. First preserve these as explicit outcomes/design questions in #681 and add reciprocal links. Keep both open until all distinct requirements have a home; do not treat symlink retention alone as complete automatic switching.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.


## 2026-09-08 issue cleanup completed

Added the shared branch-switching summary and preserved all of #764's retained-link, relative/removable flutter_sdk, metadata, and checkout requirements. #764 is now consolidated here. #681 remains open; no implementation was selected or delivered.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/681#issuecomment-5592539768). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
