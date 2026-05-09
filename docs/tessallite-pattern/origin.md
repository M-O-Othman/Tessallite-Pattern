# Origin And Discovery Story

Status: active
Last meaningful update: 2026-05-09

This document captures the discovery arc behind the Tessallite Pattern. The
framework did not start as a clean methodology. It emerged from repeated
failures while building a large AI-assisted software system.

## Summary

The Tessallite Pattern came from trying to build a real data intelligence
platform with LLM assistance, not from designing a process in isolation.

The recurring lesson was that the model could generate faster than the project
could verify. The pattern's gates were added one by one in response to concrete
failure modes: hidden assumptions, spec-code drift, weak self-review, lost
session context, and stale documentation.

## The Starting Point

Early LLM-assisted delivery looked productive. The model could draft features,
plans, tests, and documentation at high speed. That speed created a false
signal. The visible output increased, but correctness did not increase at the
same rate.

The early failure pattern was consistent:

- requirements looked clear until a schema was written
- specs looked complete until implementation chose an unstated interpretation
- generated code looked wired until phase integration
- self-review sounded confident while missing obvious drift
- session history was available in chat but not usable as project memory
- documentation existed but became stale enough to mislead retrieval

The method changed when these failures were treated as structural, not
incidental.

## Discovery 1: One Question Pass Was Not Enough

The first improvement was requirements clarification. It helped, but did not
hold through detailed design.

The second layer of ambiguity appeared only after writing concrete details:

- field names
- data types
- nullability
- validation order
- API responses
- failure behavior
- dialect or compatibility rules

That produced the first structural element: two-level open questions. The first
pass catches product and workflow ambiguity. The second pass catches contract
and implementation ambiguity.

## Discovery 2: The Author Could Not Be The Only Reviewer

The next failure was review quality. The same context that wrote the code was
too willing to believe the code was complete.

The useful move was not a role label. It was independence and adversarial
framing. A fresh reviewer, human or LLM, had to inspect the phase as a critic:
what is broken, unwired, untested, overcomplicated, or inconsistent with the
spec?

That produced the second structural element: mandatory adversarial review at
phase boundaries.

## Discovery 3: Session Memory Had To Become An Artefact

Long-running work broke when chat history was treated as memory. A future
session could not reliably reconstruct:

- why a decision was made
- what had failed
- which files mattered
- what remained blocked
- which planned actions had been skipped

Session handouts solved the immediate continuity problem. Release history
solved the reasoning-history problem.

That produced the third structural element: session continuity infrastructure.

## Discovery 4: Documentation Needed Enforcement

Documentation initially looked like the solution to context loss. Then it
became another failure mode.

When docs drifted, the LLM retrieved stale context and used it as truth. An old
spec, missing index entry, or archived document left in the active path could
cause wrong implementation.

The fix was to treat documentation as a working cache:

- L0 routes to domains
- L1 summarizes and lists active files
- L2 holds the actual detail
- CI fails when active files are not indexed

That produced the fourth structural element: tiered documentation governance
with CI enforcement, in service of trustworthy context.

## What Survived Contact With Reality

The durable parts were not the decorative parts of AI coding frameworks. The
durable parts were:

- forced uncertainty surfacing
- phase-level evidence
- independent review
- issue tracking
- session handoff
- durable reasoning history
- documentation routing
- automated index checks

These are the pieces that kept working after the first impressive generated
draft was no longer enough.

## What The Pattern Does Not Claim

The pattern does not claim that every project needs the full lifecycle. It does
not claim that LLMs are bad at software work. It does not claim novelty for each
individual technique.

The claim is about configuration. The four structural elements work together to
catch the places where LLM-assisted delivery tends to go wrong at scale.

## Why The Repo Is More Clinical Than The Article

The source article is a field report. It explains the frustration, comparison,
and sequence of failures that led to the pattern.

This repository is a kit. It gives teams artefacts they can use without
re-reading the whole argument every time.

Both are needed:

- the article explains why the pattern exists
- the repo explains how to run it

