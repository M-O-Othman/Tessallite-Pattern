# Tessallite Pattern Issue Registry

Status: active
Last meaningful update: 2026-05-09

This registry tracks kit-level documentation, governance, and process issues
found while maintaining the Tessallite Pattern materials.

## Open And Recently Closed Issues

| ID | Date Opened | Severity | Status | Owner | Source | Affected Files | Description | Evidence | Resolution Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TPG-001 | 2026-05-09 | medium | fixed | Documentation steward | Prompt index drift review | `docs/tessallite-pattern/_INDEX.md`, `docs/tessallite-pattern/prompts/_INDEX.md`, `scripts/check-docs-index.sh` | New prompt files exposed ambiguity in whether parent indexes or nested indexes own subfolder inventories. | The original guard did not validate nested `_INDEX.md` files, and the prompts index lacked a full inventory row for every prompt. | Adopted nested-index delegation with explicit parent routing, added a full prompt inventory, documented subfolder rules, and updated the guard to validate nested indexes. |
