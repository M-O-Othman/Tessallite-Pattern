#!/usr/bin/env node

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";
import { StateManager } from "./state.js";

const PROJECT_ROOT = process.env.REVIEW_BRIDGE_PROJECT_ROOT || process.cwd();

const state = new StateManager(PROJECT_ROOT);

const server = new McpServer({
  name: "review-bridge-mcp-server",
  version: "1.0.0",
});

// ---------------------------------------------------------------------------
// Tool: bridge_get_plan
// Used by: Codex (to read the execution plan before reviewing)
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_get_plan",
  {
    title: "Get Execution Plan",
    description: `Read the current execution plan file. Returns the file path and full contents.
Use this to retrieve the plan that needs reviewing.

Args:
  - plan_file (string): Relative or absolute path to the plan file (e.g. "work/action-plan.md")

Returns:
  JSON with plan_file path and content string.`,
    inputSchema: {
      plan_file: z
        .string()
        .describe('Path to the plan file, e.g. "work/action-plan.md"'),
    },
    annotations: {
      readOnlyHint: true,
      destructiveHint: false,
      idempotentHint: true,
      openWorldHint: false,
    },
  },
  async ({ plan_file }: { plan_file: string }) => {
    try {
      const content = state.getPlanContent(plan_file);
      const output = { plan_file, content };
      return {
        content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
        structuredContent: output,
      };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      return { content: [{ type: "text", text: `Error: ${msg}` }] };
    }
  }
);

// ---------------------------------------------------------------------------
// Tool: bridge_submit_review
// Used by: Codex (to submit review findings)
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_submit_review",
  {
    title: "Submit Review Report",
    description: `Submit a review report for the current execution plan. This creates a new review round.
The review content is saved to work/external-review/rounds/ with a timestamp and
also written to work/external-review/review-report.md for easy access.

Args:
  - plan_file (string): Path to the plan that was reviewed
  - review_content (string): Full markdown review report
  - summary (string): One-line summary of findings
  - critical (number): Count of critical severity issues found
  - high (number): Count of high severity issues found
  - medium (number): Count of medium severity issues found
  - low (number): Count of low severity issues found
  - info (number): Count of informational items found

Returns:
  JSON with round record including round_number, status, and file paths.`,
    inputSchema: {
      plan_file: z.string().describe("Path to the plan that was reviewed"),
      review_content: z.string().describe("Full markdown review report"),
      summary: z.string().describe("One-line summary of findings"),
      critical: z.number().int().min(0).default(0).describe("Critical issues count"),
      high: z.number().int().min(0).default(0).describe("High issues count"),
      medium: z.number().int().min(0).default(0).describe("Medium issues count"),
      low: z.number().int().min(0).default(0).describe("Low issues count"),
      info: z.number().int().min(0).default(0).describe("Informational items count"),
    },
    annotations: {
      readOnlyHint: false,
      destructiveHint: false,
      idempotentHint: false,
      openWorldHint: false,
    },
  },
  async (params: {
    plan_file: string;
    review_content: string;
    summary: string;
    critical: number;
    high: number;
    medium: number;
    low: number;
    info: number;
  }) => {
    try {
      const record = state.submitReview({
        plan_file: params.plan_file,
        review_content: params.review_content,
        summary: params.summary,
        severity_counts: {
          critical: params.critical,
          high: params.high,
          medium: params.medium,
          low: params.low,
          info: params.info,
        },
      });
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                status: "review_submitted",
                round: record.round_number,
                review_file: record.review_file,
                message: `Round ${record.round_number} review submitted. Waiting for user approval before Claude Code can read it.`,
              },
              null,
              2
            ),
          },
        ],
      };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      return { content: [{ type: "text", text: `Error: ${msg}` }] };
    }
  }
);

// ---------------------------------------------------------------------------
// Tool: bridge_get_review
// Used by: Claude Code (to read the latest approved review)
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_get_review",
  {
    title: "Get Latest Review",
    description: `Read the latest review report. Returns the review content and round metadata.
Only returns reviews that have been approved by the user.

Returns:
  JSON with round_number, status, summary, severity_counts, and full review content.`,
    inputSchema: {},
    annotations: {
      readOnlyHint: true,
      destructiveHint: false,
      idempotentHint: true,
      openWorldHint: false,
    },
  },
  async () => {
    try {
      const { record, content } = state.getLatestReview();
      if (record.status === "review_submitted") {
        return {
          content: [
            {
              type: "text",
              text: JSON.stringify(
                {
                  status: "pending_approval",
                  round: record.round_number,
                  message: "Review exists but has not been approved yet. Wait for user approval.",
                },
                null,
                2
              ),
            },
          ],
        };
      }
      const output = {
        round_number: record.round_number,
        status: record.status,
        summary: record.summary,
        severity_counts: record.severity_counts,
        plan_file: record.plan_file,
        review_content: content,
      };
      return {
        content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
        structuredContent: output,
      };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      return { content: [{ type: "text", text: `Error: ${msg}` }] };
    }
  }
);

