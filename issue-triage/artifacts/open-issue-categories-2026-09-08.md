# Open issue categories — 2026-09-08

Historical category snapshot, not the live queue. The [consolidation cleanup](issue-cleanup-2026-09-08.md) closed #764 into #681; the [later legacy cleanup](legacy-cleanup-2026-09-08.md) retired #607/#674/#738 as not planned. There are now 36 open issues: 7 confirmed, 2 compatibility, 4 needs-info and 23 backlog.

## Answer

No: the 41 open items were not 41 validated defects. After a second, type-focused review, **#578 was found already implemented and closed**, leaving **40 open issues**:

| Review category | Count | Meaning / GitHub label |
| --- | ---: | --- |
| Evidence-backed defects | 7 | `triage:confirmed`: supported by current source/package evidence or reproduction; not all platform-tested |
| IDE compatibility reports | 2 | `triage:upstream`: current reports involving external IDE behavior; not proof that FVM owns the entire fix |
| Unverified bugs / support | 4 | `need info`: insufficient evidence to call these current FVM defects |
| Feature / design backlog | 27 | `triage:backlog`: 26 enhancements and one internal DX/refactoring request; not a delivery commitment |

Priority and validity are separate. Current scheduling remains **28 P2, 8 P3, 4 needs-info**, with no P0/P1 identified. The legacy `validated/` directory means a prioritized actionable item; use `reviewCategory` and `evidenceLevel` to tell a defect from a feature request.

## Material corrections

- **#578 closed completed**: [MacPorts provides FVM](https://ports.macports.org/port/fvm/); its [live Portfile](https://github.com/macports/macports-ports/blob/master/devel/fvm/Portfile) targets 4.3.1. This supersedes the prior audit's keep-open recommendation. [Closure](https://github.com/leoafarias/fvm/issues/578#issuecomment-5587516716).
- **#761 is a bug despite its feature-request title**: directly reproduced on the published FVM 4.3.1 macOS ARM64 binary. `fluter --version` exits 0 and prints 4.3.1; `fluter` alone exits 64 with the expected error. Replaced its enhancement label with bug.
- **#1009 moved from validated P3 to needs-info**: custom-fork metadata output is not sufficient to identify an FVM defect. Need a direct-SDK versus FVM comparison and a minimal fork/ref.
- **#759 is a support/configuration question**, not a request to silently switch the global SDK. Replaced enhancement with question and added need info.
- **#674 is partly implemented already**: context owns skipInput/isCI; broader command-option propagation remains an optional refactor.
- **#689 is mixed**: retained the historic bug label for the third-party completion report, but classified the outstanding plaintext-output request as enhancement backlog. No present-day completion reproduction is claimed.
- **#968 has concrete current code evidence**: setup returns a ProcessResult with non-throwing defaults; its workflow ignores the exit code and emits success. This merits a nonzero-exit regression, not another request for already-supplied basic information.

## Evidence-backed defects

