#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
bootstrap-tessallite-pattern.sh - install Tessallite Pattern scaffolding.

Usage:
  scripts/bootstrap-tessallite-pattern.sh [target-dir] [options]

Options:
  --greenfield       Create greenfield starter docs. Default.
  --existing         Use existing-codebase wording in starter docs.
  --name NAME        Project name to write into starter docs.
  --force            Overwrite existing generated files after backing them up.
  --help             Show this help.

The script is safe to re-run. Existing files are skipped unless --force is used.
When --force is used, overwritten files are copied to .tessallite-backup first.
EOF
}

TARGET_DIR=""
MODE="greenfield"
PROJECT_NAME=""
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --greenfield)
      MODE="greenfield"
      shift
      ;;
    --existing)
      MODE="existing"
      shift
      ;;
    --name)
      PROJECT_NAME="${2:-}"
      [[ -n "$PROJECT_NAME" ]] || { echo "ERROR: --name requires a value" >&2; exit 1; }
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    -*)
      echo "ERROR: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      if [[ -n "$TARGET_DIR" ]]; then
        echo "ERROR: target directory provided more than once" >&2
        exit 1
      fi
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

TARGET_DIR="${TARGET_DIR:-$(pwd)}"
mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
PROJECT_NAME="${PROJECT_NAME:-$(basename "$TARGET_DIR")}"
TODAY="$(date +%F)"
BACKUP_DIR="$TARGET_DIR/.tessallite-backup/$TODAY-$(date +%H%M%S)"
WRITTEN=0
SKIPPED=0
BACKED_UP=0

