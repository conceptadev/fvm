# Issue Triage Log

**Started**: 2025-10-30
**Current Version**: v4.3.1
**Last Reviewed**: 2026-09-08
**Total Open Issues**: 36
**Historical Issues Triaged**: 116

## Progress Tracker

Type and evidence are separate from priority: **7 confirmed, 2 compatibility, 4 needs-info, 23 feature/design backlog**. See the [latest legacy cleanup](legacy-cleanup-2026-09-08.md), [consolidation cleanup](issue-cleanup-2026-09-08.md) and historical [category review](open-issue-categories-2026-09-08.md).

### P0 - Critical

- _No open issues_

### P1 - High

- _No open issues_

### P2 - Medium

- [ ] #577 - [backlog] Keep P2: pubspec Flutter-constraint resolution is still an enhancement; installing an explicitly pinned version is not equivalent.
- [ ] #583 - [backlog] Keep P2: fvm cleanup does not install upgrades or switch the global SDK; the upgrade workflow request remains.
- [ ] #635 - [confirmed] VS Code JSONC is decoded then serialized with prettyJson; comments/formatting cannot survive that round trip.
- [ ] #648 - [backlog] Keep P2: Dart-constraint resolution, min/max commands and Dart fallback are distinct from displaying a Dart SDK column. Interest continued in May 2026.
- [ ] #681 - [backlog] Keep P2: UpdateProjectReferencesWorkflow still deletes and recreates .fvm/versions; branch switching can lose versioned links.
- [ ] #689 - [backlog] Outstanding plain-text output is an enhancement. Preserve the historical bug label for the old third-party completion regression, but do not count that as a reproduced 4.3.1 bug. The old linked _fvm path now returns 404; that does not prove resolution.
- [ ] #696 - [backlog] Keep P2: request is to relocate the project .fvm metadata directory, not the SDK cache. Project.localFvmPath is fixed to project/.fvm. Design a separate metadata-path option; do not reinterpret cachePath.
- [ ] #702 - [backlog] Multi-SDK VS Code workspace support is an IDE-integration feature request, not a proven FVM setting-precedence defect. Verify Dart-Code capability before implementing.
- [ ] #724 - [upstream] Doctor reads IDE metadata, while actual SDK selection is controlled by the plugin; November 2025 follow-up reports continued branch-switch mismatches.
- [ ] #743 - [backlog] Keep P2: generated VS Code settings still use project.localVersionSymlinkPath, not the stable .fvm/flutter_sdk alias. Manual opt-out is only a workaround.
- [ ] #762 - [backlog] Keep P2: Docker ARM64 is not delivered merely because standalone ARM binaries exist. PR #1053 remains open pending real multi-architecture validation.
- [ ] #767 - [upstream] May/June 2026 reports confirm physical/cross-project SDK-path substitution in Android Studio. The current guide acknowledges symlink limitations; no local IDE reproduction was performed.
- [ ] #782 - [confirmed] Current docs emit ${@:1} without a shebang. dash reproduction exits 2 with Bad substitution; macOS /bin/sh accepts it, so this is shell-dependent.
- [ ] #821 - [backlog] Keep P2: VS Code command-based SDK discovery and a path command remain separate from writing a static dart.flutterSdkPath.
- [ ] #826 - [backlog] Keep P2: Winget manifests/release automation remain packaging work; native Windows archives alone do not fulfill it.
- [ ] #894 - [backlog] Keep P2: deliberate group-writable shared caches require permissions/ownership design; ordinary single-user caches do not solve it.
- [ ] #968 - [confirmed] FlutterService.setup uses run with throwOnError=false; SetupFlutterWorkflow ignores the returned exit code and logs success without rechecking isSetup. Existing test covers interruption, not ordinary nonzero exits.
- [ ] #1008 - [confirmed] Melos integration only locates melos.yaml and updates its root sdkPath; the report uses pubspec.yaml/melos/sdkPath. Automatic environment constraint updates are a separate enhancement.
- [ ] #1024 - [backlog] Keep P2: privilegedAccess:false is a manual workaround; automatic/clear Windows no-admin behavior remains requested.
- [ ] #1026 - [backlog] Per-project JDK isolation is a design request beyond Flutter SDK selection. The comment's global-config deletion/rotation script is not an endorsed workaround and is unsafe for concurrent projects.
- [ ] #1042 - [backlog] Keep P2: multiple SDK families require more than fork aliases; the reporter confirms the fork-only workaround is insufficient.
- [ ] #1050 - [backlog] Keep P2: distribute native Windows ARM64 binaries through architecture-aware package managers; release archives alone are insufficient.
- [ ] #1058 - [confirmed] Release tooling locks cli_pkg 2.14.0; its Chocolatey generator creates an exact dart-sdk dependency because snapshots are version-specific. #1021 did not change this packaging path.
- [ ] #1073 - [backlog] Keep P2 (new): initial bare git-cache fetch buffers output without explicit progress; add visible phases/progress while preserving non-TTY behavior.
- [ ] #1074 - [backlog] Keep P2 (new): platform-based automatic SDK routing is not implemented. Explicit FVM flavors are a workaround, not equivalent; coordinate SDK-family design with #1042.

### P3 - Low

- [ ] #751 - [backlog] Keep P3: semver-range input remains distinct from exact releases/channels; no complete range resolver established.
- [ ] #757 - [backlog] Keep P3: custom fork URLs address source selection, not the complete Shorebird tool/update lifecycle. Document supported boundaries before closing.
- [ ] #761 - [confirmed] Published macOS ARM64 4.3.1: fluter --version prints 4.3.1 with exit 0; fluter alone correctly returns usage error 64.
- [ ] #784 - [backlog] Keep P3: temporary shell-scoped SDK selection differs from project/global selection; an env/export workflow remains unimplemented.
- [ ] #787 - [backlog] Keep P3: rustup-style global project-aware flutter shims are not equivalent to fvm global plus PATH; September 2026 interest keeps the request current.
- [ ] #1016 - [backlog] Keep P3: cleanup patch recommendations are not an install-time partial-version resolver.
- [ ] #1048 - [confirmed] The explicit updateVscodeSettings:false branch still warns that users should remove the setting.

### Needs More Info

- [ ] #759 - [needs_info] CLI works but VS Code launch uses a different SDK; no settings/launch logs establish whether FVM or IDE configuration causes it. Retriaged as a support question, not a request to silently change the global SDK. Diagnostics requested by September 22; review new replies on or after September 23 before considering closure.
- [ ] #781 - [needs_info] Old Chocolatey missing-executable report lacks install logs. Non-ASCII username is a hypothesis, not a proven cause. Diagnostics requested by September 22; review new replies on or after September 23 before considering closure.
- [ ] #1009 - [needs_info] A custom patch tag reports 0.0.0-unknown, but no minimal public fork/metadata comparison proves FVM is responsible. Current fallback improvements do not prove this symptom fixed.
- [ ] #1017 - [needs_info] Reported on FVM 4.0.5: fvm flutter works but bare flutter/VS Code PATH differs. This is not a validated install/use failure and is not pre-4-only.

