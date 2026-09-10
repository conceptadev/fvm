# Issue #635: [BUG] `fvm use` makes unrelated changes to settings.json.

## Metadata
- **Reporter**: Brent Kleineibst (@bkleineibst)
- **Created**: 2024-02-20
- **Reported Version**: 3.0.12
- **Issue Type**: bug
- **URL**: https://github.com/leoafarias/fvm/issues/635

## Problem Summary
Running `fvm use` updates `.vscode/settings.json` to point VS Code at the correct Flutter SDK, but the entire file is rewritten using `JsonEncoder.withIndent('  ')`. Any comments are stripped and tabs are converted to spaces, creating noisy diffs and erasing customization.

## Version Context
- Reported against: 3.0.12
- Current version: v4.0.0
- Version-specific: no — `UpdateVsCodeSettingsWorkflow` still rewrites the file via `prettyJson`.
- Reason: We decode JSONC into a map, then re-encode with standard JSON formatting, which cannot preserve comments or original whitespace.

## Validation Steps
1. Reviewed `lib/src/workflows/update_vscode_settings.workflow.dart`; after decoding with `jsonc.decode`, it writes the updated map using `prettyJson`.
2. Inspected `lib/src/utils/pretty_json.dart`; it uses `JsonEncoder.withIndent('  ')`, guaranteeing the reformat.
3. Confirmed no logic exists to preserve comments or prior indentation—any update rewrites the full file.

## Evidence
```
$ sed -n '147,192p' lib/src/workflows/update_vscode_settings.workflow.dart
      if (project.pinnedVersion != null) {
        currentSettings["dart.flutterSdkPath"] = _resolveSdkPath(project);
      }
      vscodeSettingsFile.writeAsStringSync(prettyJson(currentSettings));

$ sed -n '1,40p' lib/src/utils/pretty_json.dart
String prettyJson(Map<String, dynamic> json) {
  var encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}
```

**Files/Code References:**
- [lib/src/workflows/update_vscode_settings.workflow.dart#L147](../../lib/src/workflows/update_vscode_settings.workflow.dart#L147) – Rewrites settings with `prettyJson`.
- [lib/src/utils/pretty_json.dart#L1](../../lib/src/utils/pretty_json.dart#L1) – Uses standard JSON encoder, destroying comments and tab indentation.

## Current Status in v4.0.0
- [x] Still reproducible
- [ ] Already fixed
- [ ] Not applicable to v4.0.0
- [ ] Needs more information
- [ ] Cannot reproduce

## Troubleshooting/Implementation Plan

### Root Cause Analysis
`JsonEncoder` cannot round-trip JSONC (JSON with comments) or custom formatting. We decode to a map and lose all structural information before writing.

### Proposed Solution
1. Implement a targeted editor for `settings.json`:
   - Read the file as raw text.
   - If the `dart.flutterSdkPath` property exists, replace only its value using a regex that preserves leading whitespace, trailing commas, and comments.
   - If it does not exist, insert a new property before the closing brace, matching the indentation of surrounding entries.
2. Leverage `jsonc` decode only when we need to validate/parse, but rely on the textual update to retain comments and indentation.
3. Add unit tests covering:
   - Files with comments and tabs.
   - Files where the property appears mid-object or at the end with trailing commas.
   - Empty/nonexistent settings file (we can still fall back to writing JSON like today if file absent).
4. Optionally expose a helper utility (e.g., `JsoncEditor`) so future modifications (VS Code workspace files, etc.) reuse the same logic.

### Alternative Approaches (if applicable)
- Adopt an AST-preserving JSONC library if/when available; current `jsonc` package only returns plain maps.
- Serialize with `jsonc.encode` if it gains comment preservation in a future release; for now manual editing is more predictable.

### Dependencies & Risks
- Regex replacement must handle edge cases (property inside nested object, trailing comments). Comprehensive tests mitigate risk.
- When creating new files, we can still fall back to `prettyJson` because there’s no existing formatting to preserve.

### Related Code Locations
- [lib/src/workflows/update_workspace_settings.workflow.dart](../../lib/src/workflows/update_vscode_settings.workflow.dart) – Also rewrites workspace files; apply the same editing logic there.
- [lib/src/utils/pretty_json.dart](../../lib/src/utils/pretty_json.dart) – May still be used for fresh files, but avoid for existing ones.

## Recommendation
**Action**: validate-p2

**Reason**: Quality-of-life fix that prevents unnecessary diffs and preserves developer comments, but not a functional blocker.

## Notes
- Document the behavior change so users know FVM no longer strips comments.
- Consider adding a `--no-format` flag (defaulting to true) for other editors if we extend support beyond VS Code.

---
**Validated by**: Code Agent
**Date**: 2025-10-31

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes conflicting assumptions in the historical plan above.

Keep P2: UpdateVsCodeSettingsWorkflow decodes JSONC and rewrites prettyJson, losing comments and original formatting.

The live report and comments were reviewed during the [full backlog audit](issue-closure-audit-2026-09-08.md). Retained for the existing implementation/diagnostic plan with the scope corrections above; no fix was made, and no platform-specific reproduction is claimed. Pre-4.0 age alone is not a closure reason.

## 2026-09-08 categorization follow-up

- **Type / state**: bug / confirmed; GitHub label `triage:confirmed`.
- **Evidence level**: code_inspection. VS Code JSONC is decoded then serialized with prettyJson; comments/formatting cannot survive that round trip.
- **Source**: lib/src/workflows/update_vscode_settings.workflow.dart:164,189 (FVM source baseline: origin/main a6d93976d443082d73d4718750713e6248de6b84).
- **Next action**: Add a comment-preserving edit and tests for tabs, comments and unrelated settings.
- **Age**: opened 2024-02-20; predates FVM 4.0. Label changes are not new user confirmations.

This category supersedes any earlier suggestion that every open item is a confirmed bug. See the [complete category review](open-issue-categories-2026-09-08.md); historical priority denotes scheduling, not proof of a defect.

## 2026-09-08 housekeeping follow-up

Removed good first issue; comment-preserving JSONC editing has nontrivial parsing/format-preservation risks. Bug, triage:confirmed and help wanted remain. No category or priority change. See [housekeeping recommendations](housekeeping-plan-2026-09-08.md).
