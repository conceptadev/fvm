# Issue #1008: [BUG] versions not auto update

## Metadata
- **Reporter**: @jopmiddelkamp
- **Created**: 2025-12-31
- **Reported Version**: 4.0.5
- **Issue Type**: bug / monorepo integration gap
- **URL**: https://github.com/leoafarias/fvm/issues/1008

## Problem Summary
Running `fvm use 3.38.5` in a Melos workspace did not update the workspace `sdkPath` declaration (`melos.sdkPath` in root `pubspec.yaml`). Reporter also asked if `environment.sdk` / `environment.flutter` should be auto-updated.

## Version Context
- Reported against: v4.0.5
- Current version: v4.0.0+
- Version-specific: no
- Reason: current implementation updates only `melos.yaml` root `sdkPath`, not `pubspec.yaml` `melos.sdkPath`.

## Validation Steps
1. Reviewed Melos settings workflow logic and file discovery strategy.
2. Verified update target key/path and interactive confirmation behavior.
3. Reviewed monorepo docs describing `melos.yaml`-based configuration.

## Evidence
```text
lib/src/workflows/update_melos_settings.workflow.dart:24-35
- Searches only for `melos.yaml` (not pubspec-based Melos config).

lib/src/workflows/update_melos_settings.workflow.dart:82-101
- Reads/updates root `sdkPath` key in that file.

docs/pages/documentation/guides/monorepo.md:18-24
- Docs describe automatic management of `sdkPath` in `melos.yaml`.
```

**Files/Code References:**
- [lib/src/workflows/update_melos_settings.workflow.dart:24](../../lib/src/workflows/update_melos_settings.workflow.dart#L24) - File discovery behavior.
- [lib/src/workflows/update_melos_settings.workflow.dart:82](../../lib/src/workflows/update_melos_settings.workflow.dart#L82) - Existing update target.
- [docs/pages/documentation/guides/monorepo.md:18](../../docs/pages/documentation/guides/monorepo.md#L18) - Documented behavior scope.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
FVM currently assumes Melos configuration is expressed in `melos.yaml`. Workspaces using `melos` block inside `pubspec.yaml` are not detected/updated by the existing workflow.

### Proposed Solution
1. Extend `UpdateMelosSettingsWorkflow` to detect Melos config in root `pubspec.yaml` when `melos.yaml` is absent.
2. Update `melos.sdkPath` in `pubspec.yaml` using a comment-preserving YAML edit flow.
3. Keep current `melos.yaml` behavior as-is for backward compatibility.
4. Add tests for both config styles and nested monorepo relative path calculation.
5. Treat `environment.sdk` / `environment.flutter` update as separate feature scope (opt-in only, no silent mutation by default).

### Alternative Approaches (if applicable)
- Documentation-only approach: explicitly state only `melos.yaml` is auto-managed. Lower effort but leaves modern pubspec-based setups unsolved.

### Dependencies & Risks
- YAML editing must preserve user formatting/comments where possible.
- Must avoid rewriting unrelated `pubspec.yaml` sections.

### Related Code Locations
- [lib/src/workflows/use_version.workflow.dart:54](../../lib/src/workflows/use_version.workflow.dart#L54) - Melos workflow invocation.
- [lib/src/models/project_model.dart:25](../../lib/src/models/project_model.dart#L25) - Pubspec is already loaded and available for reuse.

## Recommendation
**Action**: validate-p2

**Reason**: Valid monorepo integration bug for active workflows; not a global install blocker but impacts teams relying on Melos workspace automation.

## Notes
- The `environment.sdk`/`environment.flutter` mutation request should be tracked as a separate enhancement due risk of unintended dependency constraint changes.

---
**Validated by**: Code Agent  
**Date**: 2026-03-03

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: Melos integration needs pubspec.yaml-based melos.sdkPath support, not only melos.yaml.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: bug / confirmed; GitHub label `triage:confirmed`.
- **Evidence level**: code_inspection. Melos integration only locates melos.yaml and updates its root sdkPath; the report uses pubspec.yaml/melos/sdkPath. Automatic environment constraint updates are a separate enhancement.
- **Source**: lib/src/workflows/update_melos_settings.workflow.dart:24,29,75 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Support pubspec-based Melos config with preserved YAML and explicit tests; separate optional constraint updates.
- **Age**: opened 2025-12-31; postdates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
