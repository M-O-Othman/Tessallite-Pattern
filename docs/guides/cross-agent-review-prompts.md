# Cross-Agent Review Workflow

A structured process for running automated code review cycles between two AI agents: one that implements (Claude Code) and one that reviews (Codex or any MCP-capable agent).

## Prerequisites

- Review Bridge MCP server installed and built (tools/review-bridge/)
- Both agents configured to connect to the server
- Both agents have the workflow instructions in their memory (CLAUDE.md and .codex/config.toml)

## Process Flow

```
Step 1: Plan
  You --> Claude Code
  "Here are the bugs/requirements: [paste]. Validate against the codebase,
   discard false positives, write a fix plan to work/action-plan.md."
  
  You: review the plan, edit if needed.

Step 2: First Review
  You --> Codex
  "Delete work/external-review/bridge-state.json, then review this."

  Codex: reads plan via bridge_get_plan, reviews codebase, submits via
  bridge_submit_review, prints PASTE THIS INTO CLAUDE CODE.

Step 3: Review-Fix Loop
  You: read the review, decide whether to proceed.

    If acceptable:
      You --> Claude Code
      [paste the prompt Codex printed]

      Claude Code: approves round, reads review, fixes valid issues,
      runs tests, submits via bridge_submit_fixes,
      prints PASTE THIS INTO CODEX.

      You --> Codex
      [paste the prompt Claude Code printed]

      Codex: re-reviews, submits, prints PASTE THIS INTO CLAUDE CODE.

    If not acceptable:
      Tell Codex what to change and re-review, or stop.

  Repeat until:
    - Codex reports only low/info findings, or
    - Severity counts are flat across rounds (diminishing returns), or
    - You decide the feature is clean enough.

Step 4: Close
  Tell either agent: "Use bridge_stop."
```

## Sequence Diagram

```
  You              Claude Code           Codex             Bridge State
   |                    |                   |                    |
   |-- bugs/reqs ------>|                   |                    |
   |                    |-- write plan ---->|                    |
   |<-- review plan ----|                   |                    |
   |                    |                   |                    |
   |-- "review this" ---|------------------>|                    |
   |                    |                   |-- get_plan ------->|
   |                    |                   |-- submit_review -->|
   |                    |                   |<-- round N --------|
   |<-- PASTE THIS -----|-------------------|                    |
   |                    |                   |                    |
   |== REVIEW-FIX LOOP (repeat until clean) ====================|
   |                    |                   |                    |
   |-- [paste] -------->|                   |                    |
   |                    |-- approve_round ->|                    |
   |                    |-- get_review ---->|                    |
   |                    |-- [fix code] ---->|                    |
   |                    |-- [run tests] --->|                    |
   |                    |-- submit_fixes -->|                    |
   |<-- PASTE THIS -----|                   |                    |
   |                    |                   |                    |
   |-- [paste] ---------|------------------>|                    |
   |                    |                   |-- get_plan ------->|
   |                    |                   |-- submit_review -->|
   |<-- PASTE THIS -----|-------------------|                    |
   |                    |                   |                    |
   |== END LOOP ================================================|
   |                    |                   |                    |
   |-- "bridge_stop" -->|                   |                    |
   |                    |-- stop ---------->|                    |
```

## When to Stop

Stop the loop when any of these are true:

- No critical or high findings remain.
- Severity counts are flat or increasing across rounds (the agents are going in circles).
- The reviewer reports only low/info items.
- You have run 3+ rounds on the same feature (deeper issues need human architectural review, not more agent passes).

## Severity Scale

All review findings use this scale:

| Severity | Meaning | Action |
|----------|---------|--------|
| critical | Data loss, security vulnerability, production crash | Must fix before merge |
| high | Incorrect behavior, broken feature, missing implementation | Must fix before merge |
| medium | Unhandled edge case, inconsistent naming, missing validation | Should fix, can defer with justification |
| low | Code style, minor optimization, documentation gap | Fix if convenient |
| info | Observation, suggestion | No action required |

## Agent Roles

### Claude Code (Implementer)

- Writes the execution plan from your input
- Reads approved reviews via bridge_get_review
- Validates each finding against the codebase
- Fixes valid issues at root cause across all affected files
- Runs the full test suite
- Reports results via bridge_submit_fixes
- Generates the next Codex prompt via bridge_next_round_prompt

### Codex (Reviewer)

- Reads the plan via bridge_get_plan
- Reviews the codebase independently
- Submits findings with severity counts via bridge_submit_review
- Does NOT modify source code, tests, or configuration
- Generates the next Claude Code prompt via bridge_next_round_prompt

### You (Approver)

- Provide the initial bugs/requirements
- Review and approve the plan
- Read each review before approving the round
- Paste generated prompts between agents
- Decide when to stop the loop

## File Layout

All bridge output stays within the Tessallite Pattern work/ directory:

```
work/
  action-plan.md                    # Current execution plan
  external-review/
    bridge-state.json               # Round state (persists across sessions)
    review-report.md                # Latest review (quick-access copy)
    rounds/
      round-001-*-review.md         # Timestamped review per round
      round-001-*-fixes.md          # Timestamped fixes per round
```

## Agent Configuration

### Claude Code (CLAUDE.md)

Add this block to your project CLAUDE.md:

```markdown
## Review Bridge Workflow

When the review-bridge MCP server is connected:

### As Implementer (your primary role)
When asked to fix review findings or when receiving a prompt from bridge_next_round_prompt:
1. Call bridge_approve_round (if status is "review_submitted").
2. Call bridge_get_review to read the approved review.
3. Validate each finding, fix valid issues at root cause.
4. Run the full test suite until green.
5. Submit results via bridge_submit_fixes.
6. After submitting, call bridge_next_round_prompt with target="reviewer" and show the output to the user with the label "PASTE THIS INTO CODEX:"

### Trigger phrases
When the user says "review ready", "review submitted", or "next round":
1. Call bridge_status to check the current state.
2. If a review is pending approval, run the implementer workflow above.
```

### Codex (.codex/config.toml)

Add this instructions block to your project or global config.toml:

```toml
instructions = """
## Review Bridge Workflow

When the review-bridge MCP server is connected:

### As Reviewer (your primary role)
When asked to review code or when receiving a prompt from bridge_next_round_prompt:
1. Call bridge_get_plan to read the execution plan.
2. Review the codebase against the plan.
3. Submit findings via bridge_submit_review.
4. After submitting, call bridge_next_round_prompt with target="implementer" and show the output to the user with the label "PASTE THIS INTO CLAUDE CODE:"

### After receiving fix results
When the user says "fixes done", "round complete", or "next round":
1. Call bridge_status to check the current state.
2. If the last round status is "completed", call bridge_next_round_prompt with target="reviewer".
3. Follow the generated prompt to re-review.

### Constraints
- Write ONLY to work/external-review/
- Do NOT modify source code, tests, or config files
- Use severity scale: critical/high/medium/low/info
"""
```

## Quick Reference

| Action | Where | Command |
|--------|-------|---------|
| Start a new review cycle | Claude Code | Give bugs/requirements, ask for plan |
| Kick off first review | Codex | "Delete work/external-review/bridge-state.json, then review this." |
| Approve a review | Claude Code | "review ready" |
| Check round status | Either agent | "Use bridge_status" |
| Stop the cycle | Either agent | "Use bridge_stop" |
| See severity trends | Either agent | "Use bridge_status" |