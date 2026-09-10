# Issue #906: Very long wait when opening terminal in android studio

## Metadata
- **Reporter**: @MrErkinjon
- **Created**: 2025-09-12
- **Reported Version**: FVM 3.29.3 (macOS/Android Studio)
- **Issue Type**: bug (performance)
- **URL**: https://github.com/leoafarias/fvm/issues/906

## Problem Summary
Android Studio’s integrated terminal allegedly takes “very long” to open after the reporter runs `fvm use 3.29.3` in the project. No timing data or logs were provided beyond screenshots.

## Version Context
- Reported against: v3.29.3 (CLI)
- Current version: v4.0.0
- Version-specific: unknown — cannot confirm without reproduction

## Validation Steps
1. Reviewed `scripts/install.sh` and shell integration docs; no known blocking operations execute automatically when a terminal opens beyond PATH exports.
2. Searched the repository for recent changes affecting Android Studio terminals; no obvious regressions found.
3. Attempted to line up a repro environment, but we don’t currently have access to the reporter’s Android Studio configuration or shell profile; reproduction remains pending until we can mirror their setup.

## Evidence
_No repro logs available; issue only contains screenshots._

## Current Status in v4.0.0
- [ ] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [x] Needs more information

## Troubleshooting/Implementation Plan

### Information Needed
- Concrete timing measurements (e.g., `time /usr/bin/open -a ...` or Android Studio log) showing the startup delay.
- Whether the delay occurs outside Android Studio (iTerm/Terminal) when sourcing the same shell config.
- Output of `fvm doctor --verbose` and Android Studio version/build number.
- Contents of the shell init files that FVM modified (e.g., `~/.zshrc`, `~/.bashrc`) to rule out expensive custom logic.

### Next Steps Once Data Is Available
1. Reproduce the slowdown by mirroring the user’s shell configuration.
2. If the delay stems from repeated PATH exports in shell configs, adjust the installer to avoid duplicate blocks.
3. Profile startup scripts (`set -x`, `zprof`) to identify slow commands; optimize or document mitigations.
4. Add documentation covering Android Studio terminal performance tips once root cause is known.

### Dependencies & Risks
- Requires reporter collaboration; without logs, risk misdiagnosing.

## Recommendation
- Folder: `needs_info`
- Priority: TBD once reproduced

## Notes for Follow-up
- Respond on GitHub requesting the data listed above. If the reporter doesn’t respond within the SLA, consider closing as stale.

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes earlier recommendations above.

- **Decision**: close as not planned; Archive unanswered Android Studio terminal-latency report after two June 2026 diagnostic requests; reported FVM version is unknown.
- **Evidence**: Created before 4.0, but FVM version was never provided. Maintainer requested diagnostics 2026-06-10 and 2026-06-25 with no reporter response. #1066/4.1.5 removed cache maintenance on installed-SDK proxy hot paths, but this is not proof of this report's cause.
- **Validation**: live issue body/comments, current origin/main at a6d93976d443082d73d4718750713e6248de6b84, and relevant source/docs inspected. No product changes or full runtime reproduction.
- **Follow-up plan**: No fix is inferred. Reassess a fresh current-version reproduction with the diagnostics requested in the closure comment.
- **GitHub explanation**:

Closing this older support report as not planned because the diagnostic requests on June 10 and June 25 remain unanswered. We still do not have the FVM version, timings, or enough detail to isolate terminal startup from `pub get` or IDE work.

If this persists on FVM 4.3.1, please open a fresh report with `fvm --version`, `fvm doctor`, the terminal/shell startup configuration, and comparative timings inside Android Studio versus an external terminal. Recent cache performance changes may help some cases, but I cannot say they fix this report without that evidence.

**Verified closure**: 2026-09-08T15:03:43Z, GitHub reason `not_planned`. [Closure comment](https://github.com/leoafarias/fvm/issues/906#issuecomment-5587263695).
