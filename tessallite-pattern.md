The Tessallite Pattern: What Actually Works in the Mess of LLM Coding Frameworks We Have Today

I have spent two years trying to build a real product with LLMs. Not a demo. Not a weekend prototype. A working data intelligence platform that sits between large-scale data sources and end-user tools such as Excel, BI platforms, and AI conversational agents. Tessallite spans hundreds of features including automated data discovery, semantic modelling, query acceleration, automated aggregation and caching, applied governance, business glossaries, persona-based access control, hierarchy management, and dialect translation across BigQuery, Databricks, and Spark. The solution operates across SQL, DAX, MDX, XMLA, JDBC SQL, Excel integration, and conversational AI. Two thousand source files. Five hundred files of documentation. The product is at tessallite.io. The repo is at github.com/M-O-Othman/tessallite (public).

Along the way I tried most of the popular frameworks. Spec Kit. Kiro. OpenSpec. BMAD. AB Method. CrewAI. AutoGen. Claude Flow. AgentOS. LangGraph swarms. Ralph Loop. SprintCore. GSD. Hermes. The "wear three hats" prompt trick. The "spawn five agents and let them collaborate" trick. The "just vibe and accept the diff" non-trick.

None of them got me past a certain complexity ceiling. Each one broke at a different point. This article is the field report. What each framework does, where it breaks, and what I ended up doing instead. Then I name the pattern, because it has earned one.

This is going to be long. If you only want the punchline: the bottleneck in LLM coding is verification, not generation, and every framework I tried was solving the wrong half of the problem.

Part one: a tour of the frameworks

The frameworks competing for your attention sort into five clusters. Each cluster solves something real. Each cluster has a structural failure mode that shows up at scale.

Cluster one: spec-driven development

GitHub Spec Kit, AWS Kiro, OpenSpec, BMAD Method.

These are the most serious frameworks in the category. Spec Kit treats specifications as the primary artefact and generates implementation through commands like /specify, /plan, and /tasks (github.github.com/spec-kit). Kiro structures features into a three-phase flow of requirements, design, and implementation tasks, with steering files that preserve workspace knowledge across sessions (kiro.dev/docs/specs/feature-specs). OpenSpec pushes humans and AI to agree on proposals, specs, design, and tasks before code is written (openspec.pro). BMAD goes further with role-based planning agents (Analyst, Product Manager, Architect, Scrum Master, Developer, QA) that produce PRDs and stories before any code is written, and treats documentation as the primary source of truth with code as a derivative artefact (docs.bmad-method.org).

What they get right. Upfront ambiguity is the first failure mode of LLM coding. These frameworks force you to handle it before generation begins. That alone moves you out of the bottom quartile of LLM coding outcomes. Spec Kit at 71,000 GitHub stars is not popular by accident. It works for greenfield projects up to a meaningful complexity threshold.

Where they break. Ambiguity does not all live at the top of the project. New ambiguity appears the moment you write down a database schema, a JSON contract, or a validation rule. None of these frameworks have a forced surfacing mechanism for what the model does not know at the next level of detail. You ship a clean spec, the model starts implementing, and by phase three the code has drifted from the spec because the spec did not survive contact with the schemas. Spec Kit's /speckit.analyze checks spec consistency. Kiro has approval gates between phases. None of them runs an adversarial implementation audit that asks "is the code I just wrote consistent with the spec, or did I quietly invent a different interpretation while implementing?" The drift problem is invisible to them.

BMAD has a sharper version of the same problem. Its strength is the upfront planning intensity. Its weakness is that twelve role-playing agents producing PRDs and architecture documents will not catch their own collective blind spots, because they are all instances of the same underlying model. The role labels make the planning legible. They do not make it correct.

This is the part of the LLM coding genre I have the strongest opinion on. You have seen the ads. The TikTok and LinkedIn promo videos with the dopamine cuts and the swelling music. "Watch as a thousand specialised AI agents review your code in parallel." The architect agent hands the diff to the security agent who hands it to the QA agent who hands it to the senior architect agent who blesses the merge. It looks impressive. It is theatre. The agents are not specialists. They are the same model, called multiple times, with different system prompts. The pattern produces output that looks reviewed without being reviewed, which is worse than not reviewing at all because it manufactures false confidence. Every framework in this cluster, and most frameworks in cluster two, lean on this fallacy. Engineers should call it what it is.

Cluster two: multi-agent orchestration

