@echo off
setlocal

set "BOOTSTRAP_SELF=%~f0"
set "BOOTSTRAP_TMP=%TEMP%\bootstrap-tessallite-pattern-%RANDOM%-%RANDOM%.ps1"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$raw = Get-Content -Raw -LiteralPath $env:BOOTSTRAP_SELF; $payload = ($raw -split '# POWERSHELL_PAYLOAD', 2)[1]; Set-Content -LiteralPath $env:BOOTSTRAP_TMP -Value $payload -Encoding UTF8"
if errorlevel 1 exit /b %ERRORLEVEL%

powershell -NoProfile -ExecutionPolicy Bypass -File "%BOOTSTRAP_TMP%" %*
set "BOOTSTRAP_EXIT=%ERRORLEVEL%"
del "%BOOTSTRAP_TMP%" >nul 2>nul
exit /b %BOOTSTRAP_EXIT%

# POWERSHELL_PAYLOAD
param(
  [string]$TargetDir = (Get-Location).Path,
  [switch]$Greenfield,
  [switch]$Existing,
  [string]$Name = "",
  [switch]$Force,
  [switch]$Help
)

if ($Help) {
  @"
bootstrap-tessallite-pattern.bat - install Tessallite Pattern scaffolding.

Usage:
  scripts\bootstrap-tessallite-pattern.bat [target-dir] [options]

Options:
  -Greenfield       Create greenfield starter docs. Default.
  -Existing         Use existing-codebase wording in starter docs.
  -Name NAME        Project name to write into starter docs.
  -Force            Overwrite existing generated files after backing them up.
  -Help             Show this help.

The script is safe to re-run. Existing files are skipped unless -Force is used.
When -Force is used, overwritten files are copied to .tessallite-backup first.
"@
  exit 0
}

$ErrorActionPreference = "Stop"
$Mode = if ($Existing) { "existing" } else { "greenfield" }
$Target = [System.IO.Path]::GetFullPath($TargetDir)
New-Item -ItemType Directory -Force -Path $Target | Out-Null
$ProjectName = if ($Name) { $Name } else { Split-Path -Leaf $Target }
$Today = Get-Date -Format "yyyy-MM-dd"
$BackupDir = Join-Path $Target (".tessallite-backup\" + $Today + "-" + (Get-Date -Format "HHmmss"))
$script:Written = 0
$script:Skipped = 0
$script:BackedUp = 0

function Write-BootstrapFile {
  param(
    [string]$RelativePath,
    [string]$Content
  )

  $path = Join-Path $Target $RelativePath
  $dir = Split-Path -Parent $path
  New-Item -ItemType Directory -Force -Path $dir | Out-Null

  if ((Test-Path -LiteralPath $path) -and -not $Force) {
    Write-Host "skip  $RelativePath"
    $script:Skipped++
    return
  }

  if ((Test-Path -LiteralPath $path) -and $Force) {
    $backupPath = Join-Path $BackupDir $RelativePath
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $backupPath) | Out-Null
    Copy-Item -LiteralPath $path -Destination $backupPath -Force
    $script:BackedUp++
  }

  Set-Content -LiteralPath $path -Value $Content -Encoding UTF8
  Write-Host "write $RelativePath"
  $script:Written++
}

function Add-AgentMemory {
  $path = Join-Path $Target "AGENTS.md"
  if ((Test-Path -LiteralPath $path) -and ((Get-Content -Raw -LiteralPath $path) -like "*Tessallite Pattern Working Rules*")) {
    Write-Host "skip  AGENTS.md"
    $script:Skipped++
    return
  }

  $content = @"
# Tessallite Pattern Working Rules

Status: active
Last meaningful update: $Today

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
"@

  if (Test-Path -LiteralPath $path) {
    Add-Content -LiteralPath $path -Value "`r`n---`r`n`r`n$content" -Encoding UTF8
  } else {
    Set-Content -LiteralPath $path -Value $content -Encoding UTF8
  }
  Write-Host "write AGENTS.md"
  $script:Written++
}

Write-Host "==> Tessallite bootstrap"
Write-Host "    target: $Target"
Write-Host "    mode:   $Mode"
Write-Host "    name:   $ProjectName"
Write-Host ""

@(
  "docs\architecture",
  "docs\questions",
  "docs\execution",
  "docs\guides",
  "docs\strategy",
  "docs\archive",
  "work\sessions",
  "work\logs",
  "scripts"
) | ForEach-Object {
  New-Item -ItemType Directory -Force -Path (Join-Path $Target $_) | Out-Null
}

Add-AgentMemory

Write-BootstrapFile "docs\_INDEX.md" @"
# Documentation Index

Status: active
Last meaningful update: $Today

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
"@

Write-BootstrapFile "docs\architecture\_INDEX.md" @"
# Architecture Index

Status: active
Last meaningful update: $Today

This domain contains the current system map, design specs, decisions, and
technical boundaries for $ProjectName.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [architecture_project-overview.md](architecture_project-overview.md) | Starter system map and architecture orientation. | draft |

