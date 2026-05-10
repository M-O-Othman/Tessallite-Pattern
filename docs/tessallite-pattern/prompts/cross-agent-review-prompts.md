# Cross-Agent Review Prompts

Prompt templates for running cross-agent code review using the Review Bridge MCP server (`tools/review-bridge`). These prompts are designed for a two-agent setup where one agent implements and another reviews.

## Prerequisites

- Review Bridge MCP server installed and built (`tools/review-bridge`)
- Both agents configured to connect to the server (see `tools/review-bridge/README.md`)
- An execution plan at `work/action-plan.md` (or equivalent)

---

## Codex: External Reviewer Prompt

Paste this into Codex at the start of a review session:

```
You have access to the review-bridge MCP server. Your role is external code reviewer.

CONSTRAINTS:
- Write ONLY to work/external-review/ directory
- Do NOT modify any source code, tests, or configuration files
- Do NOT run any commands that modify the filesystem outside work/external-review/

STEPS:
1. Call bridge_get_plan with plan_file="work/action-plan.md" to read the execution plan.
2. Read all source files referenced in the plan.
3. Review against these criteria:
   a. All planned tasks are implemented (no skipped steps)
   b. No unwired code (functions defined but never called, imports unused, endpoints not registered)
   c. No missing frontend elements (API fields defined but not shown in UI, events emitted but not consumed)
   d. Race conditions (shared mutable state, async gaps between check-and-act)
   e. Unhandled boundary cases (empty arrays, null values, division by zero, missing keys)
   f. Type mismatches between producer and consumer (backend emits field X, frontend reads field Y)
   g. Inconsistent naming or signatures across layers (API schema vs ORM vs frontend type)
   h. No hardcoded config values, prompts, or secrets in source code
   i. Tests cover behavior not implementation
   j. Documentation reflects current state
4. Call bridge_submit_review with:
   - plan_file: "work/action-plan.md"
   - review_content: full markdown report organized by file/module
   - summary: one-line summary of findings
   - Severity counts using this scale:
     critical = data loss, security vulnerability, crash in production
     high = incorrect behavior, broken feature, missing implementation
     medium = edge case not handled, inconsistent naming, missing validation
     low = code style, minor optimization, documentation gap
     info = observation, suggestion, no action needed

FORMAT your review_content as:
# External Review Report - Round N

## Summary
[one paragraph overview]

## Findings

### [File or Module Name]
- [SEVERITY] Description of issue
  Location: file:line
  Expected: what should happen
  Actual: what happens or is missing

[repeat per finding]

## Severity Summary
- Critical: N
- High: N
- Medium: N
- Low: N
- Info: N
```

---

## Claude Code: Fix Executor Prompt

Tell Claude Code this after a review is approved:

```
Use bridge_get_review to read the latest approved external review.

For each finding:
1. Read the referenced file and verify the finding is valid (not a false positive).
2. If valid: fix the root cause. Apply the fix to every affected component, not only the file where the symptom appeared. Follow root-cause discipline.
3. If invalid: note why it is a false positive (e.g. the reviewer misread the code, the behavior is intentional, the code path is unreachable).

After processing all findings:
1. Run the full test suite. Fix any failures at root cause until green.
2. Update docs/execution/execution_issue-registry.md with any bugs found or fixed.
3. Call bridge_submit_fixes with:
   - fixes_applied: list of what you fixed (one line per fix)
   - fixes_skipped: list of {issue, reason} for false positives or intentionally skipped items
   - remaining_issues: anything you could not resolve (needs architectural decision, blocked by external dependency, etc.)
```

---

## Approval Prompt

After reading Codex's review report, tell either agent:

```
Use bridge_approve_round.
```

---

## Status Check Prompt

At any point during the cycle:

```
Use bridge_status to show the current round, history, and severity trends.
```

---

## Stop Prompt

When the review cycle is complete or you want to abort:

```
Use bridge_stop.
```

---

## Multi-Round Strategy

After each round, check severity trends via bridge_status. Stop when:

- No critical or high findings remain
- Severity counts are flat or increasing (indicates diminishing returns or circular fixes)
- The reviewer is flagging style/info items only
- You have run 3+ rounds on the same feature (deeper issues may need architectural review, not more agent passes)
