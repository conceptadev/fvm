# Issue #1074: [Feature Request] Support using different Flutter SDK versions based on the target platform

## Metadata

- Reporter: KiritoBeater
- Created: 2026-09-08T06:00:46Z
- Type: feature request
- URL: https://github.com/leoafarias/fvm/issues/1074
- Reviewed: 2026-09-08

## Problem Summary

The reporter wants one project to choose a Flutter SDK automatically from the target platform, including an OHOS fork, via a new `platforms` map in `.fvmrc`.

## Version Context

- Reported FVM version: not supplied; submitted 2026-09-08.
- Reviewed version: 4.3.1, origin/main a6d93976d443082d73d4718750713e6248de6b84.
- Flutter versions in the example are SDK selections, not FVM versions.

## Validation Steps and Evidence

1. Read the full report and its proposed configuration; no comments yet.
2. `lib/src/models/config_model.dart:232` defines `ProjectConfig.flutter` and `flavors`, but no `platforms` selection.
3. `lib/src/commands/flavor_command.dart:34` looks up an explicit named flavor, ensures its cache and invokes that SDK. It does not infer a platform.
4. `docs/pages/documentation/guides/project-flavors.md` documents `fvm use {version} --flavor {name}` and `fvm flavor {name} {flutter_command}`.
5. Related #1042 concerns multiple SDK families; fork aliases alone are not a proven complete solution for those integrations. The OHOS repository was not installed or tested.

## Current Status in v4.3.1

- [x] Requested automatic routing is not implemented by the current configuration/command path.
- [x] Explicit flavors offer a partial workaround.
- [ ] OHOS runtime compatibility verified.

## Troubleshooting/Implementation Plan

### Root Cause Analysis

Current configuration selects a default SDK or an explicitly requested flavor. There is no target-aware resolver and no established policy for commands whose target is unknown until device selection.

### Proposed Solution

1. Define routing rules before adding fields: precedence among explicit flavor, explicit SDK, platform map and default; behavior for `build apk`, `build ios`, `run -d`, doctor and pub commands.
2. Coordinate the SDK-family/provider boundaries with #1042. Avoid treating all alternate distributions as ordinary Flutter forks.
3. If accepted, add a backward-compatible optional map in `ProjectConfig`, regenerate mappers with build_runner, and centralize resolution before cache selection/Flutter invocation.
4. Test serialization, absent/unknown platform, conflicting selections, ambiguous device targets and unchanged existing flavor behavior. Include a namespaced fork example without requiring a live third-party SDK in unit tests.
5. Verify whether routing should affect only a spawned command or also project/IDE references; do not silently repin the project for every platform invocation.
6. Run analyzer, DCM, tests and the isolated install/use/reference smoke test before merging runtime changes.

### Alternatives and Risks

Document explicit flavors as an immediate workaround: pin a supported SDK per flavor, then use `fvm flavor ios build ios` or `fvm flavor android build apk`. FVM flavor names here select SDKs; they are distinct from Flutter's application `--flavor` argument. Automatic target inference must not break argument forwarding or unexpectedly run a build with the wrong SDK.

## Recommendation

**Action**: validate-p2. Current feature request requiring design; not already solved by custom remotes or explicit flavors. No implementation performed.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Keep P2 (new): platform-based automatic SDK routing is not implemented. Explicit FVM flavors are a workaround, not equivalent; coordinate SDK-family design with #1042.
- **Source**: lib/src/models/config_model.dart:232; lib/src/commands/flavor_command.dart:34 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2026-09-08; postdates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
