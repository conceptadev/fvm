# Issue #782: `Bad substitution` in when calling global packages

## Metadata
- **Reporter**: @dickermoshe
- **Created**: 2024-09-16
- **Reported Version**: Docs (v3.x)
- **Issue Type**: documentation bug
- **URL**: https://github.com/leoafarias/fvm/issues/782

## Problem Summary
The docs tell users to create shim scripts containing `fvm flutter ${@:1}` / `fvm dart ${@:1}`. On Linux these shims often run under `/bin/sh`, which does not support the `${@:1}` bash extension, leading to `bad substitution`. The correct portable form is `"$@"`.

## Version Context
- Reported against: documentation for v3.x
- Current version: v4.0.0
- Version-specific: no
- Reason: The doc snippet is still present in v4.0.0 and continues to produce the error.

## Validation Steps
1. Located the offending snippet in `docs/pages/documentation/guides/running-flutter.mdx:69-77`.
2. Confirmed `/bin/sh` on Ubuntu reproduces `bad substitution` when executing the example.
3. Verified no updated guidance exists elsewhere in the docs.

## Evidence
```
docs/pages/documentation/guides/running-flutter.mdx:69-77  // Uses ${@:1} causing bad substitution
```

**Files/Code References:**
- [docs/pages/documentation/guides/running-flutter.mdx:69](../../docs/pages/documentation/guides/running-flutter.mdx#L69) – Doc snippet that must be updated to `"$@"`.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
Documentation uses bash-specific parameter expansion inside scripts likely executed by `/bin/sh`. This causes shell errors for users following the instructions verbatim.

### Proposed Solution
1. Update the docs to recommend `fvm flutter "$@"` / `fvm dart "$@"`.
2. Add explicit shebang (`#!/usr/bin/env bash`) if the doc wants to demonstrate bash-specific syntax, or keep scripts POSIX-compliant.
3. Add a short explanation that `"$@"` forwards all arguments safely.
4. Optionally provide a PowerShell example for Windows parity.

### Alternative Approaches
- Could suggest using aliases or PATH symlinks instead of scripts; still mention in doc.

### Dependencies & Risks
- Documentation update only.

### Related Code Locations
- [docs/pages/documentation/guides/running-flutter.mdx](../../docs/pages/documentation/guides/running-flutter.mdx) – Single place requiring the edit.

## Recommendation
**Action**: validate-p2  
**Reason**: Documentation fix required before closing; issue remains reproducible in current docs.

## Draft Reply
```
Thanks for catching this! The docs still show `fvm flutter ${@:1}`, which only works in bash. We’re updating the guide to use the portable form `fvm flutter "$@"` / `fvm dart "$@"` so the scripts run under `/bin/sh` as well.

Leaving the issue open under documentation until that change lands—thanks again for the sharp eye.
```

## Notes
- Move classification to `validated/p2-medium` and track the doc PR.

---
**Validated by**: Code Agent  
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: running-flutter.mdx still emits ${@:1} without a shebang. Plan safe POSIX wrappers using quoted argument forwarding, preserve existing executables, and verify paths/permissions.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: bug / confirmed; GitHub label `triage:confirmed`.
- **Evidence level**: shell_reproduction_and_source. Current docs emit ${@:1} without a shebang. dash reproduction exits 2 with Bad substitution; macOS /bin/sh accepts it, so this is shell-dependent.
- **Source**: docs/pages/documentation/guides/running-flutter.mdx:69,76 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Use safe POSIX wrappers with quoted arguments, executable permissions and non-destructive installation guidance.
- **Age**: opened 2024-09-16; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

Ready for a documentation-only PR. The lowest-risk scope now supersedes the earlier replacement-wrapper suggestion: withdraw the unsafe process-wide file-creation/deletion recipe, recommend explicit proxy commands and existing interactive aliases, and explain safe recovery without deleting unrelated executables. Current PATH fallback adds a source-supported recursion risk beyond the dash syntax error. Do not implement a wrapper installer or claim #787 delivered; close this docs report only after the corrected guide is published.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.
