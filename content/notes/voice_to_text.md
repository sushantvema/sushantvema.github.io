---
title: Voice to Text
description: An investigation into primal friction
date_created: 2025-05-04T20:37:06
date: 2025-05-04T20:37:08
author: Sushant Vema
publish: true
tags:
  - project
---

## ruminations

When I think about friction, I think about thinking. Thinking is distinguished
from action because it is less definitive, less finite, than the latter.

Consider some of the most important fields of thinking. Which transcend all
human endeavors.

- Word choice
- Editing (note - [[vim_motions|vim]] can make it fun)
- Reading
- Retrieval
- Forgetting
- Summarizing

Today I read an [Essay by Clayton Ramsay called "I'd Rather Read the Prompt"](https://claytonwramsey.com/blog/prompt/).

The essay talks about how generative language models do not help you to become a
better writer, since writing is not about the outcome, but more about the process.

The process of writing is one that throws me in the deep end more than other
things I do on the day-to-day. For example, thinking about what to write about
in this essay is taking more of my concerted energy than grinding games of
bullet chess. Solving a Jira ticket at work (since I don't get / don't have an
incentive to be emotionally invested in my work product like that).

We all have the same set of mental faculties. These
resources/systems/tools/networks/processes/paradigms do a lot of things (work)
before and during and after a thought.

In that "thought process", we spend energy to communicate the thought. The why's
and how's of communicating thoughts is an interesting subject. I'll focus on
speaking and writing in this essay unless I change my mind.

We all have a unique set of experiences and backgrounds. Rather than quote a
line from that article (which I recommend reading), I will summarize this idea
as the "conditionings" we all have on top of us. Every human's conditioning is
unique. One's conditioning defines their relationships to the activities of
speaking and writing.

Since everyone's conditioning is unique, I won't speak in generalities. I'll
only reflect on my conditioning in the context of this essay.

As a
programmer/developer/(software)engineer/data-scientist/bibliophile/polyglot, I
spend a lot of time either:

- thinking about what I should say
- thinking about how I should communicate the thought
- regretting poorly-/inadequately- revised implementations of the communication.

Someone tells me to fix or implement a new feature in our code base. I have also
self-assigned myself some work. They are my boss, so I need to do what my boss
says at a level that satisfies my interpretation of what they are expecting from
me. I read the code base. I get annoyed thinking about [tech debt](https://en.wikipedia.org/wiki/Technical_debt). Colleague tells me to put everything aside and do this task. Begrudgingly, I write some design, write some code. It is integrated because I have said that I have tested it properly. The design is forgotten 2 months from now. A colleague has to implement a feature. He doesn't use my code, instead writes his own with a fabulous design. Technical debt accrues. New intern tries to fix technical debt. So on, so forth.

If you are a programmer I hope this is relatable but not PTSD-inducing.

At least as a developer, it feels like we are obligated to make so many
decisions at such high frequency. That we can not indulge in the thinking
process. Over time, many engineers will become functions to put out fires -
using their own thinking waters as the crucial element to quench the flames, one
jira ticket at a time.

It also sucks because there is this weird correlation with technical debt
accrual, putting out fires, and job security.

Anyway. Sometimes I struggle to communicate thoughts because I feel like most of
them are not worth communicating. Instead of generating a lot of low-density
high-volume material "in my name", I would rather be remembered as someone who
can consistently produce high-density, high-volume material.

When I struggle to think about communicating a feeling in my mother tongue
(Telugu); when I feel self-conscious in a crowd; when I hold my tongue without
quite knowing how to interact with another in a way that will drill down and cut
through the noise.

## seedling project idea

A few days ago, I started to build something which I can't quite define right
now. I want to use it to help me iterate on budding thoughts in my own voice.

To reduce the friction between voice and text. Instead of building a "generative"
AI application, I want to build a "regenerative" AI application. A tool that
will help me grow my actions and work products out from a robust trunk of
thinking.

Right now I developed + vibe-coded a simple command-line script that uses
[OpenAI's open-source Whisper transcription model](https://github.com/openai/whisper) to transcribe my voice.

On top of that, I am building ...

One tool I want to explore further is [superwhisper](https://superwhisper.com/).
