# Execution Issue Registry

Status: active
Last meaningful update: 2026-05-10

This registry tracks operational repository issues found while maintaining this
codebase under the Tessallite Pattern.

## Open Issues

| ID | Date | Severity | Status | Owner | Source | Affected Files | Summary | Next Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EXEC-002 | 2026-05-09 | low | open | Maintainer | Existing-codebase adoption | `scripts/generate-walkthrough-assets.js` | Walkthrough screenshot regeneration depends on local Chrome/Chromium but no version floor is documented. | Decide whether to document minimum versions or add a portable generation path. |
| EXEC-003 | 2026-05-09 | low | open | Documentation steward | Existing-codebase adoption | Markdown docs | No general markdown link checker is configured. | Decide whether to add link checking beyond `scripts/check-docs-index.sh`. |

## Closed Issues

| ID | Date Closed | Resolution | Notes |
| --- | --- | --- | --- |
| EXEC-001 | 2026-05-10 | fixed | Adoption questions answered by architect. Q1-002 and Q1-003 deferred. |
| EXEC-004 | 2026-05-10 | fixed | Bootstrap paths reconciled. See bootstrap-file-manifest.md. |
| EXEC-005 | 2026-05-10 | fixed | Cross-agent review workflow moved to docs/tessallite-pattern/guides/. |
| EXEC-006 | 2026-05-10 | fixed | Templates index renamed to _INDEX.md and populated with all 12 templates. |
| EXEC-007 | 2026-05-10 | fixed | Shell and BAT scripts now produce identical file content. |
