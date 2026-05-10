# Bootstrap Consistency Fix Plan

Status: draft
Last meaningful update: 2026-05-10

## Goal

Make the three bootstrap paths (scripted, walkthrough, manual prompt) produce
structurally identical scaffolds so that a user who picks any path arrives at the
same starting point. Fix broken cross-references, index failures, and content
drift between the shell script, batch script, prompts, walkthrough, and
documentation.

## Scope

This plan covers the following artefacts:

- `scripts/bootstrap-tessallite-pattern.sh`
- `scripts/bootstrap-tessallite-pattern.bat`
- `docs/tessallite-pattern/prompts/bootstrap-greenfield-project-prompt.md`
- `docs/tessallite-pattern/prompts/bootstrap-existing-codebase-prompt.md`
- `docs/tessallite-pattern/prompts/agent-memory-instructions.md`
- `docs/tessallite-pattern/bootstrap-user-journey.md`
- `walk-through/walkthrough.md`
- `docs/tessallite-pattern/_INDEX.md`
- `docs/tessallite-pattern/templates/_INDEX.md`
- `AGENTS.md`
- `docs/guides/cross-agent-review-prompts.md`
- `docs/architecture/architecture_system-map.md`

## Prerequisites

Answer or defer the questions in
`docs/questions/questions_bootstrap-consistency-open-questions.md` before
executing any phase below. Each phase notes which questions affect it.

---

## Phase 1: Fix Broken Cross-References And Index Failures

Priority: high
Affected questions: Q-BC-004, Q-BC-005, Q-BC-006
Risk: low (documentation-only, no script changes)

### Tasks

1.1 Fix `AGENTS.md` broken reference to `docs/tessallite-pattern/prompts/cross-agent-review-prompts.md`.
    - The file does not exist at that path.
    - The actual file is at `docs/guides/cross-agent-review-prompts.md`.
    - Update the reference in `AGENTS.md` to point to the correct path.
    - Depends on Q-BC-004.

1.2 Rename `docs/tessallite-pattern/templates/_index.md` to `_INDEX.md`.
    - The lowercase name is inconsistent with the convention used everywhere else.
    - Depends on Q-BC-005.

1.3 Populate `docs/tessallite-pattern/templates/_INDEX.md` with all templates.
    - Currently only lists `external-review-report-template.md`.
    - Must list all 13 template files in the directory.
    - Depends on Q-BC-005.

1.4 Add `docs/tessallite-pattern/templates/external-review-report-template.md` to
    `docs/tessallite-pattern/_INDEX.md` templates table.
    - Currently missing from the parent index.
    - Depends on Q-BC-005.

1.5 Handle `review-bridge-v2-patch.tar.gz` at repo root.
    - If obsolete (Q-BC-006 answer C): remove it.
    - If needed: move to `tools/review-bridge/` and document in system map.

### Verification

```bash
bash scripts/check-docs-index.sh
```

Must pass with zero failures.

---

## Phase 2: Normalize AGENTS.md Content Across All Paths

Priority: high
Affected questions: Q-BC-001
Risk: medium (changes what rules get installed in target projects)

### Problem

Three different AGENTS.md content variants exist:

| Source | Sections | Approximate lines |
| --- | --- | --- |
| Shell/BAT scripts | Core Rule, Project Feedback Rules, Documentation Routing, Delivery Gates, Implementation, Session Continuity | ~45 lines |
| `agent-memory-instructions.md` | Core Rule, Project Feedback Rules, Documentation Routing, Before Feature Implementation, Existing Codebase Adoption, Implementation, Phase Closure, Documentation Governance, Session Continuity, Architect Authority | ~127 lines |
| Repo's own `AGENTS.md` | Full agent-memory-instructions.md content + Cross-Agent Review Bridge section | ~153 lines |

The scripted path installs a stripped-down version missing: Before Feature
Implementation, Existing Codebase Adoption, Phase Closure, Documentation
Governance, and Architect Authority. The manual prompt path installs the full
set.

### Tasks

2.1 If Q-BC-001 answer is A (full form everywhere):
    - Update the shell script's `append_memory_if_needed` function to match
      `agent-memory-instructions.md` content exactly.
    - Update the BAT script's `Add-AgentMemory` function to match.
    - Both scripts become consumers of the same canonical content.

