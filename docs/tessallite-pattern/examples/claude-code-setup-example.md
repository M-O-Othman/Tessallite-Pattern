# Claude Code Setup Example

Status: active
Last meaningful update: 2026-05-10

This file shows a complete CLAUDE.md for a project using the Tessallite Pattern
with the review bridge. Copy it into your project root and adjust paths,
project name, and any project-specific rules.

## When To Use

Place a CLAUDE.md at your project root when using Claude Code as your primary
implementation agent. Claude Code reads this file automatically at session
start.

If your project uses AGENTS.md as the tool-neutral memory file (the Tessallite
Pattern default), you can either:
- Use AGENTS.md directly (Claude Code reads it too)
- Maintain a CLAUDE.md that imports or duplicates the AGENTS.md content with
  Claude Code specific additions

The example below is a standalone CLAUDE.md that includes everything.

---

## Example CLAUDE.md

```markdown
# Project Rules

This project uses the Tessallite Pattern for AI-assisted delivery.

## Task Completion

Before declaring any task done, run a validation pass:
- All tasks in the plan are complete
- No unwired or unreachable code
- No unused files or dead imports
- No incomplete stubs or TODOs left behind
- Import paths are consistent across the codebase
- Field names are aligned between producer and consumer

## Documentation

After every implementation job:
- Update README.md to reflect current state
- Update Docs/user-guide.md to reflect current state
- Create both files if they do not exist
- Keep language direct, precise, and simple

## Bug and Issue Tracking

- Never dismiss a bug as pre-existing or unrelated
- Log every identified bug to docs/execution/execution_issue-registry.md
- Never apply a band-aid fix; find and fix the root cause

## Feature Tracking

- Log any feature idea or enhancement out of current scope to docs/future-features.md
- Do not implement out-of-scope features without explicit instruction

## Configuration and Secrets

- Never hard-code parameters, prompts, config values, or static data in source code
- Use .env for secrets and environment-specific values
- Use config.json, .md, .txt, .json, or .csv for non-secret config and content
- Never write credentials into any file not listed in .gitignore

## Root Cause Discipline

- Never patch over a symptom
- Trace every bug to its root cause and fix it there
- Apply the fix to every affected component, not only the file where the symptom appeared

## Architectural Decisions

- Stop before making any critical architectural decision
- Write the question and options to docs/questions/questions_<subject>-open-questions.md
- Ask the user to review before proceeding

## Test Discipline

- Never dismiss a failing test
- All tests must pass cleanly before a task is declared done
- Write tests against behavior, not implementation details

## Planning

- Write a plan to work/action-plan.md before touching the codebase
- On task start, read docs/questions/ and work/action-plan.md first
- For complex or new projects, create open questions first and wait for answers

## Coding Principles

- Target 200-400 lines per file
- One responsibility per module
- Keep public interfaces small
- Fail clearly and early
- Document decisions, not obvious code

## Thinking Loops

- If stuck in a reasoning loop, stop immediately
- Notify the user, then continue with care

## User Requests

- Never ask the user for something that can be done via a tool or MCP
- Never give vague instructions like "Test now" or "Redeploy and check"
- When user action is required, state exactly what is needed, why, and provide full detail

## Output Quality

- No emojis, unprofessional icons, or decorative elements
- No funky colors or childish design
- No buzzwords, jargon, or filler language
- All output is corporate-grade quality

## Documentation Routing

- Read docs/_INDEX.md first unless you already know the exact document path
- Use docs/<domain>/_INDEX.md to find domain documents
- Treat active docs as current working truth

## Session Handouts

Write a handout to /work/sessions/YYYY-MM-DD-HHmmss.md before any long task
OR when user types "handout".

Structure: Project, Session Goal, What Was Done, What Was Tried and Failed,
Current State, Blockers, Next Steps, Key Files.

On session start OR when user types "handout pickup": read latest file in
work/sessions/ by filename sort, respond "Picked up handout from session
YYYY-MM-DD HHmmss." If none, stay silent.

## Code Review Skill

Trigger: "code review" or before any commit.

Step 1: Verify every task in work/action-plan.md is complete.
Step 2: Scan for unused functions/imports/dead paths; fix.
Step 3: Cross-check plan vs codebase; implement any gaps.
Step 4: Bug scan on touched files; log each fix to docs/execution/execution_issue-registry.md.
Step 5: Run full test suite; fix root cause until green.
Step 6: Commit with format: [scope] short summary, then detail lines.

## Deep Review Skill

Trigger: "deep review" or "deep-review".

Step 1: Read the active plan and identify the most recently completed phase.
Step 2: For every file touched in that phase, read fully and cross-check against plan.
Step 3: Bug scan for race conditions, boundary cases, type mismatches, naming inconsistencies.
Step 4: Verify documentation is updated.
Step 5: Run full test suite; fix root cause until green.
Step 6: Report findings as numbered list: [FIXED], [OPEN], [QUESTION].

## Review Bridge Workflow

When the review-bridge MCP server is connected:

### As Implementer (your primary role)

When asked to fix review findings or when receiving a prompt from
bridge_next_round_prompt:
1. Call bridge_approve_round (if status is "review_submitted").
2. Call bridge_get_review to read the approved review.
3. Validate each finding, fix valid issues at root cause.
4. Run the full test suite until green.
5. Submit results via bridge_submit_fixes.
6. After submitting, call bridge_next_round_prompt with target="reviewer"
   and show the output to the user with the label "PASTE THIS INTO CODEX:"

### Trigger Phrases

When the user says "review ready", "review submitted", or "next round":
1. Call bridge_status to check the current state.
2. If a review is pending approval, run the implementer workflow above.
```
