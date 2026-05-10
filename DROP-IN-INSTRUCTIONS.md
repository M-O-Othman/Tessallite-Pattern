# Drop-In Instructions

This archive mirrors the Tessallite Pattern repo structure. Copy the contents into your repo root.

## New files (just copy)

```
tools/review-bridge/             <- entire directory (new)
docs/tessallite-pattern/prompts/cross-agent-review-prompts.md  (new)
docs/tessallite-pattern/templates/external-review-report-template.md  (new)
```

## Existing files to update

### 1. AGENTS.md

Append this block to the end of AGENTS.md:

```markdown
## Cross-Agent Review Bridge

When the review-bridge MCP server is connected (check with /mcp), use these tools
for cross-agent code review:

- bridge_get_plan: Read the execution plan before reviewing
- bridge_submit_review: Submit review findings with severity counts
- bridge_get_review: Read the latest approved review
- bridge_approve_round: Approve a review for the implementer to act on
- bridge_submit_fixes: Report fixes applied, skipped, and remaining
- bridge_status: Check current round, history, and severity trends
- bridge_stop: End the review cycle

Reviewer agent constraints:
- Write ONLY to work/external-review/
- Do NOT modify source code, tests, or config

Implementer agent constraints:
- Validate each finding before acting
- Fix root cause across all affected files
- Run full test suite before submitting fixes

Prompt templates: docs/tessallite-pattern/prompts/cross-agent-review-prompts.md
Report template: docs/tessallite-pattern/templates/external-review-report-template.md
```

### 2. docs/tessallite-pattern/prompts/_INDEX.md

Add this line to the file list:

```markdown
- [cross-agent-review-prompts.md](cross-agent-review-prompts.md) - Prompt templates for cross-agent code review using the Review Bridge MCP server
```

### 3. docs/tessallite-pattern/templates/ (no _INDEX.md exists, but if one is created)

Add this line:

```markdown
- [external-review-report-template.md](external-review-report-template.md) - Template for external code review reports submitted through the Review Bridge
```

### 4. .gitignore

Add these lines if not already present:

```
# Review Bridge
tools/review-bridge/node_modules/
tools/review-bridge/dist/
work/external-review/
```

## Post-copy steps

```bash
cd tools/review-bridge
npm install
npm run build
```

Then configure both agents per tools/review-bridge/README.md.
