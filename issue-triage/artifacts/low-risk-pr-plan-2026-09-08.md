# Low-risk PR and consolidation plan — 2026-09-08

Execution update: the [consolidation cleanup](issue-cleanup-2026-09-08.md) and [legacy cleanup](legacy-cleanup-2026-09-08.md) are complete. #764 is consolidated into #681; #607/#674/#738 are retired as not planned; #759/#781 have a September 22 diagnostic deadline. Version-resolution policy remains undecided. The product PRs below have not been implemented or opened; baseline counts describe the earlier planning snapshot.

## Decision summary

Recommend two independent fix PRs, followed by one optional triage-documentation PR. Keep issue consolidation separate from implementation. This document is a plan for review, not approval, a delivery commitment, or evidence that the proposed fixes have passed tests.

| Order | Proposed PR title | Scope | Readiness |
| --- | --- | --- | --- |
| 1 | `fix: respect intentional VS Code settings opt-out` | #1048: remove the opt-out warning; retain the early return and debug message; add regression tests | Ready to implement; output-only change |
| 2 | `docs: replace unsafe Flutter and Dart wrapper instructions` | #782: withdraw the unsafe executable-wrapper recipe and use explicit proxy commands / existing aliases | Ready to implement; documentation only |
| 3 | `docs(triage): align baseline and priority guidance` | Remove stale “4.0.0 is current” assumptions and inconsistent severity guidance from the active instructions/template | Optional housekeeping; no runtime changes |

No PRs, issue-body updates, comments, closures, or label changes were made in this planning pass. Existing triage work is preserved. The earlier broad housekeeping list is superseded by this narrower implementation batch; #761 and #968 are not part of the low-risk batch.

## Verified baseline and constraints

