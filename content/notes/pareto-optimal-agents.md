---
title: "Pareto-Optimal Agents"
description: "Frontier behavior from the cheapest thing that clears the bar — why the interesting target is the cost/quality Pareto frontier, not the single best model. On disciplined evals, open-model finetuning, harness + inference engineering. References Databricks' coding-agent benchmark and Prime Intellect's open-superintelligence stack."
author: "Sushant Vema"
date_created: 2026-07-10T13:53:49
date: 2026-07-10T13:53:49
publish: true
tags:
  - "agents"
  - "evals"
  - "inference engineering"
  - "open models"
---

the question i keep coming back to isn't "which model is best." it's "what's the **cheapest thing that clears the bar** for this job?" that reframe — from a single frontier model to a **cost/quality Pareto frontier** — is, i think, the whole game in applied agents right now. and two pieces of recent work make the case better than anything i could argue from first principles.

## the frontier is a frontier, not a point

Databricks published a benchmark of coding agents on their own multi-million-line codebase ([blog](https://www.databricks.com/blog/benchmarking-coding-agents-databricks-multi-million-line-codebase)), and the findings are the crux of this whole note:

- **the Pareto frontier for coding includes open models.** GLM landed in the top capability tier, statistically tied with the best closed model on quality while costing meaningfully less. "best quality for a given cost" is a *curve*, and open weights are on it.
- **token price is a lie.** price-per-token is a terrible predictor of price-per-*task* — a model that reasons efficiently can be cheaper end-to-end than a "cheaper" model that reads and thrashes more. you have to measure at the task level.
- **the harness matters as much as the model.** same model + same effort through two different harnesses differed >2x on cost at equal quality, mostly from how much context each fed per turn. context engineering is a first-class lever, not a footnote.
- **grade behavior, not strings**, and **seal the environment** — they had to cut the working copy off from git history because agents were walking forward through commits to find the "answer." (this is the verifier-gaming problem; see [[skills-verification-in-agent-software-factories|skills verification]].)

the meta-point: *build your own benchmark from your own merged PRs.* public benchmarks leak into training data and don't reflect your codebase. your backlog of reviewed, tested PRs is a benchmark no model has trained on, graded by tests your team already wrote.

## own the optimization loop

if Databricks shows open models are *on* the frontier, Prime Intellect is building the stack to *push your own point along it* ([Series A](https://www.primeintellect.ai/blog/series-a)). their thesis: pre-training concentrated frontier AI in a few labs; RL breaks it open, because you can now train directly on **your** product and workflows and own a compounding loop.

the proof point that stuck with me: **Ramp trained a 35B model that beat a frontier model at spreadsheet search — faster and at a fraction of the cost.** rather than wait for the next frontier release, they post-trained a small model for the one workflow that mattered. that's Pareto optimality as a *strategy*, not an accident.

the stack that makes it possible is the interesting part — compute, RL, environments, sandboxes, **evals**, and deployment — with continual learning as the endgame, where training and inference collapse into one loop.

## so what actually makes an agent Pareto-optimal

putting it together, the levers — in roughly the order most teams underuse them:

1. **real evals.** you cannot ride the frontier if you can't measure where the bar is. behavior-graded, held-out, ungameable. everything else is downstream of this.
2. **the harness / context engineering.** get the right context to the model at the right time; keep the working set tight. often a bigger lever than swapping the model.
3. **open-model finetuning.** SFT/LoRA/RL on your workflow to pull a small model up to frontier behavior on the narrow thing you actually do.
4. **inference engineering.** routing to the cheapest model that clears the bar per task, fallback, caching, quantization. the cost curve is engineering, not fate.

the cost of raw intelligence is falling; anything priced on top of that compute compresses with it. what doesn't compress is the **outcome**. so the durable edge isn't the model you call — it's the eval that tells you what "good" is, the harness that gets you there cheaply, and the loop that makes it better every week.

the model was never the moat. the discipline around it is.
