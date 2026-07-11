---
title: "Skills Verification in Agent Software Factories"
description: "Why you can't build an operating system on skills you can't verify — the unsolved problem of proving shared agent skills drive the expected actions and tool-calls across heterogeneous consumers. Rhymes with dead-code detection and LSP-at-scale."
author: "Sushant Vema"
date_created: 2026-07-10T13:22:17
date: 2026-07-10T13:22:17
publish: true
tags:
  - "agents"
  - "evals"
  - "software factory"
---

everyone building an agent "software factory" right now has converged on the same primitive: the **skill**. a shareable module of knowledge and behavior — "here's how you scaffold a service," "here's how you author a spec," "here's how you file a bug" — that an agent loads and executes. skills are great. they're the cleanest way we've found to package reusable judgment so an agent (or a person) can pick it up and do the thing.

the problem starts the moment you try to build an *operating system* on top of them.

## the primitive is easy. the OS is not.

a skill is consumed by many clients, in many environments, with an implicit contract: *when you load this skill, you'll take certain actions and invoke certain tools.* "when you deploy, call `provision` before `ship`." "when you touch a system of record, validate the args first." the skill is a promise about behavior.

so here's the question nobody has a good answer to:

> **how do you verify that a skill actually works — across every consumer, in every environment — when "works" means the consumer took the right actions and called the right tools?**

not "does the skill file exist." not "did the agent say it used the skill." *did the expected behavior actually happen, everywhere it's supposed to, and if not, where and why.*

that's brutally hard, and it's hard in a way that rhymes with problems we already know are hard.

## it rhymes with dead code and LSP-at-scale

**dead-code detection.** a skill has branches — "if the risk tier is high, escalate." is that branch ever actually exercised? by which consumers? a skill can rot exactly like code: a path nobody hits, a tool call that silently stopped mattering three model upgrades ago. except with skills the "execution" is a non-deterministic agent in someone else's environment, so your usual coverage tooling sees nothing.

**LSP servers at scale.** an LSP answers "who references this symbol, what depends on it, is this call valid" across a codebase. skills verification wants the same graph — who consumes this skill, what tools does it actually invoke, does the invocation conform — except the "codebase" is a fleet of agents across repos, runtimes, and harnesses (Cursor, Claude Code, Codex, Pi, whatever), each with a different session and event model. there is no language server for behavior.

**coverage + observability of a consumer base you don't control.** the consumers are agents you didn't write, running in environments you can't fully see, producing outputs with no single correct answer. classic monitoring assumes deterministic services emitting structured signals. agents give you neither.

## why the obvious answers fail

- **"just add an eval."** evals are necessary and most people don't even have them. but an eval you run in your own sandbox tells you the skill works *for you, once.* it says nothing about the skill's behavior across the heterogeneous consumers actually loading it in production.
- **"trust the transcript."** the agent narrating "I used the deploy skill" is not evidence it invoked the right tools in the right order. self-report is the least trustworthy signal you have.
- **"grade the output."** for anything real there's no exact string to match, and the second you turn a score into a target, the agent (or the humans tuning it) optimize the score instead of the behavior. verifier gaming is the dominant failure mode of verifiable-reward systems — it's not a corner case, it's the base rate.

## what a real solution actually needs

before you can *evaluate* skill behavior, you need to be able to *see it* — attributably, across consumers, without the observer becoming a judge. concretely:

1. **an evidence model, not a log pile.** a canonical, reconstructable account of an attempt: which skill was loaded, which tools it actually called with what arguments, what it produced, tied by lineage to the operations that produced it. every causal claim carries a receipt or is explicitly a *gap* — never inferred.
2. **behavior-graded, not string-graded.** assert properties of what happened (did the write get gated, did the right tool fire, did it escalate on low confidence), with pinned graders and held-out cases the builder never sees.
3. **anti-Goodhart by construction.** the score is an *output* of real behavior, never a target. floors only move stronger. no self-scoring. trace volume and speed are not quality.
4. **cheap, non-invasive capture across harnesses.** if instrumenting a skill changes the behavior you're trying to measure, you've built a heisenberg problem, not a verifier.

get that substrate right and skills verification becomes tractable: you can mine which skills are dead, which branches never fire, which tool contracts get violated and by whom, where the papercuts cluster. get it wrong and your "operating system" is a pile of markdown nobody can prove works.

## why i care

i think this is one of the highest-leverage unsolved problems in applied AI right now, and it sits underneath the two things i'm most excited about: [[pareto-optimal-agents|pareto-optimal agents]] (getting frontier behavior out of cheaper / open models — which only works if your evals are real and ungameable) and the **software factory** (idea → shipped, verified change with a human only rubber-stamping — which only works if the skills the factory runs on are actually verified).

the model was never the moat. neither is the agent. the moat is the substrate underneath: the skills, and — the part almost nobody has solved — the machinery that proves they work.