- Live `main` and local `origin/main` both resolve to `a6d93976d443082d73d4718750713e6248de6b84`; latest published FVM is **4.3.1**.
- The current `issue-triage` branch is still based on **4.1.4**, with existing dirty research changes. Do not open product PRs from this branch or merge the whole triage diff into a product PR.
- Future implementation should start in separate clean worktrees/workspaces based on refreshed `origin/main`. Do not rename this branch or discard its changes. The two fix target files and the existing VS Code workflow test are unchanged between this branch and current main.
- Current main keeps Dart `>=3.6.0 <4.0.0` and `pub_updater >=0.4.0 <0.6.0`. This batch changes neither SDK constraints nor dependencies.
- Live queue: **40 open issues**, **1 open PR (#1053)**. No existing open PR covers #1048 or #782. All 40 issues retain one review-state label: 7 confirmed, 2 compatibility, 4 needs-info, 27 backlog.
- There are 27 open issues created before the 4.0 release. Creation date is an age marker, not proof of the reported version or present validity.

## PR 1 — #1048: intentional VS Code opt-out

### Evidence and files

- [Workflow](../../lib/src/workflows/update_vscode_settings.workflow.dart#L271): explicit `updateVscodeSettings: false` already skips writes, but warns when VS Code, `.vscode`, or a workspace file is detected.
- [Existing test](../../test/src/workflows/update_vscode_settings.workflow_test.dart#L110): checks only that a new settings file is not created; it does not check the message or preservation of existing files.
- [Logger](../../lib/src/services/logger_service.dart#L35) already exposes `outputs`; [test utilities](../../test/testing_utils.dart) provide isolated contexts. No new mocking/logging abstraction is necessary.
- [Live report](https://github.com/leoafarias/fvm/issues/1048) explicitly requests quiet opt-out. The reporter offered to contribute; credit the report and check for new contributor work before starting.

### Implementation checklist

1. Remove only the VS Code detection/warning block inside the disabled-settings branch. Keep its debug message and return in place.
2. Do not add a new configuration option, change defaults, move the unrelated no-pinned-version warning, alter SDK path calculation, or modify JSONC serialization.
3. Extend the existing test file with pinned-project cases for an empty `.vscode` directory, an existing `settings.json`, and a workspace-only `.code-workspace` file.
4. Assert the specific “Please remove updateVscodeSettings” warning is absent. Assert no new settings file is created and existing file contents are byte-for-byte unchanged, including comments/formatting. Existing enabled/default-path tests must continue to pass.
5. Verify the unpinned-project warning remains unchanged; do not accidentally broaden the requirement to suppress every warning.

### Verification and closure

Run the targeted workflow tests first, then format changed Dart files, `dart analyze --fatal-infos`, `dcm analyze lib`, and `dart test`. Run the [manual branch smoke test](../../docs/pages/documentation/guides/manual-smoke-test.md), because the workflow runs during `use` and handles VS Code project updates. Add an isolated opted-out `use` check alongside the normal enabled case. Preserve the smoke test's isolated home/cache/project boundaries; do not run against the user's real SDK cache.

Do not bypass hooks. Open the PR against `main` only with actual command results and clean intended diff. Use `Fixes #1048`; a merge completes the code issue, while release availability should be reported separately. Do not claim the fix is deployed before a release contains it.

## PR 2 — #782: remove unsafe executable-wrapper guidance

### Evidence and scope refinement

[The current guide](../../docs/pages/documentation/guides/running-flutter.mdx#L63) writes executable files without a shebang, uses non-POSIX `${@:1}`, uses `sudo echo` where redirection is not elevated, and recommends deleting conflicting package-manager binaries. The reported Ubuntu `Bad substitution` is supported by the previous dash reproduction.

A syntax-only substitution is not enough to call the whole recipe safe. [PATH fallback](../../lib/src/workflows/run_configured_flutter.workflow.dart) calls `dart`/`flutter` from PATH when no project/global SDK is selected; a same-named executable wrapper can therefore route back to itself. Runtime-dependent FVM launchers are another compatibility boundary. This is a source-supported risk, not a newly executed end-to-end recursion test.

The lowest-risk choice is to **withdraw the process-wide wrapper recipe**, not ship a replacement wrapper installer in a docs patch. This refines the earlier POSIX-wrapper suggestion to keep the batch genuinely small.

### Implementation checklist

1. Replace the macOS/Linux file-creation and blanket deletion examples with explicit `fvm flutter ...` / `fvm dart ...` guidance and the existing `f` / `d` interactive aliases.
2. Explain that aliases are conveniences for interactive shells, not a guarantee that IDEs or globally activated executables resolve through FVM.
3. For users who followed the old recipe, explain how to identify a self-created wrapper and restore the intended SDK PATH without deleting an unrelated or package-manager-owned executable. Avoid generic `rm` instructions.
4. Explain the original missing-shebang / argument-forwarding problem. Do not introduce a global shim feature, SDK-resolution changes, a new install script, or untested Windows examples.
5. Keep [#787](https://github.com/leoafarias/fvm/issues/787) open for packaged project-aware shims. Closing the documentation defect must not imply that feature is delivered.

### Verification and closure

Build docs using the repository's existing Yarn lockfile (`yarn install --frozen-lockfile`, then `yarn build` in `docs/`), and review the rendered changed section/preview. In a disposable shell environment, verify any executable examples actually published, including quoted arguments; assert the removed unsafe recipes are absent. Do not modify the real shell profile, PATH, global package cache, or installed commands for verification. Follow repository pre-push checks; no runtime regression claim follows from a docs build.

Use `Refs #782` while the PR is in review. Close #782 as addressed by corrected documentation only after the merged guide is visible on the live site. Do not claim a blanket fix for all global-package or shim behavior.

## PR 3 — optional triage guidance cleanup

Files: [TRIAGE_AGENT.md](../TRIAGE_AGENT.md), [validation template](validation-template.md), and the relevant explanatory sections of [README](../README.md).

1. Replace hardcoded “current 4.0.0” fields with a verified release, source SHA, and review date. Retain 4.0 as historical migration/age context.
2. Align priority descriptions with README's impact-based rules; documentation bugs are not automatically P0 and installation reports are not automatically P1.
3. State that `reviewCategory` / `evidenceLevel` establish validity; the `validated/` directory contains features as well as defects. Keep historical reports intact.
4. Clarify “fixed”, “consolidated”, “declined”, and “insufficient reproduction”. Preserve the existing no-fixes-during-triage boundary.
5. Validate links, active record uniqueness, category/count parity, and JSON parsing. No folder migrations, generator framework, stale automation, or bulk historical rewrite in this PR.

Port only reviewed instruction/template hunks to a clean main-based branch. Do not include the whole dirty triage queue merely to open this optional PR.

## Issue consolidation — administrative work, not code PRs

### C1 — use #681 as the proposed SDK-link tracking issue

- Re-read [#681](https://github.com/leoafarias/fvm/issues/681) and [#764](https://github.com/leoafarias/fvm/issues/764) with their full discussions. Both request retained per-version links; #764 additionally requests relative/removable `flutter_sdk` links and checkout behavior tied to committed files.
- First add a maintainer summary to #681 preserving all those outcomes, missing/not-yet-cached SDK behavior, and cleanup expectations. Record relative links and automatic triggering as design questions, not accepted implementations.
- Add reciprocal links and keep both open until the maintainer confirms one issue genuinely covers the other. Only then close #764 as **consolidated into #681**, not fixed. Do not change symlink behavior as housekeeping.
- Link #743/#821 as related IDE-path work, not automatic duplicates. #724/#767 and #702 have distinct compatibility/multi-root requirements and stay separate.

### C2 — use #751 for the version-resolution policy discussion

- [#751](https://github.com/leoafarias/fvm/issues/751) requests project ranges / reuse of compatible cached versions. [#1016](https://github.com/leoafarias/fvm/issues/1016) requests minor-only installation of the newest patch **and an available-patch indicator in `fvm list`**. A generic range resolver does not cover every part of #1016.
- Add a requirements comparison and links to #751. Link #577's pubspec input and #648's Dart constraints without closing them. Keep #583's upgrade/removal lifecycle separate.
- Explicitly reconcile the maintainer's exact-install decision in closed [#421](https://github.com/leoafarias/fvm/issues/421) before accepting new resolution behavior. Record any future decisions on reproducible pins, offline behavior, channels and custom Git refs.
- Do not close #1016 as a duplicate now; its extra output requirement is not represented by #751's current body. This remains design/backlog, not a quick implementation PR.

### C3 — clarify #648 without claiming the Dart column shipped

- Preserve three separate requirements in [#648](https://github.com/leoafarias/fvm/issues/648): Dart-to-Flutter constraint resolution, min/max-SDK execution, and fallback to Flutter's bundled Dart.
- Main's [list command](../../lib/src/commands/list_command.dart) has `Dart Version`; its [releases command](../../lib/src/commands/releases_command.dart) does not. [PR #828](https://github.com/leoafarias/fvm/pull/828) was closed **unmerged** on September 4 with an explicit output-UX/maintenance decision.
- Record that distinction in a maintainer summary. Do not mark a checklist item delivered based on list output or reopen #828 without a renewed product decision. No new child issues are needed until work is approved.

### C4 — link Windows distribution work; do not collapse it

Use [#1050](https://github.com/leoafarias/fvm/issues/1050) as an overview with links to [#826](https://github.com/leoafarias/fvm/issues/826) (Winget generally) and [#1058](https://github.com/leoafarias/fvm/issues/1058) (Chocolatey exact Dart dependency). #1050 is ARM64-specific; it does not subsume all x64 Winget/Chocolatey requirements. Keep the defect and delivery tasks open independently. No package or release PR belongs in the easy batch.

### C5 — needs-info and optional scope decisions

- **#759:** ask for current VS Code SDK settings, launch output, and comparison with the working `fvm flutter` invocation.
- **#781:** ask for a current Chocolatey install log and resulting executable/PATH locations; do not presume a non-ASCII username is the cause.
- **#1009:** ask for a minimal public fork/ref and a direct-SDK-versus-FVM version comparison.
- **#1017:** ask for current `fvm doctor`, command resolution, and editor/terminal diagnostics distinguishing `flutter` from `fvm flutter`.
- Keep all four `need info`. The proposed 30-day response window starts only when a targeted request is actually posted and the maintainer adopts that policy. No deadlines or requests were posted by this plan.
- **[#607](https://github.com/leoafarias/fvm/issues/607):** recommend a deliberate **not planned** closure only if maintaining Snap/Flatpak is out of scope. The reporter welcomed the installer alternative, but that is not proof Snap/Flatpak exists. Otherwise leave it contributor-led backlog; do not start new packaging work.

For any approved GitHub cleanup: reread the issue immediately before posting, preserve the original report, prefer an appended maintainer summary, and record links/evidence. Before a consolidation closure, explicitly account for every requirement and use not-planned/consolidated reasoning rather than “completed”. Then refresh open issues and reconcile local artifacts, summaries, and counters. Never close by pre-4.0 age alone.

## Deferred from this batch

Parser behavior (#761), SDK setup/error propagation (#968), lossless JSONC editing (#635), Melos updates (#1008), Git-cache progress (#1073), SDK-link changes (#681/#764), Windows packaging (#1050/#1058/#826), and platform/SDK-family routing require broader tests or product decisions. Their importance is not a reason to call them very-low-risk work.

Docker ARM64 PR #1053 remains on hold pending real multi-architecture build and manifest evidence. Do not merge, reopen old PRs, tag a release, or claim deployment as part of this planning pass.

## Handoff checklist

- [ ] Review and approve the two independent fix scopes.
- [ ] Implement and verify each on current main, preserving existing triage work.
- [ ] Open each PR with its actual tests and issue linkage; no release/version bump bundled in.
- [x] Perform the approved link/summary cleanup; #764 was closed only after its requirements were preserved in #681. See the execution update above.
- [ ] Decide optional triage-guidance PR, #607 disposition, and version-resolution policy separately.
- [ ] Refresh live issue/PR state before implementation and after any eventual GitHub changes.

Planning verification: source and live issue/PR/release inspection only. No candidate fix was implemented or tested in this pass; implementation checks above remain pending.

Final bookkeeping checks passed: all 40 active issue numbers match live GitHub and the local snapshot; every live issue has exactly one review-state label; the eight updated JSON summaries parse and resolve their artifact/plan links; checked local Markdown links resolve. Category counts remain 7 confirmed, 2 compatibility, 4 needs-info and 27 backlog. Tracked diff whitespace checks and the new plan's whitespace check reported no whitespace errors.
