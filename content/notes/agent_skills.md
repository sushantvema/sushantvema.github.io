---
title: Agent Skills - Procedural Knowledge for AI Agents
description: Notes about skills
author: Sushant Vema
date_created: 2026-01-05T07:12:02
date: 2026-01-05T09:31:00
publish: true
tags:
  - AI Agent Architecture
---

> Skills are knowledge packages that teach Claude how to perform tasks better,
> not just tools that extend functionality.

Skills are bundles of "instructions, scripts, and resources" that Claude (or
other agents via the open standard[^1]) to improve performance on specialized
tasks.

Skills help to teach AI agents to complete tasks in a more repeatable fashion.

Skills follow the principle of [[progressivedisclosure]]

This concept has caught on so fast that the aforementioned Open Standard was
created officially on December 18th, 2025.

## "Writing" a Skill

The best way to get a feel of how skills work is to use Anthropic's skill
creator skill[^3] to codify some procedural knowledge you already know, with the
help of an AI coding agent which uses that skill.

In order to use the Skill Creator skill (using Claude Code as a harness for now)
we actually need to install it (into the harness) since Claude Code by default
doesn't come with any skills. By default in Claude Code, skills are based on [where they live](https://code.claude.com/docs/en/skills#where-skills-live).

In order to test this out using a global configuration of claude code, we can
copy the skill creator skill to our global config as follows:
`cp -r /Users/svema/Repos/github.com/sushantvema/hackerspace/skills/skills/skill-creator ~/.claude/skills/skill-creator`[^3]

Then we can start a new claude code session (anywhere in your environment, but
I'm preferring the `~/.claude` directory for now), use the `skills` slash command,
verify that `skill-creator` is enabled, and then ask Claude to create a simple
skill.

Using the `skill-creator` skill or not, it is important to

## Random

The agent skills reference[^2] contains a helper library called skills-ref which
can be used to validate whether certain skills adhere to the specification.
Although they claim that it should not be used in production, I have yet to try
it out.

## References, Unlinked

- [Skills MP](https://skillsmp.com/)
- [Using Skills in Claude (Desktop)](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
- [Agent Skills in Claude Code](https://code.claude.com/docs/en/skills)
- [Agent Skills in the SDK](https://platform.claude.com/docs/en/agent-sdk/skills)
- [Cursor - Agent Skills](https://cursor.com/docs/context/skills)
- [OpenAI - Agent Skills](https://developers.openai.com/codex/skills/)
- [Reddit - Why are skills way better than putting them in AGENTS.md?](https://www.reddit.com/r/ClaudeCode/comments/1prjg62/why_are_skills_way_better_than_putting_them_in/)
- [Anthropic Blog - Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

[^1]: [Agent Skills Open Standard](https://agentskills.io/home)

[^2]: [Agent Skills Reference Github](https://github.com/agentskills/agentskills/tree/main/skills-ref)

[^3]: [Anthropic Skill-Creator Skill](https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md)
