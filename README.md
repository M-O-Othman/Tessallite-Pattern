# Tessallite Pattern Framework Kit

This repository contains a practical framework kit derived from
[`tessallite-pattern.md`](tessallite-pattern.md).

The original article explains why many LLM coding frameworks fail at scale:
they optimize generation while under-investing in verification. This kit turns
that argument into reusable materials, artefacts, templates, prompts,
checklists, examples, and a lightweight documentation governance script.

## What This Kit Is For

Use the Tessallite Pattern when an AI-assisted software project has moved
beyond toy generation and needs durable delivery discipline:

- features span many files or modules
- specs can drift from implementation
- sessions continue across days or weeks
- documentation is part of the working context
- LLM output must be audited before it is trusted
- the architect must preserve decisions, surprises, and trade-offs

The pattern is intentionally heavier than casual AI coding. It is designed for
systems where wrong assumptions compound.

## Start Here

1. Read the framework index:
   [`docs/tessallite-pattern/_INDEX.md`](docs/tessallite-pattern/_INDEX.md)
2. Read the handbook:
   [`docs/tessallite-pattern/framework-handbook.md`](docs/tessallite-pattern/framework-handbook.md)
3. Use the lifecycle guide for real delivery:
   [`docs/tessallite-pattern/lifecycle-guide.md`](docs/tessallite-pattern/lifecycle-guide.md)
4. Copy the templates you need from:
   [`docs/tessallite-pattern/templates/`](docs/tessallite-pattern/templates/)
5. Run the documentation index guard when you adopt the tiered docs structure:
   `bash scripts/check-docs-index.sh`

## Core Idea

The Tessallite Pattern says that the bottleneck in LLM coding is verification,
not generation.

The four load-bearing elements are:

1. Two-level open-questions gate
2. Mandatory adversarial review at every phase boundary
3. Session continuity infrastructure
4. Tiered documentation governance with CI enforcement

Everything in this kit supports those four elements.

## Contents

- `framework-handbook.md`: the full operating model
- `lifecycle-guide.md`: end-to-end feature workflow
- `adoption-roadmap.md`: how to introduce the pattern gradually
- `governance-model.md`: ownership, gates, artefact rules, and failure modes
- `templates/`: fill-in artefacts for each stage
- `checklists/`: practical gates and maturity scorecards
- `prompts/`: reusable prompts for LLM-assisted work
- `examples/`: worked example of a feature moving through the pattern
- `training/`: workshop material and exercises
- `scripts/check-docs-index.sh`: lightweight index consistency guard

## Important Assumption

The pattern requires a responsible architect. The LLM can draft, implement,
audit, summarize, and route context, but it cannot own business judgment. The
architect answers ambiguity, approves gates, and decides when a phase is truly
closed.

