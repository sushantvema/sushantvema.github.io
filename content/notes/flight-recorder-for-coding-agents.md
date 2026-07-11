---
title: "A flight recorder for coding agents: why the recorder must never be the judge"
description: "Agent observability is a commodity in 2026. The real objective in a software factory is reducing unit cost and variance, which demands reliable unbiased statistics, and then compounding those into a loop you own. This is the build-log and the case for content-free, vendor-neutral evidence: pg_stat_statements for agent runs."
author: "Sushant Vema"
date_created: 2026-07-10T21:00:00
date: 2026-07-10T21:00:00
publish: true
tags:
  - "agents"
  - "evals"
  - "observability"
  - "software factory"
---

![[images/fdr.jpg|A flight data recorder, the "black box" that survives the crash and explains the flight. Photo via Wikimedia Commons.]]

*A flight data recorder, the "black box" that survives the crash and explains the flight. Photo via Wikimedia Commons.*

An agent opened a pull request last week. It passed CI, a human skimmed it, it merged. Seven days later it broke in production in a way the tests never covered. So you go to understand how the agent got there. Which files did it read before it committed to this approach? What did it try first and throw away? Did it call the tool that mattered, or reason its way around it? The diff is right in front of you and it explains almost nothing about the process that produced it. You have the destination and no flight path.

The reflex, industry-wide, is to reach for observability. Add a tracing SDK, get a dashboard, watch the agents. I think that reflex is wrong, or at least badly incomplete. The interesting problem sits one level down from "can I see what the agent did," and getting it right changes what you build.

## The commodity graveyard