CrewAI, AutoGen (AG2), LangGraph, Claude Flow.

These frameworks coordinate multiple agents working concurrently. CrewAI manages role-based teams of agents that mimic human department structures and distinguishes between structured flows and autonomous crews (docs.crewai.com). AutoGen enables collaborative conversational workflows between agents. LangGraph builds durable, stateful agent workflows with persistence and human-in-the-loop checkpoints (docs.langchain.com/oss/javascript/langgraph). Claude Flow extends this into enterprise-scale swarms.

What they get right. Stateful workflows with persistence are genuinely useful. LangGraph in particular is solid infrastructure when you need long-running agent processes that survive interruption. CrewAI's flow concept is reasonable for sequential agent pipelines.

Where they break. Parallelism in software development is dangerous unless ownership is unambiguous. When five agents work concurrently on overlapping artefacts, they produce coordination tax that exceeds the parallelism speedup. They contradict each other. They edit the same files. They produce specs that disagree at the boundaries. You end up needing a human to reconcile the swarm output, which means you have replaced "write the code" with "referee the agents," and the referee job is harder than the original. Orchestration is not architecture. A graph can coordinate steps. It cannot decide which business rule is authoritative.

Worse, these frameworks inherit the hat-trick fallacy. An "architect agent" is not an architect. It is an LLM with the word "architect" in its system prompt. Same model, same training data, same blind spots. The role labels make the swarm legible. They do not produce architectural judgment.

Cluster three: role-based and context layering

GSD, Hermes, AgentOS, AB Method.

GSD is execution-focused with role-based prompts. Hermes structures reasoning across labour-divided agents. AgentOS provides Standard, Product, and Specs layers to give agents contextual awareness. AB Method focuses on missions executed by specialised subagents.

What they get right. Layered context is a real technique. Separating standing project rules from per-feature context from session-level state matches how humans work in complex codebases, and it matches what RAG systems do well.

Where they break. The layering is necessary but not sufficient. These frameworks lean heavily on the assumption that a well-prompted agent in a well-layered context will produce well-aligned output. That assumption is wrong at scale. The model still hallucinates cross-references between modules. The model still invents fields that do not exist. The model still claims a phase is complete when half of it is unwired. Context engineering reduces these failures. It does not eliminate them, and the frameworks that rely on context as the primary control mechanism have nothing left when context engineering is not enough.

Cluster four: tooling and infrastructure

Claude Task Master, Better Agents, Ralph Loop, SprintCore.

These are not methodologies. They are infrastructure. Task Master manages task state across sessions. Better Agents establishes production-grade standards for agent behaviour. Ralph Loop maintains context across long sessions. SprintCore manages full-cycle sprint artefacts.

What they get right. Useful primitives. Task state management is a real problem. Context preservation across sessions is a real problem.

Where they break. Treating these as substitutes for a delivery methodology is a category error. They are tools you use inside a methodology. They do not constitute one. A team using Task Master without a delivery pattern around it is using a fancy ticket tracker.

Cluster five: vibe coding

The absence of methodology. Karpathy's original framing was honest about that. A randomized controlled trial in 2025 found experienced open-source developers using AI tools this way took 19 percent longer than coding manually, the opposite of what they expected. It works for scripts. It does not work for systems. Anthropic's own Claude Code best-practices guidance (code.claude.com/docs/en/best-practices) emphasises managing context aggressively, using clean sessions, providing verification methods, and using subagents for investigation rather than uncontrolled implementation. That is a tacit admission that even with the most capable coding model, vibe coding does not survive complexity.

The shared blind spot

Look across all five clusters and the same hole opens up. Every framework optimises generation. Spec Kit optimises spec generation. CrewAI optimises agent generation. AgentOS optimises context-aware generation. BMAD optimises role-played planning generation. None of them gates verification at the granularity where verification has to happen.

Generation is cheap. The model will produce a thousand lines while you make tea. Verification (that the code is correct, integrated, consistent with the spec, free of unwired stubs, and aligned with the rest of the system) is expensive. The frameworks added more structure to the cheap part. They added almost nothing to the expensive part.

That is why none of them shipped Tessallite for me, and why nothing publicly verifiable comparable in scale has shipped from teams using them either.

Part two: what I had to add

I am not claiming I invented a new paradigm. I want to be clear about this. Spec-first development exists. Question-led clarification exists. Human-in-the-loop approval exists. Phase-based delivery exists. LLM review exists. Tiered documentation exists. Test gates exist. CI enforcement exists. I tried all of them. I read the docs. I ran the experiments. I broke things and watched them stay broken until I changed something specific.