## Routing Notes

- Start with architecture_project-overview.md when orienting a new assistant.
- Add design specs and architecture decisions here as the project evolves.
"@

Write-BootstrapFile "docs\architecture\architecture_project-overview.md" @"
# Project Overview

Status: draft
Last meaningful update: $Today

This document orients future sessions to $ProjectName.

## Summary

Project type:

Primary users:

Core workflows:

Current mode:

- $Mode bootstrap

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
"@

Write-BootstrapFile "docs\questions\_INDEX.md" @"
# Questions Index

Status: active
Last meaningful update: $Today

This domain captures open questions and decision gates.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [questions_initial-project.md](questions_initial-project.md) | Initial bootstrap questions. | pending |
"@

Write-BootstrapFile "docs\questions\questions_initial-project.md" @"
# Initial Project Questions

Status: pending
Last meaningful update: $Today

These questions define the first safe delivery path for $ProjectName.

| ID | Question | Why It Matters | Owner | Answer | Status |
| --- | --- | --- | --- | --- | --- |
| Q1-001 | What goal should the first delivery milestone serve? | Prevents implementation from optimizing the wrong outcome. | Architect | Pending. | pending |
| Q1-002 | Who are the primary users or operators? | Drives UX, permissions, terminology, and testing. | Architect | Pending. | pending |
| Q1-003 | What workflows are in scope for the first milestone? | Prevents accidental feature creep. | Architect | Pending. | pending |
| Q1-004 | What workflows are explicitly out of scope? | Keeps the plan reviewable. | Architect | Pending. | pending |
| Q1-005 | What stack, deployment target, and external systems are fixed constraints? | Prevents assistants from introducing new technology by default. | Architect | Pending. | pending |
| Q1-006 | What commands are approved for tests, build, generated assets, and deploy? | Prevents unsafe or wrong command execution. | Architect | Pending. | pending |
"@

Write-BootstrapFile "docs\execution\_INDEX.md" @"
# Execution Index

Status: active
Last meaningful update: $Today

This domain tracks implementation evidence, issue registry entries, command
discipline, plans, and delivery work.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [execution_issue-registry.md](execution_issue-registry.md) | Bugs, review findings, risks, and unresolved execution issues. | active |
| [execution_command-registry.md](execution_command-registry.md) | Approved commands and wrappers for verification, generated assets, deploy, and publish. | active |
| [execution_bootstrap-report.md](execution_bootstrap-report.md) | Record of this Tessallite bootstrap run. | active |
"@

Write-BootstrapFile "docs\execution\execution_issue-registry.md" @"
# Execution Issue Registry

Status: active
Last meaningful update: $Today

This registry tracks unresolved bugs, execution failures, accepted risks, and
review findings.

## Open Issues

| ID | Date | Severity | Status | Owner | Source | Affected Files | Summary | Next Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EXEC-001 | $Today | low | open | Architect | Bootstrap | docs/architecture/architecture_project-overview.md | Architecture overview still needs project-specific details. | Fill in modules, data stores, integrations, and commands before major feature work. |
"@

Write-BootstrapFile "docs\execution\execution_command-registry.md" @"
# Command Registry

Status: active
Last meaningful update: $Today

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
| Docs index check | ``bash scripts/check-docs-index.sh`` | Before committing docs changes. | Created by bootstrap. |
| Targeted tests | ``<command>`` | During implementation after focused changes. | Fill in. |
| Full tests | ``<command>`` | At phase close, before commit when requested, or when risk requires. | Fill in. |
| Build | ``<command>`` | Before phase close when build output is affected. | Fill in. |
| Lint/typecheck | ``<command>`` | Before phase close when language/tooling supports it. | Fill in. |

## Generated Assets And Help

| Purpose | Command | Output | Notes |
| --- | --- | --- | --- |
| Screenshots | ``<command>`` | ``<path>`` | Use the shared screenshot helper if one exists. |
| Help build | ``<command>`` | ``<path>`` | Register new pages in the help index and navigation chain. |

## Data And Smoke Checks

| Purpose | Command | Environment | Notes |
| --- | --- | --- | --- |
| Seed/reset demo data | ``<command>`` | ``<environment>`` | Use only safe demo or local environments. |
| Smoke test | ``<command>`` | ``<environment>`` | Fill in. |

## Deploy And Publish Wrappers

| Purpose | Approved Command | Commands Not To Run Bare | Notes |
| --- | --- | --- | --- |
| Deploy | ``<wrapper command>`` | ``<bare command>`` | Fill in if applicable. |
| Publish/push | ``<wrapper command>`` | ``<bare command>`` | Fill in if applicable. |
"@

Write-BootstrapFile "docs\execution\execution_bootstrap-report.md" @"
# Bootstrap Report

Status: active
Last meaningful update: $Today

The Tessallite Pattern bootstrap script initialized $ProjectName.

## Mode

$Mode

## Next Actions

