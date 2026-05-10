# Bootstrap File Manifest

Status: active
Last meaningful update: 2026-05-10

This document is the canonical file list that every bootstrap path must produce
for each mode. If any path diverges from this list, that is a bug.

## Greenfield Mode

| File | Created By Script | Created By Prompt | Shown In Walkthrough |
| --- | --- | --- | --- |
| AGENTS.md | YES | YES (via prompt) | YES |
| docs/_INDEX.md | YES | YES | YES |
| docs/architecture/_INDEX.md | YES | YES | YES |
| docs/architecture/architecture_system-map.md | YES | YES | YES |
| docs/questions/_INDEX.md | YES | YES | YES |
| docs/questions/questions_initial-project.md | YES | YES | YES |
| docs/execution/_INDEX.md | YES | YES | YES |
| docs/execution/execution_issue-registry.md | YES | YES | YES |
| docs/execution/execution_command-registry.md | YES | YES | YES |
| docs/execution/execution_bootstrap-report.md | YES | YES | YES |
| docs/guides/_INDEX.md | YES | YES | YES |
| docs/guides/guides_developer-guide.md | YES | YES | YES |
| docs/guides/guides_project-feedback-rules.md | YES | YES | YES |
| docs/strategy/_INDEX.md | YES | YES | YES |
| docs/strategy/strategy_product-brief.md | YES | YES | YES |
| docs/archive/_INDEX.md | YES | YES | YES |
| work/logs/project-journal.md | YES | YES | YES |
| work/sessions/ | YES | YES | YES |
| work/sessions/bootstrap-next-prompt.md | YES | N/A (script-only) | N/A |
| scripts/check-docs-index.sh | YES | YES | YES |

## Existing Codebase Mode

Same as greenfield mode. All files use the same names regardless of mode. The
content of `architecture_system-map.md` and `questions_initial-project.md`
adapts to the mode context (existing codebase language vs greenfield language).

## AGENTS.md Content

All paths install the full form from
`docs/tessallite-pattern/prompts/agent-memory-instructions.md`. The short form
is no longer used.

## Initial Questions

All paths ask 7 questions:

1. Product goal (Q1-001)
2. Primary users (Q1-002)
3. Workflows in scope (Q1-003)
4. Workflows out of scope (Q1-004)
5. Stack, deployment, external systems (Q1-005)
6. Approved commands (Q1-006)
7. Initial delivery milestone (Q1-007)

## Verification

To verify a bootstrap path against this manifest:

1. Run the path (script, prompt, or walkthrough step-by-step).
2. List all created files.
3. Compare against the table above.
4. Confirm AGENTS.md matches agent-memory-instructions.md.
5. Confirm questions_initial-project.md has 7 questions.
6. Run `bash scripts/check-docs-index.sh` on the result.
