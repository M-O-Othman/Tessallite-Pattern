# MCP Configuration Example

Status: active
Last meaningful update: 2026-05-10

This file shows a complete .mcp.json for connecting Claude Code to the review
bridge MCP server. Place it at your project root.

## When To Use

Create a .mcp.json at your project root when using the review bridge for
cross-agent code review. Claude Code reads this file automatically and
connects to the configured MCP servers at startup.

## File Location

```
your-project/
  .mcp.json          <-- this file
  tools/
    review-bridge/   <-- the MCP server (must be built first)
```

## Prerequisites

Before creating this file, install and build the review bridge:

```bash
cd tools/review-bridge
npm install
npm run build
```

## Adding Via CLI

You can also add the MCP server via the Claude Code CLI:

```bash
claude mcp add --scope project review-bridge \
  --env REVIEW_BRIDGE_PROJECT_ROOT=/absolute/path/to/your/project \
  -- node tools/review-bridge/dist/index.js
```

This creates the .mcp.json file for you.

---

## Example .mcp.json

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

Replace `/absolute/path/to/your/project` with the full path to your project
root. This must be an absolute path, not relative.

## Multiple MCP Servers

If you have other MCP servers, add them alongside review-bridge:

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
    },
    "another-server": {
      "type": "stdio",
      "command": "node",
      "args": ["path/to/another/server.js"]
    }
  }
}
```

## Verification

After saving the file, restart Claude Code and run:

```
/mcp
```

You should see review-bridge listed as connected with all 8 tools:
bridge_approve_round, bridge_get_plan, bridge_get_review,
bridge_next_round_prompt, bridge_status, bridge_stop, bridge_submit_fixes,
bridge_submit_review.

## Gitignore

Add .mcp.json to your .gitignore if the absolute path is machine-specific
(which it usually is):

```
.mcp.json
```

If your team uses the same project path convention, you can commit it.
