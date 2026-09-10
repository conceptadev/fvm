# Issue #826: [Feature Request] Add package to Winget

## Metadata
- **Reporter**: @AMDphreak
- **Created**: 2025-02-25
- **Reported Version**: Packaging request
- **Issue Type**: feature request
- **URL**: https://github.com/leoafarias/fvm/issues/826

## Problem Summary
FVM currently distributes Windows packages via Chocolatey. The reporter notes Chocolatey lag and asks for a native Winget package.

## Version Context
- Current version: v4.0.0
- Winget support does not exist yet.

## Validation Steps
1. Reviewed `.github/workflows/release.yml`: deploy jobs cover Pub, GitHub, Homebrew, Chocolatey, Docker. No Winget pipeline.
2. A search of the Winget manifest repository shows no FVM entry (manual check required during implementation).

## Evidence
```
.github/workflows/release.yml  // no winget step
```

## Troubleshooting/Implementation Plan

### Root Cause Analysis
The release automation only targets Pub, Homebrew, Chocolatey, and Docker, so Windows users who prefer Winget cannot install or update FVM through their native package manager. Chocolatey delays prompted the request.

### Proposed Implementation Plan
1. Create Winget manifest(s) under a new `.winget` directory or integrate into release automation.
2. Use `wingetcreate` or the official Winget YAML schema. Manifests reside in `manifests/f/Fvm/Fvm/`. Define installer (portable .zip or MSI) referencing GitHub release assets.
3. Add GitHub Action step (Windows runner) after Chocolatey deploy to:
   - Download latest release asset.
   - Run `wingetcreate update` or `wingetcreate submit` with manifest updates.
   - Submit PR to `microsoft/winget-pkgs` repo (requires PAT and automation similar to `pkg-homebrew-update`).
4. Document Winget install instructions in `docs/pages/documentation/getting-started/installation.mdx` (Windows section).
5. Coordinate version bump process (Winget requires manual PR review; include fallback instructions if automation blocked).

## Recommendation
- Priority: **P2 - Medium** (expands distribution reach)
- Suggested Folder: `validated/p2-medium/`

## Notes for Follow-up
- Ensure licensing compliant; Winget requires silent install support (portable is fine). Might reuse Windows `.zip` shipped today.

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: Winget manifests/release automation remain packaging work; native Windows archives alone do not fulfill it.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: Winget manifests/release automation remain packaging work; native Windows archives alone do not fulfill it.
- **Source**: Current winget-pkgs code search returned no FVM manifest; issue #1050 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2025-02-25; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 housekeeping follow-up

Added windows label; Winget is Windows package distribution. Enhancement and triage:backlog remain. No category or priority change. See [housekeeping recommendations](housekeeping-plan-2026-09-08.md).


## 2026-09-08 issue cleanup completed

Linked #1050 for ARM64 delivery and distinguished #1058's Chocolatey conflict. General Winget support, including x64, remains open here.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/826#issuecomment-5592553299). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
