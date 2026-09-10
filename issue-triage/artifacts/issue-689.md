# Issue #689: [BUG] Version 3.0 broke shell completion and is less readable

## Metadata
- **Reporter**: Bartek Pacia (@bartekpacia)
- **Created**: 2024-03-11
- **Reported Version**: 3.0.13
- **Issue Type**: bug / UX regression
- **URL**: https://github.com/leoafarias/fvm/issues/689

## Problem Summary
FVM 3.x switched the CLI output to bordered tables using `dart_console`. The new grid layout is wider and harder to scan for some users, and it breaks external tab-completion scripts (e.g., `zsh-users/zsh-completions` `_fvm`) that expected the previous minimal text output.

## Version Context
- Reported against: v3.0.x
- Current version: v4.0.0
- Version-specific: no (table output still used in v4)
- Reason: List, releases, and doctor commands still render grid tables by default and offer no plain/TTY-friendly mode.

## Validation Steps
1. Inspected `lib/src/commands/list_command.dart` and confirmed it always builds a `dart_console.Table` with borders, icons, and colors when printing cached SDKs.
2. Reviewed `lib/src/utils/console_utils.dart` used by other commands (doctor, releases); it configures `BorderType.grid` and square corners unconditionally, leaving no alternative style.
3. Checked `LoggerService` and configuration models; there’s no flag, env var, or auto-detection to emit plain text when stdout is not a TTY, so completion scripts capture the full box-drawing output.

## Evidence
```
$ sed -n '18,80p' lib/src/commands/list_command.dart
  void displayVersionsTable(...) {
    final table = Table()
      ..insertColumn(header: 'Version', ...)
      ...
    table
      ..insertRows([...])
      ..borderStyle = BorderStyle.square
      ..borderColor = ConsoleColor.white
      ..borderType = BorderType.grid;
    logger.info(table.toString());
  }

$ sed -n '1,40p' lib/src/utils/console_utils.dart
Table createTable([List<String> columns = const []]) {
  final table = Table()
    ..borderColor = ConsoleColor.white
    ..borderType = BorderType.grid
    ..borderStyle = BorderStyle.square
    ..headerStyle = FontStyle.bold;
```

**Files/Code References:**
- [lib/src/commands/list_command.dart#L20](../../lib/src/commands/list_command.dart#L20) – Always renders the seven-column grid with borders/icons.
- [lib/src/utils/console_utils.dart#L1](../../lib/src/utils/console_utils.dart#L1) – Helper hardcodes grid styling for other commands (doctor, releases).
- [lib/src/services/logger_service.dart#L137](../../lib/src/services/logger_service.dart#L137) – Logger has no toggle for plain output; even notices/important messages are boxed.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
The CLI redesign standardized on `dart_console.Table` with heavy borders but omitted a compatibility mode. External scripts (e.g., zsh completions) parse command output and now receive box-drawing characters and header rows, breaking tokenization.

### Proposed Solution
1. Introduce a console style toggle (e.g., `ConsoleStyle { grid, plain }`) exposed through global config (`AppConfig`) and project config (`.fvmrc`), plus CLI overrides (`--plain`, `--style=grid|plain`) on commands such as `list`, `releases`, and `doctor`.
2. Teach `Table` helpers (`displayVersionsTable`, `createTable`, logger.notice/important) to honor the selected style: in `plain` mode disable borders, emit simple space-separated rows, and suppress Unicode icons/ANSI colors when stdout is not a TTY.
3. Auto-detect non-interactive output (`stdout.hasTerminal == false` or `!stdout.supportsAnsiEscapes`) and fall back to plain style unless explicitly overridden, so shell-completion scripts regain predictable text without extra flags.
4. Extend tests that cover CLI output (goldens/unit) to assert both grid and plain modes, and add regression coverage ensuring `--plain` produces parse-friendly output.
5. Update documentation (`docs/pages/documentation/guides/basic-commands.mdx` or a new “CLI Output” section) explaining how to opt into plain mode and recommending it for scripting/completions.

### Alternative Approaches (if applicable)
- Provide `--output json` or `--script` flags instead; higher effort and still requires plain fallback for completions.
- Maintain dual command variants (e.g., `fvm list --plain` only) without config; simpler but lacks persistent preference the reporter requested.

### Dependencies & Risks
- Changes touch shared console utilities; need to ensure existing table formatting stays intact for users who prefer rich output.
- Plain mode must strip icons and color codes to avoid confusing parsers on Windows terminals lacking Unicode support.
- Coordinate with doc updates and release notes to set expectations for the new flags/config options.

### Related Code Locations
- [lib/src/utils/console_utils.dart#L1](../../lib/src/utils/console_utils.dart#L1) – Centralize style selection here.
- [lib/src/services/logger_service.dart#L151](../../lib/src/services/logger_service.dart#L151) – Update notice/important boxes to respect plain style.
- [lib/src/models/config_model.dart#L17](../../lib/src/models/config_model.dart#L17) – Extend config schema for new console style field.

## Recommendation
**Action**: validate-p2

**Reason**: User-facing regression with tangible workflow impact (shell completion, readability). Medium priority because core functionality works but the UX/scripting compatibility degraded.

## Notes
- After implementation, confirm with zsh-completions maintainers whether they can drop any workarounds once plain mode ships.

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: JSON API output does not fulfill a plain-text table/completion mode; reporter objections remain relevant.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: enhancement / backlog; GitHub label `triage:backlog`.
- **Evidence level**: unimplemented_request. Outstanding plain-text output is an enhancement. Preserve the historical bug label for the old third-party completion regression, but do not count that as a reproduced 4.3.1 bug. The old linked _fvm path now returns 404; that does not prove resolution.
- **Source**: lib/src/commands/list_command.dart; lib/src/commands/api_command.dart; issue comments (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Retain the existing implementation plan as backlog; require design approval before runtime changes.
- **Age**: opened 2024-03-11; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.