2.2 If Q-BC-001 answer is B (short form everywhere):
    - Trim `agent-memory-instructions.md` to match the script content.
    - Update the greenfield and existing-codebase bootstrap prompts to reference
      the shorter content.
    - Risk: loses important gates (Phase Closure, Documentation Governance).

2.3 If Q-BC-001 answer is C (tiered):
    - Document explicitly which path installs which content.
    - Add a warning in bootstrap-user-journey.md that the scripted path installs
      fewer rules.

2.4 Regardless of the answer: ensure `agent-memory-instructions.md` and the
    scripts produce byte-identical content for the sections they share. Currently
    the scripts say "Delivery Gates" while agent-memory-instructions.md has
    "Before Feature Implementation" with different wording.

### Verification

- Extract AGENTS.md content from each source (shell script, BAT script,
  agent-memory-instructions.md).
- Compare section headers and rules text line by line.
- Confirm they are identical for all shared sections.

---

## Phase 3: Normalize Scaffold File Lists

Priority: high
Affected questions: Q-BC-002, Q-BC-003, Q-BC-007
Risk: medium (changes what files get created in target projects)

### Problem

The three paths create different file sets:

| File | Shell Script | BAT Script | Greenfield Prompt | Existing Prompt | Walkthrough |
| --- | --- | --- | --- | --- | --- |
| AGENTS.md | YES | YES | (via prompt) | (via prompt) | YES |
| docs/_INDEX.md | YES | YES | YES | YES | YES |
| docs/architecture/_INDEX.md | YES | YES | YES | YES | YES |
| docs/architecture/architecture_project-overview.md | YES | YES | YES | - | YES |
| docs/architecture/architecture_system-map.md | - | - | - | YES | - |
| docs/questions/_INDEX.md | YES | YES | YES | YES | YES |
| docs/questions/questions_initial-project.md | YES | YES | YES | - | YES |
| docs/questions/questions_adoption-open-questions.md | - | - | - | YES | - |
| docs/execution/_INDEX.md | YES | YES | YES | YES | YES |
| docs/execution/execution_issue-registry.md | YES | YES | YES | YES | YES |
| docs/execution/execution_command-registry.md | YES | YES | - | - | - |
| docs/execution/execution_bootstrap-report.md | YES | YES | - | - | - |
| docs/guides/_INDEX.md | YES | YES | YES | YES | YES |
| docs/guides/guides_developer-guide.md | YES | YES | YES | YES | YES |
| docs/guides/guides_project-feedback-rules.md | YES | YES | - | - | - |
| docs/strategy/_INDEX.md | YES | YES | YES | - | - |
| docs/strategy/strategy_product-brief.md | YES | YES | - | - | - |
| docs/archive/_INDEX.md | YES | YES | YES | YES | YES |
| work/logs/project-journal.md | YES | YES | YES | YES | YES |
| work/sessions/ | YES | YES | YES | YES | YES |
| work/sessions/bootstrap-next-prompt.md | YES | YES | - | - | - |
| scripts/check-docs-index.sh | YES | YES | YES | YES | YES |

Gaps:

1. The greenfield prompt and walkthrough miss 5 files the scripts create
   (command-registry, bootstrap-report, project-feedback-rules, strategy files,
   bootstrap-next-prompt).
2. The existing-codebase prompt uses different file names for architecture and
   questions files.
3. The existing-codebase prompt omits the strategy domain entirely.
4. The walkthrough shows a smaller file set than either the scripts or the
   prompts.

### Tasks

3.1 Define the canonical file list for greenfield mode:

    ```
    AGENTS.md
    docs/_INDEX.md
    docs/architecture/_INDEX.md
    docs/architecture/architecture_project-overview.md
    docs/questions/_INDEX.md
    docs/questions/questions_initial-project.md
    docs/execution/_INDEX.md
    docs/execution/execution_issue-registry.md
    docs/execution/execution_command-registry.md
    docs/execution/execution_bootstrap-report.md
    docs/guides/_INDEX.md
    docs/guides/guides_developer-guide.md
    docs/guides/guides_project-feedback-rules.md
    docs/strategy/_INDEX.md
    docs/strategy/strategy_product-brief.md
    docs/archive/_INDEX.md
    work/logs/project-journal.md
    work/sessions/.gitkeep
    work/sessions/bootstrap-next-prompt.md
    scripts/check-docs-index.sh
    ```

