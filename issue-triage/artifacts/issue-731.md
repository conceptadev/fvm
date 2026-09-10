# Issue #731: The provided value cache.git is not the root of a git directory

## Metadata
- **Reporter**: @joshua1996
- **Created**: 2024-06-01
- **Issue Type**: needs info
- **URL**: https://github.com/conceptadev/fvm/issues/731

## Problem Summary
Issue description only contains screenshot. Need textual error logs and steps.

## Validation Steps
1. Re-read the live issue body and comments; no textual reproduction or environment details were added.
2. Inspected current git-cache handling, which now validates and can repair/recreate invalid caches.
3. Could not map the screenshot-only message to a current FVM 4.1.2 code path with confidence.

## Evidence
```text
Live issue body: one image attachment only.
Missing: FVM version, OS, command, verbose output, cache path/config, and reproduction steps.
```

## Troubleshooting/Implementation Plan
1. Request `fvm --version`, OS, the exact command, and `--verbose` output.
2. Request `fvm doctor --verbose` plus `FVM_CACHE_PATH`/`FVM_GIT_CACHE_PATH` values.
3. Ask whether deleting only the git cache makes the issue recur on 4.1.2.
4. Reclassify only after the current failing code path is identifiable.

## Recommendation
Request additional details; do not implement from a screenshot-only report.

## Classification Recommendation
- Folder: `needs_info/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes earlier recommendations above.

- **Decision**: close as not planned; Retire the legacy 3.1.5–3.1.7 cache support thread; current hook-environment protection exists, but the original screenshot-only failure is not proven fixed.
- **Evidence**: Last report activity 2024-11-16; no 4.x reproduction. FVM 4.1.4/#1060 introduced repository-env scrubbing for git/flutter/dart (`ProcessService`) with regression tests in `test/services/process_service_test.dart`; 4.1.0 replaced the cache architecture. Tests inspected, not run in this triage.
- **Validation**: live issue body/comments, current origin/main at a6d93976d443082d73d4718750713e6248de6b84, and relevant source/docs inspected. No product changes or full runtime reproduction.
- **Follow-up plan**: No fix is inferred. Reassess a fresh current-version reproduction with the diagnostics requested in the closure comment.
- **GitHub explanation**:

Closing this legacy FVM 3.1.5–3.1.7 support thread as not planned. The cache implementation has since been replaced, and 4.1.4 (#1060) specifically addressed inherited Git repository variables when FVM runs inside hooks—the concrete submodule/pre-commit case described here.

That does not establish that every failure behind the original screenshot has been fixed. If this still happens on FVM 4.3.1, please open a fresh report with the exact command, full verbose output, `fvm doctor`, and whether it runs inside a submodule/worktree hook. Please preserve the existing cache and repository while collecting diagnostics; the old cache-deletion and global Git-tuning suggestions above are not a general fix.

**Verified closure**: 2026-09-08T15:03:29Z, GitHub reason `not_planned`. [Closure comment](https://github.com/leoafarias/fvm/issues/731#issuecomment-5587260637).
