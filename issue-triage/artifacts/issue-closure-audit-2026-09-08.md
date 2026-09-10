# Issue closure audit — 2026-09-08

> Historical first-pass snapshot. The subsequent [category review](open-issue-categories-2026-09-08.md), [consolidation cleanup](issue-cleanup-2026-09-08.md) and [legacy cleanup](legacy-cleanup-2026-09-08.md) supersede these counts and decisions. The live queue is now 36 open issues; the later maintenance closures are not claims of verified fixes.

## Scope and decision rule

Reviewed the live issue bodies/comments for all **48 issues open at intake**, plus the three recently closed issues still active locally. The user corrected the legacy cutoff to **before FVM 4.0**. Review baseline: **FVM 4.3.1**, origin/main `a6d93976d443082d73d4718750713e6248de6b84`.

Created-before-4.0 is a screening aid, not proof of the reported FVM version or obsolescence. In particular, #906 never supplied an FVM version. Current confirmations, still-present behavior and unimplemented enhancements remain open regardless of age. Completed requests are distinguished from legacy support threads retired without a verified fix.

## Outcome

- **7 issues closed in this pass**: 3 completed, 4 not planned.
- **3 prior GitHub closures reconciled locally**: #1021, #1046, #1064.
- **2 new requests triaged**: #1073 and #1074, both P2 with implementation plans.
- **41 issues remain open**: 0 P0, 0 P1, 28 P2, 10 P3, 3 needs-info.
- **75 archived issues**, 116 historical issues represented.
- **1 open PR**, #1053; left untouched and on hold pending a real multi-architecture build/manifest validation.
- No product implementation, new release, merge, commit or push in this triage pass.

## Closures performed