1. Fill docs/architecture/architecture_project-overview.md.
2. Answer docs/questions/questions_initial-project.md.
3. Fill docs/execution/execution_command-registry.md with real commands.
4. Add project-specific feedback rules to AGENTS.md or docs/guides/guides_project-feedback-rules.md.
5. Run scripts/check-docs-index.sh before committing docs changes.
"@

Write-BootstrapFile "docs\guides\_INDEX.md" @"
# Guides Index

Status: active
Last meaningful update: $Today

This domain contains setup, developer, user, help, and runbook guidance.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [guides_developer-guide.md](guides_developer-guide.md) | Starter developer guide. | draft |
| [guides_project-feedback-rules.md](guides_project-feedback-rules.md) | Project-specific feedback skills and reference pointers. | draft |
"@

Write-BootstrapFile "docs\guides\guides_developer-guide.md" @"
# Developer Guide

Status: draft
Last meaningful update: $Today

This guide explains how to work in $ProjectName.

## Start Of Session

1. Check git status.
2. Read AGENTS.md.
3. Read docs/_INDEX.md.
4. Check docs/execution/execution_command-registry.md before running commands.

## Verification

Use docs/execution/execution_command-registry.md.

## Before Implementation

- Requirements must be written.
- First-pass open questions must be answered or deferred.
- Design must be active for non-trivial work.
- Second-pass open questions must be answered before planning.
- Plans must name verification commands.

## Documentation

- Update docs when behavior, setup, architecture, contracts, UI, or commands change.
- Add new docs to the relevant _INDEX.md immediately.
- Run scripts/check-docs-index.sh before committing docs changes.
"@

Write-BootstrapFile "docs\guides\guides_project-feedback-rules.md" @"
# Project Feedback Rules

Status: draft
Last meaningful update: $Today

Use this file for local skills that every assistant should remember.

| Rule | Why It Matters | Where To Find Detail |
| --- | --- | --- |
| Preserve test intent. | Prevents weakening tests to hide incorrect behavior. | <link> |
| Never dismiss failing tests or execution bugs. | Keeps defects visible. | docs/execution/execution_issue-registry.md |
| Use command wrappers. | Prevents unsafe or incomplete environment setup. | docs/execution/execution_command-registry.md |
| No new technology without approval. | Protects architecture and dependency budget. | <link> |
"@

Write-BootstrapFile "docs\strategy\_INDEX.md" @"
# Strategy Index

Status: active
Last meaningful update: $Today

This domain contains roadmap, positioning, product direction, and
non-implementation strategy.

## Active Documents

| File | Purpose | Status |
| --- | --- | --- |
| [strategy_product-brief.md](strategy_product-brief.md) | Starter product and delivery brief. | draft |
"@

Write-BootstrapFile "docs\strategy\strategy_product-brief.md" @"
# Product Brief

Status: draft
Last meaningful update: $Today

This brief captures the product direction for $ProjectName.

## Goal

Pending.

## Users

Pending.

## First Milestone

Pending.

## Non-Goals

Pending.
"@

Write-BootstrapFile "docs\archive\_INDEX.md" @"
# Archive Index

Status: active
Last meaningful update: $Today

This domain is reserved for superseded, duplicate, archived, or historical
documents that should no longer route current work.

## Active Archive Entries

No documents are archived yet.
"@

Write-BootstrapFile "work\logs\project-journal.md" @"
# Project Journal

Status: active
Last meaningful update: $Today

This journal records significant work, discoveries, and course changes.

## $Today

The project was bootstrapped with the Tessallite Pattern in $Mode mode. The
first course is to complete the project overview, answer initial questions, and
register real verification commands before implementation begins.
"@

Write-BootstrapFile "work\sessions\.gitkeep" "# Keeps the session handout directory in version control."

Write-BootstrapFile "work\sessions\bootstrap-next-prompt.md" @"
# Next Assistant Prompt

Status: active
Last meaningful update: $Today

Paste this into a coding assistant after bootstrap:

````text
Read AGENTS.md, docs/_INDEX.md, docs/architecture/architecture_project-overview.md,
docs/questions/questions_initial-project.md, and
docs/execution/execution_command-registry.md.

Do not write application code yet.

First, report:
- what has already been bootstrapped
- which initial questions still block design
- which commands are missing from the command registry
- the smallest safe next step
````
"@

Write-BootstrapFile "scripts\check-docs-index.sh" @'
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

if [[ "$failures" -gt 0 ]]; then
  echo "documentation index check failed with $failures issue(s)" >&2
  exit 1
fi

echo "documentation index check passed"
'@

Write-Host ""
Write-Host "==> Bootstrap complete"
Write-Host "    written:   $script:Written"
Write-Host "    skipped:   $script:Skipped"
Write-Host "    backups:   $script:BackedUp"
if ($script:BackedUp -gt 0) {
  Write-Host "    backup dir: $BackupDir"
}
Write-Host ""
Write-Host "Next:"
Write-Host "  cd `"$Target`""
Write-Host "  bash scripts/check-docs-index.sh"
Write-Host "  type work\sessions\bootstrap-next-prompt.md"