The pattern that finally worked is a configuration of these existing ideas, with four structural elements I did not find combined in any single framework. All four are about verification, because verification is where every other framework fails.

Structural element one: a two-level open-questions gate.

Every spec-driven framework does requirements clarification once, upfront. The Tessallite Pattern does it twice. First pass after high-level requirements, before any detailed spec. Second pass after the detailed spec is drafted, because writing down schemas, API contracts, validation rules, and dialect translations exposes a new layer of ambiguity that the high-level pass cannot see.

The model is forced to declare what it does not know at both levels. The architect answers. The spec only freezes after the second pass. This is the move that prevents the entire downstream cascade of plausible-but-wrong code, because the cascade starts with a single unsurfaced assumption and compounds.

In the Tessallite repo, both passes live in `docs/questions/` as numbered files, one per feature. The file is a gate. Planning is blocked until the user answers, and follow-up questions go into the same file rather than being asked verbally.

I did not arrive at this from theory. I added the second pass after watching specs that survived the first pass produce code that contradicted itself by phase three. The contradiction always traced back to an assumption the model made when writing the schemas, which the spec writing pass had not been gated to surface.

Structural element two: mandatory adversarial review at every phase boundary.

Not a code review by the writing agent. Not a generic linter. A second LLM, fresh context, with an explicit "you are not the author of this code" prompt. Its job is to find what is broken, fragile, dead, overcomplicated, or missing. It is told to cross-reference findings against existing known-issues files to avoid duplicate findings. It produces a report with file paths, line numbers, severity, and recommended fixes.

Then the architect reviews the auditor's report alongside the diff and the test coverage. Then the architect runs the tests. Then the phase closes.

Findings are logged to `docs/execution/execution_issue-registry.md` as numbered entries. Every bug gets a short description, the affected file, and a status. Bugs are never dismissed as pre-existing or unrelated. Band-aid fixes are not acceptable. Root cause is found and fixed.

Spec Kit, Kiro, OpenSpec, and BMAD all have spec-level review. None of them runs an adversarial implementation audit at every phase boundary, with the auditor explicitly told it is not the author. The Tessallite Pattern does, because every time I skipped it, something broke later.

Structural element three: session continuity infrastructure.

The first two elements gate verification within a feature. The third element gates continuity across sessions, because the model has no memory of yesterday and the architect cannot reload the full context every morning.

Two components.

The first component is a routine layer. Skills and templates that force the model to do specific housekeeping at session boundaries. Produce a session handout at the end. Read the previous handout at the start. Generate a review checklist that confirms every planned action was implemented. Verify no planned action was silently skipped. Commit with a structured message. None of this is glamorous. All of it is mechanical. The point of mechanical hooks is that they happen whether the model feels like it or not.

Session handouts live in `work/sessions/` and follow a fixed structure: Project, Session Goal, What Was Done, What Was Tried and Failed, Current State, Blockers, Next Steps, Key Files. The next session begins by reading the most recent handout before any new work starts.

The second component is a persistent journal. Append-only. One dated entry per significant work session. The entry covers what was attempted, what was completed, what was deferred, what broke, what surprised the architect. The journal is the only artefact in the pattern that captures the arc across sessions, as opposed to the state of a single session.

The journal lives at `docs/execution/execution_release-history.md`. Each entry has a date heading, commit hashes, and one to three paragraphs of prose. Entries are written in the tone of a 17th-century English ship captain's logbook. Measured, factual, understated. The voice is a deliberate technical choice, not a flourish. Format-locked dry technical journals get skimmed and forgotten. A constrained voice forces compression because the format will not tolerate filler, and makes entries memorable enough that you read them back. The captain's log voice in particular makes you write "encountered fog at the dialect translator, becalmed for two hours, course corrected by reverting commit 3f4a" instead of "had some issues with the dialect translator, eventually fixed it." The first entry is useful three weeks later. The second is forgotten by the next morning. Pick whatever voice you like. War correspondent. Field naturalist. Trial-court stenographer. The voice does not matter. The compression and memorability function does.

I added this element after losing two days because I could not reconstruct what we had decided in a session three weeks earlier. The conversation export was useless. The handouts had been generated but were terse. The commit messages were accurate but stripped of reasoning. The journal closes that gap.

