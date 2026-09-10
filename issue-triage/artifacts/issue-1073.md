# Issue #1073: [Feature Request] Show progress on installing a new version

## Metadata

- Reporter: AliYar-Khan
- Created: 2026-09-05T18:47:13Z
- Type: feature request
- URL: https://github.com/leoafarias/fvm/issues/1073
- Reviewed: 2026-09-08

## Problem Summary

The first `fvm install stable` can appear stalled while creating the shared Git cache. The request is for visible progress, not a demonstrated deadlock.

## Version Context

- Reported FVM version: not supplied; submitted 2026-09-05.
- Reviewed version: 4.3.1, origin/main a6d93976d443082d73d4718750713e6248de6b84.
- Not a pre-4.0-only report.

## Validation Steps and Evidence

1. Read the full issue and checked for comments (none).
2. Inspected `lib/src/services/git_service.dart:250`: `_createHeadsTagsCacheInto` prints "Creating local git cache..." once, then initializes, configures the remote, fetches, sets HEAD and validates.
3. `_fetchHeadsTags` at line 469 calls `git fetch --prune --no-tags origin` without `--progress`.
4. `lib/src/services/process_service.dart:91` defaults to `echoOutput: false`; the buffered `Process.run` path does not stream that fetch to the user.
5. An existing `lib/src/utils/git_clone_progress_tracker.dart` supports SDK cloning, but does not cover this initial bare-cache fetch.

## Current Status in v4.3.1

- [x] Still applicable by source inspection.
- [ ] End-to-end slow-network reproduction performed.
- [ ] Deadlock proven.

## Troubleshooting/Implementation Plan

### Root Cause Analysis

The lengthy network stage has only a static initial message. Git's own progress is absent/suppressed and subprocess output is buffered.

### Proposed Solution

1. Add an explicit cache-fetch phase in `GitService._createHeadsTagsCacheInto`; distinguish initialization, download and validation.
2. Evaluate reusing the clone progress tracker for streamed fetch stderr with `--progress`. Use an indeterminate activity indicator when no totals are available; do not fabricate percentages.
3. Preserve captured diagnostics, nonzero exit handling, cancellation, repository-environment scrubbing, cache locks and atomic replacement.
4. Add deterministic fake-Git tests for delayed progress chunks, completion, errors and interruption. Ensure CI/non-TTY output is useful without animation/control characters.
5. Verify a first install with empty isolated FVM/Git caches and an existing-cache install. Run analysis, DCM, tests and the documented isolated manual smoke test before merging an implementation.

### Dependencies and Risks

Progress output must not change subprocess semantics or expose authentication data. Existing cache creation can be shared across concurrent installs; avoid misleading duplicate progress displays.

## Recommendation

**Action**: validate-p2. Current, useful install UX request. No product change during triage.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2 (new): initial bare git-cache fetch buffers output without explicit progress; add visible phases/progress while preserving non-TTY behavior.
- **Source**: lib/src/services/git_service.dart:250,469; lib/src/services/process_service.dart:91 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2026-09-05; postdates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
