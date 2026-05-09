# Execution Issue Registry

Status: active
Last meaningful update: 2026-05-09

This registry tracks operational repository issues found while maintaining this
codebase under the Tessallite Pattern.

## Open Issues

| ID | Date | Severity | Status | Owner | Source | Affected Files | Summary | Next Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EXEC-001 | 2026-05-09 | medium | open | Documentation steward | Existing-codebase adoption | `docs/questions/questions_adoption-open-questions.md` | Adoption questions are pending architect answers. | Architect should answer or defer Q1-001 through Q1-005 before broad process or release changes. |
| EXEC-002 | 2026-05-09 | low | open | Maintainer | Existing-codebase adoption | `scripts/generate-walkthrough-assets.js` | Walkthrough screenshot regeneration depends on local Chrome/Chromium but no version floor is documented. | Decide whether to document minimum versions or add a portable generation path. |
| EXEC-003 | 2026-05-09 | low | open | Documentation steward | Existing-codebase adoption | Markdown docs | No general markdown link checker is configured. | Decide whether to add link checking beyond `scripts/check-docs-index.sh`. |

## Closed Issues

| ID | Date Closed | Resolution | Notes |
| --- | --- | --- | --- |
| `<id>` | `<date>` | fixed/duplicate/wont-fix/accepted-risk | `<notes>` |
