# Tessallite Pattern Issue Registry

Status: active
Last meaningful update: 2026-05-09

This registry tracks kit-level documentation, governance, and process issues
found while maintaining the Tessallite Pattern materials.

## Open And Recently Closed Issues

| ID | Date Opened | Severity | Status | Owner | Source | Affected Files | Description | Evidence | Resolution Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TPG-001 | 2026-05-09 | medium | fixed | Documentation steward | Prompt index drift review | `docs/tessallite-pattern/_INDEX.md`, `docs/tessallite-pattern/prompts/_INDEX.md`, `scripts/check-docs-index.sh` | New prompt files exposed ambiguity in whether parent indexes or nested indexes own subfolder inventories. | The original guard did not validate nested `_INDEX.md` files, and the prompts index lacked a full inventory row for every prompt. | Adopted nested-index delegation with explicit parent routing, added a full prompt inventory, documented subfolder rules, and updated the guard to validate nested indexes. |
| TPG-002 | 2026-05-09 | medium | fixed | Documentation steward | Greenfield walkthrough consistency review | `walk-through/walkthrough.md`, `docs/tessallite-pattern/prompts/bootstrap-greenfield-project-prompt.md`, `docs/tessallite-pattern/prompts/bootstrap-existing-codebase-prompt.md`, `docs/tessallite-pattern/framework-handbook.md`, `docs/tessallite-pattern/templates/domain-index-template.md` | The visual walkthrough established a more realistic sequence than parts of the written kit: prepare prompt files in the shell before opening Codex, then interact with Codex as chat rather than continuing shell commands. Some docs also retained folder-only index wording after nested index delegation was adopted. | Sequential review of all Markdown files found the conflict in bootstrap usage instructions and index governance wording. | Updated bootstrap prompts to prepare files before opening the agent and to call the agent input chat text, not a shell command. Updated handbook, router, memory instructions, and domain-index template to match nested-index governance. |
