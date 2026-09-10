# Housekeeping and consolidation recommendations — 2026-09-08

Execution update: the [consolidation cleanup](issue-cleanup-2026-09-08.md) and [legacy cleanup](legacy-cleanup-2026-09-08.md) are complete. There are now 36 open issues; #764 is consolidated into #681, #607/#674/#738 are retired as not planned, and #759/#781 have a September 22 diagnostic deadline. The recommendations below remain planning history, not the live queue.

Follow-up: the [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md) supersedes this document's broader implementation batch. Only #1048 and #782 are recommended for the next fix PRs; consolidation remains conditional on preserving unique requirements. The plan also clarifies the closed-unmerged #828 decision. Historical recommendations below remain for context, not execution approval.

## Status and scope

Live recheck: **40 open issues**, each with exactly one review-state label. Counts remain 7 evidence-backed defects, 2 IDE compatibility reports, 4 needs-info and 27 feature/design backlog items. No further issue closure was justified merely by age.

This pass verifies/corrects tags and recommends broader cleanup. It does **not** execute duplicate closures, rewrite issue bodies, create tracking issues, send information requests, adopt an automatic stale policy, or implement product fixes.

## Tag cleanup completed

- **#826**: added the existing `windows` label to the Winget request.
- **#635**: removed `good first issue`. Its JSONC-preserving edit needs careful handling of comments, escaping, nesting and existing formatting; the current historical plan itself documents these risks. Kept `bug`, `triage:confirmed` and `help wanted`.
- Verified all 40 retain exactly one of `triage:confirmed`, `triage:backlog`, `triage:upstream`, or `need info`.
- Kept #689's historic bug label plus enhancement because the report mixes legacy third-party completion behavior and an unimplemented plaintext-output request. Its review state remains backlog, not confirmed.
- Did not add an `old`, `invalid` or automated `stale` label. Age is already recorded separately in local JSON, including pre-label activity dates.

## Recommended order

1. Consolidate requirements into existing lead issues, without erasing unique acceptance criteria.
2. Give unverified reports one targeted request for current diagnostics; only then apply a response window.
3. Make explicit maintainership decisions on optional older feature work.
4. Fix the small confirmed defects and setup-success bug before adding more feature scope.
5. Simplify local triage bookkeeping so different summaries cannot drift.

## Proposed workstream leads

These are planning groupings, not executed GitHub parent/child changes or proof of duplication.

| Workstream | Proposed lead | Related issues | Closure boundary |
| --- | --- | --- | --- |
| Version constraints / patch selection | #751 | #577, #648, #1016; #583 for upgrade lifecycle | Keep separate input/upgrade semantics until their acceptance criteria are represented. |
| Project SDK links and branch switching | #681 | #764, #743, #821; #702 for multi-root IDE capability | #764 is the strongest consolidation candidate, but first preserve its stable-link/checkout requirements in #681. Do not call it fixed. |
| Windows package distribution | #1050 | #826, #1058; diagnostic #781 | Winget support and Chocolatey Dart pinning are separate deliverables; retain the defect until its actual package behavior is fixed. |
| Alternate SDK distributions / target routing | #1042 | #757, #1074 | A fork URL, a distribution-specific CLI and automatic platform selection are not interchangeable features. |
| Shell SDK selection | #787 | #784; defect #782 | Session-local selection differs from project-aware shims; keep explicit acceptance criteria for both. |

Keep #724/#767 linked as IDE compatibility reports, not automatically merged into project-link work: doctor metadata and actual plugin path normalization are different observations.

For any consolidation: summarize the smaller report's requirements in the lead issue, add reciprocal links, then close the redundant report with a clear **consolidated into #N** explanation. Use completed only for delivered work, never merely for moving the discussion. Reopen/retain the child if it has requirements the lead does not cover.

## Needs-info policy proposal

Apply to **#759, #781, #1009, #1017**:

- Ask once for the exact missing diagnostics, not another generic checklist.
- Start a proposed **30-day response window from that actual request**, not from this label update or issue creation. No requests or deadline were posted in this pass.
- Before closing, recheck for responses and current linked reproductions. If still unactionable, close **not planned / insufficient reproduction**, with a fresh-report or reopen path; do not call it fixed or invalid.
- Keep #1009's direct-SDK-versus-FVM comparison distinct from #781's Chocolatey installation logs and #759/#1017's editor/PATH diagnostics.

## Optional older feature work: explicit decisions, not “fake bug” labels

- **#607 Snap/Flatpak**: strongest candidate for a deliberate not-planned decision. The reporter said an install script met the no-Homebrew preference, and that path exists. Snap/Flatpak support itself is not implemented. Recommend closing only if maintaining those distributions is outside the intended scope.
- **#738 Codespaces template**: defer unless a contributor owns the template and maintenance. Publishing Docker images alone does not fulfill it.
- **#674 general context flags**: optional internal refactoring, already partially implemented. Move remaining acceptance criteria into a concrete engineering task when work is scheduled; otherwise defer rather than treating it as a user-visible defect.
- Keep older, concrete behavior reports such as #635, #761 and #782: they have present-day evidence. Do not close #767, which has 2026 confirmations.
- Valid enhancements may still be declined on maintenance/scope grounds. Explain that decision as **not planned**, not **invalid**.

## Small implementation batch to schedule

- #782: safe shell-wrapper documentation.
- #1048: remove misleading warning for intentional VS Code opt-out.
- #761: reject a misspelled command even with a global version flag.
- #968: propagate ordinary SDK setup failure and avoid false-success messages; prioritize its impact over cosmetic cleanup.
- Keep #635 separate until the JSONC editing approach is designed and tested; no simplistic regex recommendation should be treated as a ready-to-merge solution.
- Leave Docker ARM64 PR #1053 on hold until multi-architecture build/manifest validation succeeds.

## Local organization recommendations

Current read-only audit found:

1. `TRIAGE_AGENT.md` and `artifacts/validation-template.md` still hardcode 4.0.0 as current and use old priority descriptions. Make the version a verified baseline field and align priority guidance with README's impact-based rules.
2. `validated/` contains both bugs and enhancements. Keep existing paths for now to avoid breaking historical links; document `reviewCategory` and `evidenceLevel` as authoritative.
3. Generate the README counts, active checklist and category view from per-issue JSON instead of maintaining three independent copies. Add a read-only validator for exactly-one-active-record, valid links, labels and live GitHub parity.
4. Keep dated reports historical and link to one current index. Preserve existing evidence and pre-label activity timestamps; do not rewrite old reports to imply their old findings were current.
5. Use one repository or saved-filter view for each review category. Avoid adding redundant priority/age/status labels until there is a concrete filtering need.

## Verification

Refreshed live GitHub after the two tag edits; local snapshots updated. Counts, exactly-one review label, per-issue JSON/artifact links and summary statistics checked before handoff. No product tests or code changes in this organizational pass.