The honest weakness of this element: nothing external enforces it. If the model skips the handout, the next session is degraded silently. The first two structural elements have external gates (the architect answers questions, the auditor runs after every phase). This one relies on routine adherence and architect vigilance. It is the weakest of the three. It is also the cheapest to add and the highest yield per unit of effort, because the alternative is silently losing context every week.

Structural element four: tiered documentation governance with CI enforcement.

The first three elements assume the documentation is trustworthy. This element is what makes that assumption hold. Without it, the documentation becomes a museum within a month. Files contradict each other, folders accumulate stale work, and the model starts retrieving outdated context from artefacts nobody has updated since the feature shipped. The cache decays. The first three elements decay with it.

The element has three components: a tiered structure, filing discipline, and a CI guard that fails the build when discipline lapses.

The tiered structure is a router pattern. Three levels.

L0 is `docs/_INDEX.md`. The router. Lists domain folders only. The model reads this first when it does not know where a document lives.

L1 is `docs/<domain>/_INDEX.md`. One per folder. Contains a short TL;DR of the domain's current state and a grouped list of every file in that folder. Often the L1 summary is enough on its own. The model may not need to open the L2 file at all.

L2 is `docs/<domain>/<domain>_<name>.md`. The actual document. Every L2 file opens with a 3 to 5 line summary: what it is, its status (draft, active, or closed), and the date of the last meaningful update.

The reading strategy is a cache hierarchy. The model follows the shortest path. If it knows the file path, it opens the file directly. If it knows the domain but not the file, it reads the L1 index. If it knows nothing, it starts at L0, picks the domain, then reads L1. This avoids loading dozens of files to find one answer, and matches how Anthropic's Claude Code best-practices guidance describes effective context management (code.claude.com/docs/en/best-practices). Context windows fill quickly. Performance degrades as context gets cluttered. The tiered router lets the model retrieve the right level of truth without flooding the window.

The domain folders are scoped by purpose. `execution/` holds action plans, sprint work, in-flight bugs, and continuous registries. `questions/` holds the open-questions gates. `architecture/` holds decisions, schemas, specs, and data flow diagrams. `strategy/` holds the roadmap, competitive analysis, and positioning documents. `guides/` holds setup runbooks, API references, configuration catalogues, and templates. `temporary/` holds web-fetch dumps and exploratory research that is short-lived. `archive/` holds closed or superseded documents.

File naming is locked. Lowercase, hyphens for word breaks, no spaces, no brackets, no capitals. Pattern: `<domain>_<descriptive-name>.md`. Archived files get a suffix like `__superseded` or `__duplicate` so the reason for archival is visible without opening the file.

Filing discipline keeps the indexes synchronised with reality. When a file is created, an entry is added to the domain's L1 index immediately, under the right group heading. If the file changes the domain's overall state, the TL;DR is updated. When a file is edited, the L1 entry is touched only if the file's purpose changed. Routine edits do not require L1 updates. When a file is archived, the L1 entry is removed from the source domain and added to `archive/_INDEX.md` under the appropriate reason heading. If an L1 entry materially misrepresents the L2 file, the L1 entry is fixed before any other work continues.

The CI guard is the part most documentation systems lack. `scripts/check-docs-index.sh` fails the build if any `docs/<domain>/*.md` file is missing from its folder's `_INDEX.md`. Run locally before committing. Run in CI on every push. The guard turns filing discipline from a habit into a contract. The build does not pass until the indexes match the files. This is the move that makes the cache trustworthy in a way no framework I tried provides. Documentation drift becomes an instant build failure rather than a slow rot.

I added this element after watching the documentation cache degrade twice in production projects. The first time was a Bormagi project where stale specs caused the model to implement a deprecated API contract because the L1 index still pointed to it. The second time was earlier in Tessallite when an archived feature spec stayed in its original folder for three weeks and was retrieved as if it were active. After the second incident I added the CI guard. The cache has not drifted since.

These four structural elements, combined with the existing components (spec-first, phased delivery, test gates, format-locked documentation), are what makes the pattern hold at two thousand files. None of them is novel individually. The configuration is.

Part three: the pattern, end to end

This section walks the full feature lifecycle and names every document type produced at each stage. The article is intentionally specific about paths and document types. Reproducing the discipline matters more than reproducing the philosophy.

Stage one. High-level requirements conversation.

The architect describes the feature in business terms. The model produces a short requirements document covering scope, primary use cases, key actors, external integration points. No code. No detailed implementation. Two to five pages.