write_file() {
  local rel="$1"
  local path="$TARGET_DIR/$rel"
  mkdir -p "$(dirname "$path")"

  if [[ -e "$path" && "$FORCE" -ne 1 ]]; then
    echo "skip  $rel"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  if [[ -e "$path" && "$FORCE" -eq 1 ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp "$path" "$BACKUP_DIR/$rel"
    BACKED_UP=$((BACKED_UP + 1))
  fi

  cat > "$path"
  echo "write $rel"
  WRITTEN=$((WRITTEN + 1))
}

append_memory_if_needed() {
  local path="$TARGET_DIR/AGENTS.md"
  if [[ -f "$path" ]] && grep -Fq "Tessallite Pattern Working Rules" "$path"; then
    echo "skip  AGENTS.md"
    SKIPPED=$((SKIPPED + 1))
    return
  fi

  mkdir -p "$(dirname "$path")"
  if [[ -f "$path" ]]; then
    cat >> "$path" <<'EOF'

---

EOF
  fi

  cat >> "$path" <<EOF
# Tessallite Pattern Working Rules

Status: active
Last meaningful update: $TODAY

This project uses the Tessallite Pattern for AI-assisted delivery.

## Core Rule

- Optimize for verification, not generation.
- Do not treat generated code, specs, tests, or docs as correct until they pass the relevant gate.
- If required information is missing, ask questions instead of guessing.

## Project Feedback Rules

- Convert tool-specific memories into assistant-neutral project rules.
- Keep short behavioral rules here.
- Keep long references, command recipes, credentials policy, and tool setup in indexed docs.
- Do not copy permission bypasses, model choices, plugin lists, local home-directory paths, or automatic publishing settings into project rules unless the architect explicitly approves them.
- When feedback rules conflict, prefer safety, verification, and explicit user approval over convenience automation.

## Documentation Routing

- Read docs/_INDEX.md first unless the exact document path is known.
- Use docs/<domain>/_INDEX.md to find domain documents.
- Treat active docs as current working truth, draft docs as provisional, and archived docs as historical.

## Delivery Gates

- Requirements before design.
- First open-questions pass before design.
- Design spec before second open-questions pass.
- Second open-questions pass before implementation planning.
- Phase implementation before adversarial review.
- Phase closure only after findings are fixed, accepted, or logged.

## Implementation

- Work one phase at a time.
- Preserve unrelated user changes.
- Prefer existing codebase patterns.
- Add or update tests for the risk introduced.
- Use commands from docs/execution/execution_command-registry.md.
- Log unresolved bugs, risks, missing wiring, and review findings in docs/execution/execution_issue-registry.md.
- Do not introduce new libraries, frameworks, packages, services, or tools without architect approval.

## Session Continuity

- At session start, read the latest relevant handout in work/sessions/ when needed.
- At session end or explicit handout request, create work/sessions/<date>.md.
- Append work/logs/project-journal.md after significant work, discoveries, or course changes.
EOF
  echo "write AGENTS.md"
  WRITTEN=$((WRITTEN + 1))
}

echo "==> Tessallite bootstrap"
echo "    target: $TARGET_DIR"
echo "    mode:   $MODE"
echo "    name:   $PROJECT_NAME"
echo ""

mkdir -p \
  "$TARGET_DIR/docs/architecture" \
  "$TARGET_DIR/docs/questions" \
  "$TARGET_DIR/docs/execution" \
  "$TARGET_DIR/docs/guides" \
  "$TARGET_DIR/docs/strategy" \
  "$TARGET_DIR/docs/archive" \
  "$TARGET_DIR/work/sessions" \
  "$TARGET_DIR/work/logs" \
  "$TARGET_DIR/scripts"

append_memory_if_needed

write_file "docs/_INDEX.md" <<EOF
# Documentation Index

Status: active
Last meaningful update: $TODAY

This is the L0 router for the project documentation set. Start here when you do
not know where a document belongs.

## Domains

| Domain | Purpose | Index |
| --- | --- | --- |
| Architecture | Current structure, design specs, decisions, runtime assumptions, and technical boundaries. | [docs/architecture/_INDEX.md](architecture/_INDEX.md) |
| Questions | Open-question gates, ambiguity, and decisions needed before design or implementation. | [docs/questions/_INDEX.md](questions/_INDEX.md) |
| Execution | Issue registry, command registry, phase plans, delivery evidence, and implementation tracking. | [docs/execution/_INDEX.md](execution/_INDEX.md) |
| Guides | Setup, developer, user, help, and runbook guidance. | [docs/guides/_INDEX.md](guides/_INDEX.md) |
| Strategy | Roadmap, positioning, product direction, and non-implementation strategy. | [docs/strategy/_INDEX.md](strategy/_INDEX.md) |
| Archive | Superseded, duplicate, or historical documents. | [docs/archive/_INDEX.md](archive/_INDEX.md) |

## Routing Rule

1. If you know the exact file, open it directly.
2. If you know the domain, read that domain's _INDEX.md.
3. If you know neither, start here.
EOF

write_file "docs/architecture/_INDEX.md" <<EOF
# Architecture Index

Status: active
Last meaningful update: $TODAY

This domain contains the current system map, design specs, decisions, and
technical boundaries for $PROJECT_NAME.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [architecture_project-overview.md](architecture_project-overview.md) | Starter system map and architecture orientation. | draft |

## Routing Notes

- Start with architecture_project-overview.md when orienting a new assistant.
- Add design specs and architecture decisions here as the project evolves.
EOF

write_file "docs/architecture/architecture_project-overview.md" <<EOF
# Project Overview

Status: draft
Last meaningful update: $TODAY

This document orients future sessions to $PROJECT_NAME.

## Summary

Project type:

Primary users:

Core workflows:

Current mode:

- $MODE bootstrap

## Main Entry Points

| Entry Point | Purpose |
| --- | --- |
| README.md | Public or project starting point. |
| docs/_INDEX.md | Documentation router. |
| AGENTS.md | Persistent assistant working rules. |

## Primary Modules

| Path | Role |
| --- | --- |
| <path> | <role> |

## Data Stores

| Store | Purpose | Notes |
| --- | --- | --- |
| <store> | <purpose> | <notes> |

## External Integrations

| Integration | Use | Notes |
| --- | --- | --- |
| <integration> | <use> | <notes> |

## Test And Verification Commands

See docs/execution/execution_command-registry.md.

## Known Risks And Unclear Areas

| Risk | Impact | Next Action |
| --- | --- | --- |
| Architecture not yet mapped in detail. | Assistants may guess module boundaries. | Fill this document before major implementation. |
EOF

write_file "docs/questions/_INDEX.md" <<EOF
# Questions Index

Status: active
Last meaningful update: $TODAY

This domain captures open questions and decision gates.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [questions_initial-project.md](questions_initial-project.md) | Initial bootstrap questions. | pending |

## Routing Notes

- Add feature-specific open-question files here before design work.
- Fold answers into the active master plan if the project uses one.
EOF

write_file "docs/questions/questions_initial-project.md" <<EOF
# Initial Project Questions

Status: pending
Last meaningful update: $TODAY

These questions define the first safe delivery path for $PROJECT_NAME.

## First Pass Questions

| ID | Question | Why It Matters | Owner | Answer | Status |
| --- | --- | --- | --- | --- | --- |
| Q1-001 | What product or system goal should the first delivery milestone serve? | Prevents implementation from optimizing the wrong outcome. | Architect | Pending. | pending |
| Q1-002 | Who are the primary users or operators? | Drives UX, permissions, terminology, and testing. | Architect | Pending. | pending |
| Q1-003 | What workflows are in scope for the first milestone? | Prevents accidental feature creep. | Architect | Pending. | pending |
| Q1-004 | What workflows are explicitly out of scope? | Keeps the plan reviewable. | Architect | Pending. | pending |
| Q1-005 | What stack, deployment target, and external systems are fixed constraints? | Prevents assistants from introducing new technology by default. | Architect | Pending. | pending |
| Q1-006 | What commands are approved for tests, build, generated assets, and deploy? | Prevents unsafe or wrong command execution. | Architect | Pending. | pending |

## Closure Rule

Do not create an implementation plan until blocking questions are answered,
deferred with owner and review date, or removed by narrowing scope.
EOF

write_file "docs/execution/_INDEX.md" <<EOF
# Execution Index

Status: active
Last meaningful update: $TODAY

This domain tracks implementation evidence, issue registry entries, command
discipline, plans, and delivery work.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [execution_issue-registry.md](execution_issue-registry.md) | Bugs, review findings, risks, and unresolved execution issues. | active |
| [execution_command-registry.md](execution_command-registry.md) | Approved commands and wrappers for verification, generated assets, deploy, and publish. | active |
| [execution_bootstrap-report.md](execution_bootstrap-report.md) | Record of this Tessallite bootstrap run. | active |
EOF

write_file "docs/execution/execution_issue-registry.md" <<EOF
# Execution Issue Registry

Status: active
Last meaningful update: $TODAY

This registry tracks unresolved bugs, execution failures, accepted risks, and
review findings.

## Open Issues

| ID | Date | Severity | Status | Owner | Source | Affected Files | Summary | Next Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EXEC-001 | $TODAY | low | open | Architect | Bootstrap | docs/architecture/architecture_project-overview.md | Architecture overview still needs project-specific details. | Fill in modules, data stores, integrations, and commands before major feature work. |

## Closed Issues

| ID | Date Closed | Resolution | Notes |
| --- | --- | --- | --- |
EOF

write_file "docs/execution/execution_command-registry.md" <<EOF
# Command Registry

Status: active
Last meaningful update: $TODAY

Use this registry for approved commands and wrappers. Assistants should use
these commands instead of inventing bare commands.

## Command Policy

- Use the commands in this registry.
- Prefer project wrappers over bare tool commands.
- Do not run destructive, publishing, deployment, or production-affecting
  commands without explicit approval.
- Add missing commands here before using them as phase gates.

## Verification Commands

| Purpose | Command | When To Run | Notes |
| --- | --- | --- | --- |
| Docs index check | \`bash scripts/check-docs-index.sh\` | Before committing docs changes. | Created by bootstrap. |
| Targeted tests | \`<command>\` | During implementation after focused changes. | Fill in. |
| Full tests | \`<command>\` | At phase close, before commit when requested, or when risk requires. | Fill in. |
| Build | \`<command>\` | Before phase close when build output is affected. | Fill in. |
| Lint/typecheck | \`<command>\` | Before phase close when language/tooling supports it. | Fill in. |

## Generated Assets And Help

| Purpose | Command | Output | Notes |
| --- | --- | --- | --- |
| Screenshots | \`<command>\` | \`<path>\` | Use the shared screenshot helper if one exists. |
| Help build | \`<command>\` | \`<path>\` | Register new pages in the help index and navigation chain. |

## Deploy And Publish Wrappers

| Purpose | Approved Command | Commands Not To Run Bare | Notes |
| --- | --- | --- | --- |
| Deploy | \`<wrapper command>\` | \`<bare command>\` | Fill in if applicable. |
| Publish/push | \`<wrapper command>\` | \`<bare command>\` | Fill in if applicable. |
EOF

write_file "docs/execution/execution_bootstrap-report.md" <<EOF
# Bootstrap Report

Status: active
Last meaningful update: $TODAY

The Tessallite Pattern bootstrap script initialized $PROJECT_NAME.

## Mode

$MODE

## Installed

- persistent assistant rules in AGENTS.md
- L0 documentation router
- architecture, questions, execution, guides, strategy, and archive domains
- issue registry
- command registry
- project feedback rules guide
- project journal
- session directory
- docs index checker

## Next Actions

1. Fill docs/architecture/architecture_project-overview.md.
2. Answer docs/questions/questions_initial-project.md.
3. Fill docs/execution/execution_command-registry.md with real commands.
4. Add project-specific feedback rules to AGENTS.md or docs/guides/guides_project-feedback-rules.md.
5. Run scripts/check-docs-index.sh before committing docs changes.
EOF

write_file "docs/guides/_INDEX.md" <<EOF
# Guides Index

Status: active
Last meaningful update: $TODAY

This domain contains setup, developer, user, help, and runbook guidance.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [guides_developer-guide.md](guides_developer-guide.md) | Starter developer guide. | draft |
| [guides_project-feedback-rules.md](guides_project-feedback-rules.md) | Project-specific feedback skills and reference pointers. | draft |
EOF

write_file "docs/guides/guides_developer-guide.md" <<EOF
# Developer Guide

Status: draft
Last meaningful update: $TODAY

This guide explains how to work in $PROJECT_NAME.

## Start Of Session

1. Check git status.
2. Read AGENTS.md.
3. Read docs/_INDEX.md.
4. Read the latest relevant work/sessions handout when resuming work.
5. Check docs/execution/execution_command-registry.md before running commands.

## Before Implementation

- Requirements must be written.
- First-pass open questions must be answered or deferred.
- Design must be active for non-trivial work.
- Second-pass open questions must be answered before planning.
- Plans must name verification commands.

## Verification

Use docs/execution/execution_command-registry.md.

## Documentation

- Update docs when behavior, setup, architecture, contracts, UI, or commands change.
- Add new docs to the relevant _INDEX.md immediately.
- Run scripts/check-docs-index.sh before committing docs changes.
EOF

write_file "docs/guides/guides_project-feedback-rules.md" <<EOF
# Project Feedback Rules

Status: draft
Last meaningful update: $TODAY

Use this file for local skills that every assistant should remember.

## Behavioral Rules

| Rule | Why It Matters | Where To Find Detail |
| --- | --- | --- |
| Preserve test intent. | Prevents weakening tests to hide incorrect behavior. | <link> |
| Never dismiss failing tests or execution bugs. | Keeps defects visible. | docs/execution/execution_issue-registry.md |
| Use command wrappers. | Prevents unsafe or incomplete environment setup. | docs/execution/execution_command-registry.md |
| No new technology without approval. | Protects architecture and dependency budget. | <link> |

## Reference Pointers

| Reference | Purpose | Path |
| --- | --- | --- |
| UI guidelines | Product look and feel. | <path> |
| Help authoring | Help page and screenshot rules. | <path> |
| Deploy/publish workflow | Approved release commands. | docs/execution/execution_command-registry.md |
EOF

write_file "docs/strategy/_INDEX.md" <<EOF
# Strategy Index

Status: active
Last meaningful update: $TODAY

This domain contains roadmap, positioning, product direction, and
non-implementation strategy.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [strategy_product-brief.md](strategy_product-brief.md) | Starter product and delivery brief. | draft |
EOF

write_file "docs/strategy/strategy_product-brief.md" <<EOF
# Product Brief

Status: draft
Last meaningful update: $TODAY

This brief captures the product direction for $PROJECT_NAME.

## Goal

Pending.

## Users

Pending.

## First Milestone

Pending.

## Non-Goals

Pending.
EOF

write_file "docs/archive/_INDEX.md" <<EOF
# Archive Index

Status: active
Last meaningful update: $TODAY

This domain is reserved for superseded, duplicate, archived, or historical
documents that should no longer route current work.

## Active Archive Entries

No documents are archived yet.
EOF

write_file "work/logs/project-journal.md" <<EOF
# Project Journal

Status: active
Last meaningful update: $TODAY

This journal records significant work, discoveries, and course changes.

## $TODAY

The project was bootstrapped with the Tessallite Pattern in $MODE mode. The
first course is to complete the project overview, answer initial questions, and
register real verification commands before implementation begins.
EOF

write_file "work/sessions/.gitkeep" <<'EOF'
# Keeps the session handout directory in version control.
EOF

write_file "work/sessions/bootstrap-next-prompt.md" <<EOF
# Next Assistant Prompt

Status: active
Last meaningful update: $TODAY

Paste this into a coding assistant after bootstrap:

\`\`\`text
Read AGENTS.md, docs/_INDEX.md, docs/architecture/architecture_project-overview.md,
docs/questions/questions_initial-project.md, and
docs/execution/execution_command-registry.md.

Do not write application code yet.

First, report:
- what has already been bootstrapped
- which initial questions still block design
- which commands are missing from the command registry
- the smallest safe next step
\`\`\`
EOF

write_file "scripts/check-docs-index.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS_DIR="$ROOT_DIR/docs"

if [[ ! -d "$DOCS_DIR" ]]; then
  echo "docs directory not found: $DOCS_DIR" >&2
  exit 1
fi

failures=0

for domain_dir in "$DOCS_DIR"/*; do
  [[ -d "$domain_dir" ]] || continue

  domain_name="$(basename "$domain_dir")"
  index_file="$domain_dir/_INDEX.md"

  if [[ ! -f "$index_file" ]]; then
    echo "missing index: docs/$domain_name/_INDEX.md" >&2
    failures=$((failures + 1))
    continue
  fi

  while IFS= read -r -d '' doc_file; do
    file_name="$(basename "$doc_file")"
    [[ "$file_name" == "_INDEX.md" ]] && continue

    relative_path="${doc_file#"$domain_dir"/}"

    if ! grep -Fq "$relative_path" "$index_file"; then
      echo "missing index entry: docs/$domain_name/$relative_path is not listed in docs/$domain_name/_INDEX.md" >&2
      failures=$((failures + 1))
    fi
  done < <(find "$domain_dir" -type f -name "*.md" -print0)
done

while IFS= read -r -d '' nested_index; do
  nested_dir="$(dirname "$nested_index")"
  [[ "$nested_dir" == "$DOCS_DIR" ]] && continue
  [[ "$(dirname "$nested_dir")" == "$DOCS_DIR" ]] && continue

  display_index="${nested_index#"$ROOT_DIR"/}"

  while IFS= read -r -d '' doc_file; do
    file_name="$(basename "$doc_file")"
    [[ "$file_name" == "_INDEX.md" ]] && continue

    display_file="${doc_file#"$ROOT_DIR"/}"

    if ! grep -Fq "$file_name" "$nested_index"; then
      echo "missing nested index entry: $display_file is not listed in $display_index" >&2
      failures=$((failures + 1))
    fi
  done < <(find "$nested_dir" -maxdepth 1 -type f -name "*.md" -print0)
done < <(find "$DOCS_DIR" -mindepth 2 -type f -name "_INDEX.md" -print0)

if [[ "$failures" -gt 0 ]]; then
  echo "documentation index check failed with $failures issue(s)" >&2
  exit 1
fi

echo "documentation index check passed"
EOF

chmod +x "$TARGET_DIR/scripts/check-docs-index.sh"

echo ""
echo "==> Bootstrap complete"
echo "    written:   $WRITTEN"
echo "    skipped:   $SKIPPED"
echo "    backups:   $BACKED_UP"
if [[ "$BACKED_UP" -gt 0 ]]; then
  echo "    backup dir: $BACKUP_DIR"
fi
echo ""
echo "Next:"
echo "  cd \"$TARGET_DIR\""
echo "  bash scripts/check-docs-index.sh"
echo "  cat work/sessions/bootstrap-next-prompt.md"
