# Issue #600: [Feature Request] Improve docs for configuration Android Studio

## Metadata
- **Reporter**: Matias de Andrea (@deandreamatias)
- **Created**: 2024-02-12
- **Reported Version**: 3.0.x
- **Issue Type**: documentation enhancement
- **URL**: https://github.com/leoafarias/fvm/issues/600

## Problem Summary
After the FVM 3.0 changes, Android Studio/IntelliJ expects the Flutter SDK path to be the `.fvm/flutter_sdk` symlink. The current documentation mentions this briefly, but it doesn’t explain that the symlink updates automatically or how to refresh the IDE, leading users to point at version-specific folders and losing the dynamic benefits.

## Version Context
- Reported against: FVM 3.0.0
- Current version: v4.0.0
- Version-specific: no — the VS Code docs are more explicit, but Android Studio instructions are minimal.

## Validation Steps
1. Read the Android Studio section in `docs/pages/documentation/guides/workflows.mdx`; it lists only three terse steps.
2. Confirmed no screenshots or troubleshooting tips exist in the configuration guide; newcomers may not realize `.fvm/flutter_sdk` is a symlink updated by `fvm use`.
3. Checked recent support threads — multiple questions about Android Studio still referencing the old workflow.

## Evidence
```
$ sed -n '198,210p' docs/pages/documentation/guides/workflows.mdx
1. Open **Project Structure** (Cmd/Ctrl + ;)
2. Set **Flutter SDK path** to: `.fvm/flutter_sdk`
3. Apply and restart IDE
```

**Files/Code References:**
- [docs/pages/documentation/guides/workflows.mdx#L198](../../docs/pages/documentation/guides/workflows.mdx#L198) – Needs richer guidance.
- [docs/pages/documentation/getting-started/configuration.mdx](../../docs/pages/documentation/getting-started/configuration.mdx) – No Android Studio/IntelliJ detail.

## Current Status in v4.0.0
- [x] Still reproducible (docs lack detail)
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
Android Studio users rely on `.fvm/flutter_sdk`, but the docs only list a terse three-step checklist without explaining the symlink behavior or how to refresh the IDE. The lack of guidance causes users to point at version-specific folders and lose the automatic switching FVM provides.

### Proposed Documentation Updates
1. Expand the Android Studio section to include:
   - Explanation that `.fvm/flutter_sdk` is created/updated by `fvm use` (no manual path changes per branch).
   - Instructions to use **File → Sync with Gradle** or **Tools → Flutter → Sync Project** after running `fvm use`.
   - Troubleshooting tips for when the IDE caches an old path (invalidate caches/restart).
   - Mention of the global fallback (if `.fvm/flutter_sdk` missing, run `fvm use`).
2. Add screenshots or GIF showing the Project Structure dialog pointing at `.fvm/flutter_sdk`.
3. Cross-link from the configuration guide to the workflows doc so the advice is discoverable from both places.
4. Include a note for multi-root workspaces / monorepos (point each module to its own `.fvm/flutter_sdk`).

### Alternative Approaches (if applicable)
- Embed a short video tutorial instead of screenshots; whichever is easier to maintain.

### Dependencies & Risks
- Need to capture updated screenshots for the current Android Studio UI.
- Ensure docs remain accurate after other triage items (e.g., issue #681) change project symlink behavior.

### Related Code Locations
- No code changes; purely documentation.

## Recommendation
**Action**: validate-p3

**Reason**: Improves clarity but doesn’t block functionality; treat as doc backlog item.

## Notes
- Once docs are updated, link the issue in release notes so users know where to look.
- Consider adding a `doctor` check that warns when Android Studio points to a version-specific path, as a future improvement.

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes earlier recommendations above.

- **Decision**: close as completed; Android Studio setup documentation shipped in #1056; automatic IDE switching remains tracked in #724/#767.
- **Evidence**: PR #1056 merged; `docs/pages/documentation/guides/android-studio.mdx` covers setup, actual IDE verification, troubleshooting and symlink limitations. Live canonical page returned HTTP 200 with the SDK-path/symlink content on 2026-09-08.
- **Validation**: live issue body/comments, current origin/main at a6d93976d443082d73d4718750713e6248de6b84, and relevant source/docs inspected. No product changes or full runtime reproduction.
- **Follow-up plan**: No implementation needed for the original request. Keep distinct unresolved behavior separately tracked.
- **GitHub explanation**:

The documentation request is now addressed by #1056 and the published [Android Studio guide](https://fvm.app/documentation/guides/android-studio). It covers `.fvm/flutter_sdk`, setup and verification, and the limitation where the Flutter plugin resolves a symlink to its physical SDK path.

Closing the documentation request as completed. This does **not** mean automatic IDE switching or opt-in IDE hooks are implemented: the remaining compatibility work stays open in #767 and #724, including the concerns raised later in this thread.

**Verified closure**: 2026-09-08T15:03:25Z, GitHub reason `completed`. [Closure comment](https://github.com/leoafarias/fvm/issues/600#issuecomment-5587259783).
