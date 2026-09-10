# Issue #607: Support flatpak or snaps on Linux.

Current disposition — 2026-09-08: [closed as not planned](https://github.com/leoafarias/fvm/issues/607#issuecomment-5593074742) because the maintainer declined Snap/Flatpak maintenance; the install-script alternative does not mean those packages shipped. The historical proposals below are not scheduled. This is not a verified fix.

## Metadata
- **Reporter**: @safield
- **Created**: 2024-02-13
- **Reported Version**: 3.0.x
- **Issue Type**: enhancement (distribution)
- **URL**: https://github.com/leoafarias/fvm/issues/607

## Problem Summary
Linux users currently install FVM via Homebrew (or the install script). Homebrew on Linux is uncommon, so providing native packaging (Snap/Flatpak) would simplify onboarding and align with the distribution channels many distros expect.

## Version Context
- Reported against: 3.0.x
- Current version: v4.0.0
- Version-specific: no — release engineering gap.

## Validation Steps
1. Reviewed the repository — no Snapcraft or Flatpak manifests exist.
2. Checked current release docs (`docs/pages/documentation/getting-started/installation.mdx`) — Linux instructions mention Homebrew and shell script only.
3. Audited build tooling — the GitHub Actions release workflow already produces standalone binaries, which can be repackaged for Snap/Flatpak.

## Evidence
```
$ ls snap
ls: snap: No such file or directory

$ rg "flatpak" -n
# no hits besides the issue text
```

**Files/Code References:**
- Release automation lives in `.github/workflows`, but no Linux-native packaging targets.

## Current Status in v4.0.0
- [x] Still reproducible (feature missing)
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Proposed Solution
1. **Snap package (preferred first step):**
   - Author `snap/snapcraft.yaml` using `base: core22`, stage the compiled `fvm` binary and dependencies.
   - Request `classic` confinement (FVM needs unrestricted access to `$HOME`, git, and user shells).
   - Add a GitHub Actions job that, on tagged releases, builds the Snap (using `snapcraft --use-lxd`) and pushes to the Snap Store edge channel. Promote to stable once verified.
   - Provide instructions for manual testing (`snap install --dangerous`).
2. **Evaluate Flatpak feasibility:**
   - Draft a manifest (YAML/JSON) targeting `org.freedesktop.Platform//23.08`.
   - Determine sandbox permissions (`--filesystem=home`, `--socket=ssh-auth`?) necessary for git, shell integration, and PATH management. If acceptable, submit to Flathub (requires review).
   - If sandbox restrictions are too tight, document the limitation and consider shipping only Snap + shell script.
3. **Update documentation:**
   - Add Linux installation options to the “Installation” docs.
   - Mention required permissions (`snap install --classic fvm`) and potential Flatpak sandbox flags.
4. **Telemetry/Analytics:**
   - Track adoption by monitoring Snap download metrics; adjust support accordingly.

### Dependencies & Risks
- Snap *classic* confinement needs manual review by the Snap Store team; expect lead time.
- Flatpak’s sandbox may conflict with FVM’s need to edit shell profiles; may need to declare as “not supported” if permissions can’t be granted.
- Release automation must handle signing/credentials securely (store tokens via GitHub Secrets).

### Related Code Locations
- `.github/workflows/release.yml` (or equivalent) — extend to build/publish packages.
- `docs/pages/documentation/getting-started/installation.mdx` — update installation instructions.

## Recommendation
**Action**: validate-p3

**Reason**: Improves distribution ergonomics but doesn’t block existing users (install script and binaries still work). Prioritize after higher-impact fixes.

## Notes
- Consider offering Debian/RPM packages later via `apt`/`dnf` if community demand grows.
- Coordinate with marketing/documentation before Flip to ensure announcements coincide with store availability.

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: the reporter accepted an install-script alternative, but Snap/Flatpak packaging itself is not implemented; do not call it completed.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Optional Snap/Flatpak packaging backlog. The official installer addresses the reporter's underlying no-Homebrew need, but no supported Snap/Flatpak FVM distribution was established here.
- **Source**: scripts/install.sh; canonical installation guide; current Snap/Flathub searches did not establish an FVM package (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-02-13; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 low-risk execution-plan follow-up

The live discussion shows the reporter welcomed an install-script alternative, not confirmation of Snap/Flatpak delivery. Recommend a not-planned closure only after an explicit maintenance/scope decision; otherwise retain contributor-led backlog. Do not execute the historical packaging/telemetry plan as a quick win.

Details and verification gates: [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md). Existing priority/category are unchanged. No GitHub mutation or product fix was made in this planning pass.
