# Current Closure Decisions

Revalidated on 2026-09-08 against live GitHub and FVM 4.3.1.

- Completed: #584 (custom remotes), #600 (Android Studio documentation), #811 (Nix package), #578 (MacPorts).
- Legacy support reports retired as not planned, not proven fixed: #731, #797, #809, #906.
- Already closed; local records reconciled: #1021, #1046, #1064.
- Consolidated, not fixed: #764 into #681, with its distinct requirements preserved.
- Optional requests declined by the maintainer: #607 (Snap/Flatpak), #674 (flags/context refactor), #738 (Codespaces/devcontainer template). All three are closed as not planned, not completed.

See the [first closure audit](artifacts/issue-closure-audit-2026-09-08.md), [consolidation cleanup](artifacts/issue-cleanup-2026-09-08.md) and [latest legacy cleanup](artifacts/legacy-cleanup-2026-09-08.md) for the evidence and public replies.

## Follow-up after September 22

#759 (VS Code SDK selection) and #781 (Chocolatey installation) remain open with `need info`. Reporters have through September 22, 2026 to supply current diagnostics. On or after September 23, read any new replies before considering closure as not planned if a current reproduction is still missing. Reopen when useful diagnostic details arrive.

No automatic closure is scheduled. #1009 and #1017 have no deadline. Do not close confirmed bugs, active IDE reports or other feature requests solely because they predate FVM 4.0.

## Remaining queue

36 open issues: 25 P2, 7 P3 and 4 needs-info; no P0/P1 identified. By evidence: 7 confirmed defects, 2 IDE compatibility reports, 4 needs-info and 23 feature/design requests. There are 80 archived records.

The only open PR is #1053 (Docker ARM64). It remains on hold pending multi-architecture build and manifest validation. Release 4.3.1 is already published. No product fix or new PR was made during this cleanup.
