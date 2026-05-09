# Session Handout: Apply Tessallite Pattern To This Repository

Status: active
Last meaningful update: 2026-05-09

## Goal

Apply the Tessallite Pattern operational structure to the Tessallite Pattern
framework kit repository itself.

## Completed Work

- Installed persistent agent working rules in `AGENTS.md`.
- Added operational documentation domains under `docs/architecture/`,
  `docs/questions/`, `docs/execution/`, `docs/guides/`, and `docs/archive/`.
- Updated `docs/_INDEX.md` so the new domains are routed from the L0 index.
- Created a repository system map in
  `docs/architecture/architecture_system-map.md`.
- Created first-pass adoption questions in
  `docs/questions/questions_adoption-open-questions.md`.
- Created an operational issue registry in
  `docs/execution/execution_issue-registry.md`.
- Created a maintainer guide in `docs/guides/guides_developer-guide.md`.
- Started `work/logs/project-journal.md`.
- Added `docs/tessallite-pattern/prompts/project-feedback-rules.md` as a
  generic bootstrap supplement for converting assistant-specific feedback
  memories into project rules.
- Wired the feedback-rule supplement into both greenfield and existing-codebase
  bootstrap prompts, the prompt index, the Tessallite Pattern index, and the
  persistent memory instructions.
- Generalized a tool-specific assistant bootstrap script into reusable rule
  families for task validation, documentation, issue tracking, configuration,
  planning, code review, handouts, command wrappers, publishing, and reference
  pointers.
- Added explicit conflict-resolution guidance so generic rules do not force
  unrelated README/user-guide edits, generic `action-plan.md` files,
  unsolicited close-out, automatic commits, or unsafe permission defaults.
- Added `scripts/bootstrap-tessallite-pattern.sh` and
  `scripts/bootstrap-tessallite-pattern.bat` so the pattern can be scaffolded
  directly into a target project.
- Smoke-tested the Bash bootstrap script in `/tmp/tessallite-bootstrap-smoke`;
  the generated `scripts/check-docs-index.sh` passed.

## Current State

The repository now demonstrates the same documentation-routing and continuity
structure that the framework recommends for existing-codebase adoption. The
framework materials remain under `docs/tessallite-pattern/`; the new operational
domains describe this repository as a codebase.

## Open Blockers

No implementation blocker is active.

## Deferred Decisions

- Answer or defer the adoption questions in
  `docs/questions/questions_adoption-open-questions.md`.
- Decide whether to add CI for `scripts/check-docs-index.sh`.
- Decide whether to add markdown link checking.
- Decide whether to document version floors for Node and Chrome/Chromium.
- For real target-project adoption, decide which project-specific feedback
  rules should be installed as hard memory rules and which should remain linked
  references.
- Run the Windows batch bootstrap on a Windows machine before release tagging;
  PowerShell was not available in this Linux environment.

## Verification To Run

```bash
bash scripts/check-docs-index.sh
```

## Key Files

- `AGENTS.md`
- `docs/_INDEX.md`
- `docs/architecture/architecture_system-map.md`
- `docs/questions/questions_adoption-open-questions.md`
- `docs/execution/execution_issue-registry.md`
- `docs/guides/guides_developer-guide.md`
- `docs/tessallite-pattern/prompts/project-feedback-rules.md`
- `scripts/bootstrap-tessallite-pattern.sh`
- `scripts/bootstrap-tessallite-pattern.bat`
- `work/logs/project-journal.md`