### Delegated MCP

- _No open issues_

---

## Detailed Triage Results

### Session 1: 2025-10-30
- #944: Confirmed `/documentation/installation` returns 404 while `/documentation/getting-started/installation` resolves. Root cause traced to relative links in `docs/pages/documentation/getting-started/index.md`; implementation plan captured in `artifacts/issue-944.md`.
- #915: Quick Start instructions already include `brew tap`, but the “Next Steps” links still hit `/documentation/installation` 404. Fix piggybacks on #944 (`artifacts/issue-915.md`).
- #940: Homebrew formula bundles Dart 3.2.6 causing `pub get` failure once FVM depends on `pubspec_parse 1.5.0`. Plan recorded in `artifacts/issue-940.md` to raise SDK floor and update tap.
- #938: Reproduced `fvm doctor` stack trace when `android/local.properties` exists but no pinned version. Plan in `artifacts/issue-938.md` to guard missing symlinks.
- #914: Documented automation plan to add git safe.directory entries so Windows installs stop failing (`artifacts/issue-914.md`).
- #935: Install script rejects `riscv64`; outlined plan to add architecture support and ship new binaries (`artifacts/issue-935.md`).
- #933: Chocolatey nuspec shows only “fvm”; documented metadata update to expose “Flutter Version Manager” (`artifacts/issue-933.md`).
- #906: Could not reproduce Android Studio terminal delay; requested timing data and shell config (`artifacts/issue-906.md`).
- #904: Determined Kotlin warning is upstream in Flutter’s Gradle tooling; no FVM fix (`artifacts/issue-904.md`).
- #897: Root cause found - `cli_completion` package auto-installs completions on every command, accessing read-only shell configs. Fix: override `enableAutoInstall => false` in `runner.dart`. Full plan in `artifacts/issue-897-fix-plan.md`. Note: PR #967 does NOT fix this.
- #895: Confirmed FVM 4.0.0 is published (Homebrew + docs) and issue can be closed (`artifacts/issue-895.md`).
- #894: Documented approach for group-writable shared caches (core.sharedRepository, chmod) (`artifacts/issue-894.md`).
- #893: Plan to merge PATH updates into VS Code terminal settings so `flutter` resolves to project SDK (`artifacts/issue-893.md`).
- #884: Confirmed new workflow silently updates `.gitignore`; feature request obsolete (`artifacts/issue-884.md`).
- #881: Expand git URL validation to accept SSH/scp formats for forks and config (`artifacts/issue-881.md`).
- #880: Add `--force` flag to spawn command to propagate non-interactive behavior (`artifacts/issue-880.md`).
- #841: Confirmed PATH configuration requirement; advised documentation reminder (`artifacts/issue-841.md`).
- #839: Ensure `.gitignore` workflow writes a final newline (`artifacts/issue-839.md`).
- #833: Outline wildcard expansion for `fvm remove` (`artifacts/issue-833.md`).
- #826: Plan Winget manifests and automation (`artifacts/issue-826.md`).
- #821: Integrate VS Code command-based SDK resolution (`artifacts/issue-821.md`).
- #820: Author official GitHub Action wrapper (`artifacts/issue-820.md`).
- #811: Draft Nix derivation and upstream plan (`artifacts/issue-811.md`).
- #812: Answered configuration question (docs reference) (`artifacts/issue-812.md`).
- #807: Highlighted existing environment variables for cache path (`artifacts/issue-807.md`).
- #805: Not pursuing hot-reload integration (`artifacts/issue-805.md`).
- #799: Duplicate of shell profile guard (#897) (`artifacts/issue-799.md`).
- #825: Update README documentation link (`artifacts/issue-825.md`).
- #801: Default to inheriting stdio so Ctrl+C works in fish (`artifacts/issue-801.md`).
- #794: Add Linux ARM binaries and install script support (`artifacts/issue-794.md`).
- #791: Confirmed fork namespaced handling already exists (`artifacts/issue-791.md`).
- #786: Replace interact prompts and upgrade dart_console (`artifacts/issue-786.md`).
- #783: Persist 40-char commit hashes in config (`artifacts/issue-783.md`).
- #782: Correct docs for rerouted flutter/dart shims (`artifacts/issue-782.md`).
- #774: Document requirement to expose FVM's dart on PATH (`artifacts/issue-774.md`).
- #771: Adjust version weighting to tolerate custom fork names (`artifacts/issue-771.md`).
- #764: Keep project symlinks stable across git checkouts (`artifacts/issue-764.md`).
- #762: Produce docker images for arm64 via Buildx (`artifacts/issue-762.md`).
- #761: Throw UsageException when command not found (`artifacts/issue-761.md`).
- #751: Investigate semver range constraints (`artifacts/issue-751.md`).
- #743: Point VS Code to .fvm/flutter_sdk or dynamic command (`artifacts/issue-743.md`).
- #738: Publish devcontainer template leveraging FVM Docker image (`artifacts/issue-738.md`).
- #720: Explore auto-install command (`artifacts/issue-720.md`).
- #769: Clarify .fvmrc ancestor lookup behavior (`artifacts/issue-769.md`).
- #768: Declined adding external AI badge (`artifacts/issue-768.md`).
- #757: Documented custom flutter URL support (`artifacts/issue-757.md`).
- #754: Provide install.sh workaround for outdated Xcode (`artifacts/issue-754.md`).
- #724: Clarify Android Studio SDK path configuration (`artifacts/issue-724.md`).

