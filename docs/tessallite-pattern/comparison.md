# Framework Comparison

Status: active
Last meaningful update: 2026-05-09

This document explains why the Tessallite Pattern exists alongside other LLM
coding frameworks. It summarizes the critique from the source article and turns
it into a practical comparison for teams deciding whether this kit is worth the
extra process.

## Summary

Most LLM coding frameworks improve generation. The Tessallite Pattern improves
verification.

That distinction matters because generation is no longer the expensive part of
AI-assisted software work. A capable model can draft specs, code, tests, and
documentation quickly. The hard part is proving that the generated output is
correct, integrated, consistent with contracts, current with the documentation,
and not built on a hidden assumption.

The Tessallite Pattern is strongest when:

- the system has many files or modules
- documentation is reused as LLM working context
- schema, API, or validation drift would be expensive
- work spans multiple sessions
- architecture decisions must remain defensible
- phase completion needs evidence, not generated confidence

## Comparison Table

| Framework Type | Examples | What It Gets Right | Where It Breaks At Scale | Tessallite Pattern Response |
| --- | --- | --- | --- | --- |
| Spec-driven development | Spec Kit, Kiro, OpenSpec, BMAD | Forces requirements and design discipline before coding. | Ambiguity reappears at schema, contract, and validation level after the first spec pass. Spec-code drift can remain invisible. | Adds a second open-questions gate after detailed design and adversarial review at every phase boundary. |
| Multi-agent orchestration | CrewAI, AutoGen, LangGraph swarms, Claude Flow | Useful for durable workflows, stateful execution, and parallel investigation. | Parallel agents create coordination tax when ownership overlaps. Role labels can simulate review without independent judgment. | Uses clear ownership and sequential phase delivery; the main multi-agent move is independent audit after implementation. |
| Role and context layering | AgentOS, AB Method, GSD, Hermes | Separates standing rules, project context, feature context, and session state. | Better context reduces errors but does not prove generated work is correct. | Keeps context layering, then adds explicit verification gates and issue tracking. |
| Tooling and task infrastructure | Task Master, Ralph Loop, SprintCore | Useful primitives for task state, long sessions, and workflow management. | Tools are not a delivery methodology by themselves. | Treats tooling as optional infrastructure inside a verification-first lifecycle. |
| Vibe coding | Unstructured prompt-and-accept workflows | Fast for scripts, experiments, and disposable prototypes. | Hidden assumptions compound. Session memory is lost. Tests and docs trail behind generated code. | Adds explicit questions, specs, plans, reviews, continuity, and docs governance. |

## Versus Spec-Driven Frameworks

Spec-driven tools are the closest relatives. They correctly identify that
upfront ambiguity is dangerous. Their weakness is that ambiguity does not only
exist upfront.

The detailed act of writing a schema, API response, permission rule, or
validation order exposes new questions. If those questions are not surfaced,
the implementation begins with hidden guesses. The Tessallite Pattern keeps the
spec-first discipline but adds a second open-questions pass after detailed
design, before planning freezes.

The second difference is implementation audit. A spec consistency check is not
the same as asking whether the actual code just written drifted from the spec.
The Tessallite Pattern makes the phase-boundary audit mandatory for non-trivial
work.

## Versus Multi-Agent Swarms

The pattern is not anti-agent. It is anti-ambiguous ownership.

Multiple agents can investigate in parallel when the tasks are independent.
They become expensive when they edit overlapping artefacts, produce conflicting
interpretations, or require a human to reconcile outputs that should never have
diverged.

The Tessallite Pattern uses a narrower multi-agent move: an independent reviewer
after implementation. The reviewer is valuable because it is not the author and
because its job is adversarial verification, not parallel generation.

## Versus Role-Playing Review

An "architect agent" and a "QA agent" using the same underlying model may make a
workflow easier to read, but role labels do not create independent judgment.
They can produce the appearance of review without the substance of review.

The pattern avoids relying on role theatre. It defines responsibilities,
artefacts, evidence, and gates. A review must produce findings, severity,
evidence, spec drift checks, test adequacy checks, documentation checks, and
notes about what the auditor tried to disprove.

## Versus Context-First Methods

Context engineering is necessary. It is not sufficient.

Layered instructions, domain docs, steering files, and task state all help the
model stay oriented. They do not prove that code is wired, tested, and
consistent with the latest design. The Tessallite Pattern treats documentation
as a working cache, then protects that cache with L0/L1/L2 routing and index
checks.

## When Another Approach Is Enough

Use a lighter method when:

- the work is a throwaway script
- the code will not be maintained
- there is no public contract
- there is no meaningful session continuity problem
- a wrong assumption has low cost

The Tessallite Pattern is not meant to make small work feel formal. It is meant
to stop large work from becoming unverifiable.

## Decision Guide

Ask these questions:

1. Would a hidden schema or API assumption be expensive later?
2. Will a future LLM session read today documentation as context?
3. Does the feature need more than one working session?
4. Are there multiple modules, users, permissions, or integration points?
5. Would "the model says it is done" be insufficient evidence?

If the answer is yes to several of these, use the Tessallite Pattern or a
deliberate subset of it.

