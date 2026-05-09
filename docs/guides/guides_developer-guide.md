# Developer Guide

Status: active
Last meaningful update: 2026-05-09

This guide explains how to work in the Tessallite Pattern framework kit
repository after applying the Tessallite Pattern to the codebase itself.

## Repository Type

This is a static documentation and asset repository. There is no application
server, database, or package-managed build. Most changes are Markdown, PNG
assets, shell scripts, or the walkthrough screenshot generator.

## Before Editing

1. Inspect the worktree:

   ```bash
   git status --short --branch
   ```

2. Read routing docs:

   ```text
   docs/_INDEX.md
   docs/architecture/architecture_system-map.md
   ```

3. If the change is broad or process-level, check:

   ```text
   docs/questions/questions_adoption-open-questions.md
   docs/execution/execution_issue-registry.md
   ```

## Common Verification Commands

Run the docs index guard after documentation changes:

```bash
bash scripts/check-docs-index.sh
```

Regenerate the greenfield walkthrough screenshots after editing
`scripts/generate-walkthrough-assets.js`:

```bash
node scripts/generate-walkthrough-assets.js
```

The screenshot generator requires a local `google-chrome`, `chromium`, or
`chromium-browser` binary.

## Documentation Rules

- `docs/_INDEX.md` is the L0 router and lists documentation domains.
- Every docs domain needs an `_INDEX.md`.
- Every active Markdown file under a docs domain must be listed in the domain
  `_INDEX.md`.
- If a nested folder has its own `_INDEX.md`, list files there as well.
- When changing file purpose, update the relevant index summary.
- Run `bash scripts/check-docs-index.sh` before committing docs changes.

## Walkthrough Rules

- Treat `walk-through/walkthrough.md` as the canonical written walkthrough.
- Treat `walk-through/illustrations/*.png` as generated outputs.
- Edit `scripts/generate-walkthrough-assets.js` first, regenerate PNGs, then
  inspect at least representative frames.
- Preserve the Tessallite palette documented in `illustrations/BRAND_BRIEF.md`.
- Keep shell setup before `codex` or `claude`; after the agent starts, examples
  should show chat input, not normal shell commands.

## Issue Registry Rules

Use `docs/execution/execution_issue-registry.md` for operational repo issues.
Use `docs/tessallite-pattern/issue-registry.md` for kit-level issues in the
framework materials themselves.

## Release Notes And Session Memory

For meaningful maintenance work:

- add or update a session handout under `work/sessions/`
- append `work/logs/project-journal.md`
- keep next steps specific enough for a new session to resume

## Known Gaps

- No markdown link checker is currently configured.
- No package manifest pins Node or Chrome versions for screenshot generation.
- Adoption questions remain pending until answered by the architect.
