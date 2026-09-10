# Issue #762: [Feature Request] Support arm64 docker images

## Metadata
- **Reporter**: @AngeloAvv
- **Created**: 2024-08-23
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/762

## Problem Summary
Docker image currently built for amd64 only. Need arm64 variant for Ampere cloud machines.

## Validation Steps
1. Inspected `.github/workflows/deploy_docker.yml` and the release workflow on current `origin/main`.
2. Confirmed both use Docker Buildx/QEMU but omit the `platforms:` input.
3. Checked PR #845; it proposed ARM64 Docker support but is closed without merge.

## Evidence
```text
.github/workflows/deploy_docker.yml
  docker/build-push-action@v5
  no platforms: linux/amd64,linux/arm64

PR #845: CLOSED, mergedAt: null
```

## Current Status in v4.1.2
- [x] Still unresolved
- [ ] Already implemented
- [ ] Needs more information

## Troubleshooting/Implementation Plan
1. Update `.github/workflows/deploy_docker.yml` to build multi-arch images (`platforms: linux/amd64,linux/arm64`) using Buildx.
2. Ensure Dockerfile is architecture neutral (no prebuilt binaries). If necessary, download correct Dart SDK/Flutter packages for each arch.
3. Consider tag naming (e.g., include `-arm64`).
4. Inspect and reuse any safe parts of closed PR #845, then verify the published manifest contains both architectures.

## Recommendation
- Priority: **P2 - Medium**
- Suggested Folder: `validated/p2-medium/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: Docker ARM64 is not delivered merely because standalone ARM binaries exist. PR #1053 remains open pending real multi-architecture validation.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: Docker ARM64 is not delivered merely because standalone ARM binaries exist. PR #1053 remains open pending real multi-architecture validation.
- **Source**: .github/workflows/deploy_docker.yml; open PR #1053 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-08-23; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
