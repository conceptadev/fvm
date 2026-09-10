# Issue #787: [Feature Request] Add alias command files for execute directly `flutter`

## Metadata
- **Reporter**: @quyenvsp
- **Created**: 2024-10-10
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/787

## Problem Summary
Request to ship wrapper scripts (`flutter`, `dart`, `fvm`) so users can run `flutter` directly through FVM without prefixing commands.

## Current Behavior
- FVM offers `fvm global` (adds `~/.fvm/default/bin` to PATH) and project symlinks (`.fvm/flutter_sdk/bin`). Users can already set PATH to those directories.
- Reporter provided alias scripts used locally for 2 years.

## Validation Steps
1. Confirmed current FVM maintains a global SDK link and documents adding its `bin` directory to PATH.
2. Confirmed FVM does not ship `flutter`/`dart` wrapper executables alongside the FVM binary.
3. Confirmed project-local direct resolution still requires IDE configuration, shell hooks, or manual PATH changes.

## Evidence
```text
Current commands include `fvm global`, `fvm flutter`, and `fvm dart`.
No packaged alias/flutter or alias/dart wrappers exist on origin/main.
```

## Considerations
- Adding wrappers could simplify setup, especially on Windows.
- Need to ensure wrappers respect `fvm use` project settings and global version, and don't conflict with existing Flutter installations.

## Troubleshooting/Implementation Plan
1. Evaluate existing `global` command behavior; confirm direct `flutter` via symlink meets requirement. Document this path first.
2. If wrappers still useful (e.g., for CI), package optional `bin/flutter` and `bin/dart` scripts calling `fvm flutter`/`fvm dart`.
3. Update installer to create wrappers only when safe (avoid overwriting existing binaries).
4. Document usage and potential conflicts.
5. Test command resolution when a system Flutter is already earlier on PATH and on Windows where wrapper/shim behavior differs.

## Recommendation
- Priority: **P3 - Low** (quality-of-life enhancement; alternative already exists via PATH)
- Suggested Folder: `validated/p3-low/`

## 2026-09-04 Revalidation Update
- New comment from @Iizuki (2026-09-02): they want a rustup/ghcup-style global `flutter` on PATH and say the docs imply this already works on Linux.
- That is already the `fvm global` + `~/.fvm/default/bin` PATH workflow, plus `fvm flutter` / `fvm dart`. The request is still documentation/ergonomics, not a setup blocker.
- Keep **P3**. Not urgent.

---
**Validated by**: Code Agent
**Date**: 2025-10-30
**Last revalidated**: 2026-09-04

## Notes for Follow-up
- Might close after improving docs explaining how to add `.fvm/flutter_sdk/bin` to PATH.

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: rustup-style global project-aware flutter shims are not equivalent to fvm global plus PATH; September 2026 interest keeps the request current.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P3: rustup-style global project-aware flutter shims are not equivalent to fvm global plus PATH; September 2026 interest keeps the request current.
- **Source**: lib/src/commands/global_command.dart; docs/pages/documentation/guides/running-flutter.mdx (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-10-10; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
