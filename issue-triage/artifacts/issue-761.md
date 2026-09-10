# Issue #761: [Feature Request] when we typo, show error

## Metadata
- **Reporter**: @shinriyo
- **Created**: 2024-08-22
- **Issue Type**: UX bug
- **URL**: https://github.com/conceptadev/fvm/issues/761

## Problem Summary
Typos like `fvm fluter --version` should produce an error, but currently FVM ignores the unknown token and just prints the version (because `--version` is handled as a global flag).

## Validation Steps
1. Reproduced against the current branch: `dart run bin/main.dart fluter --version`.
2. Confirmed it printed the package version and exited successfully.
3. Inspected `FvmCommandRunner.runCommand`; top-level `--version` is handled before the unknown command is rejected.

## Evidence
```text
$ dart run bin/main.dart fluter --version
4.1.1
$ echo $?
0
```

## Troubleshooting/Implementation Plan
In `FvmCommandRunner.run`, after parsing args, detect `argResults.rest` when no command selected and throw `UsageException` with unknown command message.
Add regression tests for typos with and without top-level flags, ensuring valid `fvm --version` remains successful.

## Recommendation
- Priority: **P3 - Low**
- Suggested Folder: `validated/p3-low/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: typo/unknown-command handling is not shown fixed by the release; retain until the global --version interaction is reproduced and tested.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: bug / confirmed; GitHub label `triage:confirmed`.
- **Evidence level**: reproduced_4.3.1. Published macOS ARM64 4.3.1: fluter --version prints 4.3.1 with exit 0; fluter alone correctly returns usage error 64.
- **Source**: lib/src/runner.dart:300; published fvm-4.3.1-macos-arm64.tar.gz (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Validate unknown commands before honoring a global version flag, with regression tests.
- **Age**: opened 2024-08-22; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