// ---------------------------------------------------------------------------
// Tool: bridge_approve_round
// Used by: Either agent on behalf of the user, or a CLI call
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_approve_round",
  {
    title: "Approve Current Round",
    description: `Approve the current review round so Claude Code can read the review and act on it.
Call this after reviewing the Codex report and deciding to proceed.

Returns:
  JSON with round_number and updated status.`,
    inputSchema: {},
    annotations: {
      readOnlyHint: false,
      destructiveHint: false,
      idempotentHint: true,
      openWorldHint: false,
    },
  },
  async () => {
    try {
      const record = state.approveRound();
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                status: "approved",
                round: record.round_number,
                message: `Round ${record.round_number} approved. Claude Code can now read the review via bridge_get_review.`,
              },
              null,
              2
            ),
          },
        ],
      };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      return { content: [{ type: "text", text: `Error: ${msg}` }] };
    }
  }
);

// ---------------------------------------------------------------------------
// Tool: bridge_submit_fixes
// Used by: Claude Code (to report what was fixed after reading the review)
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_submit_fixes",
  {
    title: "Submit Fixes Report",
    description: `Report the fixes applied after reading the review. Saves a fixes report to the rounds directory.

Args:
  - fixes_applied (string[]): List of fixes that were applied
  - fixes_skipped (array of {issue, reason}): Fixes that were skipped with reasons
  - remaining_issues (string[]): Issues still open after this round

Returns:
  JSON with round_number, status, and file paths.`,
    inputSchema: {
      fixes_applied: z
        .array(z.string())
        .describe("List of fixes that were applied"),
      fixes_skipped: z
        .array(
          z.object({
            issue: z.string().describe("The issue that was skipped"),
            reason: z.string().describe("Why it was skipped"),
          })
        )
        .default([])
        .describe("Fixes skipped with reasons"),
      remaining_issues: z
        .array(z.string())
        .default([])
        .describe("Issues still open after this round"),
    },
    annotations: {
      readOnlyHint: false,
      destructiveHint: false,
      idempotentHint: false,
      openWorldHint: false,
    },
  },
  async (params: {
    fixes_applied: string[];
    fixes_skipped: Array<{ issue: string; reason: string }>;
    remaining_issues: string[];
  }) => {
    try {
      const record = state.submitFixes({
        fixes_applied: params.fixes_applied,
        fixes_skipped: params.fixes_skipped,
        remaining_issues: params.remaining_issues,
      });
      return {
        content: [
          {
            type: "text",
            text: JSON.stringify(
              {
                status: "completed",
                round: record.round_number,
                fixes_file: record.fixes_file,
                fixes_applied_count: params.fixes_applied.length,
                fixes_skipped_count: params.fixes_skipped.length,
                remaining_count: params.remaining_issues.length,
                message:
                  params.remaining_issues.length > 0
                    ? `Round ${record.round_number} complete. ${params.remaining_issues.length} issues remain for next round.`
                    : `Round ${record.round_number} complete. All issues resolved.`,
              },
              null,
              2
            ),
          },
        ],
      };
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      return { content: [{ type: "text", text: `Error: ${msg}` }] };
    }
  }
);

// ---------------------------------------------------------------------------
// Tool: bridge_status
// Used by: Either agent (to check current state, round history, severity trends)
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_status",
  {
    title: "Bridge Status",
    description: `Get the current state of the review bridge including active round, history, and severity trends.

Returns:
  JSON with current_round, active status, round history, and severity trend data.`,
    inputSchema: {},
    annotations: {
      readOnlyHint: true,
      destructiveHint: false,
      idempotentHint: true,
      openWorldHint: false,
    },
  },
  async () => {
    const bridgeState = state.getState();
    const trend = state.getSeverityTrend();
    const current = state.getCurrentRound();
    const output = {
      active: bridgeState.active,
      current_round: bridgeState.current_round,
      current_status: current?.status ?? "no_rounds",
      total_rounds: bridgeState.rounds.length,
      severity_trend: trend,
      rounds: bridgeState.rounds.map((r) => ({
        round: r.round_number,
        status: r.status,
        summary: r.summary,
        timestamp: r.timestamp,
      })),
    };
    return {
      content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
      structuredContent: output,
    };
  }
);

// ---------------------------------------------------------------------------
// Tool: bridge_stop
// Used by: Either agent (to end the review cycle)
// ---------------------------------------------------------------------------
server.registerTool(
  "bridge_stop",
  {
    title: "Stop Review Bridge",
    description: `Stop the review bridge and mark the current round as stopped.
Use when the review cycle is complete or you want to abort.

Returns:
  JSON with final state summary.`,
    inputSchema: {},
    annotations: {
      readOnlyHint: false,
      destructiveHint: false,
      idempotentHint: true,
      openWorldHint: false,
    },
  },
  async () => {
    const finalState = state.stopBridge();
    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(
            {
              status: "stopped",
              total_rounds: finalState.rounds.length,
              message: "Review bridge stopped.",
            },
            null,
            2
          ),
        },
      ],
    };
  }
);

// ---------------------------------------------------------------------------
// Start server
// ---------------------------------------------------------------------------
async function main(): Promise<void> {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error(`review-bridge-mcp-server running (project: ${PROJECT_ROOT})`);
}

main().catch((err) => {
  console.error("Fatal error:", err);
  process.exit(1);
});
