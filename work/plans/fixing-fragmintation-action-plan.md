# Tessallite Pattern Repo Cleanup Plan

## Assessment

The repo has two layers that coexist correctly:

1. The pattern kit (docs/tessallite-pattern/) contains reusable materials people copy into their projects.
2. The operational docs (docs/architecture/, docs/execution/, docs/guides/, docs/questions/) document this repo itself, demonstrating the pattern in practice.

Both layers are valid. The problems are inconsistencies between them, broken references, misplaced files, and naming conflicts between the scripted and manual bootstrap paths.

## Phase 1: Fix Broken References and Misplaced Files

### 1.1 Move cross-agent review workflow to correct location
The workflow guide is at docs/guides/cross-agent-review-prompts.md but AGENTS.md references docs/tessallite-pattern/prompts/cross-agent-review-prompts.md (which was deleted).

Action:
- Rename docs/guides/cross-agent-review-prompts.md to docs/guides/guides_cross-agent-review-workflow.md (follows the domain prefix convention: guides_*)
- Update docs/guides/_INDEX.md to reference the new filename
- Update AGENTS.md to reference docs/guides/guides_cross-agent-review-workflow.md

### 1.2 Fix templates/_index.md casing
Action:
- Rename docs/tessallite-pattern/templates/_index.md to docs/tessallite-pattern/templates/_INDEX.md
- Populate it with all 12 templates currently listed only in the parent _INDEX.md

### 1.3 Add external-review-report-template to indexes
The file docs/tessallite-pattern/templates/external-review-report-template.md exists but is not listed in any index.

Action:
- Add it to the templates _INDEX.md (created in 1.2)
- Add it to the templates table in docs/tessallite-pattern/_INDEX.md

### 1.4 Fix walk-through reference in tessallite-pattern/_INDEX.md
The examples table references ../../walk-through/walkthrough.md which works but breaks the self-contained kit boundary.

Action:
- Keep the reference (the walkthrough is a repo-level asset, not a kit asset)
- Add a note in the table: "Repository-level asset, not part of the portable kit"

## Phase 2: Normalize Naming Conventions

### 2.1 Domain prefix convention
Current state: docs/guides/ uses guides_developer-guide.md (prefixed). docs/architecture/ uses architecture_system-map.md (prefixed). docs/execution/ uses execution_issue-registry.md (prefixed). docs/questions/ uses questions_adoption-open-questions.md (prefixed).

This is consistent. No action needed.

### 2.2 Bootstrap file naming (per Q-BC-002, Q-BC-003 decisions)
Action:
- In scripts/bootstrap-tessallite-pattern.sh, change architecture_project-overview.md to architecture_system-map.md for both modes
- In scripts/bootstrap-tessallite-pattern.sh, change questions_initial-project.md to questions_initial-project.md for greenfield and questions_adoption-open-questions.md for existing (mode-dependent per Q-BC-003 answer, but reconsider: use same name for both per the recommendation)
- Align the manual prompts (bootstrap-greenfield-project-prompt.md and bootstrap-existing-codebase-prompt.md) to use the same file names as the scripts
- Update the walkthrough if it references the old file names

### 2.3 AGENTS.md content (per Q-BC-001)
Action:
- Make AGENTS.md in the scripts match the full form from docs/tessallite-pattern/prompts/agent-memory-instructions.md
- Add the review bridge section
- Ensure the scripted path installs the same rule set as the manual path

## Phase 3: Add Strategy Domain

Per Q-BC-007: add docs/strategy/ to both bootstrap modes.