### Session 2: 2025-10-31
- #719: Verified the “Running Flutter” guide documents rerouting bare `flutter`/`dart` commands through FVM; issue can be closed as resolved (`artifacts/issue-719.md`).
- #715: Determined Java toolchain errors stem from missing system JDK when using Flutter 3.7.x; documented workaround and marked as environment issue (`artifacts/issue-715.md`).
- #702: Confirmed multi-root VS Code workspaces get a single `dart.flutterSdkPath`; outlined fix to skip workspace override and document the workflow (`artifacts/issue-702.md`).
- #697: Clarified that `fvm global` only manages the `.fvm/default` symlink and Android Studio must be pointed there; planned doc updates (`artifacts/issue-697.md`).
- #696: Validated request to move `.fvm` outside the project and proposed honoring `.fvmrc cachePath` with docs/tests (`artifacts/issue-696.md`).
- #689: Documented grid-table regression in CLI output and plan for configurable/plain mode to fix shell completions (`artifacts/issue-689.md`).
- #688: Planned archive-based installs so mirrored storage URLs work without Git/GCS access (`artifacts/issue-688.md`).
- #683: Identified `pubspec` parser bug for hosted overrides without versions and outlined sanitizer/upstream fix (`artifacts/issue-683.md`).
- #681: Proposed keeping per-version project symlinks instead of deleting `.fvm/versions` so branch switching works seamlessly (`artifacts/issue-681.md`).
- #674: Designed context-based command options to remove repetitive flag plumbing across workflows (`artifacts/issue-674.md`).
- #666: Planned semantic normalization for version mismatch detection so non-numeric tags stop triggering repairs (`artifacts/issue-666.md`).
- #648: Outlined constraint-aware tooling (resolve by Dart version, min/max exec, better dart fallback) (`artifacts/issue-648.md`).
- #635: Proposed comment-preserving JSONC editor so `.vscode/settings.json` keeps user formatting (`artifacts/issue-635.md`).
- #607: Planned Snap packaging (classic confinement) and evaluated Flatpak support for Linux users (`artifacts/issue-607.md`).
- #600: Identified gaps in Android Studio docs and outlined clearer configuration steps with screenshots (`artifacts/issue-600.md`).
- #587: Planned to set `TAR_OPTIONS=--no-same-owner` when running flutter to avoid tar ownership failures in containers (`artifacts/issue-587.md`).
- #584: Will document how to override the Flutter Git remote via config/env (`artifacts/issue-584.md`).
- #583: Designed an `fvm upgrade` command (plus `--force` removal) to streamline global updates (`artifacts/issue-583.md`).
- #581: Migrate Docker image to glibc base and build multi-arch variants to fix arm64 installs (`artifacts/issue-581.md`).
- #578: Planned creation of a MacPorts Portfile and documentation updates (`artifacts/issue-578.md`).
- #577: Planned pubspec constraint resolution for `fvm install --pubspec` (`artifacts/issue-577.md`).
- #421: Planned partial-version resolution so `fvm install 2` picks the newest Flutter 2 release (`artifacts/issue-421.md`).
- #388: Documented Android Studio's single-SDK limitation and suggested workarounds (`artifacts/issue-388.md`).

### Session 3: 2025-10-31 (Closure Session)
- #884: Closed as resolved in v4.0.0 - `.gitignore` auto-update now built-in and working with `--force` and `--skip-setup` flags.
- #807: Closed as already supported - `FVM_CACHE_PATH` (primary) and `FVM_HOME` (legacy) environment variables documented.
- #805: Closed as out of scope - hot reload functionality belongs to Flutter/IDEs, not version management tools.
- #812: Closed with comprehensive answer - FVM automatically uses project `.fvmrc` versions when in project, global otherwise.
- #904: Closed as upstream Flutter issue - Kotlin deprecation warning originates from Flutter's `flutter_tools`, not FVM code.
- #719: Already closed (merged docs) - rerouting `flutter`/`dart` commands documented in running-flutter guide.
- #768: Already closed - external AI badge not aligned with FVM roadmap.
- #769: Already closed - ancestor directory `.fvmrc` lookup is intentional design (monorepo/workspace support).

**Android Studio Research Findings Updated**: Consolidated guidance and action plan for IDE automation now lives at `artifacts/android-studio-research.md`.

### Session 4: 2025-10-31 (Resolved Audit)
- #388: Re-validated Android Studio multi-module limitation; prepared closure guidance and left issue in `resolved/` (`artifacts/issue-388.md`).
- #575: Confirmed `fvm flavor` already proxies flavor-specific SDKs; ready to close with usage examples (`artifacts/issue-575.md`).
- #697: Verified global symlink behavior and doc updates; closure comment drafted to direct Android Studio to `~/.fvm/default` (`artifacts/issue-697.md`).
- #724: Checked IDE workflow docs now highlight `.fvm/flutter_sdk`; closure reply drafted (`artifacts/issue-724.md`).
- #754: Homebrew/Xcode constraint documented with install script workaround; safe to close (`artifacts/issue-754.md`).
- #757: Custom Flutter repository support confirmed via `--flutter-url` / fork workflow; closure reply drafted (`artifacts/issue-757.md`).
- #774: Documentation gap on exporting `~/.fvm/default/bin` persists—moved to `validated/p2-medium` with doc update plan (`artifacts/issue-774.md`).
- #782: `Bad substitution` doc bug still reproducible—moved to `validated/p2-medium` with fix plan (`artifacts/issue-782.md`).
- #801: Fish shell Ctrl+C issue fixed in v4.0.0; ready to close with upgrade guidance (`artifacts/issue-801.md`).
- #791: Fork namespace handling already implemented; closure comment ready (`artifacts/issue-791.md`).
- #799: Duplicate of #897; closure note prepared pointing users to canonical bug (`artifacts/issue-799.md`).

### Session 5: 2025-10-31 (Investigation & Closure)
- #893: Investigated VS Code terminal PATH integration with FVM. Confirmed that Dart Code extension v3.60.0+ handles terminal PATH injection automatically via `dart.addSdkToTerminalPath` setting (enabled by default). FVM correctly updates `dart.flutterSdkPath`, and terminal integration should work with FVM v4 + modern Dart Code versions. Reclassified from P1-High to resolved/working-as-intended. **Closed on GitHub** with upgrade guidance (`artifacts/issue-893.md`).
- #587: Determined tar ownership errors stem from upstream Flutter behavior on restricted filesystems. Documented TAR_OPTIONS workaround and marked as not planned for FVM changes. **Closed on GitHub** with maintainer comment (`artifacts/issue-587.md`).

### Session 6: 2025-11-01 (Post-Release Sync)
- #940: Homebrew tap now ships Dart 3.6.0 via PR #22; reinstalling from the tap resolves the solver failure. **Closed on GitHub** (`artifacts/issue-940.md`).
- #881: PR #954 loosens git URL validation so SSH/scp remotes work in `fvm fork add` and `fvm config`. **Closed on GitHub** (`artifacts/issue-881.md`).
- #666: Cache integrity check now normalizes version labels (PR #955). **Closed on GitHub** (`artifacts/issue-666.md`).
- #683: Upstream pubspec fix allows hosted overrides without version; FVM no longer crashes. **Closed on GitHub** (`artifacts/issue-683.md`).
- #581: Alpine docker bug closed with documented workaround/community image (`artifacts/issue-581.md`).
- #421: Partial-version install request declined; please use exact releases. **Closed with comment** (`https://github.com/leoafarias/fvm/issues/421#issuecomment-3476844567`).
- #388: IntelliJ multi-package limitation documented; no change planned. **Closed with comment** (`https://github.com/leoafarias/fvm/issues/388#issuecomment-3476845312`).
- #801: Fish shell Ctrl+C fixed in FVM 4.0.0. **Closed with comment** (`https://github.com/leoafarias/fvm/issues/801#issuecomment-3476846075`).

