# Issue #784: [Feature Request] Set specified version of Flutter SDK in current terminal environment

## Metadata
- **Reporter**: @SunJenry
- **Created**: 2024-09-20
- **Issue Type**: feature request
- **URL**: https://github.com/conceptadev/fvm/issues/784

## Problem Summary
User wants to temporarily use a specific Flutter version in the current shell session without modifying global config or creating project files.

## Validation Steps
1. Inspected current commands on `origin/main`.
2. Confirmed `fvm spawn <version> <command>` and `fvm flutter` affect child commands only.
3. Confirmed no command prints shell exports for evaluation in the caller's current shell.

## Evidence
```text
Available related commands: global, spawn, flutter, dart, exec.
No env/current command or shell-export output exists.
```

## Current Status in v4.1.2
- [x] Still unresolved
- [ ] Already implemented
- [ ] Needs more information

## Existing Workarounds
- `fvm flutter <command>` or `fvm spawn <version> <command>` cover individual commands but still require prefix.

## Troubleshooting/Implementation Plan
- Add `fvm env <version>` that prints export commands, e.g. `eval "$(fvm env stable)"`, to prepend the version’s `bin` directory for the current shell. No files touched.
- Provide `fvm env --unset` to restore defaults.
- Define separate output for POSIX shells, fish, and PowerShell and add quoting tests for paths containing spaces.

## Recommendation
- Priority: **P3 - Low**
- Suggested Folder: `validated/p3-low/`

## Notes for Follow-up
- Document usage including Windows PowerShell equivalents.

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P3: temporary shell-scoped SDK selection differs from project/global selection; an env/export workflow remains unimplemented.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P3: temporary shell-scoped SDK selection differs from project/global selection; an env/export workflow remains unimplemented.
- **Source**: lib/src/runner.dart command registration; lib/src/commands/exec_command.dart (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-09-20; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
