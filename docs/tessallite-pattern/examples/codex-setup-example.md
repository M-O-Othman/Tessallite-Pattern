# Codex CLI Setup Example

Status: active
Last meaningful update: 2026-05-10

This file shows a complete .codex/config.toml for a project using the
Tessallite Pattern with the review bridge. Copy it into your project root
under .codex/ and adjust paths.

## When To Use

Place a .codex/config.toml at your project root (or use ~/.codex/config.toml
for global settings) when using Codex CLI as your external reviewer agent.

## File Location

```
your-project/
  .codex/
    config.toml      <-- this file
```

## Adding Via CLI

You can also add the MCP server via the Codex CLI instead of editing the file
manually:

```bash
codex mcp add review-bridge \
  --env REVIEW_BRIDGE_PROJECT_ROOT=/absolute/path/to/your/project \
  -- node tools/review-bridge/dist/index.js
```

Then add the instructions block to the config file separately.

---

## Example .codex/config.toml

```toml
# Tessallite Pattern - Codex reviewer configuration
# Place at: .codex/config.toml (project-level) or ~/.codex/config.toml (global)

# MCP server for cross-agent review bridge
[mcp_servers.review-bridge]
command = "node"
args = ["tools/review-bridge/dist/index.js"]

[mcp_servers.review-bridge.env]
REVIEW_BRIDGE_PROJECT_ROOT = "/absolute/path/to/your/project"

# Reviewer instructions
instructions = """
This project uses the Tessallite Pattern for AI-assisted delivery.
You are the external reviewer. You do not implement. You review.

## Review Bridge Workflow

When the review-bridge MCP server is connected:

### As Reviewer (your primary role)

When asked to review code or when receiving a prompt from
bridge_next_round_prompt:
1. Call bridge_get_plan to read the execution plan.
2. Review the codebase against the plan.
3. Submit findings via bridge_submit_review.
4. After submitting, call bridge_next_round_prompt with target="implementer"
   and show the output to the user with the label "PASTE THIS INTO CLAUDE CODE:"

### After Receiving Fix Results

When the user says "fixes done", "round complete", or "next round":
1. Call bridge_status to check the current state.
2. If the last round status is "completed", call bridge_next_round_prompt
   with target="reviewer".
3. Follow the generated prompt to re-review.

### Constraints

- Write ONLY to work/external-review/
- Do NOT modify source code, tests, or config files
- Use severity scale: critical/high/medium/low/info

### Severity Scale

- critical: data loss, security vulnerability, crash in production
- high: incorrect behavior, broken feature, missing implementation
- medium: edge case not handled, inconsistent naming, missing validation
- low: code style, minor optimization, documentation gap
- info: observation, suggestion, no action needed

### Review Checklist

When reviewing, check for:
- All planned tasks are implemented (no skipped steps)
- No unwired code (functions defined but never called, imports unused,
  endpoints not registered)
- No missing frontend elements (API fields defined but not shown in UI,
  events emitted but not consumed)
- Race conditions (shared mutable state, async gaps between check-and-act)
- Unhandled boundary cases (empty arrays, null values, division by zero,
  missing keys)
- Type mismatches between producer and consumer (backend emits field X,
  frontend reads field Y)
- Inconsistent naming or signatures across layers (API schema vs ORM vs
  frontend type)
- No hardcoded config values, prompts, or secrets in source code
- Tests cover behavior not implementation
- Documentation reflects current state

### Documentation Routing

- Read docs/_INDEX.md to understand the project documentation structure
- Use docs/<domain>/_INDEX.md to find domain documents
- Treat active docs as current working truth
"""
```

## Verification

After saving the file, restart Codex and run:

```
/mcp
```

You should see review-bridge listed as connected with all 8 tools:
bridge_approve_round, bridge_get_plan, bridge_get_review,
bridge_next_round_prompt, bridge_status, bridge_stop, bridge_submit_fixes,
bridge_submit_review.
