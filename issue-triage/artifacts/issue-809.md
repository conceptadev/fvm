# Issue #809: [BUG]: cannot update to newer flutter version (sidekick related)

## Metadata
- **Reporter**: @Ahmadre
- **Created**: 2024-12-29
- **Reported Version**: FVM 3.2.1
- **Issue Type**: bug (needs reproduction)
- **URL**: https://github.com/conceptadev/fvm/issues/809

## Problem Summary
Reporter references Sidekick issue #280 where Sidekick warns about local changes preventing upgrade. Believes underlying problem lies in FVM. No logs or reproduction steps provided.

## Validation Steps
- Without logs or steps, we cannot confirm behavior. `EnsureCacheWorkflow` already performs `git reset --hard` and `clean -fd` before fetching (see `ensure_cache.workflow.dart`), so need more info to diagnose.

## Evidence
```text
Reported version: FVM 3.2.1
Reporter explicitly says reliable reproduction steps are unavailable.
No verbose FVM CLI log or current 4.1.2 reproduction is attached.
The observed message originates from a Sidekick workflow.
```

## Troubleshooting/Implementation Plan
1. Request the reporter to provide `fvm install <version> --verbose` output and contents of `.fvm` cache directory when the warning occurs.
2. Confirm whether the issue only appears via Sidekick or also using CLI.
3. Reproduce on FVM 4.1.2 before changing current cache-reset behavior.
4. If CLI succeeds and only Sidekick fails, move the issue to the Sidekick integration tracker.

## Recommendation
- Folder: `needs_info/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes earlier recommendations above.

- **Decision**: close as not planned; Retire the FVM 3.2.1 Sidekick follow-up; original tracking stays in sidekick#280, no reliable CLI reproduction.
- **Evidence**: Reporter explicitly describes this as a reminder/follow-up to sidekick#280 and cannot offer reliable reproduction. Last January 2025 comment is a separate nonexistent custom-remote error, not evidence of the original upgrade failure. Linked Sidekick issue remains open.
- **Validation**: live issue body/comments, current origin/main at a6d93976d443082d73d4718750713e6248de6b84, and relevant source/docs inspected. No product changes or full runtime reproduction.
- **Follow-up plan**: No fix is inferred. Reassess a fresh current-version reproduction with the diagnostics requested in the closure comment.
- **GitHub explanation**:

Closing this FVM 3.2.1 reminder/follow-up as not planned. The original Sidekick report remains tracked at https://github.com/leoafarias/sidekick/issues/280, and this thread does not contain reliable standalone FVM reproduction steps. The later `Repository not found` comment is a different custom-remote failure.

This is not a claim that the underlying Sidekick upgrade behavior is fixed. If it reproduces with FVM 4.3.1 directly from a terminal, please open a fresh FVM issue with the exact commands, configured remote, `fvm doctor`, and full verbose output. Preserve any SDK-local changes while investigating.

**Verified closure**: 2026-09-08T15:03:35Z, GitHub reason `not_planned`. [Closure comment](https://github.com/leoafarias/fvm/issues/809#issuecomment-5587262156).