Output: a draft requirements document, typically filed under `docs/architecture/` with the status `draft`.

Stage two. First open-questions pass.

The model lists every assumption it would otherwise paper over. Ambiguous data flows. Undefined edge cases. Missing constraint definitions. Dialect choices. Validation rules. Error handling strategies. The architect answers each question. The model does not guess. This inverts the LLM's training to fill gaps, and is the single highest-leverage move in the pattern.

Output: an open-questions file in `docs/questions/`, with the status `pending` until answered. Planning is blocked until the file is closed.

Stage three. Design specification.

With the questions answered, the model produces a design spec. This is the locked-in design. Architecture, components, data flow, trade-offs, the chosen approach. Once approved, it becomes the contract the implementation plan implements.

For Tessallite features the spec runs thirty to eighty pages. Database schemas with column types and constraints. Full API request and response contracts in JSON. Validation rules with exact error messages and HTTP codes. Query router integration logic. Dialect translation rules. Complete XMLA DISCOVER response schemas. MDX and DAX query patterns. Cross-table join path resolution with generated SQL examples.

The architect reviews the spec. A second open-questions pass follows at the new level of detail. Edge cases in cardinality. Conflicts between two existing features. Validation rule ordering. The architect answers. The spec is updated. Only then does the spec freeze.

Output: a design spec under `docs/superpowers/specs/`, status `active`. Often accompanied by an architecture decision document under `docs/architecture/` that captures the chosen approach, the alternatives considered, and the rationale.

Stage four. Implementation plan.

The frozen spec converts into a step-by-step task list with exact file paths, code blocks, test commands, and expected outcomes. Bite-sized tasks. Each step is one action that takes two to five minutes to execute. The plan is executed sequentially. Each task is marked complete as it finishes.

For larger features the plan is split into phases with dependency markers. A typical Tessallite feature splits into five to ten phases. Each phase has a defined exit condition: working code, passing tests, updated documentation, no unwired modules, no incomplete stubs.

For a sprint or feature chunk that does not warrant a full spec-and-plan cycle, an action plan is produced instead. Lighter weight, scoped to a bounded piece of work. Read prior action plans before starting.

Output: an implementation plan under `docs/superpowers/plans/`, or an action plan under `docs/execution/`.

Stage five. Phase delivery and double review.

The model implements one phase of the plan. The adversarial auditor LLM runs with the "you are not the author" prompt and produces a findings report. The architect reviews the report, the diff, and the tests. Unit tests are written for the phase before the next phase begins. Findings are logged to the issue registry. New feature ideas surfaced during the phase go to a future-features file.

The phase only closes when code, tests, and documentation are aligned. No phase advances until the architect signs off.

Documentation updates are mandatory at this stage. The user guide at `docs/guides/guides_user-guide.md` is refreshed after every implementation job. Help pages under `tessallite/help/` are added or updated when UI features ship or change. Help pages are educational, not just step-by-step instructions: they teach concepts, theory, when-to-use, best practices, pitfalls, and worked examples. Every page must appear in `index.html` and have prev/home/next navigation links. UX changes require refreshed screenshots.

Output: code commits, test files, an updated issue registry at `docs/execution/execution_issue-registry.md`, future-features entries, and refreshed user-facing documentation.

Stage six. Session close.

Before any session ends, the model produces a handout summarising what was attempted, what completed, what deferred. The model verifies the review checklist, confirming no planned action was silently skipped. The architect commits with a structured message. The model appends a dated entry to the persistent journal in the captain's log voice. The next session starts by reading the previous handout and the latest journal entries before any new work begins.

Output: a session handout at `work/sessions/<date>.md` and a new entry in `docs/execution/execution_release-history.md`.

The full feature workflow

Open questions to design spec to implementation plan to execution to release history. Five canonical document stages, each with its own folder, each with its own gating rules.

Not every piece of work requires all five stages. A small bug fix skips questions, spec, and plan. It goes straight to execution and a journal entry. A large new subsystem uses all five and accumulates dozens of files across the tiered structure.

Continuous artefacts run alongside the stages. The issue registry is updated whenever a bug is identified. The future-features file logs out-of-scope ideas as they surface. Architecture decisions are written before any critical architectural choice and reviewed before work proceeds. Temporary research goes into `docs/temporary/` and is archived or deleted once the work it supports is done.

Then the loop continues. Next phase. Same gates.

Part four: where the Tessallite Pattern is superior, framework by framework