First, the uncomfortable part. "Agent observability" is a solved, crowded, commodity category. [LangSmith](https://www.langchain.com/langsmith), [Langfuse](https://langfuse.com), [Arize Phoenix](https://phoenix.arize.com), [Braintrust](https://www.braintrust.dev), [Helicone](https://www.helicone.ai), [Weights & Biases Weave](https://wandb.ai/site/weave), [Datadog LLM Observability](https://www.datadoghq.com/product/llm-observability/), [Honeycomb](https://www.honeycomb.io), [Laminar](https://www.lmnr.ai), [Latitude](https://latitude.so), [Traceloop](https://www.traceloop.com). The [2026](https://www.twotail.ai/articles/best-agent-observability-tools-2026) [roundups](https://turion.ai/blog/langsmith-vs-langfuse-vs-arize-phoenix/) say it outright: trace viewers and evaluation tools are mature, the category is well served.

So if your plan is to build another trace viewer, don't. And if your plan is to buy one and call it a strategy, that isn't a strategy either. A dashboard is not an objective; it's a screen you glance at. The question none of these tools answer well, because it isn't their job, is the only one that matters: what is the observation actually **for**?

## A factory optimizes unit cost and variance

Call it a software factory and you should mean it. A factory, in the industrial-engineering sense, optimizes two numbers: **unit cost**, the cost per unit of output, and **variance**, the consistency of outcomes. [Statistical process control](https://en.wikipedia.org/wiki/Statistical_process_control), [Six Sigma](https://en.wikipedia.org/wiki/Six_Sigma), process capability; all of it exists to push those two numbers down. A factory that ships changes with agents is no different. The unit is a shipped, verified change, or a resolved customer outcome. The job is to make each one cheaper and more consistent than it was last quarter.

And here is the iron law that observability-as-dashboard quietly forgets: **you cannot reduce a cost or a variance you cannot measure reliably and without bias.** Measurement is upstream of every optimization. There is no process improvement without statistics you trust.

## pg_stat_statements for agent runs

Which brings me to the analogy that reframed this whole thing for me. How does anyone actually optimize a [Postgres](https://www.postgresql.org) database? Not by logging every query ever run; that's unusable and expensive and nobody does it. You turn on [`pg_stat_statements`](https://www.postgresql.org/docs/current/pgstatstatements.html). It keeps normalized, aggregated, bounded statistics per query shape: call counts, mean and standard-deviation execution time (it tracks variance, literally), rows returned, buffer hits. It strips the literals out of the query text. It holds a bounded number of statements and evicts the rest. It is lossy and content-light by design.

And it is completely sufficient to find the expensive queries and the high-variance queries, which is exactly what you need to make the database faster. No serious DBA asks for a full transcript of every query in history; they ask for reliable, unbiased summary statistics. And `pg_stat_statements` lives inside the database you already own.

**The flight recorder for a software factory is `pg_stat_statements` for agent runs.** You do not need every prompt, every diff, every token to drive down cost-per-outcome and variance-of-outcome. You need reliable, unbiased, structured statistics over what your agents actually did. This flips the usual instinct on its head. Content-free capture is not a privacy compromise you tolerate; it is the *correct* design. Exhaustive transcript logging is the amateur move, in query tuning and in agent factories alike.

Concretely, that means capturing **metadata and content hashes, never content**:

- Lifecycle and tool events (which tool, when, with what outcome), plus model, usage, and cost stats; these are your unit-cost and variance numbers.
- Exact git coordinates (base SHA, changed paths) and a content hash of each artifact that changed; this is your provenance.
- Explicitly not: prompts, assistant text, thinking, tool arguments or results, file bodies, or diff content.

Back it with **fail-closed redaction**: if a payload can't be provably scrubbed before it's written, it doesn't get written; it becomes a labeled, non-sensitive gap. You lose nothing you needed for the statistics, and you gain evidence you can actually hand to a teammate or export without a compliance review. This is the call most observability products get backwards, and it's the one that decides whether the thing is safe to run at all.

## Your factory is your database at a higher abstraction

You might object that your problems are too specific, your codebase too weird, for any of this to be worth building yourself. I think that gets it backwards, and the reason is scale. An AI-native company spends staggering amounts on AI: inference, agents, and the people steering them. That spend is your real production workload, whether or not you instrument it. And nobody runs a high-volume production database blind; the volume is precisely what justifies `pg_stat_statements` and a DBA who reads it every morning.

High-volume AI usage is the same situation, one level of abstraction up. Your factory *is* your database at a higher abstraction: the rows flowing through it aren't queries, they're agent runs and shipped changes, and each one costs orders of magnitude more than a SELECT. The more you spend on AI, the more obvious the instrument becomes, and the faster building it yourself pays for itself. The specificity you were worried about is the argument *for* building it, not against. A rented tool is generic by construction. The statistics that actually move your unit cost and variance are the ones shaped like your factory, and only you can capture those.

## Sampling, not surveillance

There is a second reason total capture is the wrong instinct, beyond cost and privacy: it is statistically unnecessary. No serious quality process inspects every unit. Manufacturing QA runs [acceptance sampling](https://en.wikipedia.org/wiki/Acceptance_sampling) and plots [control charts](https://en.wikipedia.org/wiki/Control_chart) on sampled subgroups, not on the whole line. Statistics as a field is the science of learning a population from a representative sample. Even distributed tracing head-samples, and `pg_stat_statements` is bounded and evicts. You learn what you need from a fraction, as long as the fraction is chosen well.

The same holds for a factory of agent runs. The reflection loop does not need to observe every run, and the recorder does not need every dimension of the runs it does observe. You sample runs, and you reduce each one to the bounded, signal-bearing dimensions (which tool, what outcome, what cost, the hashes that establish provenance), keeping everything else by reference. That second half is just [dimensionality reduction](https://en.wikipedia.org/wiki/Dimensionality_reduction): keep the axes that carry the cost and variance signal, drop the rest. It also keeps the instrument itself cheap, which matters more than it sounds, because an observer that meaningfully raises your unit cost is a bad trade in a system whose entire purpose is lowering unit cost.

Sampling demands one discipline, and it is the same one everything here demands. The sample has to be unbiased and its basis disclosed. Representative, never cherry-picked, and every aggregate states what it sampled and what it dropped. A biased sample is a biased statistic, and a biased statistic is worse than none.

## Unbiased is the entire game

Statistical process control has one unforgiving requirement. The statistics have to be **unbiased**. [The moment a measure becomes a target it bends](https://en.wikipedia.org/wiki/Goodhart%27s_law), and every improvement you make on top of it is fiction.

This is why the recorder must never be the judge. It captures facts; it never grades. Trace volume, latency, token count get recorded flat, editorializing nothing. The instant "more tool calls" or "fewer tokens" becomes a number someone is trying to move, you have manufactured false confidence, which is strictly worse than no measurement. [Databricks](https://www.databricks.com/blog/benchmarking-coding-agents-databricks-multi-million-line-codebase) ran into this concretely: building a coding benchmark on their own repository, they found the "correct" implementation was still recoverable in the git history of the worktree, so their agents walked forward through history to read the merged answer. Not malice; a gameable measurement getting gamed. They had to cut the working copy off from the repository entirely to get an honest number. A biased statistic is worse than none. Keep the wall between "record what happened" and "decide whether it was good," and put evaluation on the far side of it as a separate consumer.

## The point is a loop you own, and it compounds

So you have unbiased statistics you can trust. For what? Not a dashboard. To own a loop that compounds, which is the part the observability vendors structurally cannot give you, and the actual objective.

This is the [Prime Intellect](https://www.primeintellect.ai/blog/series-a) thesis, and they say it cleanly: "companies can now own their model optimization loop. Owning this loop is how you build a compounding moat in the agentic era." Their homepage is one phrase: own your intelligence. Their investors put it in industrial terms, that a company should "train on real product signal, iterate fast, and compound performance with every run," and that "the company that owns its model, its data, and its results holds a durable advantage." They point at [Cursor](https://cursor.com) building its own Composer stack and [Cognition](https://cognition.ai) doing the same, rather than renting models they couldn't improve. Databricks made the same move on evals: build your own benchmark from your own merged pull requests, sealed and yours, because a public benchmark leaks into training data and doesn't reflect your codebase anyway.

The flywheel is simple. Runs produce evidence. Evidence becomes [[skills-verification-in-agent-software-factories|evals and environments]]. Evals train [[pareto-optimal-agents|finetunes on open models]]. Finetunes make your agents cheaper, more reliable, and more specific to your business. Better agents run more, and produce more evidence. Every turn of the loop lowers unit cost and variance, and the advantage compounds. That compounding advantage is the alpha. It is the only durable moat in a world where the base models are a commodity everyone rents at the same price.

## Why rented observability forecloses the loop

Now the punchline about the commodity platforms. When you wrap your agents in a vendor tracing SDK, your evidence lives in their system, in their schema, on their retention policy. You are renting visibility into your own loop. And you cannot compound what you do not own. Traces sitting inside someone else's product do not become your evals and your finetunes without exporting, reshaping, and fighting their ontology the whole way. The labs are candid that they want your reasoning traces; the observability vendors quietly benefit from them too.

There's a brittleness cost on top of the ownership cost. The common pattern is to wrap each run in a vendor SDK through interceptors and harness-specific shims. That couples your instrumentation to one vendor's model of the world and one harness's lifecycle, and it breaks the moment either changes. If the evidence isn't yours, portable, content-free, and vendor-neutral, then neither is the loop. **Owning the evidence layer is the precondition for owning the loop.**

## The harness is not the job

There is a companion mistake to renting observability, and it is more personal. Engineers pick one harness, usually a proprietary one, and defend it. [Cursor](https://cursor.com) versus [Claude Code](https://www.anthropic.com/claude-code) versus [Codex](https://openai.com/codex/) versus [Aider](https://aider.chat), and the argument is almost never about outcomes. It is interface familiarity, a couple of vendor features you happen to like, and a vibes-based conviction that this one is simply best. That is not engineering, it is behavioral psychology. The [mere-exposure effect](https://en.wikipedia.org/wiki/Mere-exposure_effect) (you prefer what you have seen most), the [IKEA effect](https://en.wikipedia.org/wiki/IKEA_effect) and the [endowment effect](https://en.wikipedia.org/wiki/Endowment_effect) (you built your setup, so you overvalue it), status-quo and sunk-cost bias, and plain tool tribalism. Addy Osmani names the escape hatch: once you notice the pieces are the same across tools, you stop arguing about which one and just design a loop that works no matter which you happen to be sitting in.

Which is the point. If you are a builder at an AI-native services company, your job is to reliably solve business problems and to buy yourself leverage and free time to think strategically. Every cycle you spend litigating models and harnesses is a cycle you did not spend on the business, and it is spent defending a commodity input that will be different in three months. The harness is a swappable input. The model is a swappable input. The thing worth your scarce attention is the loop.

This is [**loop engineering**](https://addyosmani.com/blog/loop-engineering/), and it is the right frame. The leverage moved from prompting an agent to designing the loop that prompts it: an automation on a cadence finds and triages work, worktrees keep parallel attempts from colliding, skills carry the project knowledge, connectors let the loop act in your real tools, and a separate verifier checks the maker so that "done" means something, with state on disk because the model forgets between runs.

But there is a floor above even that, and it is the whole reason for this essay. The highest-leverage loop is not the one that ships a feature. It is the loop that reflects on its own runs and compounds. Observe a representative sample of attempts with the content-free recorder, aggregate the unbiased statistics, and feed the misses back into your evals, your finetunes, and your routing. Loop engineering ships the work; the reflection loop makes the factory itself cheaper and more consistent every night. And because the recorder is vendor-neutral and harness-agnostic, the reflection loop does not care which harness won a given attempt. It just measures which configuration cleared the bar cheapest, which is the only harness opinion worth having.

Here is the shape, in pseudocode:

```python
# The factory reflection loop. You design this once; you do not prompt any of it.
# The recorder makes it honest. The evidence is what compounds.

on schedule (nightly, or on a trigger):
    work_orders = triage()                 # Automation: issues, CI failures, regressions worth doing.

    for wo in work_orders:
        attempts = []
        for cfg in candidate_configs:      # Harness/model-agnostic: try a few, no favorites.
            wt  = fresh_worktree(wo.base_sha)          # Disposable, SHA-pinned, own blast radius.
            rec = recorder.start(wo, wt)               # Content-free evidence + receipts-or-gap.
            run_agent(cfg, wo, wt,
                      tools=READ_ONLY + armed_writes,  # Least privilege; no shell.
                      recorder=rec)
            attempts.append(rec.finalize())            # Reconstructable ledger, even on crash.

        # Maker != checker. A separate verifier scores against spec+tests. The recorder never grades.
        for a in attempts:
            a.outcome = verify(a, spec=wo.spec)

        # Reflection = unbiased statistics. This is pg_stat_statements for the factory.
        stats  = aggregate(attempts)        # Unit cost, variance, retries, tool-failures, papercuts, dead skills.
        winner = select(attempts, by=("verified_outcome", "cost"))   # Not by vibes.

        if human_rubber_stamps(winner):     # The one human step: approve a checkable result.
            ship(winner)

        # Compound: turn the evidence into assets you OWN.
        for miss in high_value_failures(stats):
            evals.add(environment_from(miss))          # Own the evals.
        finetune_queue.add(examples_from(stats))       # Own the model (open-model finetune).
        routing.update(cost_variance=stats)            # Own the alpha (cheapest config that clears the bar).

    # Tomorrow's run starts from stronger evals, cheaper routing, better skills. The moat compounds.
```

Design that once and you are no longer in the turn-by-turn loop, and no longer emotionally invested in a vendor. You are the person who owns the loop and reads what it produced.

## But won't the models just do this for you?

The sharpest objection to all of this is one that keeps landing in my inbox, from a widely-shared [AI Engineer keynote](https://tokenless.tech/posts/2026/ai-engineer-worlds-fair-2026-theo-browne-keynote/): "you don't need some custom tooling, some custom systems, some fancy software factory. You just need to prompt it to go a little further." The talk argues we're in the skeuomorphic phase of software, clinging to terminals and Git habits and tool identity out of familiarity, while the orchestration-era models quietly got good enough to spawn their own subagents, verify their own work, and let an entire product run as a markdown file on a cron.

Most of that I violently agree with, because most of it is this essay. Get over your harness. Your language is not your identity. Prompts and skills rot and should be audited and deleted, not defended. Delete code without the sunk-cost guilt. The maker loop really is collapsing into a prompt. If you read "the harness is not the job" and "treat skills as load-bearing code" as agreement with that talk, good, they are.

But look closely at the example the talk celebrates: a markdown file that triages your pull requests every morning on a cron and hands you your work for the day. That is not the absence of a factory. That is loop engineering. It is the triage automation at the top of the reflection loop, the exact first line of the pseudocode above. The talk is building the loop and waving off the word.

Here is the part "just prompt it bigger" cannot answer. Prompting bigger optimizes the *maker*. It says nothing about unit cost and variance across a thousand runs, and it hands you zero ownership of anything that compounds. A model that orchestrates itself still produces runs you cannot make cheaper or more consistent without unbiased statistics you own, and it is still rented intelligence that snaps back to the mean the day your competitor pipes the same markdown file to the same frontier model. The factory I'm describing is not the "fancy custom tooling" the talk warns against. It is a thin, content-free recorder and a reflection loop, deliberately minimal, which is the same "build the instrument, not the product" posture. The talk's own separate warning, that bespoke prompt-systems are technical debt that rots with every model release, is an argument for keeping the instrument small, not for skipping it.

And the economics run the opposite way from the objection. As the models get bigger and the maker gets cheaper, the value of owning the loop goes *up*, not down, because the maker is now the commodity everyone rents at the same price. When the entire industry can execute a markdown file against a frontier model, the only thing left that compounds is the evidence you own and the evals and finetunes you build from it. Going wider, which is the talk's actual thesis, is precisely what a low-unit-cost, low-variance factory *enables*. You can only credibly cover a wide surface if each unit is cheap and consistent, and you only know that if you measure it, without bias, in a loop you own.

## The build

So build the recorder, and build it as the instrument, not the product. What follows is not a specification and it is not a finished science; treat it as food for thought, a set of design biases I've found useful rather than laws. There is no perfect version of this, and you shouldn't wait for one before you start. The whole philosophy is incremental upgrades: ship a crude recorder, read what it tells you, tighten the next turn, and let the reflection loop improve the instrument the same way it improves everything else. With that caveat, a few calls tend to make it trustworthy.

**Run each attempt in a disposable worktree, with the narrowest tools.** A fresh git worktree pinned to an exact SHA gives you a deterministic base state and a blast radius you throw away. Give the agent read-only tools by default. Make writes opt-in and containment-checked, refusing any path outside the directories the task is allowed to touch, and never add a shell. And name the boundary honestly: a worktree with normal permissions is observational isolation, not a kernel sandbox. Don't log "deny by default" and imply a security guarantee you didn't build.

**Make the evidence a plane, not a pile.** The rule is receipts-or-gap: every causal claim is backed by something a stranger can check (a SHA, a content hash, a ledger sequence number) or is explicitly labeled a gap. You never infer a missing edge to make the account look complete. An append-only ledger plus a manifest of hashes and git coordinates gives you that. And one rule that saves you later: the local ledger is authoritative, telemetry export is best-effort. Ship spans to an [OTLP](https://opentelemetry.io/docs/specs/otlp/) collector for querying across runs, absolutely, but a trace link with no durable artifact behind it is a gap, not a receipt. Telemetry backends sample, expire, and drop. Your evidence cannot depend on a span surviving in a backend you don't own. Done right, reconstruction is a pure function of the receipts: feed the same bundle in twice, get byte-identical output.

**Make the failures reconstructable too.** The run that crashes is the run you most need. An aborted attempt, or one where the provider was never configured, still leaves a clean ledger. "Incomplete" is a first-class, visible state, never rounded up to "done." If your instrument only produces good numbers on the happy path, you built a demo, and demos are exactly what you can't trust when it counts. A factory that only measures its good days has no idea what its variance is.

**Treat skills as load-bearing code.** The skills you hand your agents (the reusable instructions, the project knowledge, the tool playbooks) are code, and code rots. Once the recorder tells you which skills actually fire in the hot path and which ones move outcomes, the dead ones become visible: skills that are never invoked, or that are invoked and change nothing. Retire them. An unused skill isn't harmless documentation; it's a liability that bloats context, competes for the agent's attention, and quietly raises unit cost, exactly like dead code sitting in a hot loop. The reflection loop should hunt dead skills the way a good build hunts unreachable branches, and the recorder is what turns "unused" from a guess into a measurement.

**Let the agent report its own papercuts.** One small structured tool to append "this was confusing, wasteful, or blocked," against the active context, append-only, never auto-filed and never scored. The agent is the best-positioned witness to its own friction, and almost every system throws that testimony away. It's another unbiased signal about where the factory hurts.

Put it together and, from a bundle with no content in it, you can reconstruct an ordered, checkable account of an attempt, compute cost and variance per operation kind, cluster retries and tool failures, and see which of your shared agent skills are effectively dead code. That's `pg_stat_statements` for the factory. And because it's yours, content-free, and portable, it's also the first mile of the owned loop.

## The call

Stop renting visibility into your loop. Build the recorder: content-free, vendor-neutral, unbiased, and yours. Treat it like `pg_stat_statements` for your factory, the boring instrument that makes unit cost and variance measurable and therefore reducible. Then close the loop. Turn the evidence into your evals, your finetunes, your alpha. The pattern is already proven by the teams who refused to rent their intelligence.

The model was never the moat, and neither was the agent, and it was never the observability dashboard. The moat is the loop you own and compound: reliable unbiased measurement, converted run after run into a factory that gets cheaper and more consistent than anyone renting the same models can match. Build the boring instrument. Own the loop.
