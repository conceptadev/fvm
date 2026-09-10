# Issue #781: Cannot find file at '..\lib\fvm\bin\fvm.exe' after Chocolatey install

Current disposition — 2026-09-08: still `need info`, with a [diagnostic response deadline](https://github.com/leoafarias/fvm/issues/781#issuecomment-5593076111) of September 22, 2026. Review new replies on or after September 23 before considering closure as not planned; no automatic closure is scheduled. This supersedes earlier no-deadline notes below and does not establish a fix.

## Metadata
- **Reporter**: @RNOVOSELOV
- **Created**: 2024-09-16
- **Issue Type**: installation bug (needs info)
- **URL**: https://github.com/conceptadev/fvm/issues/781

## Problem Summary
Chocolatey install reports `Cannot find file at '..\lib\fvm\bin\fvm.exe'`. Need more detail about the version and logs.

## Validation Steps
1. Reviewed the live report; it predates FVM 4.x and contains no Chocolatey package version or verbose install log.
2. Confirmed current FVM publishes Windows x64/arm64 zip assets, but Chocolatey packaging is external to the core install script.
3. Could not establish whether the current Chocolatey package still creates the broken shim target.

## Evidence
```text
Reported missing path:
C:\ProgramData\chocolatey\lib\fvm\bin\fvm.exe

Missing: choco package version, install transcript, package directory listing,
and a reproduction on the current FVM/Chocolatey package.
```

## Troubleshooting/Implementation Plan
- Ask for `choco install fvm --force --verbose` output and `dir C:\ProgramData\chocolatey\lib\fvm\` listing.
- Verify whether latest package (v4.0.0) resolves the issue.
- If current, inspect the Chocolatey shim target and package install script; otherwise close as obsolete after reporter confirmation.

## Recommendation
- Folder: `needs_info/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep needs-info: an old Chocolatey missing-executable report may involve a non-ASCII user path. Current packaging alone does not prove that path works; need logs and installed-file inventory.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: support_or_unverified_bug / needs_info; GitHub label `need info`.
- **Evidence level**: unverified_report. Old Chocolatey missing-executable report lacks install logs. Non-ASCII username is a hypothesis, not a proven cause.
- **Source**: issue #781 body/comments; related #1050/#1058 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Obtain package version, Chocolatey logs and installed-file inventory on a current Windows reproduction.
- **Age**: opened 2024-09-16; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.


## 2026-09-08 issue cleanup completed

Requested the package/Chocolatey versions, failing command, relevant install log, command resolution and missing executable check. Username remains a hypothesis. Remains needs-info; no closure deadline.

[Posted maintainer reply](https://github.com/leoafarias/fvm/issues/781#issuecomment-5592553860). Original issue body and title were verified unchanged. Details: [cleanup audit](issue-cleanup-2026-09-08.md).