Action:
- Create docs/strategy/_INDEX.md as an empty domain index (this repo doesn't need strategy docs, but the bootstrap should create the domain for target projects)
- Add strategy domain creation to both --greenfield and --existing modes in the bootstrap scripts
- Add strategy domain creation to both manual bootstrap prompts
- Do NOT create docs/strategy/ in this repo itself (it's a kit repo, not a product repo; the strategy domain is for target projects only)

Wait, this contradicts the pattern-eats-itself principle. This repo uses the pattern on itself. If strategy is part of the pattern, this repo should have it too.

Revised action:
- Create docs/strategy/_INDEX.md in this repo with a single entry explaining that strategy docs are not applicable to a framework kit repo but the domain exists to demonstrate completeness
- Add strategy to docs/_INDEX.md
- Add strategy domain creation to bootstrap scripts and prompts for both modes

## Phase 4: Clean Up Stale Artifacts

### 4.1 Remove review-bridge-v2-patch.tar.gz (per Q-BC-006)
Action:
- Delete from repo root if present
- Verify it's not tracked in git

### 4.2 Remove DROP-IN-INSTRUCTIONS.md
Already deleted per commit 524dcf9. Verify it's gone.

## Phase 5: Reconcile Bootstrap Paths

This is the largest task. Three bootstrap paths exist:
1. scripts/bootstrap-tessallite-pattern.sh (scripted)
2. docs/tessallite-pattern/prompts/bootstrap-greenfield-project-prompt.md (manual greenfield)
3. docs/tessallite-pattern/prompts/bootstrap-existing-codebase-prompt.md (manual existing)
4. walk-through/walkthrough.md (visual guide using Codex)

All four should produce the same file structure and content for the same mode.

Action:
- Create a canonical file list document at docs/tessallite-pattern/bootstrap-file-manifest.md listing every file each mode creates, with expected content summaries
- Audit all four paths against this manifest
- Fix divergences so all paths converge on the same output

### Files each mode should create (proposed canonical list):

Greenfield:
- AGENTS.md (full form)
- docs/_INDEX.md
- docs/architecture/_INDEX.md
- docs/architecture/architecture_system-map.md (empty template)
- docs/questions/_INDEX.md
- docs/questions/questions_initial-project.md
- docs/execution/_INDEX.md
- docs/execution/execution_issue-registry.md (empty template)
- docs/guides/_INDEX.md
- docs/guides/guides_developer-guide.md (empty template)
- docs/strategy/_INDEX.md
- docs/archive/_INDEX.md
- work/logs/project-journal.md
- work/sessions/ (empty directory)

Existing (same as greenfield plus):
- docs/architecture/architecture_system-map.md (pre-filled with codebase scan prompts)
- docs/questions/questions_adoption-open-questions.md (adoption-focused questions template)

### 5.1 Add review bridge to bootstrap
Action:
- Add tools/review-bridge/ setup instructions to the developer guide template
- Add .mcp.json and .codex/config.toml creation to bootstrap scripts (commented out, with instructions)
- Do NOT auto-install the review bridge in bootstrap (it requires npm install, which is a runtime dependency the pattern shouldn't force)

## Phase 6: Update Root README.md

The current README lists contents as bullet points referencing framework-handbook, lifecycle-guide, etc. It should also reference:
- tools/review-bridge/ and its purpose
- docs/guides/guides_cross-agent-review-workflow.md
- The operational docs layer (architecture, execution, guides, questions)
- The bootstrap file manifest (once created)

Action:
- Add a "Repository Structure" section showing the two-layer architecture
- Add a "Tools" section listing review-bridge
- Keep the existing "Start Here" section as-is

## Phase 7: Answer Pending Questions

### From questions_adoption-open-questions.md:
- Q1-001: Keep both layers. The operational domains stay alongside the kit. Answer: resolved.
- Q1-002: Screenshots stay manual-only for now. No CI. Answer: deferred.
- Q1-003: No markdown link checker for now. Answer: deferred.
- Q1-004: Source article stays as historical field report. Kit docs are operating truth. Answer: resolved.
- Q1-005: No version floor for now. Document "requires Node 18+ and Chrome/Chromium" in developer guide. Answer: resolved.

Action:
- Update the questions file with these answers
- Close Q1-001, Q1-004, Q1-005
- Mark Q1-002, Q1-003 as deferred with review dates

### From questions_bootstrap-consistency-open-questions.md:
Apply the Q-BC decisions from earlier in this conversation.

## Execution Order

1. Phase 4 (stale artifacts) - fast, no dependencies
2. Phase 1 (broken references) - fixes navigation
3. Phase 2 (naming) - fixes consistency
4. Phase 7 (answer questions) - unblocks everything else
5. Phase 5 (bootstrap reconciliation) - largest task, depends on naming decisions
6. Phase 3 (strategy domain) - small, depends on bootstrap reconciliation
7. Phase 6 (README) - last, reflects final state

## Estimated Effort

Phases 1-4, 6-7: 
Phase 5: medium, needs careful comparison of four paths.  