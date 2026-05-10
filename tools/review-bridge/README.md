# Review Bridge MCP Server

MCP server that bridges Claude Code and Codex (or any two MCP-capable agents) for automated cross-agent code review workflows. Part of the Tessallite Pattern tooling.

## Problem

When using two AI agents on the same codebase (e.g. Claude Code as implementer, Codex as external reviewer), the human becomes a clipboard. You copy plan file paths from one agent to another, paste review reports back, track which round you're on, and repeat. This server eliminates that manual transfer by giving both agents a shared MCP tool interface.

## How It Works

```
You (three terminals)
 |
 |-- Terminal 1: Claude Code (MCP client) --\
 |                                           +--> review-bridge (stdio MCP server)
 |-- Terminal 2: Codex CLI  (MCP client)  --/           |
 |                                                      v
 |-- Terminal 3: watch the files              work/external-review/
                                                bridge-state.json
                                                review-report.md
                                                rounds/
                                                  round-001-*-review.md
                                                  round-001-*-fixes.md
```

Both agents spawn their own instance of the server via stdio. They share state through `work/external-review/bridge-state.json` on disk. The workflow is sequential (Codex writes, you approve, Claude Code writes), so there are no concurrency issues.

## Setup

### 1. Install and build

```bash
cd tools/review-bridge
npm install
npm run build
```

### 2. Configure Claude Code

Option A: Add to your project-level `.mcp.json` at repo root:

```json
{
  "mcpServers": {
    "review-bridge": {
      "type": "stdio",
      "command": "node",
      "args": ["tools/review-bridge/dist/index.js"],
      "env": {
        "REVIEW_BRIDGE_PROJECT_ROOT": "/absolute/path/to/your/project"
      }
    }
  }
}
```

Option B: Via CLI:

```bash
claude mcp add --scope project review-bridge \
  --env REVIEW_BRIDGE_PROJECT_ROOT=/absolute/path/to/your/project \
  -- node tools/review-bridge/dist/index.js
```

### 3. Configure Codex CLI

Option A: Add to project-level `.codex/config.toml`:

```toml
[mcp_servers.review-bridge]
command = "node"
args = ["tools/review-bridge/dist/index.js"]

[mcp_servers.review-bridge.env]
REVIEW_BRIDGE_PROJECT_ROOT = "/absolute/path/to/your/project"
```

Option B: Via CLI:

```bash
codex mcp add review-bridge \
  --env REVIEW_BRIDGE_PROJECT_ROOT=/absolute/path/to/your/project \
  -- node tools/review-bridge/dist/index.js
```

### 4. Verify

In Claude Code: `/mcp` should list review-bridge as connected.

In Codex: `/mcp` should list review-bridge as connected.

## Workflow Per Round

1. Tell Codex: "Use bridge_get_plan to read work/action-plan.md, review the codebase against it, and submit findings via bridge_submit_review."

2. Codex reads the plan through the MCP tool, reviews source files, submits the report. The report lands in `work/external-review/rounds/` and `work/external-review/review-report.md`.

3. You read the review. If satisfied, tell either agent: "Use bridge_approve_round."

4. Tell Claude Code: "Use bridge_get_review to read the latest approved review. Validate each finding and fix valid issues. Submit results via bridge_submit_fixes."

5. Claude Code reads, fixes, reports back through the MCP tool.

6. Check bridge_status to see severity trends. Decide whether to run another round or stop.

Full prompt templates are in `docs/tessallite-pattern/prompts/cross-agent-review-prompts.md`.

## Tools

| Tool | Used by | Purpose |
|------|---------|---------|
| bridge_get_plan | Reviewer agent | Read the execution plan file |
| bridge_submit_review | Reviewer agent | Submit review findings with severity counts |
| bridge_get_review | Implementer agent | Read the latest approved review |
| bridge_approve_round | You (via either agent) | Approve a review round |
| bridge_submit_fixes | Implementer agent | Report fixes applied, skipped, remaining |
| bridge_status | Either | Current state, round history, severity trends |
| bridge_stop | Either | End the review cycle |

## Output Files

All output stays within the Tessallite Pattern's `work/` directory:

```
work/external-review/
  bridge-state.json          # Round state (persists across sessions)
  review-report.md           # Latest review (quick-access copy)
  rounds/
    round-001-*-review.md    # Timestamped review for round 1
    round-001-*-fixes.md     # Timestamped fixes for round 1
    round-002-*-review.md    # Round 2, etc.
```