| Issue | Evidence level | Current finding / next action |
| --- | --- | --- |
| [#635](issue-635.md) | code_inspection | VS Code JSONC is decoded then serialized with prettyJson; comments/formatting cannot survive that round trip. Add a comment-preserving edit and tests for tabs, comments and unrelated settings. |
| [#761](issue-761.md) | reproduced_4.3.1 | Published macOS ARM64 4.3.1: fluter --version prints 4.3.1 with exit 0; fluter alone correctly returns usage error 64. Validate unknown commands before honoring a global version flag, with regression tests. |
| [#782](issue-782.md) | shell_reproduction_and_source | Current docs emit ${@:1} without a shebang. dash reproduction exits 2 with Bad substitution; macOS /bin/sh accepts it, so this is shell-dependent. Use safe POSIX wrappers with quoted arguments, executable permissions and non-destructive installation guidance. |
| [#968](issue-968.md) | code_inspection | FlutterService.setup uses run with throwOnError=false; SetupFlutterWorkflow ignores the returned exit code and logs success without rechecking isSetup. Existing test covers interruption, not ordinary nonzero exits. Add a nonzero-exit fake-service regression, propagate setup failure and verify post-setup state. |
| [#1008](issue-1008.md) | code_inspection | Melos integration only locates melos.yaml and updates its root sdkPath; the report uses pubspec.yaml/melos/sdkPath. Automatic environment constraint updates are a separate enhancement. Support pubspec-based Melos config with preserved YAML and explicit tests; separate optional constraint updates. |
| [#1048](issue-1048.md) | code_inspection | The explicit updateVscodeSettings:false branch still warns that users should remove the setting. Keep the opt-out behavior and remove/downgrade the warning; test that intentional opt-out stays quiet. |
| [#1058](issue-1058.md) | package_source_inspection | Release tooling locks cli_pkg 2.14.0; its Chocolatey generator creates an exact dart-sdk dependency because snapshots are version-specific. #1021 did not change this packaging path. Use native/architecture-aware packaging with #1050; do not merely relax the snapshot runtime constraint. |

## All 40 retained items

Created-before-4.0 is an age marker, not an affected-version assertion. **27** retained issues predate the 4.0 release; **13** were opened afterwards. We did not close unimplemented requests merely because they are old. Each JSON record preserves the pre-label updated timestamp and latest discussion timestamp to avoid treating this bulk categorization as new reporter activity.

| Issue | Category | Opened | Evidence and disposition |
| --- | --- | --- | --- |
| [#577](issue-577.md) | Feature / design backlog | 2023-12-01 | Keep P2: pubspec Flutter-constraint resolution is still an enhancement; installing an explicitly pinned version is not equivalent. |
| [#583](issue-583.md) | Feature / design backlog | 2023-12-07 | Keep P2: fvm cleanup does not install upgrades or switch the global SDK; the upgrade workflow request remains. |
| [#607](issue-607.md) | Feature / design backlog | 2024-02-13 | Optional Snap/Flatpak packaging backlog. The official installer addresses the reporter's underlying no-Homebrew need, but no supported Snap/Flatpak FVM distribution was established here. |
| [#635](issue-635.md) | Evidence-backed defect | 2024-02-20 | VS Code JSONC is decoded then serialized with prettyJson; comments/formatting cannot survive that round trip. |
| [#648](issue-648.md) | Feature / design backlog | 2024-02-23 | Keep P2: Dart-constraint resolution, min/max commands and Dart fallback are distinct from displaying a Dart SDK column. Interest continued in May 2026. |
| [#674](issue-674.md) | Feature / design backlog | 2024-02-29 | Partially implemented: skipInput/isCI already live in FvmContext. General force/skipSetup options are still passed through workflows. Retain as optional internal DX design, not a missing feature across all flags. |
| [#681](issue-681.md) | Feature / design backlog | 2024-03-04 | Keep P2: UpdateProjectReferencesWorkflow still deletes and recreates .fvm/versions; branch switching can lose versioned links. |
| [#689](issue-689.md) | Feature / design backlog | 2024-03-11 | Outstanding plain-text output is an enhancement. Preserve the historical bug label for the old third-party completion regression, but do not count that as a reproduced 4.3.1 bug. The old linked _fvm path now returns 404; that does not prove resolution. |
| [#696](issue-696.md) | Feature / design backlog | 2024-03-21 | Keep P2: request is to relocate the project .fvm metadata directory, not the SDK cache. Project.localFvmPath is fixed to project/.fvm. Design a separate metadata-path option; do not reinterpret cachePath. |
| [#702](issue-702.md) | Feature / design backlog | 2024-03-26 | Multi-SDK VS Code workspace support is an IDE-integration feature request, not a proven FVM setting-precedence defect. Verify Dart-Code capability before implementing. |
| [#724](issue-724.md) | IDE compatibility | 2024-05-18 | Doctor reads IDE metadata, while actual SDK selection is controlled by the plugin; November 2025 follow-up reports continued branch-switch mismatches. |
| [#738](issue-738.md) | Feature / design backlog | 2024-06-10 | Keep P2: a Codespaces/devcontainer template is distinct from publishing a Docker image; no implemented template established here. |
| [#743](issue-743.md) | Feature / design backlog | 2024-06-22 | Keep P2: generated VS Code settings still use project.localVersionSymlinkPath, not the stable .fvm/flutter_sdk alias. Manual opt-out is only a workaround. |
| [#751](issue-751.md) | Feature / design backlog | 2024-07-10 | Keep P3: semver-range input remains distinct from exact releases/channels; no complete range resolver established. |
| [#757](issue-757.md) | Feature / design backlog | 2024-07-31 | Keep P3: custom fork URLs address source selection, not the complete Shorebird tool/update lifecycle. Document supported boundaries before closing. |
| [#759](issue-759.md) | Needs diagnostics | 2024-08-07 | CLI works but VS Code launch uses a different SDK; no settings/launch logs establish whether FVM or IDE configuration causes it. Retriaged as a support question, not a request to silently change the global SDK. |
| [#761](issue-761.md) | Evidence-backed defect | 2024-08-22 | Published macOS ARM64 4.3.1: fluter --version prints 4.3.1 with exit 0; fluter alone correctly returns usage error 64. |
| [#762](issue-762.md) | Feature / design backlog | 2024-08-23 | Keep P2: Docker ARM64 is not delivered merely because standalone ARM binaries exist. PR #1053 remains open pending real multi-architecture validation. |
| [#764](issue-764.md) | Feature / design backlog | 2024-08-23 | Keep P2: per-version project symlinks are still wiped during reference updates; overlaps #681. |
| [#767](issue-767.md) | IDE compatibility | 2024-08-26 | May/June 2026 reports confirm physical/cross-project SDK-path substitution in Android Studio. The current guide acknowledges symlink limitations; no local IDE reproduction was performed. |
| [#781](issue-781.md) | Needs diagnostics | 2024-09-16 | Old Chocolatey missing-executable report lacks install logs. Non-ASCII username is a hypothesis, not a proven cause. |
| [#782](issue-782.md) | Evidence-backed defect | 2024-09-16 | Current docs emit ${@:1} without a shebang. dash reproduction exits 2 with Bad substitution; macOS /bin/sh accepts it, so this is shell-dependent. |
| [#784](issue-784.md) | Feature / design backlog | 2024-09-20 | Keep P3: temporary shell-scoped SDK selection differs from project/global selection; an env/export workflow remains unimplemented. |
| [#787](issue-787.md) | Feature / design backlog | 2024-10-10 | Keep P3: rustup-style global project-aware flutter shims are not equivalent to fvm global plus PATH; September 2026 interest keeps the request current. |
| [#821](issue-821.md) | Feature / design backlog | 2025-02-13 | Keep P2: VS Code command-based SDK discovery and a path command remain separate from writing a static dart.flutterSdkPath. |
| [#826](issue-826.md) | Feature / design backlog | 2025-02-25 | Keep P2: Winget manifests/release automation remain packaging work; native Windows archives alone do not fulfill it. |
| [#894](issue-894.md) | Feature / design backlog | 2025-07-16 | Keep P2: deliberate group-writable shared caches require permissions/ownership design; ordinary single-user caches do not solve it. |
| [#968](issue-968.md) | Evidence-backed defect | 2025-11-12 | FlutterService.setup uses run with throwOnError=false; SetupFlutterWorkflow ignores the returned exit code and logs success without rechecking isSetup. Existing test covers interruption, not ordinary nonzero exits. |
| [#1008](issue-1008.md) | Evidence-backed defect | 2025-12-31 | Melos integration only locates melos.yaml and updates its root sdkPath; the report uses pubspec.yaml/melos/sdkPath. Automatic environment constraint updates are a separate enhancement. |
| [#1009](issue-1009.md) | Needs diagnostics | 2026-01-02 | A custom patch tag reports 0.0.0-unknown, but no minimal public fork/metadata comparison proves FVM is responsible. Current fallback improvements do not prove this symptom fixed. |
| [#1016](issue-1016.md) | Feature / design backlog | 2026-02-19 | Keep P3: cleanup patch recommendations are not an install-time partial-version resolver. |
| [#1017](issue-1017.md) | Needs diagnostics | 2026-03-02 | Reported on FVM 4.0.5: fvm flutter works but bare flutter/VS Code PATH differs. This is not a validated install/use failure and is not pre-4-only. |
| [#1024](issue-1024.md) | Feature / design backlog | 2026-03-13 | Keep P2: privilegedAccess:false is a manual workaround; automatic/clear Windows no-admin behavior remains requested. |
| [#1026](issue-1026.md) | Feature / design backlog | 2026-04-05 | Per-project JDK isolation is a design request beyond Flutter SDK selection. The comment's global-config deletion/rotation script is not an endorsed workaround and is unsafe for concurrent projects. |
| [#1042](issue-1042.md) | Feature / design backlog | 2026-06-19 | Keep P2: multiple SDK families require more than fork aliases; the reporter confirms the fork-only workaround is insufficient. |
| [#1048](issue-1048.md) | Evidence-backed defect | 2026-07-16 | The explicit updateVscodeSettings:false branch still warns that users should remove the setting. |
| [#1050](issue-1050.md) | Feature / design backlog | 2026-07-18 | Keep P2: distribute native Windows ARM64 binaries through architecture-aware package managers; release archives alone are insufficient. |
| [#1058](issue-1058.md) | Evidence-backed defect | 2026-08-17 | Release tooling locks cli_pkg 2.14.0; its Chocolatey generator creates an exact dart-sdk dependency because snapshots are version-specific. #1021 did not change this packaging path. |
| [#1073](issue-1073.md) | Feature / design backlog | 2026-09-05 | Keep P2 (new): initial bare git-cache fetch buffers output without explicit progress; add visible phases/progress while preserving non-TTY behavior. |
| [#1074](issue-1074.md) | Feature / design backlog | 2026-09-08 | Keep P2 (new): platform-based automatic SDK routing is not implemented. Explicit FVM flavors are a workaround, not equivalent; coordinate SDK-family design with #1042. |

## Consolidation opportunities, not automatic duplicate closures

- **Version resolution/upgrades**: #577, #648, #751, #1016, #583. Shared resolver design, but different inputs and upgrade policies.
- **IDE SDK discovery and reference retention**: #681, #764, #743, #821, #702; defects #635/#1048 and compatibility #724/#767 belong in the same implementation planning discussion.
- **Windows packaging**: #826, #1050, #1058; diagnostic #781 is not proven the same root cause.
- **Alternate SDK distributions/platform routing**: #757, #1042, #1074. Fork URLs, executable layouts and automatic target selection are different requirements.
- **Optional older platform/distribution work**: #607, #738, #894. Keep as backlog until maintenance ownership and demand justify implementation.
- **Shell integration**: #784 and #787 are enhancements; #782 is the separately actionable broken documentation.

## Validation and limits

- Re-read the live inventory and all retained issue bodies/comments from the earlier full-thread snapshot, checking unchanged activity before each label update.
- Read current FVM pubspec, analyzer configuration, command registration, context, setup/process behavior, install/reference workflows, VS Code/Melos updates, tests and release package generator.
- Used the Dart/Flutter skill's repository-first validation approach; no Dart source or dependency changes.
- Ran the published 4.3.1 binary to reproduce #761. The machine's globally installed FVM is 4.2.0, so it was not used as evidence of 4.3.1 behavior.
- Reproduced #782's expression with `dash`: exit 2, Bad substitution. macOS `/bin/sh` accepted it; this difference is recorded rather than calling it universal.
- Verified #1058 against the exact cli_pkg 2.14.0 pinned by release tooling; its Chocolatey generator intentionally pins Dart for snapshot compatibility. Relaxing that version constraint alone is not the fix.
- Checked current MacPorts package sources; Winget search found no FVM manifests. Snap/Flathub searches did not establish an FVM package. Negative searches are not proof of universal nonexistence.
- Consulted [Dart-Code SDK locating](https://dartcode.org/docs/sdk-locating/) and [settings](https://dartcode.org/docs/settings/) for SDK/PATH distinctions. Did not run multiple IDE versions or reproduce Windows/NixOS installations.
- No full Dart test suite, SDK install/use smoke suite, product implementation, release or PR mutation was performed.
- Created three review-state labels, labeled all 40 retained issues, and preserved unrelated labels. Existing bug/enhancement labels may reflect a mixed original report; the review-state labels are the authoritative category for this pass.
- Final live inventory, label parity, JSON classification/artifact links, log counters and unchanged historical artifact content are verified before handoff.
