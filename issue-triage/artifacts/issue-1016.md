# Issue #1016: [Feature Request] support installing the latest patch for a stable version without taking latest stable

## Metadata
- **Reporter**: @scopendo
- **Created**: 2026-02-19
- **Reported Version**: N/A (feature request)
- **Issue Type**: enhancement
- **URL**: https://github.com/leoafarias/fvm/issues/1016

## Problem Summary
User wants `fvm install 3.38` to resolve to latest `3.38.x` while keeping minor version pinned (instead of moving to current `stable` minor).

## Version Context
- Reported against: v4.x behavior
- Current version: v4.0.0+
- Version-specific: no
- Reason: current parser expects full semver for releases and treats partial versions as git refs.

## Validation Steps
1. Reviewed version parsing behavior for partial versions.
2. Reviewed install command docs for accepted version formats.
3. Reviewed release lookup flow for full-version resolution.

## Evidence
```text
lib/src/models/flutter_version_model.dart:121-139
- Non-semver values (e.g., 3.38) are parsed as git references.

lib/src/services/flutter_service.dart:158-169
- Release-channel inference uses exact release lookup by version string.

docs/pages/documentation/guides/basic-commands.mdx:79
- Install docs currently describe explicit version input, not minor-line wildcard resolution.
```

**Files/Code References:**
- [lib/src/models/flutter_version_model.dart:121](../../lib/src/models/flutter_version_model.dart#L121) - Semver validation behavior.
- [lib/src/services/flutter_service.dart:158](../../lib/src/services/flutter_service.dart#L158) - Release-channel lookup with exact version.
- [docs/pages/documentation/guides/basic-commands.mdx:79](../../docs/pages/documentation/guides/basic-commands.mdx#L79) - Current install argument documentation.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
Current parser and install flow are designed for full semantic versions/channels/refs. Minor-only constraints are not resolved via release metadata.

### Proposed Solution
1. Add a "partial version" resolver before normal parse/install flow.
2. When input matches `major.minor` pattern, fetch releases and pick newest patch in that minor line.
3. Surface resolved version in CLI output (`3.38 -> 3.38.10`) for transparency.
4. Add tests for:
   - valid partials,
   - no matching releases,
   - channel override interactions.
5. Document behavior and edge-cases in `basic-commands` and quick-reference.

### Alternative Approaches (if applicable)
- Add explicit flag (`--latest-patch`) to avoid changing interpretation of partial refs.

### Dependencies & Risks
- Potential ambiguity with branch names matching `x.y` patterns in custom forks.
- Must avoid breaking existing workflows that rely on git-ref interpretation.

### Related Code Locations
- [lib/src/workflows/validate_flutter_version.workflow.dart:9](../../lib/src/workflows/validate_flutter_version.workflow.dart#L9) - Entry point for version validation.
- [lib/src/services/releases_service/releases_client.dart:95](../../lib/src/services/releases_service/releases_client.dart#L95) - Release retrieval API.

## Recommendation
**Action**: validate-p3

**Reason**: Useful enhancement for version-management ergonomics; not a blocking defect.

## Notes
- Could be introduced behind a flag first to minimize behavior surprises.

---
**Validated by**: Code Agent  
**Date**: 2026-03-03

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: cleanup patch recommendations are not an install-time partial-version resolver.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P3: cleanup patch recommendations are not an install-time partial-version resolver.
- **Source**: lib/src/commands/install_command.dart; lib/src/commands/cleanup_command.dart (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2026-02-19; postdates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

Full live body recheck adds an acceptance criterion omitted from the historical implementation plan: fvm list should indicate when a new patch is available. Keep this alongside minor-only latest-patch installation. Link #751, but do not close as duplicate or implement parsing changes before the exact-install policy in #421 is reconciled.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.


## 2026-09-08 issue cleanup completed

Linked #751 while keeping this report open for minor-only latest-patch installation and fvm list patch-availability indicators. No duplicate closure or parser change.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/1016#issuecomment-5592552662). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
