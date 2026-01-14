---
title: Agent Deck - Your AI Agent Command Center
date_created: 2026-01-05T11:25:45
date: 2026-01-05T11:25:53
publish: true
author: Sushant Vema
---

I love command-line tools and terminal UIs. One of my favorite tools these days
is Claude Code.

I run many claude code sessions in different [[tmux]] windows all in a single
monolithic session. I often end up with over 40 different windows in my session,
with at least a handful of claude code sessions (and in future, other terminal
agentic coding tools as well) for a variety of projects.

The issue that Agent Deck tries to mitigate is managing multiple AI coding
session in the terminal.

> Too many terminal tabs. Hard to track what's running, what's waiting, what's done. Switching between projects means hunting through windows.

Agent Deck offers 5 small but powerful value additions:

1. See everything at a glance.
2. Switch in milliseconds
3. Never lose track
4. Stay organized
5. Zero config switching

Now my monolith tmux session isn't so monolithic - the highly stateful AI agent
sessions are now contained in a separate tmux session.

## Other Features

- Conversation forking
- Quick attach MCP servers
  - Defined once in a global config

## Setup

Pretty straightforward
[x] Ported over global MCP config (supabase, linear, context7) to the agent deck
global config toml file
[x] enabled MCP socket pooling

## Bug tracker

- [] When you configure a global configuration for MCP, it requires an
  `.mcp.json to already be created`
- [] When you are attached to an agent session, you are unable to use vim mode
  page scrolling, instead you have to scroll with mouse.

## References, Unlinked

- [Agent Deck Github](https://github.com/asheshgoplani/agent-deck)
