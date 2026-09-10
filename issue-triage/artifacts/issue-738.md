# Issue #738: [Feature Request] publish fvm DockerFile to github marketplace

Current disposition — 2026-09-08: [closed as not planned](https://github.com/leoafarias/fvm/issues/738#issuecomment-5593075538) because the maintainer declined an official Codespaces/devcontainer template; Docker ARM64 remains separate in #762. The historical proposals below are not scheduled. This is not a verified fix.

## Metadata
- **Reporter**: @Alvish0407
- **Created**: 2024-06-10
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/738

## Problem Summary
Request for a preconfigured Dockerfile/devcontainer for GitHub Codespaces. FVM already ships a Dockerfile (`.docker/Dockerfile`) but not a published devcontainer template.

## Version Context
- Current target: FVM 4.1.2 / current `origin/main`.
- The repository still has `.docker/Dockerfile`, but no `.devcontainer/` template or Codespaces configuration.

## Validation Steps
1. Checked current `origin/main` for Docker and devcontainer files.
2. Confirmed `.docker/Dockerfile` exists and is used by release workflows.
3. Confirmed no `.devcontainer/devcontainer.json` or published template metadata exists.

## Evidence
```text
.docker/Dockerfile                         present
.github/workflows/deploy_docker.yml       present
.devcontainer/devcontainer.json           absent
```

## Current Status in v4.1.2
- [x] Still applicable
- [ ] Already implemented
- [ ] Needs more information

## Troubleshooting/Implementation Plan
- Create `.devcontainer/devcontainer.json` referencing FVM Docker image and publish to GitHub Marketplace.
- Add a smoke workflow that opens a sample Flutter project, installs its pinned SDK, and runs `flutter --version`.
- Document image tags, supported architectures, cache persistence, and Codespaces usage.

## Recommendation
- Priority: **P2 - Medium**
- Suggested Folder: `validated/p2-medium/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: a Codespaces/devcontainer template is distinct from publishing a Docker image; no implemented template established here.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2: a Codespaces/devcontainer template is distinct from publishing a Docker image; no implemented template established here.
- **Source**: Dockerfile; .github/workflows/deploy_docker.yml; no tracked devcontainer/marketplace template found (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-06-10; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
