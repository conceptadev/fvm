# Legacy issue cleanup — 2026-09-08

Closed three optional requests as not planned after the maintainer approved narrowing the backlog. Two older reports remain open with a diagnostic deadline. No product code, PR or release was changed.

## Closed as not planned

| Issue | Decision |
| --- | --- |
| [#607 — Snap/Flatpak](https://github.com/leoafarias/fvm/issues/607#issuecomment-5593074742) | Not taking on these packages. The install script addresses installation without Homebrew, but does not deliver Snap/Flatpak support. |
| [#674 — flags/context refactor](https://github.com/leoafarias/fvm/issues/674#issuecomment-5593075163) | Retired the optional internal refactor. Partial context support is not completion of the broader request. |
| [#738 — Codespaces template](https://github.com/leoafarias/fvm/issues/738#issuecomment-5593075538) | Not maintaining an official Codespaces/devcontainer template. Docker ARM64 #762 and PR #1053 remain open and separate. |

All three have GitHub reason `not_planned`. Removed their active `triage:backlog` label and retained the original titles, bodies and other labels. Their per-issue records are now in `closed/`. These are maintenance decisions, not verified fixes.

## Diagnostics due September 22

[#759 — VS Code SDK selection](https://github.com/leoafarias/fvm/issues/759#issuecomment-5593075976) and [#781 — Chocolatey installation](https://github.com/leoafarias/fvm/issues/781#issuecomment-5593076111) retain `need info`. The short follow-ups link the specific diagnostic requests already posted.

Reporters have through September 22, 2026. On or after September 23, review new replies before considering a not-planned closure if a current reproduction is still missing. The issues can be reopened when those details arrive. #759 asks for the latest FVM release (currently 4.3.1); #781 asks about the latest package available through Chocolatey, without assuming package-manager publication matches the release.

No automatic closure is scheduled. This response window applies only to these two issues; #1009 and #1017 have no deadline.

## Remaining queue

36 open issues: 7 confirmed defects, 2 IDE compatibility reports, 4 needs-info and 23 feature/design requests. Priorities: 25 P2, 7 P3 and 4 needs-info; no P0/P1. There are 80 archived records and 116 historical items.

23 open issues predate FVM 4.0. This is an age marker, not proof of an affected version. Confirmed pre-4.0 bugs #635/#761/#782 and active IDE reports #724/#767 remain open.

## Evidence

Fresh preflight reads found no new reporter evidence on the five targets. All five replies were fetched back and matched their saved text. Original issue titles and bodies were preserved. The live open set changed only by removing #607/#674/#738; PR #1053 is still the only open PR and was not edited.

Exact replies, timestamps and closure receipts are in the [comment journal](../comment_logs/legacy-cleanup-2026-09-08.json). Pre/post snapshots and request payloads are in `.context/legacy-cleanup-CfQ7TS/`. Per-issue JSON retains reporter-activity dates separately from today's maintainer replies.

The Human Writing skill kept the public replies short and specific without claiming the issues were fixed. No product tests were run because this pass only changed issue administration and triage records.

Final checks passed: the live issue list, snapshot, 36 active records and checklist match; 80 archive records parse; category/priority counters and artifact links agree. The final GitHub refresh found no further changes. The tracked diff has no whitespace errors or product-file changes.