Versus Spec Kit and OpenSpec. Same upfront discipline. Plus a second open-questions pass after the detailed spec, which Spec Kit and OpenSpec do not have. Plus per-phase adversarial audit, which neither has. Plus session continuity infrastructure, which neither addresses. Plus a tiered documentation router with CI enforcement, which neither provides. Result: drift between spec and code is caught at phase boundaries, context survives across sessions, and the documentation cache cannot decay silently.

Versus Kiro. Same three-phase structure (requirements, design, tasks). Plus the four structural elements above. Kiro's steering files preserve workspace knowledge but do not capture session arcs and have no enforcement of index consistency. Result: feature-level coherence at scale, plus an audit trail of how the project evolved, plus a documentation system that fails the build when filing breaks.

Versus BMAD. BMAD's docs-as-source-of-truth philosophy is right. The role-based planning team is theatre. The Tessallite Pattern keeps the documentation discipline, drops the role play, adds the adversarial implementation audit that BMAD's QA agent cannot provide because it is the same model that wrote the code, adds the persistent journal, and adds the L0/L1/L2 router with CI enforcement. BMAD treats documentation as authoritative but does not enforce that the index reflects reality.

Versus CrewAI, AutoGen, Claude Flow. The Tessallite Pattern uses sequential agents with clear ownership, not concurrent swarms. The only multi-agent move is the adversarial reviewer, which runs after implementation, not during. Result: no artefact conflicts, no coordination tax, no referee work.

Versus AgentOS, AB Method. Comparable context layering. Plus the verification gates. Plus session continuity. Plus CI-enforced documentation governance. Context layering alone is not enough.

Versus LangGraph, Task Master, Ralph Loop. These are tools the Tessallite Pattern can use internally. LangGraph for durable execution. Task Master for task state. Ralph Loop for context preservation. They are infrastructure, not competitors. None of them substitutes for the journal or the tiered router, because none of them captures reasoning and surprise alongside state, and none of them enforces filing discipline.

Versus vibe coding. No comparison. Vibe coding fails at the second feature. The Tessallite Pattern shipped two thousand files.

Part five: the honest weaknesses

The Tessallite Pattern requires a strong solution architect. Someone who can answer open-questions documents quickly and decisively. Someone who can review phase output rigorously enough to catch unwired code, drift, and field-name mismatches. If your architect is slow or imprecise, the pattern stalls. The frameworks I criticised do not name this dependency. I am naming it.

The pattern is heavier than vibe coding. Two open-questions passes, double review at every phase, format-locked documentation, CI enforcement of index consistency. For a fifty-line script this is overhead theatre. For a fifty-thousand-line platform, vibe coding is malpractice. Choose the right tool for the size of the system.

The fourth element has its own startup cost. Setting up the tiered router, writing the L1 indexes for existing folders, and adding the CI guard takes a day or two on a project that did not start with the pattern. Worth it on anything past a few hundred files. Likely not worth it on a single-feature prototype.

I have shipped Tessallite using this pattern. I have not run a controlled comparison against Spec Kit or BMAD on the same project. The pattern works for me, on the kinds of systems I build, with me as the architect. Whether it generalises to teams with weaker architects, or to domains with less precedent than BI tooling, is open. I think the structural elements (two-level open questions, per-phase adversarial review, session continuity infrastructure, tiered documentation governance) are robust. The exact configuration around them is tunable.

Part six: what I want you to take from this

If you are building a real product with LLMs, stop optimising generation and start gating verification. The frameworks promising to do the work for you are mostly selling better generation, which is not your problem. Your problem is that the model does not know when it is wrong, and the cost of the model being wrong compounds with every phase.

The four moves that consistently catch the wrongness are forced uncertainty surfacing at two levels of detail, adversarial review by an independent model at every phase boundary, session continuity infrastructure that captures the arc across sessions, and tiered documentation governance with CI enforcement that keeps the cache trustworthy. Everything else (the role labels, the swarm orchestration, the slash commands, the layered agent contexts) is decoration. Useful sometimes. Not load-bearing.

Name your gates. Run your gates. Trust your model less than the documentation suggests. Make the build fail when the documentation lies.

That is the pattern. It is called the Tessallite Pattern because it emerged from building Tessallite, and because origin-anchored names are easier to argue about than acronyms. Tessallite is at github.com/M-O-Othman/tessallite if you want to see the system that produced it.

Try it. Break it. Tell me where it failed. That is how patterns earn their names.