3.2 Define the canonical file list for existing mode (depends on Q-BC-002,
    Q-BC-003, Q-BC-007):

    If Q-BC-002 answer is A (mode-dependent names):
    ```
    Same as greenfield but:
    - docs/architecture/architecture_system-map.md  (instead of project-overview)
    - docs/questions/questions_adoption-open-questions.md  (instead of initial-project)
    ```

    If Q-BC-007 answer is A (add strategy to existing):
    ```
    Includes strategy/ domain files
    ```

3.3 Update the greenfield bootstrap prompt to list the same starter documents as
    the script. Add the 5 missing files to its "Create starter documents" section.

3.4 Update the existing-codebase bootstrap prompt to list the same starter
    documents as the script --existing mode. Add missing files.

3.5 Update the walkthrough to show all files that the greenfield path creates.
    Steps 8 and 9 currently omit 5 files. Add them to the expected output in
    the walkthrough text.
    - Update `scripts/generate-walkthrough-assets.js` if the screenshot text
      needs to change.

3.6 Update `docs/tessallite-pattern/bootstrap-user-journey.md` "What The Script
    Installs" section to list every file the script creates, not just
    directories and a handful of files.

### Verification

- Extract file lists from shell script, BAT script, greenfield prompt,
  existing-codebase prompt, and walkthrough.
- Confirm all produce the same set for the same mode.
- Run `bash scripts/check-docs-index.sh`.

---

## Phase 4: Fix Shell/BAT Script Content Parity

Priority: high
Affected questions: none
Risk: medium (changes file content in both scripts)

### Problem

The shell script (.sh) and batch script (.bat) produce different file contents
for several files:

| File | Difference | Shell (.sh) | Batch (.bat) |
| --- | --- | --- | --- |
| execution_command-registry.md | Section count | 3 sections (Verification, Generated Assets, Deploy) | 4 sections (+ "Data And Smoke Checks") |
| execution_bootstrap-report.md | "Installed" section | Present | Missing |
| guides_developer-guide.md | Start Of Session step count | 5 steps (includes handout pickup) | 4 steps (missing handout pickup) |
| questions_initial-project.md | Structure | Has "## First Pass Questions" header + "## Closure Rule" | Plain table, no headers |

### Tasks

4.1 Decide which variant is correct for each file and update the other script.

    Recommended resolution:
    - `execution_command-registry.md`: Use the BAT version (4 sections). Add
      "Data And Smoke Checks" to the shell script.
    - `execution_bootstrap-report.md`: Use the shell version (with "Installed"
      section). Add it to the BAT script.
    - `guides_developer-guide.md`: Use the shell version (5 steps). Add the
      missing handout-pickup step to the BAT script.
    - `questions_initial-project.md`: Use the shell version (with headers and
      closure rule). Update the BAT script.

4.2 After fixing, do a line-by-line comparison of every generated file between
    the two scripts. The only differences should be:
    - Line endings (LF vs CRLF)
    - Date stamp (same date format)
    - Project name variable interpolation

### Verification

- Create two temp directories.
- Run the shell script into one and the BAT script into the other.
- Normalize line endings and compare every file with `diff`.
- All files must be identical after normalization.

---

## Phase 5: Fix Walkthrough And Screenshot Generator Consistency

Priority: medium
Affected questions: Q-BC-001 (if AGENTS.md content changes)
Risk: low (display only)

### Problem