| Issue | GitHub reason | Evidence / boundary |
| --- | --- | --- |
| [#584](https://github.com/leoafarias/fvm/issues/584#issuecomment-5587259131) | completed | Custom Flutter remotes and the requested FLUTTER_GIT_URL fallback are implemented and documented. |
| [#600](https://github.com/leoafarias/fvm/issues/600#issuecomment-5587259783) | completed | Android Studio setup documentation shipped in #1056; automatic IDE switching remains tracked in #724/#767. |
| [#731](https://github.com/leoafarias/fvm/issues/731#issuecomment-5587260637) | not planned | Retire the legacy 3.1.5–3.1.7 cache support thread; current hook-environment protection exists, but the original screenshot-only failure is not proven fixed. |
| [#797](https://github.com/leoafarias/fvm/issues/797#issuecomment-5587261365) | not planned | Retire the FVM 3.2.1 CRLF/IDE support report; no current reproduction, and the IDE question has current documentation. |
| [#809](https://github.com/leoafarias/fvm/issues/809#issuecomment-5587262156) | not planned | Retire the FVM 3.2.1 Sidekick follow-up; original tracking stays in sidekick#280, no reliable CLI reproduction. |
| [#811](https://github.com/leoafarias/fvm/issues/811#issuecomment-5587262909) | completed | FVM is already packaged in nixpkgs; current upstream derivation targets 4.3.1. |
| [#906](https://github.com/leoafarias/fvm/issues/906#issuecomment-5587263695) | not planned | Archive unanswered Android Studio terminal-latency report after two June 2026 diagnostic requests; reported FVM version is unknown. |

Each issue was rechecked for state and intervening comments immediately before posting its explanation and closing it. All seven closed states/reasons were subsequently verified through the GitHub API.

### Already closed before this pass

- [#1021](https://github.com/leoafarias/fvm/issues/1021): completed on September 4 by #1022. The shipped range is `>=0.4.0 <0.6.0`, not an unconditional minimum-version increase; Dart 3.6 compatibility is retained.
- [#1046](https://github.com/leoafarias/fvm/issues/1046): completed on September 4 by #1054, released in 4.3.1.
- [#1064](https://github.com/leoafarias/fvm/issues/1064): completed on September 4 by #1070; installation documentation was published.
- Archived those records without posting redundant GitHub comments.

## Every issue retained

“Keep” means still actionable or insufficient evidence to close, not necessarily reproduced on its target platform. Historical implementation plans remain in the linked issue artifacts, with dated scope corrections.

| Issue | Current disposition and next step |
| --- | --- |
| [#577](issue-577.md) | Keep P2: pubspec Flutter-constraint resolution is still an enhancement; installing an explicitly pinned version is not equivalent. |
| [#578](issue-578.md) | Keep P3: no verified MacPorts implementation in this review; age is not evidence that the packaging request is invalid. |
| [#583](issue-583.md) | Keep P2: fvm cleanup does not install upgrades or switch the global SDK; the upgrade workflow request remains. |
| [#607](issue-607.md) | Keep P3: the reporter accepted an install-script alternative, but Snap/Flatpak packaging itself is not implemented; do not call it completed. |
| [#635](issue-635.md) | Keep P2: UpdateVsCodeSettingsWorkflow decodes JSONC and rewrites prettyJson, losing comments and original formatting. |
| [#648](issue-648.md) | Keep P2: Dart-constraint resolution, min/max commands and Dart fallback are distinct from displaying a Dart SDK column. Interest continued in May 2026. |
| [#674](issue-674.md) | Keep P2: command-scoped option/context design remains a valid refactoring request, not a pre-4-only bug. |
| [#681](issue-681.md) | Keep P2: UpdateProjectReferencesWorkflow still deletes and recreates .fvm/versions; branch switching can lose versioned links. |
| [#689](issue-689.md) | Keep P2: JSON API output does not fulfill a plain-text table/completion mode; reporter objections remain relevant. |
| [#696](issue-696.md) | Keep P2: request is to relocate the project .fvm metadata directory, not the SDK cache. Project.localFvmPath is fixed to project/.fvm. Design a separate metadata-path option; do not reinterpret cachePath. |
| [#702](issue-702.md) | Keep P2: FVM still writes one dart.flutterSdkPath into a discovered .code-workspace. Verify Dart-Code multi-root behavior before asserting setting precedence or implementing a fix; folder-specific settings are also written. |
| [#724](issue-724.md) | Keep P2: doctor warning and actual Android Studio SDK selection must be distinguished. Current guide is available, but a November 2025 follow-up still reports branch-switch mismatches; coordinate with #767. |
| [#738](issue-738.md) | Keep P2: a Codespaces/devcontainer template is distinct from publishing a Docker image; no implemented template established here. |
| [#743](issue-743.md) | Keep P2: generated VS Code settings still use project.localVersionSymlinkPath, not the stable .fvm/flutter_sdk alias. Manual opt-out is only a workaround. |
| [#751](issue-751.md) | Keep P3: semver-range input remains distinct from exact releases/channels; no complete range resolver established. |
| [#757](issue-757.md) | Keep P3: custom fork URLs address source selection, not the complete Shorebird tool/update lifecycle. Document supported boundaries before closing. |
| [#759](issue-759.md) | Keep needs-info: current project SDK docs may help, but no evidence proves the reported VS Code launch/global-SDK mismatch fixed. Need settings and launch output on 4.3.1. |
| [#761](issue-761.md) | Keep P3: typo/unknown-command handling is not shown fixed by the release; retain until the global --version interaction is reproduced and tested. |
| [#762](issue-762.md) | Keep P2: Docker ARM64 is not delivered merely because standalone ARM binaries exist. PR #1053 remains open pending real multi-architecture validation. |
| [#764](issue-764.md) | Keep P2: per-version project symlinks are still wiped during reference updates; overlaps #681. |
| [#767](issue-767.md) | Keep P2: Android Studio resolves symlinks to physical SDK paths; May/June 2026 confirmations make this current. New documentation does not implement automatic switching. |
| [#781](issue-781.md) | Keep needs-info: an old Chocolatey missing-executable report may involve a non-ASCII user path. Current packaging alone does not prove that path works; need logs and installed-file inventory. |
| [#782](issue-782.md) | Keep P2: running-flutter.mdx still emits ${@:1} without a shebang. Plan safe POSIX wrappers using quoted argument forwarding, preserve existing executables, and verify paths/permissions. |
| [#784](issue-784.md) | Keep P3: temporary shell-scoped SDK selection differs from project/global selection; an env/export workflow remains unimplemented. |
| [#787](issue-787.md) | Keep P3: rustup-style global project-aware flutter shims are not equivalent to fvm global plus PATH; September 2026 interest keeps the request current. |
| [#821](issue-821.md) | Keep P2: VS Code command-based SDK discovery and a path command remain separate from writing a static dart.flutterSdkPath. |
| [#826](issue-826.md) | Keep P2: Winget manifests/release automation remain packaging work; native Windows archives alone do not fulfill it. |
| [#894](issue-894.md) | Keep P2: deliberate group-writable shared caches require permissions/ownership design; ordinary single-user caches do not solve it. |
| [#968](issue-968.md) | Keep P2: missing unzip/setup-success reporting remains actionable; verify setup state and subprocess failure propagation with a missing-tool fixture. |
| [#1008](issue-1008.md) | Keep P2: Melos integration needs pubspec.yaml-based melos.sdkPath support, not only melos.yaml. |
| [#1009](issue-1009.md) | Keep P3: custom fork tags can still lack standard Flutter metadata; generic fork support does not guarantee meaningful version output. |
| [#1016](issue-1016.md) | Keep P3: cleanup patch recommendations are not an install-time partial-version resolver. |
| [#1017](issue-1017.md) | Keep needs-info: explicitly reported on 4.0.5, so outside the legacy retirement cutoff. fvm flutter works while bare flutter/IDE PATH differs; reproduce in a fresh VS Code terminal and inspect where flutter. |
| [#1024](issue-1024.md) | Keep P2: privilegedAccess:false is a manual workaround; automatic/clear Windows no-admin behavior remains requested. |
| [#1026](issue-1026.md) | Keep P2: Flutter's global JDK setting is not isolated per FVM project; design explicit per-project JDK behavior. |
| [#1042](issue-1042.md) | Keep P2: multiple SDK families require more than fork aliases; the reporter confirms the fork-only workaround is insufficient. |
| [#1048](issue-1048.md) | Keep P3: intentionally disabling updateVscodeSettings still produces a warning asking the user to remove the setting. |
| [#1050](issue-1050.md) | Keep P2: distribute native Windows ARM64 binaries through architecture-aware package managers; release archives alone are insufficient. |
| [#1058](issue-1058.md) | Keep P2: Chocolatey's exact Dart dependency is unrelated to the pub_updater fix in #1021; native Windows packaging remains the proposed remedy. |
| [#1073](issue-1073.md) | Keep P2 (new): initial bare git-cache fetch buffers output without explicit progress; add visible phases/progress while preserving non-TTY behavior. |
| [#1074](issue-1074.md) | Keep P2 (new): platform-based automatic SDK routing is not implemented. Explicit FVM flavors are a workaround, not equivalent; coordinate SDK-family design with #1042. |

## Verification and evidence

- Ran `issue-triage/scripts/sync_github.sh` at intake and after closures; refreshed again before handoff.
- Fetched full issue bodies/comments via GitHub CLI; preserved the intake snapshot in `.context/triage-2026-09-08/open-issue-threads.json`.
- Queried GitHub issue state/reason/closed time for the ten archived records.
- Inspected current release changelog, config/environment loading, process Git-environment isolation, Git cache fetch, project-reference updates, VS Code settings workflow, flavor command/model and relevant current docs.
- Live Android Studio guide returned HTTP 200 and includes SDK-path and symlink guidance. Custom-remote documentation is available at its canonical URL.
- Read the live [nixpkgs FVM derivation](https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/fv/fvm/package.nix): it targets 4.3.1. No claim of NixOS runtime verification.
- Regression tests for repository-environment scrubbing were inspected, not executed during this research pass. No Flutter SDK installs, Windows/IDE runtime reproduction or full Dart test suite were run.
- Preserved pre-existing local triage changes, with a pre-turn copy in `.context/triage-2026-09-08/before`.
- Local JSON, artifact links, classification parity, counters and final GitHub snapshot checked before handoff.

## Recommended next work

1. Fix #782's still-present shell wrapper documentation, including POSIX argument forwarding, permissions and preserving existing executables.
2. Investigate #968 setup-failure reporting; implement #1073 cache-fetch progress independently.
3. Continue #767/#724 IDE compatibility and #681/#764 project-link retention; new docs do not resolve these behaviors.
4. Design native Windows package delivery for #1050/#1058/#826; do not mistake the pub_updater dependency fix for Chocolatey's Dart pin.
5. Resolve #1074's routing precedence/SDK-family design with #1042 before implementation.
6. Collect concrete current diagnostics for #759, #781 and #1017; these were not closed speculatively.
