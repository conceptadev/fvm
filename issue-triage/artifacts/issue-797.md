# Issue #797: env: bash\r: No such file or directory

## Metadata
- **Reporter**: @zakblacki
- **Created**: 2024-11-12
- **Issue Type**: bug (needs info)
- **URL**: https://github.com/conceptadev/fvm/issues/797

## Problem Summary
1. `fvm flutter --version` exits with `env: bash\r: No such file or directory`.
2. IDE doctor warning about SDK path.

## Observations
- The error indicates the Flutter wrapper script has Windows line endings. Need confirmation of the file contents (`file ~/.fvm/versions/stable/bin/flutter`).
- IDE warning already documented (configure path to `.fvm/flutter_sdk`).

## Validation Steps
1. Reviewed the supplied FVM 3.2.1 doctor output and exact `bash\r` error.
2. Confirmed the signature is consistent with CRLF in the managed Flutter shell script, not an FVM argument parser failure.
3. No current 4.1.2 reproduction or file inspection was supplied, so the source of the CRLF conversion remains unknown.

## Evidence
```text
env: bash\r: No such file or directory

This error occurs when a shebang such as #!/usr/bin/env bash contains CRLF.
Required confirmation: file and line-ending output for <managed-sdk>/bin/flutter.
```

## Troubleshooting/Implementation Plan
Request reporter to:
- Run `file ~/.fvm/versions/stable/bin/flutter` and `head -n5` to check line endings.
- Remove/reinstall the version (`fvm remove stable && fvm install stable --setup`).
- Confirm if the issue persists outside the project.
- Follow docs for IDE setup.
- If reproducible on 4.1.2, trace whether Git configuration (`core.autocrlf`), cache cloning, or an external sync tool converts the SDK script.

## Recommendation
- Folder: `needs_info/`

## 2026-09-08 review — FVM 4.3.1

This dated review supersedes earlier recommendations above.

- **Decision**: close as not planned; Retire the FVM 3.2.1 CRLF/IDE support report; no current reproduction, and the IDE question has current documentation.
- **Evidence**: Report 2024-11-12 identifies FVM 3.2.1 and `env: bash\\r` plus an unrelated global SDK path. No comments/current reproduction. Current Android Studio guide addresses SDK configuration; CRLF cause has not been reproduced or proven fixed.
- **Validation**: live issue body/comments, current origin/main at a6d93976d443082d73d4718750713e6248de6b84, and relevant source/docs inspected. No product changes or full runtime reproduction.
- **Follow-up plan**: No fix is inferred. Reassess a fresh current-version reproduction with the diagnostics requested in the closure comment.
- **GitHub explanation**:

Closing this FVM 3.2.1 support report as not planned during the pre-4.0 backlog cleanup. The IDE setup question is covered by the current [Android Studio guide](https://fvm.app/documentation/guides/android-studio); ongoing symlink compatibility remains tracked in #724/#767.

The `env: bash\r` error is a separate script/line-ending problem, and I am not marking it fixed without a current reproduction. If it persists with FVM 4.3.1, please open a fresh report with `fvm doctor`, the exact failing command and verbose output, the resolved Flutter executable path, and the script's first line/line-ending information.

**Verified closure**: 2026-09-08T15:03:32Z, GitHub reason `not_planned`. [Closure comment](https://github.com/leoafarias/fvm/issues/797#issuecomment-5587261365).
