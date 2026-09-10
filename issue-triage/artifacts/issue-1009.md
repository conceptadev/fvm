# Issue #1009: Custom fork issues

## Metadata
- **Reporter**: @patrick-billingsley
- **Created**: 2026-01-02
- **Reported Version**: Not specified (recent v4 usage)
- **Issue Type**: fork workflow support / docs
- **URL**: https://github.com/leoafarias/fvm/issues/1009

## Problem Summary
Using a forked Flutter ref like `my-fork/3.35.6-patch` installs, but `fvm list` shows `0.0.0-unknown` for Flutter version. Reporter needs a team-shareable fork workflow for patched builds.

## Version Context
- Reported against: v4.x
- Current version: v4.0.0+
- Version-specific: no
- Reason: behavior depends on how fork refs map to Flutter's internal version metadata and how list output displays it.

## Validation Steps
1. Reviewed version parser behavior for non-semver fork refs.
2. Reviewed list output source for Flutter version field.
3. Reviewed custom fork documentation and known workaround in issue comments.

## Evidence
```text
lib/src/models/flutter_version_model.dart:121-139
- Non-semver refs are parsed as git references.

lib/src/services/cache_service.dart:64-83
- Fork directories are discovered and parsed as `fork/version`.

lib/src/commands/list_command.dart:64-80
- `fvm list` displays value from SDK `version` file (can appear as unknown for custom refs).

docs/pages/documentation/advanced/custom-version.mdx:53-61
- Docs call out `custom_` flow and full clone requirements for non-standard versions.
```

**Files/Code References:**
- [lib/src/models/flutter_version_model.dart:121](../../lib/src/models/flutter_version_model.dart#L121) - Version classification fallback.
- [lib/src/commands/list_command.dart:64](../../lib/src/commands/list_command.dart#L64) - Displayed Flutter version source.
- [docs/pages/documentation/advanced/custom-version.mdx:53](../../docs/pages/documentation/advanced/custom-version.mdx#L53) - Custom version guidance.

## Current Status in v4.0.0
- [ ] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [x] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
The issue appears to be mostly about fork naming/version metadata expectations. Non-standard fork tags may not produce a standard Flutter version string, so list output can show unknown metadata even when checkout works.

### Proposed Solution
1. Improve docs for fork refs with patches:
   - Prefer semver-like tags where possible.
   - Document `custom_*` approach for truly custom snapshots.
2. Improve `fvm list` UX for fork refs when SDK version is unknown (show reference + fork context, not just unknown value).
3. Add a dedicated troubleshooting section for forked repos requiring team-wide reproducibility.
4. Ask reporter for a minimal fork repo example if behavior persists with recommended naming.

### Alternative Approaches (if applicable)
- Keep behavior as-is and provide support-only guidance in issue comments.

### Dependencies & Risks
- Any list formatting change must avoid breaking scripts parsing current table output.
- Fork metadata is partially controlled by Flutter tooling behavior.

### Related Code Locations
- [docs/pages/documentation/guides/basic-commands.mdx:351](../../docs/pages/documentation/guides/basic-commands.mdx#L351) - Fork command docs.
- [lib/src/services/flutter_service.dart:212](../../lib/src/services/flutter_service.dart#L212) - Checkout/reset behavior for non-channel refs.

## Recommendation
**Action**: validate-p3

**Reason**: Primarily docs/UX quality issue with a reported workaround; not a broad runtime blocker.

## Notes
- Existing workaround comment suggests semver-like ref (`my-fork/3.35.7`) avoided the unknown version display.

---
**Validated by**: Code Agent  
**Date**: 2026-03-03

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: custom fork tags can still lack standard Flutter metadata; generic fork support does not guarantee meaningful version output.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: support_or_unverified_bug / needs_info; GitHub label `need info`.
- **Evidence level**: unverified_report. A custom patch tag reports 0.0.0-unknown, but no minimal public fork/metadata comparison proves FVM is responsible. Current fallback improvements do not prove this symptom fixed.
- **Source**: lib/src/models/cache_flutter_version_model.dart; issue #1009 body/comments (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Compare direct fork flutter --version --machine with FVM output; supply a minimal accessible fork/ref and current versions.
- **Age**: opened 2026-01-02; postdates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.


## 2026-09-08 issue cleanup completed

Requested a minimal public fork without company code and an FVM-versus-direct-SDK comparison at the same commit. Remains needs-info; the similar closed #773 report is not proof of a fix. No closure deadline.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/1009#issuecomment-5592554039). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
