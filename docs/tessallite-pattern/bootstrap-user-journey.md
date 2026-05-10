# Bootstrap User Journey

Status: active
Last meaningful update: 2026-05-09

This document is the canonical user journey for applying the Tessallite Pattern
to a project. It keeps the scripted path, guided walkthrough, and manual prompt
path consistent.

## Rule Of Thumb

Choose one bootstrap path for the first setup pass:

- Use the scripted path when you want the scaffold installed immediately.
- Use the guided walkthrough when you want to see the manual macOS/Codex flow.
- Use the manual prompt path when you cannot or do not want to run scripts.

Do not run the script and then ask an assistant to recreate the same bootstrap
files from the bootstrap prompt. After a scripted bootstrap, the assistant's job
is to inspect, adapt, answer questions, and fill project-specific details.

## Path A: Fast Scripted Bootstrap

Use this path for most projects.

### macOS Or Linux

```bash
bash scripts/bootstrap-tessallite-pattern.sh /path/to/project --greenfield
```

For an existing codebase:

```bash
bash scripts/bootstrap-tessallite-pattern.sh /path/to/project --existing
```

### Windows

```bat
scripts\bootstrap-tessallite-pattern.bat C:\path\to\project -Greenfield
```

For an existing codebase:

```bat
scripts\bootstrap-tessallite-pattern.bat C:\path\to\project -Existing
```

### What The Script Installs

- `AGENTS.md`
- `docs/_INDEX.md`
- `docs/architecture/_INDEX.md`
- `docs/architecture/architecture_system-map.md`
- `docs/questions/_INDEX.md`
- `docs/questions/questions_initial-project.md`
- `docs/execution/_INDEX.md`
- `docs/execution/execution_issue-registry.md`
- `docs/execution/execution_command-registry.md`
- `docs/execution/execution_bootstrap-report.md`
- `docs/guides/_INDEX.md`
- `docs/guides/guides_developer-guide.md`
- `docs/guides/guides_project-feedback-rules.md`
- `docs/strategy/_INDEX.md`
- `docs/strategy/strategy_product-brief.md`
- `docs/archive/_INDEX.md`
- `work/logs/project-journal.md`
- `work/sessions/`
- `work/sessions/bootstrap-next-prompt.md`
- `scripts/check-docs-index.sh`

### Next Step After Scripted Bootstrap

Open your coding assistant in the target project and paste the generated prompt:

```text
work/sessions/bootstrap-next-prompt.md
```

The assistant should report:

- what was bootstrapped
- which initial questions still block design
- which commands are missing from the command registry
- the smallest safe next step

The assistant should not write application code yet.

## Path B: Guided Walkthrough

Use this path when you want to understand the manual flow before adopting it.

Start with:

```text
walk-through/walkthrough.md
```

The walkthrough shows the older manual sequence:

1. create a project directory
2. copy the bootstrap prompt and memory instructions into the project
3. open the coding assistant
4. ask the assistant to follow the bootstrap prompt
5. review the generated docs and initial questions

This path is educational. It is still valid, but it is not required when you use
the bootstrap scripts.

## Path C: Manual Prompt Bootstrap

Use this path when scripts are unavailable or when you want the assistant to
perform the scaffold step itself.

For a new project, use:

```text
docs/tessallite-pattern/prompts/bootstrap-greenfield-project-prompt.md
```

For an existing codebase, use:

```text
docs/tessallite-pattern/prompts/bootstrap-existing-codebase-prompt.md
```

Also provide:

```text
docs/tessallite-pattern/prompts/agent-memory-instructions.md
docs/tessallite-pattern/prompts/project-feedback-rules.md
```

The assistant should install memory, create or map docs, ask initial questions,
and stop before application code.

## Existing Codebase Sequence

For an existing codebase, the safest sequence is:

1. Inspect the worktree.
2. Run the script with `--existing` or `-Existing`, or use the existing-codebase
   bootstrap prompt manually.
3. Ask the assistant to verify the scaffold against the actual repository.
4. Fill the system map with real entry points, modules, tests, builds,
   deployment assumptions, and risks.
5. Fill the command registry with real commands and wrappers.
6. Record stale-doc risks and missing docs in the issue registry.
7. Only then begin feature requirements.

## Common Next Steps For All Paths

After any bootstrap path:

1. Read `AGENTS.md`.
2. Read `docs/_INDEX.md`.
3. Answer or defer `docs/questions/questions_initial-project.md` or the
   adoption questions created for the project.
4. Fill `docs/execution/execution_command-registry.md`.
5. Run `bash scripts/check-docs-index.sh`.
6. Fill `docs/architecture/architecture_system-map.md` with real entry points,
   modules, tests, builds, deployment assumptions, and risks.
7. Start requirements for the first real feature.

## What Not To Do

- Do not use the walkthrough as a second required step after the script.
- Do not ask the assistant to recreate files the script already created.
- Do not start implementation while initial questions or command registry gaps
  still block safe work.
- Do not copy tool-specific permission bypasses or local model settings into
  project memory as universal rules.
- Do not run deploy, publish, destructive, or production-affecting commands
  until the command registry names the approved wrapper and the user approves
  the action.
