# Issue #1064: [BUG] Docs: custom install dir variable set incorrectly

## Metadata
- **Reporter**: olof-dev
- **Created**: 2026-08-21
- **Reported Version**: docs (current fvm.app install page)
- **Issue Type**: documentation
- **URL**: https://github.com/leoafarias/fvm/issues/1064

## Problem Summary
The official Linux/macOS install docs tell users to select a custom install directory with:

```bash
FVM_INSTALL_DIR=<path> curl -fsSL https://fvm.app/install.sh | bash
```

That assignment applies only to `curl`, not to the `bash` process that actually runs `install.sh`. The documented command therefore silently installs to `$HOME/fvm` instead of the requested path. The reporter's form is the correct one:

```bash
curl -fsSL https://fvm.app/install.sh | FVM_INSTALL_DIR=<path> bash
```

## Version Context
- Reported against: current docs (issue opened 2026-08-21; no FVM runtime version)
- Current version: v4.2.0 (`origin/main`)
- Version-specific: no
- Reason: The bug is in the published install one-liner, not in FVM itself. `install.sh` already honors `FVM_INSTALL_DIR` when that variable is present in the installer process environment. The same wrong one-liner is still on `origin/main` and on https://fvm.app/documentation/getting-started/installation.

## Validation Steps
1. Read the live install page and the repo copy of `installation.mdx`.
2. Confirmed `docs/public/install.sh` reads `FVM_INSTALL_DIR` inside `resolve_install_base()`.
3. Reproduced POSIX pipeline env-prefix behavior with a local bash experiment (no network install required).
4. Checked CI: the custom-dir job exports `FVM_INSTALL_DIR` in the same shell that runs `install.sh` directly, so it never exercises the documented `curl | bash` form.
5. Confirmed `install.sh --help` documents the variable but does not show the broken curl prefix example.

## Evidence

Repo docs, still wrong on `origin/main` and this branch:

```markdown
# docs/pages/documentation/getting-started/installation.mdx:127
- **Custom install location**: `FVM_INSTALL_DIR=<path> curl -fsSL https://fvm.app/install.sh | bash` (absolute path under `$HOME`)
```

The installer *does* honor the variable when it is actually in its environment:

```bash
# docs/public/install.sh:27-31
resolve_install_base() {
  local base="${FVM_INSTALL_DIR:-}"
  if [ -z "$base" ]; then
    base="${HOME}/fvm"
  fi
```

POSIX/bash env prefixes bind to the simple command they precede, not to the other side of a pipe. Local reproduction (2026-08-23):

```text
--- documented pattern (env on left of pipe) ---
bash received FVM_INSTALL_DIR=<unset>
--- reporter pattern (env on bash) ---
bash received FVM_INSTALL_DIR=/tmp/custom-fvm
```

CI does not catch this, because it exports the variable and invokes the script in-process:

```yaml
# .github/workflows/test-install.yml:101-107
- name: Test custom install location (FVM_INSTALL_DIR)
  run: |
    export FVM_INSTALL_DIR="$HOME/fvm-install-test"
    ...
    ./docs/public/install.sh
```

Live docs at https://fvm.app/documentation/getting-started/installation still show the curl-prefixed form.

**Files/Code References:**
- [docs/pages/documentation/getting-started/installation.mdx:127](../../docs/pages/documentation/getting-started/installation.mdx#L127) - documented one-liner puts `FVM_INSTALL_DIR` on `curl`
- [docs/public/install.sh:27](../../docs/public/install.sh#L27) - installer reads `FVM_INSTALL_DIR` from its own environment
- [docs/public/install.sh:96](../../docs/public/install.sh#L96) - help text documents the variable, without a curl example
- [.github/workflows/test-install.yml:101](../../.github/workflows/test-install.yml#L101) - CI covers the export/direct-invoke path only

## Current Status in v4.2.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.2.0
- [ ] Needs more information
- [ ] Cannot reproduce

Default install (`curl ... | bash` with no custom dir) is unaffected. Custom-dir install via the documented one-liner is a silent no-op.

## Troubleshooting/Implementation Plan
**IMPORTANT**: This section is a plan only. Do not implement the fix during triage.

### Root Cause Analysis
`VAR=value cmd` sets `VAR` only for `cmd`. In `FVM_INSTALL_DIR=<path> curl ... | bash`, `bash` is a separate process and never sees the variable, so `resolve_install_base()` falls back to `$HOME/fvm`. Users get a successful install in the default location and can easily miss that the custom path was ignored.

### Proposed Solution
1. Change the custom-location example in [installation.mdx:127](../../docs/pages/documentation/getting-started/installation.mdx#L127) to put the assignment on the installer process, e.g. `curl -fsSL https://fvm.app/install.sh | FVM_INSTALL_DIR=<path> bash`.
2. Optionally add an equivalent `export FVM_INSTALL_DIR=<path>` then `curl ... | bash` form, which also works and matches the CI job.
3. Add the same corrected example to `install.sh` `usage()` so `--help` and the docs cannot drift.
4. Extend `.github/workflows/test-install.yml` with a piped invocation (`cat docs/public/install.sh | FVM_INSTALL_DIR=... bash` or `env FVM_INSTALL_DIR=... bash docs/public/install.sh` is not enough by itself — the regression to catch is specifically env-on-curl vs env-on-bash). A cheap unit-less check is: fail the docs test if the old prefix-on-curl snippet reappears.
5. Publish the docs site so fvm.app matches the repo.

### Alternative Approaches
- Prefixing the entire pipeline (`FVM_INSTALL_DIR=<path> sh -c 'curl ... | bash'`) also works, but is harder to copy and easier to get wrong than putting the assignment on `bash`.
- Changing `install.sh` cannot fix the documented one-liner; the installer never receives the variable.

### Dependencies & Risks
- Docs-only plus a CI assertion. No FVM runtime change.
- Custom dir still must be an absolute path under `$HOME`; that validation in `install.sh` is correct and should stay.
- Avoid recommending `sudo` with this variable; the installer is user-local.

### Related Code Locations
- [docs/pages/documentation/getting-started/installation.mdx:125](../../docs/pages/documentation/getting-started/installation.mdx#L125) - neighboring one-liners that correctly put flags on `bash -s`
- [docs/public/uninstall.sh:7](../../docs/public/uninstall.sh#L7) - uninstall also reads `FVM_INSTALL_DIR`; any docs example for uninstall should use the same env-on-bash pattern

## Recommendation
**Action**: validate-p2

**Reason**: Confirmed official-docs bug: the documented custom-install command silently ignores the directory. Default install still works, so this is not a P0/P1 setup blocker, but it is a real getting-started failure with a one-line fix.

## Notes
- Closest precedent is #782 (docs snippet that does not work under the shell users actually run); that was also P2.
- Do not close until the docs site is updated; a repo-only fix leaves fvm.app wrong.

## 2026-09-04 Revalidation Update
- Still open and still wrong on `origin/main` v4.3.0 and on fvm.app.
- PR **#1070** (opened 2026-08-28) is a one-line docs fix that matches the triage plan: `curl ... | FVM_INSTALL_DIR=<path> bash`. It declares `Fixes #1064`. Not merged yet; the only GitHub check is a failed Vercel authorization, which is not product CI.
- Keep **P2**. Not P0/P1: default install still works. Highest-value remaining docs merge.

---
**Validated by**: Code Agent
**Date**: 2026-08-23
**Last revalidated**: 2026-09-04

## 2026-09-08 reconciliation — FVM 4.3.1

This dated review supersedes the earlier open-PR recommendation.

Already closed on GitHub: #1070 merged and installation docs corrected the environment assignment to the bash side of the pipe.

Verified via live GitHub API: closed 2026-09-04T17:59:34Z, reason `completed`. Current origin/main changelog/source and prior release verification agree. No new closure comment was posted; this is local reconciliation only. No further implementation is needed for this issue.