The walkthrough (`walk-through/walkthrough.md`) and its screenshot generator
(`scripts/generate-walkthrough-assets.js`) show the manual greenfield path.
Steps 8 and 9 show fewer files than the canonical list. Step 10 asks 7 questions
but the scripted `questions_initial-project.md` has 6 questions (no "initial
delivery milestone" question -- actually wait, let me check this).

Actually, looking more carefully:
- Walkthrough step 10 asks: product goal, primary users, core workflows, target
  stack, external systems, non-goals, initial delivery milestone (7 items)
- Shell script `questions_initial-project.md` asks: Q1-001 through Q1-006 (6
  questions -- goal, users, workflows in scope, workflows out of scope, stack,
  commands)
- Greenfield prompt asks: product goal, primary users, core workflows, target
  stack, external systems, non-goals, initial delivery milestone (7 items)

So the shell script has 6 questions (merging some, missing "non-goals" as
separate and "initial delivery milestone"), while the prompt and walkthrough
have 7 items.

### Tasks

5.1 Align the initial questions between:
    - Shell script `questions_initial-project.md` content
    - BAT script `questions_initial-project.md` content
    - Greenfield bootstrap prompt "First task" section
    - Walkthrough step 10

    Recommended: use 7 questions matching the greenfield prompt, which is the
    most complete set:
    1. Product goal
    2. Primary users
    3. Core workflows (in scope)
    4. Workflows out of scope (non-goals)
    5. Target stack, deployment target, external systems
    6. Commands for tests, build, generated assets, deploy
    7. Initial delivery milestone

5.2 Update walkthrough steps 8 and 9 to show the full file list (after Phase 3
    changes).

5.3 Regenerate walkthrough screenshots if the terminal text changed:
    ```bash
    node scripts/generate-walkthrough-assets.js
    ```

### Verification

- Compare question count and wording across all 4 sources.
- Run `bash scripts/check-docs-index.sh`.
- Visually inspect regenerated screenshots.

---

## Phase 6: Update Documentation To Reflect New Canonical State

Priority: medium
Affected questions: all
Risk: low

### Tasks

6.1 Update `docs/tessallite-pattern/bootstrap-user-journey.md`:
    - "What The Script Installs" section: list every file, not just directories.
    - Ensure the file list matches the canonical list from Phase 3.
    - Update "Common Next Steps" if the file names changed.

6.2 Update `docs/architecture/architecture_system-map.md`:
    - Add `review-bridge-v2-patch.tar.gz` handling (depends on Q-BC-006).
    - Reflect any file additions or removals.

6.3 Update `docs/tessallite-pattern/framework-handbook.md`:
    - No changes expected unless new artefacts were added.

6.4 Update `docs/tessallite-pattern/_INDEX.md`:
    - Add `external-review-report-template.md` to templates table.
    - Verify all entries match actual files.

6.5 Update `README.md`:
    - Verify "Repository Map" and "Contents" sections match the actual state.
    - Update if any paths or descriptions changed.

6.6 Update `docs/execution/execution_issue-registry.md`:
    - Add entries for each inconsistency found and fixed.

6.7 Append `work/logs/project-journal.md` with a summary of this consistency
    work.

### Verification

```bash
bash scripts/check-docs-index.sh
```

All documentation must pass. Manually verify that cross-references resolve
to existing files.

---

## Phase 7: Final Validation

Priority: high
Risk: low

### Tasks

7.1 Run the shell script into a temp directory with --greenfield and --force.
7.2 Run the shell script into another temp directory with --existing and --force.
7.3 Run the BAT script equivalent (if Windows testing is available).
7.4 For each run:
    - Verify every expected file exists.
    - Verify every _INDEX.md lists every .md file in its domain.
    - Run `bash scripts/check-docs-index.sh` against the temp project.
    - Verify AGENTS.md content matches `agent-memory-instructions.md`.
    - Verify no placeholder remains unfilled where the script should have
      substituted values.
7.5 Run the greenfield prompt mentally against the canonical file list and
    confirm the prompt asks for every file.
7.6 Run the existing-codebase prompt the same way.
7.7 Walk through the walkthrough steps and confirm every file it mentions exists
    in the canonical list.

### Exit Criteria

- `bash scripts/check-docs-index.sh` passes on this repo.
- `bash scripts/check-docs-index.sh` passes on a freshly bootstrapped temp
  project (both modes).
- All cross-references in AGENTS.md, README.md, bootstrap-user-journey.md, and
  framework-handbook.md resolve to existing files.
- The shell script and BAT script produce identical file content (after line
  ending normalization).
- No open issues remain in `execution_issue-registry.md` related to consistency.
