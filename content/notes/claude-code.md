---
title: "Claude Code"
description: "Anthropic's official CLI tool for software development that combines conversational AI with powerful coding capabilities, including agentic workflows, MCP server integration, and specialized tools for modern development."
author: "Sushant Vema"
date_created: "2026-01-07T05:28:23"
date: "2026-01-07T05:28:23"
publish: true
tags:
  - "claude"
  - "ai"
  - "cli"
  - "development-tools"
  - "agents"
---

Claude Code is a powerful tool. As I learn more and continuously take
inspiration from various sources, I will add my insights here as well as what I
am working on.

I use and orchestrate claude code in [[tmux]]. Since claude code automatically
renames tmux windows, I modified my tmux configuration with

```tmux
# prevent automatic window renaming
+set-option -g allow-rename off
+set-window-option -g automatic-rename off
```

which hopefully prevents this.

The next thing I want to work on is figuring out elegant github worktree flows.
-> @Claude: If I have a parent directory that contains multiple git
repositorities as subdirectories which are their own projects, what are elegant
ways to manage git worktrees for the purpose of having multiple AI agents work
on features in parallel.
-> @Claude build and comment on a [[stacked-prs]] skill that is global. this skill
should be designed in a way that coding agents, when thinking about making a PR
or release, should always adhere to this flow which encourages stacked PRs
following best practices.

I also am going to alias `claude` to `claude --continue
--dangeously-skip-permissions`

## Claude Code CLI Flags

`--dangeously-skip-permissions` ->
