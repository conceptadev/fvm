# Issue #1059: [BUG] FVM git-cache migration can destroy an unrelated repository

## Metadata
- **Reporter**: (see GitHub issue)
- **Created**: 2026-08-19
- **Reported Version**: 4.1.2
- **Issue Type**: bug
- **URL**: https://github.com/leoafarias/fvm/issues/1059

## Problem Summary
When the git-cache path existed but was not FVM's own standalone repository, FVM classified it as a legacy clone via Git's normal discovery (`core.bare` with upward walk, gitfile redirection, and inherited `GIT_DIR`). Migration then ran `git reset --hard` / `git clean -fdx` / remote rewrites / `fetch --prune` against a repository FVM did not own. Real damage included emptied indexes in hook runs, rewritten remotes, and foreign Flutter refs injected into a project repo.

## Version Context
- Reported against: v4.1.2
- Current version: v4.2.0
- Version-specific: yes — fixed in v4.1.4
- Reason: PR #1060 merged 2026-08-19 and shipped in the v4.1.4 release. Changelog: stop git-cache maintenance from running destructive git commands against repositories FVM does not own, and clear `git rev-parse --local-env-vars` when spawning `git` / `flutter` / `dart`.

## Validation Steps
1. Confirmed GitHub state: closed as completed on 2026-08-19, closing reference PR #1060.
2. Confirmed `origin/main` CHANGELOG 4.1.4 records the fix and the git-env scrubbing behavior change.
3. Noted this issue never appeared in the 2026-08-19 open-queue snapshot because it was opened and closed the same day as Session 25.

## Current Status in v4.2.0
- [ ] Still reproducible
- [x] Already fixed
- [ ] Not applicable to v4.2.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Recommendation
**Action**: resolved (archive)

**Reason**: Data-loss bug, already shipped in 4.1.4 via #1060. No further triage or implementation work.

## Notes
- Related later work: #1061 / #1066 skipped git-cache maintenance on the flutter/dart hot path, which also reduces how often cache classification runs during everyday commands.
- Archived on 2026-08-23 during the post-4.2.0 queue sync so the closed set matches GitHub.

---
**Validated by**: Code Agent
**Date**: 2026-08-23
