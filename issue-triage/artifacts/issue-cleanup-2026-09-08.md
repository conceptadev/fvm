# Issue cleanup completed — 2026-09-08

Historical record of the first cleanup pass. The [later legacy cleanup](legacy-cleanup-2026-09-08.md) retired #607, #674 and #738 as not planned, leaving 36 open issues, and added a September 22 diagnostic deadline for #759/#781. Earlier counts and no-deadline notes below describe this first pass.

The approved issue cleanup is complete. #764 was consolidated into #681 after its requirements were recorded there. Eleven other issues received scope summaries or diagnostic requests. No product code, PR, or release was changed.

## Consolidation

[#681's summary](https://github.com/leoafarias/fvm/issues/681#issuecomment-5592539768) preserves retained per-version SDK links, SDK consistency after checkout, #764's relative/removable flutter_sdk proposal, questions about the other .fvm metadata files, and missing/removed-cache behavior. The implementation remains undecided.

[#764 was closed](https://github.com/leoafarias/fvm/issues/764#issuecomment-5592548403) as consolidated, using GitHub's not_planned reason and duplicate label. Its enhancement label remains; the active triage:backlog label was removed. The original body and title are unchanged. This is not a claim that SDK switching was fixed.

## Scope summaries posted

| Issue | What the reply records |
| --- | --- |
| [#751](https://github.com/leoafarias/fvm/issues/751#issuecomment-5592552450) | Related range, partial-version, pubspec and Dart-constraint requests, plus the unresolved exact-version policy in #421. |
| [#1016](https://github.com/leoafarias/fvm/issues/1016#issuecomment-5592552662) | Its latest-patch installation and fvm list patch-indicator requirements stay separate from #751. |
| [#648](https://github.com/leoafarias/fvm/issues/648#issuecomment-5592552873) | The three original Dart requirements remain open. fvm list has a Dart column; fvm releases does not, and #828 was closed unmerged. |
| [#1050](https://github.com/leoafarias/fvm/issues/1050#issuecomment-5592553080) | ARM64 package-manager delivery links to, but does not replace, Winget and Chocolatey tasks. |
| [#826](https://github.com/leoafarias/fvm/issues/826#issuecomment-5592553299) | General Winget support, including x64, remains its own request. |
| [#1058](https://github.com/leoafarias/fvm/issues/1058#issuecomment-5592553483) | The supplied log establishes an exact Chocolatey dependency conflict, not Dart-source incompatibility. |

All six remain open. Their related issues were linked without a feature commitment or an unsupported duplicate closure.

## Diagnostic requests posted

| Issue | Missing evidence requested |
| --- | --- |
| [#759](https://github.com/leoafarias/fvm/issues/759#issuecomment-5592553676) | Current editor/FVM versions, SDK settings, launch configuration/error and working FVM invocation. |
| [#781](https://github.com/leoafarias/fvm/issues/781#issuecomment-5592553860) | Chocolatey/package versions, failing install command/log and executable resolution. |
| [#1009](https://github.com/leoafarias/fvm/issues/1009#issuecomment-5592554039) | A minimal public fork without company code, plus direct-Flutter versus FVM output at the same commit. |
| [#1017](https://github.com/leoafarias/fvm/issues/1017#issuecomment-5592554276) | Fresh terminal resolution, versions, doctor/settings and the action opening an elevated terminal. |

All four retain need info. Requests acknowledge the evidence already supplied and ask reporters to redact private details. No response deadline or automatic closure policy was added. Maintainer replies are recorded separately from the preserved pre-cleanup reporter activity dates.

## Left untouched

- #607 remains open: the user has not decided to rule out Snap/Flatpak maintenance.
- #421's version-resolution policy and the closed-unmerged #828 decision were not changed.
- #1048 and #782 remain proposed fix PRs; no implementation or new PR was started.
- #1053 remains the only open PR and was not modified or merged.
- Original issue bodies and titles were preserved. No reports were closed just because they predate FVM 4.0.

## Final queue

- 39 open issues and 1 open PR.
- 7 confirmed defects, 2 IDE compatibility reports, 4 needs-info reports and 26 feature/design requests.
- 27 P2, 8 P3 and 4 needs-info; no P0/P1.
- 77 archived records, including #764. Historical total remains 116.
- 26 open issues were created before FVM 4.0; this is an age marker, not an affected-version assertion.

## Evidence and verification

All 12 posted replies were fetched back from GitHub and matched their saved bodies. The 12 affected issues retained their original titles and descriptions. #607 was also checked and remains untouched. Comparing the live open set before and after the pass found only #764 removed, with no new intake.

Final local checks passed: 39 unique active records match the live issue list, snapshot and active checklist; all 77 archived records parse; artifact/plan links resolve; category and priority counts agree; every open issue has exactly one review-state label. The tracked diff has no whitespace errors or changes outside issue-triage.

Comment text, URLs and timestamps are preserved in the [comment journal](../comment_logs/issue-cleanup-2026-09-08.json). The [archived #764 record](../closed/issue-764.json) records the closure reason and surviving issue. Pre/post snapshots and exact request payloads are saved in `.context/issue-cleanup-8rsXFs/`.

The Human Writing skill was used to keep the public replies specific and direct while preserving technical caveats. No product tests were run: this pass changed GitHub issue administration and local triage records only.