### Session 7: 2025-11-04 (Open Issue Sync)
- Re-ran `gh issue list --state open` (48 issues) and removed closed #771 from the pending queue.
- Regenerated `pending_issues/open_issues.json` via GraphQL so titles/bodies/labels reflect the latest GitHub data.
- Moved reopened items (#575, #697, #724, #754, #757, #791) back into the validated folders and archived closed ones (#771, #786, #825, #833, #880, #933).
- Rebuilt the Progress Tracker and Summary Statistics so action items only list currently open issues.

### Session 8: 2025-11-24 (Open Issue Sync)
- Ran `issue-triage/scripts/sync_github.sh`; pending lists now show 54 open issues and 15 open PRs from GitHub.

### Session 9: 2025-11-24 (PR Alignment)
- PR #972 improves version detection and “Need setup” status; addresses open issue #970 (3.38.x not listed/flagged).
- PR #967 (installer v2, user-local default) mitigates cross-user install/security concerns raised in #974; monitor until merged.
- PR #966 (archive installs) explicitly resolves #688 once merged.
- PR #964 adds read-only shell profile handling; fixes #897.
- PR #845 builds arm64 Docker images; fixes #762 multi-arch image gap.

### Session 10: 2025-12-09 (Issue Sync)
- #783 closed by maintainer as "not a security vulnerability / not planned"; moved to `resolved/` with note that PR #962 was closed without merge.
- #974 validated as P1-High architectural issue: install script places binary in `$HOME/.fvm_flutter` with system symlink in `/usr/local/bin`, violating industry standards (no major tool uses this pattern). Creates cross-user security risks, unnecessary sudo requirements, and fragile uninstall semantics. **PR #967 directly addresses this** with user-local default install (`artifacts/issue-974-validation.md`).
- Added initial triage artifacts for #968 (fail fast when unzip missing) and #969 (riscv64 pulls arm64 binaries); later re-reviewed in the 2026-03-03 sweep with refined classifications.
- Moved closed #820 to `resolved/` after confirming GitHub state.
---

### Session 11: 2026-03-03 (Open Issue Triage Sweep)
- #968: Validated confusing partial-setup success path when required tools are missing; planned post-setup completeness validation and clearer failure messaging (`artifacts/issue-968.md`).
- #969: Triaged RISC-V architecture mismatch report as mostly upstream Flutter/toolchain constrained; proposed clearer FVM guardrails and docs (`artifacts/issue-969.md`).
- #1008: Confirmed Melos auto-update currently targets `melos.yaml` only; planned support for `pubspec.yaml` `melos.sdkPath` workflows (`artifacts/issue-1008.md`).
- #1009: Documented custom fork metadata ambiguity (`0.0.0-unknown`) and planned docs/output improvements (`artifacts/issue-1009.md`).
- #1014: Classified install failure as P1 blocker; proposed clone validation diagnostics + retry strategy (`artifacts/issue-1014.md`).
- #1015: Confirmed MCP docs gap and proposed dedicated guidance for `.fvm/flutter_sdk` integration (`artifacts/issue-1015.md`).
- #1016: Validated minor-line patch resolution request (`3.38` -> latest `3.38.x`) as feature enhancement candidate (`artifacts/issue-1016.md`).
- #1017: Marked as needs-info pending minimal reproduction; current logs indicate environment/PATH mismatch rather than core `fvm use` failure (`artifacts/issue-1017.md`).
---

### Session 12: 2026-06-10 (Live GitHub Sync and Consistency Audit)
- Ran `issue-triage/scripts/sync_github.sh`; pending snapshots now show 58 open issues and 10 open PRs.
- Archived closed active items #897, #974, #1014, #783, and #820 into `closed/`; removed the duplicate P3 summary for #969 and kept the P2 classification.
- Triaged newly open/unclassified issues: #1021 -> P2, #1023 -> P3, #1024 -> P2, #1026 -> P2, #1028 -> P1, and #1030 -> P1.
- Verified the specialized `install_permission_issues/` research cluster is absent from the live open issue list and left it as a separate historical archive.
- Synced stale auxiliary metadata: refreshed closed/merged states for comment logs #897, #920, #923, #956, and #960; marked the #897 action item as archived.
- Rebuilt the Progress Tracker and Summary Statistics from active JSON folders so totals match the live open issue snapshot.
---

### Session 13: 2026-06-10 (Post-Main Priority Plan)
- Re-ran the GitHub sync after merging `origin/main`; pending snapshots still show 58 open issues and 10 open PRs.
- Verified active classification parity: every live open issue has exactly one active P0/P1/P2/P3/needs-info JSON summary, with no stale closed or duplicate active entries.
- Rechecked all four P1 items against the latest code and docs. No P1 downgrades: #688, #1028, and #1030 remain unresolved in code; #914 docs now exist but doctor/CLI diagnostics remain open.
- Added `artifacts/actionable-priority-plan-2026-06-10.md` as the execution handoff for actionable priorities and validation gates.
- Added missing P1 action items for #1028 and #1030, and narrowed the #914 action item to current remaining scope.
---

### Session 14: 2026-06-16 (Post-Merge Issue Closure Sync)
- Ran `issue-triage/scripts/sync_github.sh`; pending snapshots now show 56 open issues and 4 open PRs.
- Moved #1030 from active P1 to `closed/` after GitHub closed it as completed by merged PR #1033 (`fix: avoid false cache version mismatches from git describe tags`).
- Moved #969 from active P2 to `closed/` after GitHub closed it as completed; reporter confirmed Flutter 3.42+ now reaches the expected upstream RISC-V SDK/engine support path.
- Left #1028 active in P1, but marked it for revalidation after pulling latest `main` because merged PR #1037 materially changed git-cache behavior without closing the issue.
- Left #1015 active in P3 and noted open PR #1038, which closes #1015 if merged.
- Verified no newly open issue is unclassified and no duplicate active classifications remain after the moves.
---

### Session 15: 2026-06-16 (Merged PR Issue Audit)
- Audited all PRs merged since 2026-06-10: #1032, #1033, #1034, #1035, #1036, #1037, #1039, #1040, and #1041.
- Confirmed only #1033 has a GitHub issue-closing reference, closing #1030; #1030 was already moved to `closed/` in Session 14.
- Confirmed #1036 only references #1030 without closing it, and #1041 references PR numbers rather than additional issues.
- Ran a closed-issue sweep for `closed:>=2026-06-10`; only #969 and #1030 were returned, and both are already in `closed/`.
- Recorded the audit in `artifacts/merged-pr-issue-audit-2026-06-16.md`; no additional active issues need closure from merged PRs.
---

### Session 16: 2026-06-19 (Main Merge, Latest Sync, MCP Delegation)
- Merged latest `origin/main` into `issue-triage` and kept the triage workflow guidance in `AGENTS.md`.
- Ran `issue-triage/scripts/sync_github.sh`; pending snapshots now show 57 open issues and 4 open PRs.
- Triaged new issue #1042 as P2-medium with an architecture/design handoff for multi-SDK-family support.
- Removed MCP issue #1015 from the regular P3 queue and moved its summary to `delegated/mcp/`; created `mcp_task.md` for the MCP/docs agent to own PR #1038 and closure.
- Standard active triage now covers 56 open issues; one additional open issue is delegated to MCP.
---

### Session 17: 2026-06-22 (Post-4.1.1 Urgency Revalidation)
- Ran `issue-triage/scripts/sync_github.sh`; pending snapshots now show 56 open issues and 3 open PRs.
- Used subagent issue explorers to revalidate #688, #914, #1028, and #1042 against the FVM 4.1.1 release date and current code/docs.
- Kept #688 as the only current P1: archive-based installs for `FLUTTER_STORAGE_BASE_URL` mirrors are still not in `main`/4.1.1, and PR #1013 remains open.
- Downgraded #914 to P2 because it is a real Windows Git `safe.directory` environment issue, but current docs/FAQ cover the workaround and maintainers do not want silent global Git config mutation.
- Moved #1028 to needs-info/revalidation because it was reported on FVM 4.0.5 and 4.1.1 shipped relevant git-cache/non-interactive hang fixes after all issue comments.
- Confirmed #1042 is a valid post-4.1.1 enhancement/design request, not an urgent release regression.
- Archived #1015 from delegated MCP to `closed/` because PR #1038 merged on 2026-06-19 and GitHub issue #1015 is closed.
---

### Session 18: 2026-06-22 (Maintainer Closure Comments)
- Commented on #688 with the current plan: keep the issue open and track archive-based install implementation through PR #1013; do not close until the PR passes CI, merges, and is released.
- Closed #1028 as completed with a retest request for FVM 4.1.1, clean cache, and `FVM_USE_GIT_CACHE=false`; archived the local summary to `closed/`.
- Closed #914 as documented/not planned for automatic Git config mutation; archived the local summary to `closed/`.
- Re-ran `issue-triage/scripts/sync_github.sh`; pending snapshots now show 54 open issues and 3 open PRs.
---

### Session 19: 2026-07-18 (Live Sync + New Issue Triage)
- Ran `issue-triage/scripts/sync_github.sh`; pending snapshots now show **56 open issues** and **3 open PRs** (#828, #1013, #1022).
- Archived GitHub-closed items: **#1023** (upgrade workflow question; closed 2026-06-25) moved from `validated/p3-low` → `closed/`; **#1043** (macOS git-cache recreation via `.DS_Store` in refs; fixed/closed 2026-06-25) archived to `closed/` with artifact.
- Triaged newly open issues:
  - **#1046** → P2: fish terminal raw-mode after Ctrl+C on `fvm flutter` (4.1.2); inheritStdio insufficient; investigate `runInShell` + TTY restore (`artifacts/issue-1046.md`).
  - **#1047** → P2: Windows arm64 support; `windows-arm64` release asset already ships, but `install.ps1` hardcodes x64; Flutter `releases_windows.json` still has no arm64 archives (`artifacts/issue-1047.md`).
  - **#1048** → P3: explicit `updateVscodeSettings: false` still emits WARN; should debug-only (`artifacts/issue-1048.md`).
- Verified active classification parity: every live open issue has exactly one active P0/P1/P2/P3/needs-info summary; no untriaged open issues remain.
- Rebuilt Progress Tracker and Summary Statistics from live open set + active JSON folders.
---

### Session 20: 2026-07-18 (Full Queue Validation and Urgency Audit)
- Re-ran the live sync and confirmed **56 open issues** and **3 open PRs**; every open issue has exactly one active classification and a resolvable evidence artifact.
- Audited all 56 active artifacts against the validation template and upgraded 18 legacy artifacts that lacked explicit validation steps, repository evidence, or an implementation/closure plan.
- Revalidated every plausible urgent issue against `origin/main` v4.1.2. There are **no P0 issues**; **#688 remains the sole P1** because restricted-network installs still depend on Git/GitHub. PR #1013 is mergeable but its Linux `Test` check is failing.
- Reclassified **#767** from needs-info to P2 because multiple recent Android Studio/Flutter plugin confirmations establish a current compatibility bug; additional reproduction data is needed for implementation scope, not issue validity.
- Corrected stale conclusions for **#724** (still active IDE symlink-resolution gap), **#757** (Shorebird has a distinct SDK lifecycle), and **#720** (bare `fvm install` already reads `.fvmrc`; remaining pubspec fallback overlaps #577).
- Confirmed **#575, #697, #754, #791, and #794** are ready for evidence-backed maintainer replies and closure; replaced the stale 2025 closure/PR list in `ready-to-close.md` with the current queue.
- Repaired 14 broken archived artifact links and normalized the legacy #974 archive summary key/path.
- Repaired 99 active-report code/document links that were one directory too shallow; every local Markdown target in all 56 active artifacts now resolves.
---

### Session 21: 2026-07-23 (Live Queue Sync and Urgency Check)
- Rechecked GitHub: the live queue still has **56 open issues**. Closed #1047 left the queue and follow-up #1050 was added.
- Archived **#1047** as completed after merged PR #1049 documented native Windows ARM64 release archives, improved release parsing, and added a passing `windows-11-arm` smoke workflow.
- Triaged **#1050** as P2-medium: native ARM64 binaries already work through GitHub Releases; the remaining Winget/Chocolatey package-manager delivery gap overlaps #826 and is not a release blocker (`artifacts/issue-1050.md`).
- Revalidated urgency: **no P0 issues**; **#688 remains the sole P1**. Its implementation PR #1013 is still open and unstable because the Linux `Test` check is failing.
- Rechecked all newly created and recently updated bug reports; no additional P0/P1 issue was identified.
---

### Session 22: 2026-08-11 (Remote Refresh and Priority Audit)
- Fetched all current remote refs and ran `git pull --ff-only`; `issue-triage` is already current with `origin/issue-triage` and remains 24 commits ahead locally.
- Did not force-merge the 22 newer `origin/main` commits because the dirty triage worktree overlaps 82 remotely changed paths; all research used the fetched `origin/main` tree and live GitHub state.
- Ran `issue-triage/scripts/sync_github.sh`; snapshots now contain **57 open issues** and **6 open PRs**.
- Triaged new **#1055** as P3-low/ready-to-close: `fvm --version` and installation-method-specific update commands answer the question; current docs lack a consolidated update section (`artifacts/issue-1055.md`).
- Revalidated urgency: **no P0 issues** and **#688 remains the only P1**. PR #1013 is still stale/open with a failing Linux `Test` check.
- Identified **#1046 / PR #1054** as the highest-value actionable P2: the fish SIGINT fix includes PTY regression coverage but still needs the full CLI CI matrix and maintainer review.
- Recorded the current execution order in `artifacts/actionable-priority-plan-2026-08-11.md`.
---

### Session 23: 2026-08-11 (Latest-Code Full Queue Execution Plan)
- Audited the 57 active issues against a clean detached `origin/main` worktree at commit `2871c7d8ef924210689a10115695d137c9c776cb` (FVM 4.1.2), without merging over the dirty triage branch.
- Confirmed the 22 newer `main` commits do not invalidate active triage conclusions; their only direct active-queue impact is #1050, where native Windows ARM64 archives now exist but package-manager delivery remains open.
- Normalized 22 legacy issue reports, repairing 31 missing required validation-template sections; every active report now includes problem summary, validation steps, evidence, implementation/troubleshooting plan, and recommendation.
- Added `artifacts/all-open-issues-execution-plan-2026-08-11.md`, which assigns all 57 live issues exactly one primary disposition and sequences P1/PR review, closures, needs-info follow-up, core workstreams, packaging/providers, and CLI/documentation work.
- Verified all local plan citations and confirmed that every live issue number appears in the execution plan; classification counters are unchanged.
---

### Session 24: 2026-08-11 (Validity Cleanup and GitHub Closures)
- Re-synced the live queue and rechecked all 57 open issues against FVM 4.1.2, current `origin/main`, documentation, code paths, and live issue threads.
- Posted evidence-backed closure explanations and closed nine issues: **#575, #697, #720, #748, #754, #774, #791, #794, and #1055**.
- Marked **#720** duplicate/not planned because no-argument `fvm install` implements the `.fvmrc` behavior and remaining pubspec resolution is tracked in #577; marked **#754** not planned/working as intended because Homebrew owns the Xcode requirement.
- Closed the other seven as completed, answered, documented, or already supported; applied `working as intended`, `documentation`, and `question` labels where they clarify the disposition.
- Did not close valid enhancements or the seven remaining needs-info reports solely because of age; those require targeted evidence requests or an explicit stale-report policy.
- Re-ran `scripts/sync_github.sh`; the live queue now contains **48 open issues** and **6 open PRs**. Archived all nine summaries under `closed/` and documented the review in `artifacts/issue-closure-audit-2026-08-11.md`.
---

### Session 25: 2026-08-19 (Main Sync and New Intake)
- Merged `origin/main` into the triage branch (merge `e23bcf2c`), bringing the queue up to **v4.1.4** including #1060, #1049, and the v4.1.3/v4.1.4 release commits. Re-verified active conclusions against that tree.
- Re-ran `scripts/sync_github.sh`: **50 open issues**, **6 open PRs**. No issues closed since the 2026-08-11 sync; two new arrivals, **#1058** and **#1061**.
- Validated **#1061** as **P1**. Traced the reported ~4s per-command overhead to `EnsureCacheWorkflow` calling `ensureBareCacheIfPresent()` for every non-fork version, which reaches `git fsck --connectivity-only` over the entire bare cache through `_determineCacheState`. Confirmed the reporter's finding that `FVM_USE_GIT_CACHE=false` does not help, because `context.gitCache` only gates `updateLocalMirror`. Key evidence: the fsck result cannot change that call site's behavior, since `ready`, `missing`, and `invalid` share one no-op branch while the acting states come from the shape check.
- Validated **#1058** as **P2**. The Chocolatey `dart-sdk (= 3.9.0)` constraint is generated by `cli_pkg`'s `pkg-chocolatey-deploy`, not by this repository's `fvm.nuspec` (whose dependency block is commented out); the exact pin exists only because the Chocolatey artifact is a Dart snapshot. Native Windows packaging removes it and overlaps #1050.
- Recorded **PR #1013** (archive install hardening for the P1 #688) as **closed unmerged** on 2026-08-19; #688 stays open and now needs a fresh implementation pass. **PR #1056** (Android Studio guide, covering #697/#724/#767) is open.
- Scoped the branch to triage-only content: removed an incidental `.fvmrc`, reverted unrelated `fvm_mcp` formatter churn to `origin/main`, and dropped the local Android Studio docs copy already published as PR #1056. Relocated `mcp_task.md` under `issue-triage/` to match the `README.md` reference.
---

### Session 26: 2026-08-23 (Post-4.2.0 Sync, #1061 Closure, #1064 Intake)
- Ran `scripts/sync_github.sh` against live GitHub. Open set is still **50 issues** and **6 PRs** (`#828`, `#1022`, `#1051`, `#1053`, `#1054`, `#1056`). `origin/main` is now **v4.2.0** (4.1.5 and 4.2.0 shipped since Session 25). Research used `origin/main`; product code was not merged into this triage-only branch.
- Archived **#1061** to `closed/`. GitHub closed it as completed on 2026-08-22 via PR **#1066**, shipped in 4.1.5. `RunConfiguredFlutterWorkflow` now calls `EnsureCacheWorkflow(maintainGitCacheOnHit: false)`, so `fvm flutter` / `fvm dart` skip `ensureBareCacheIfPresent` / `git fsck --connectivity-only` on a cache hit. #688 is the only remaining P1.
- Archived **#1059** (opened and closed 2026-08-19, so it never sat in the open queue). Data-loss git-cache migration against unrelated repos; fixed by PR **#1060** in 4.1.4.
- Validated new **#1064** as **P2**. Official install docs prefix `FVM_INSTALL_DIR` onto `curl` in a `curl | bash` pipeline, so bash never sees it and custom-dir install silently uses `$HOME/fvm`. Confirmed on the live fvm.app page, `installation.mdx:127`, and a local POSIX env-prefix experiment. `install.sh` already reads the variable; CI only tests `export` + direct invoke. Plan: put the assignment on `bash`, guard the old snippet in CI, publish docs.
- Reconfirmed **#688** is still unresolved on v4.2.0 (git clone install path; no archive installer). Open PRs are unchanged except that **#1013** remains closed unmerged. No other open issue is now a P0/P1, and none of the remaining 49 pre-existing classifications changed.
- Classification parity: 50 open GitHub issues = 1 P1 + 30 P2 + 12 P3 + 7 needs-info. Closed archive is 64.
---

### Session 26b: 2026-08-23 (#688 closed not planned)
- Reviewed remaining P1 candidates with the maintainer. **#688 was the only P1.** No other open issue meets the P1 bar (install/setup blocker with no practical workaround).
- Explained that "archive install" means downloading Flutter SDK zip/tar files from `FLUTTER_STORAGE_BASE_URL` instead of `git clone`. That is **not** FVM's current install model. Custom Git remotes already work via `FLUTTER_GIT_URL` / `FVM_FLUTTER_URL` / `fvm config --flutter-url`.
- The implementation PR **#1013** was already closed unmerged on 2026-08-19; the GitHub **issue** was still open. Closed **#688** as **not planned** (`2026-08-23T19:31:47Z`).
- Open queue is now **49 issues**, **0 P1**. Highest remaining work is P2, starting with the #1064 docs one-liner.
---

### Session 27: 2026-08-25 (4.3.0 Resync, No New Intake)
- Re-ran `scripts/sync_github.sh`. Live GitHub still has **49 open issues** and the same **6 open PRs** (#1056, #1054, #1053, #1051, #1022, #828). No issues created since 2026-08-23. The only GitHub close in that window is #688, already archived.
- `origin/main` is now **v4.3.0** (PR #1068 `fvm cleanup`). Re-checked overlap with the open queue:
  - **#583** stays P2: cleanup can remove unused cached SDKs, but there is still no `fvm upgrade` / `--remove-old` / `fvm remove --force`.
  - **#681 / #764** stay P2: 4.3.0 does not change project `.fvm/versions` wiping on `fvm use`.
  - **#1064** stays P2: install docs on `origin/main` and fvm.app still put `FVM_INSTALL_DIR` on `curl`.
- Needs-info set is unchanged and still silent (#731, #759, #781, #797, #809, #906, #1017). No new reproduction data; left open per the age policy.
- Classification parity: 49 open = 0 P0 + 0 P1 + 30 P2 + 12 P3 + 7 needs-info. Nothing new to intake or escalate.
---

### Session 28: 2026-09-04 (Urgency Resync)
- Re-ran `scripts/sync_github.sh`. Live GitHub still has **49 open issues** (same numbers as Session 27). No issues created or closed since 2026-08-25. Open PRs are now **7** because **PR #1070** (`docs: put FVM_INSTALL_DIR on the bash side of the install pipe`, Fixes #1064) opened 2026-08-28.
- Urgency pass against `origin/main` v4.3.0 and the live bug list: **no P0, no P1**. Default install still works; no widespread install/runtime regression.
- **#1064** stays P2: the docs one-liner is still wrong on main/fvm.app; PR #1070 is the exact planned fix and is the highest-value merge. Do not close until it lands and the site publishes.
- **#1046** stays P2: PR #1054 was touched 2026-08-31 but still has no full CLI CI / review (Vercel auth failure only). Highest-value remaining runtime bug, fish-only.
- **#787** stays P3: new 2026-09-02 comment wants rustup-style global `flutter` on PATH; that is already `fvm global` + PATH, not an urgent bug.
- Classification parity unchanged: 49 open = 0 P0 + 0 P1 + 30 P2 + 12 P3 + 7 needs-info.
---

### Session 29: 2026-09-08 (4.3.1 refresh and pre-4.0 legacy cleanup)

- Reviewed all 48 live open issue threads; used the corrected pre-4.0 cutoff without blanket age-based closure. Full evidence and retained-issue decisions: [closure audit](issue-closure-audit-2026-09-08.md).
- [x] #584 → closed (completed): Custom Flutter remotes and the requested FLUTTER_GIT_URL fallback are implemented and documented.
- [x] #600 → closed (completed): Android Studio setup documentation shipped in #1056; automatic IDE switching remains tracked in #724/#767.
- [x] #731 → closed (not planned): Retire the legacy 3.1.5–3.1.7 cache support thread; current hook-environment protection exists, but the original screenshot-only failure is not proven fixed.
- [x] #797 → closed (not planned): Retire the FVM 3.2.1 CRLF/IDE support report; no current reproduction, and the IDE question has current documentation.
- [x] #809 → closed (not planned): Retire the FVM 3.2.1 Sidekick follow-up; original tracking stays in sidekick#280, no reliable CLI reproduction.
- [x] #811 → closed (completed): FVM is already packaged in nixpkgs; current upstream derivation targets 4.3.1.
- [x] #906 → closed (not planned): Archive unanswered Android Studio terminal-latency report after two June 2026 diagnostic requests; reported FVM version is unknown.
- [x] #1021, #1046, #1064 → archived: already closed September 4, now reconciled with shipped/published fixes.
- [x] #1073 → P2: initial bare Git-cache fetch has no streamed progress; implementation and verification plan captured.
- [x] #1074 → P2: automatic platform-based SDK selection is distinct from explicit flavors; design/compatibility plan captured.
- Corrected historical scope assumptions for #696 (metadata versus SDK cache), #702 (verify extension precedence), #757 (fork source versus tool lifecycle), #787 (project-aware shims versus global pin) and #724 (IDE selection versus doctor metadata).
- Kept #782, #681/#764, #724/#767, #762 and all other still-relevant enhancements open. #759/#781/#1017 remain needs-info.
- Sole open PR #1053 remains on hold; no PR mutation or release action.
- Verified closure reasons, rebuilt per-issue classifications and counters, refreshed live GitHub before handoff. Final parity: 41 open = 28 P2 + 10 P3 + 3 needs-info; 75 archived, 116 historical.
---

### Session 30: 2026-09-08 (Type and validity categorization)

- Reviewed all 41 retained items by type, evidence, age and current scope. Full table: [category review](open-issue-categories-2026-09-08.md).
- [x] #578 → closed completed after verifying the MacPorts Portfile targets 4.3.1. Supersedes the earlier keep-open recommendation.
- [x] #1009 → needs-info, not a validated P3 defect; require direct-SDK comparison and a minimal fork/ref.
- [x] #761 → confirmed bug, reproduced on the published 4.3.1 binary; corrected GitHub type label.
- [x] #759 → question / needs-info, not automatic global-SDK switching.
- [x] All 40 retained issues → labeled: 7 triage:confirmed, 2 triage:upstream, 4 need info, 27 triage:backlog. Per-issue JSON/artifacts capture evidence, next steps and pre-label activity dates.
- #674 partly implemented flags/context behavior and #689 mixed completion/plaintext scope now explicitly recorded.
- #782 reproduced under dash; macOS sh accepts the syntax. No universal shell-failure claim.
- Preserved historical plans and existing unrelated labels; grouped overlaps without speculative duplicate closure.
- Final parity: 40 open = 28 P2 + 8 P3 + 4 needs-info; 76 archived, 116 historical. No P0/P1; PR #1053 unchanged.
---

### Session 31: 2026-09-08 (Housekeeping recommendations and label audit)

- Verified exactly one review-state label on all 40 open issues; category counts unchanged.
- [x] #826 → added windows area label for Winget.
- [x] #635 → removed good first issue because lossless JSONC editing has nontrivial design/testing requirements; bug/confirmed/help wanted retained.
- Saved [housekeeping plan](housekeeping-plan-2026-09-08.md): proposed lead issues, consolidation boundaries, targeted needs-info requests/30-day response-window proposal, explicit maintenance decisions for older features, and local source-of-truth cleanup.
- No issue closures, parent/child creation, information-request comments or stale automation in this pass. Product/priority classifications unchanged.
- Final counters remain 40 open (28 P2, 8 P3, 4 needs-info), 76 archived; 7 confirmed, 2 compatibility, 27 backlog.
---

### Session 32: 2026-09-08 (Low-risk PR and consolidation execution plan)

- Saved the [low-risk PR and consolidation plan](low-risk-pr-plan-2026-09-08.md): two independently reviewable fixes (#1048, #782), one optional triage-guidance PR, explicit test/publication gates, and separate administrative cleanup.
- Rechecked live main/release state (4.3.1, a6d93976), the two fix code/doc paths and existing tests. The current dirty triage branch remains on 4.1.4; future product PRs must start from current main without importing unrelated triage changes.
- #1048: narrowed to the specific opt-out warning, retaining the debug/return path and unrelated unpinned-project warning. Existing Logger.outputs supports focused assertions; file-preservation tests and branch smoke test are planned, not run.
- #782: refined the low-risk scope to withdrawing unsafe process-wide wrapper instructions in favor of explicit FVM commands / existing aliases. Missing shebang/argument syntax, executable overwrites and PATH fallback recursion make a replacement shim installer inappropriate for this batch.
- #681/#764: conditional consolidation only after preserving the relative-link and checkout requirements. #751/#1016: link first; the latter additionally requires fvm list patch-availability indicators. Closed #421 requires a version-resolution policy decision.
- #648: confirmed fvm list has Dart Version but fvm releases does not; #828 was closed unmerged September 4 by documented scope/UX decision. Preserved all three original Dart requirements; no automatic reopening.
- #607: retained pending an explicit Snap/Flatpak maintenance decision; no claim the feature is implemented. Windows packaging remains linked but separate.
- Updated eight existing per-issue artifacts/JSON next actions with the execution-plan reference and refreshed the current README ordering. Historical evidence, age fields, classifications and counters remain intact.
- Planning-only pass: no product edits, runtime tests, GitHub comments/body edits/labels/closures, branches, PRs or release actions. Final live issue/label parity was rechecked before handoff.

---

### Session 33: 2026-09-08 (Approved issue consolidation and cleanup)

- Completed the [approved cleanup](issue-cleanup-2026-09-08.md) using short, issue-specific maintainer replies. The Human Writing skill was applied without changing technical meaning or inventing delivery claims.
- [x] #764 → closed as not_planned/consolidated into #681 after recording retained links, relative/removable flutter_sdk, metadata, checkout, and cache-lifecycle requirements in the surviving thread. Kept enhancement, added duplicate and removed the active backlog label. No SDK behavior was fixed.
- [x] #751/#1016 → linked with their different range, installation and patch-indicator requirements preserved; both remain open pending the #421 policy question.
- [x] #648 → clarified the three original Dart requests and list-versus-releases output; #828 stays closed unmerged.
- [x] #1050/#826/#1058 → linked, retaining separate ARM64, general Winget and Chocolatey-dependency scopes. All remain open.
- [x] #759/#781/#1009/#1017 → posted targeted diagnostic requests that acknowledge existing evidence. All remain needs-info; no response deadline or stale automation was introduced.
- #607 remains untouched pending an explicit Snap/Flatpak maintenance decision. No other issues were closed or old PRs reopened.
- Verified all 12 posted replies, original titles/bodies, and #764's actual closure reason. Saved the [comment journal](../comment_logs/issue-cleanup-2026-09-08.json), updated per-issue artifacts/next actions, archived #764 and refreshed the GitHub snapshot. Reporter-activity timestamps were preserved separately from these maintainer replies.
- Final queue: 39 open = 27 P2 + 8 P3 + 4 needs-info; 77 archived, 116 historical. Categories: 7 confirmed, 2 compatibility, 4 needs-info, 26 backlog. Only open PR #1053 is unchanged. No product code, tests, PRs or release actions in this pass.

---

### Session 34: 2026-09-08 (Approved legacy backlog retirement)

- Used the Human Writing skill for five concise, issue-specific replies; fresh preflight checks found no new reporter evidence on these five issues.
- [x] #607 → closed as not planned: maintainer declined Snap/Flatpak maintenance. The installer alternative is not proof those packages shipped.
- [x] #674 → closed as not planned: retired the optional flags/context refactor, not a verified bug fix.
- [x] #738 → closed as not planned: declined an official Codespaces/devcontainer template. Docker ARM64 #762 and PR #1053 remain separate and open.
- [x] #759/#781 → remain needs-info, with current diagnostics requested by September 22, 2026. Review replies on or after September 23 before considering not-planned closure. No automatic closure was scheduled; #1009/#1017 have no deadline.
- Preserved original issue titles/bodies, unrelated labels and pre-cleanup activity dates. Removed only the active backlog label from the three closed issues; no other GitHub issues or PRs were edited.
- Saved the [legacy cleanup audit](legacy-cleanup-2026-09-08.md) and [comment journal](../comment_logs/legacy-cleanup-2026-09-08.json); archived the three records and refreshed the live queue.
- Final queue: 36 open = 25 P2 + 7 P3 + 4 needs-info; 80 archived, 116 historical. Categories: 7 confirmed, 2 compatibility, 4 needs-info, 23 backlog. Of the 36, 23 predate FVM 4.0; age is not an affected-version assertion. No product edits, tests, new PRs or release actions.

---

## Summary Statistics

- **Last Counter Verification**: 2026-09-08 (Session 34; three optional requests retired)
- **Open Issues**: 36
- **P0 Critical**: 0
- **P1 High**: 0
- **P2 Medium**: 25
- **P3 Low**: 7
- **Needs Info**: 4
- **Delegated MCP**: 0
- **Resolved/Archived**: 80
- **Evidence-backed Defects**: 7
- **IDE Compatibility**: 2
- **Feature/Design Backlog**: 23
