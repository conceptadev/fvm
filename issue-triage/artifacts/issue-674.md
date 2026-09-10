# Issue #674: Pass global level flags and options

Current disposition — 2026-09-08: [closed as not planned](https://github.com/leoafarias/fvm/issues/674#issuecomment-5593075163) because the maintainer retired the optional flags/context refactor; existing partial context support does not complete the broader request. The historical proposals below are not scheduled. This is not a verified fix.

## Metadata
- **Reporter**: Leo Farias (@leoafarias)
- **Created**: 2024-02-29
- **Reported Version**: 3.0.x
- **Issue Type**: enhancement (internal architecture)
- **URL**: https://github.com/leoafarias/fvm/issues/674

## Problem Summary
Several command-line flags (e.g., `--force`, `--skip-setup`, `--skip-pub-get`) are passed down through multiple command/workflow layers. Each new workflow needs to accept these parameters, making the signature surface inconsistent and error-prone. We want a single source of truth for runtime options so sub-workflows can consult context instead of adding more method arguments.

## Version Context
- Reported against: FVM 3.0.x
- Current version: v4.0.0
- Version-specific: no — current code still threads flags manually.
- Reason: No runtime option registry exists in `FvmContext`; commands mutate boolean flags and forward them manually.

## Validation Steps
1. Reviewed `lib/src/commands/use_command.dart:52-90` and observed flags being read and passed to `UseVersionWorkflow`, `EnsureCacheWorkflow`, etc.
2. Inspected other commands (e.g., `global`, `destroy`) and found similar boilerplate to propagate `--force`.
3. Checked `FvmContext` (`lib/src/utils/context.dart`) — it stores configuration and environment, but not per-command runtime options.
4. Confirmed no helper exists to set or retrieve command-scoped flags from the context, so every workflow must carry extra parameters.

## Evidence
```
$ sed -n '52,120p' lib/src/commands/use_command.dart
    final forceOption = boolArg('force');
    final skipPubGet = boolArg('skip-pub-get');
    final skipSetup = boolArg('skip-setup');
    ...
    await useVersion(
      version: cacheVersion,
      project: project,
      force: forceOption,
      skipSetup: skipSetup,
      skipPubGet: skipPubGet,
      flavor: flavorOption,
    );
```

**Files/Code References:**
- [lib/src/commands/use_command.dart#L52](../../lib/src/commands/use_command.dart#L52) – Example of flag propagation.
- [lib/src/utils/context.dart#L1](../../lib/src/utils/context.dart#L1) – Context currently lacks runtime option storage.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
Without a central registry, every workflow must receive flags explicitly. This leads to repetitive signatures and risks forgetting to forward a flag when introducing new workflows.

### Proposed Solution
1. Extend `FvmContext` with a `CommandOptions` helper:
   - Add a mutable `Map<String, dynamic>` (or typed wrapper) and helper methods (`setOption`, `getBool`, etc.).
   - Ensure the map resets for each command invocation to avoid leaks between runs.
2. Enhance `FvmCommandRunner.run` / `runCommand`:
   - After `parse(args)`, store relevant global values (e.g., `verbose`) and pass the full `ArgResults` to the active command.
   - Introduce a lightweight `CommandScope` utility to push/pop options when subcommands are executed programmatically.
3. Update commands/workflows gradually:
   - Replace parameters like `skipSetup`, `force`, `skipPubGet` with reads from `context.commandOptions`.
   - Maintain backward compatibility during migration by defaulting to parameter values if provided.
   - Simplify workflow signatures once all call sites rely on context.
4. Provide helpers for defaulting and type safety (e.g., `context.options.skipSetup`).
5. Add tests verifying:
   - Options persist throughout nested workflow invocations.
   - Options reset between separate command executions.
6. Document the new API for maintainers (in `AGENTS.md` / contributor docs) to encourage using context instead of threading parameters.

### Alternative Approaches (if applicable)
- Create immutable command config objects and pass a single `UseOptions` struct instead of multiple parameters. Still requires manual forwarding, so context-based storage is cleaner.

### Dependencies & Risks
- Need to avoid stale data when running commands programmatically (e.g., integration tests). Ensure options map is cleared when command completes.
- Multi-threaded/parallel execution is not supported today; the new map should stay command-local.
- Commands that spawn other FVM commands (integration tests) must propagate or isolate options intentionally.

### Related Code Locations
- [lib/src/workflows/use_version.workflow.dart#L21](../../lib/src/workflows/use_version.workflow.dart#L21) – Candidate for reading flags from context instead of parameters.
- [lib/src/commands/destroy_command.dart#L27](../../lib/src/commands/destroy_command.dart#L27) – Another example of manual flag handling.

## Recommendation
**Action**: validate-p2

**Reason**: Architectural cleanup that reduces boilerplate and future bugs. Medium priority because current behavior works, but maintenance cost is high.

## Notes
- After rollout, audit all commands for duplicate flag parsing and remove redundant parameters.
- Consider surfacing command options in debug logging to aid troubleshooting (`logger.debug`).

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: command-scoped option/context design remains a valid refactoring request, not a pre-4-only bug.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: maintenance / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Partially implemented: skipInput/isCI already live in FvmContext. General force/skipSetup options are still passed through workflows. Retain as optional internal DX design, not a missing feature across all flags.
- **Source**: lib/src/utils/context.dart:73,207; lib/src/workflows/ensure_cache.workflow.dart:142 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-02-29; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
