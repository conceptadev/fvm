# Issue #1026: [Feature Request] Per-project JDK configuration

## Metadata
- **Reporter**: manmaor
- **Created**: 2026-04-05
- **Reported Version**: Not specified
- **Issue Type**: feature/toolchain configuration
- **URL**: https://github.com/leoafarias/fvm/issues/1026

## Problem Summary
Flutter stores `--jdk-dir` configuration globally, so users working across projects with different Java requirements must repeatedly switch the JDK. The issue requests FVM-managed per-project JDK configuration.

## Version Context
- Reported against: current FVM 4.x behavior
- Current version: v4.0.0 triage baseline; branch package version is 4.0.5
- Version-specific: no
- Reason: This is a missing project-scoped toolchain feature, not a version-specific regression.

## Validation Steps
1. Searched code and docs for `jdk-dir`, `JAVA_HOME`, and JDK-specific configuration.
2. Confirmed `.fvmrc` supports project settings, but not a JDK path.
3. Checked issue comments; reporter supplied a shell workaround that wraps FVM and switches JDK before command execution.

## Evidence
```text
grep jdk-dir/JAVA_HOME: no project-scoped JDK implementation found in lib/ or docs/.
lib/src/models/config_model.dart: ProjectConfig contains FVM settings, but no jdkDir field.
docs/pages/documentation/getting-started/configuration.mdx: project config options do not include JDK configuration.
```

**Files/Code References:**
- [../../lib/src/models/config_model.dart](../../lib/src/models/config_model.dart) - project/global config model.
- [../../lib/src/services/project_service.dart](../../lib/src/services/project_service.dart) - project config update path.
- [../../lib/src/workflows/use_version.workflow.dart](../../lib/src/workflows/use_version.workflow.dart) - central project switch workflow.
- [../../docs/pages/documentation/getting-started/configuration.mdx](../../docs/pages/documentation/getting-started/configuration.mdx) - documented config options.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
FVM scopes Flutter SDK selection per project, but it does not currently scope Android Java configuration. Flutter's `config --jdk-dir` is global, so FVM cannot isolate JDK choice without adding its own project setting and command-environment behavior.

### Proposed Solution
1. Add an optional project config field such as `jdkDir` to [../../lib/src/models/config_model.dart](../../lib/src/models/config_model.dart).
2. Add CLI support to set/clear the project JDK value, or document direct `.fvmrc` editing if a command is not added initially.
3. Update the command proxy path so `fvm flutter`, `fvm dart`, `fvm use`, and dependency resolution run with the configured `JAVA_HOME`/`PATH` adjusted for that project.
4. Investigate whether Flutter's global `jdk-dir` setting can be avoided entirely; if not, design a safe set/restore wrapper around Flutter commands.
5. Add tests covering config serialization, environment construction, and no-leak behavior between two projects.

### Alternative Approaches
- Document shell hooks only and leave FVM out of JDK switching.
- Add a generic per-project environment variable block instead of a JDK-specific setting.
- Integrate with `.java-version`/jEnv/asdf rather than storing paths in `.fvmrc`.

### Dependencies & Risks
- Mutating Flutter's global config during every command could race across concurrent projects.
- Absolute JDK paths in `.fvmrc` may not be portable across machines.
- Environment-only configuration may not override a previously set Flutter global `jdk-dir`.

### Related Code Locations
- [../../lib/src/workflows/run_configured_flutter.workflow.dart](../../lib/src/workflows/run_configured_flutter.workflow.dart) - Flutter command execution path.
- [../../lib/src/services/flutter_service.dart](../../lib/src/services/flutter_service.dart) - managed SDK process execution.
- [../../lib/src/utils/context.dart](../../lib/src/utils/context.dart) - environment/config context.

## Recommendation
**Action**: validate-p2

**Reason**: Valid toolchain isolation gap for Android projects. It has workarounds but causes real multi-project friction and fits the same medium-priority IDE/toolchain class as other project environment issues.

## Notes
The reporter shared a workaround script on 2026-04-27; that should be referenced if closing as workaround-only.

---
**Validated by**: Code Agent
**Date**: 2026-06-10

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: Flutter's global JDK setting is not isolated per FVM project; design explicit per-project JDK behavior.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Per-project JDK isolation is a design request beyond Flutter SDK selection. The comment's global-config deletion/rotation script is not an endorsed workaround and is unsafe for concurrent projects.
- **Source**: lib/src/models/config_model.dart:ProjectConfig; issue #1026 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2026-04-05; postdates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
