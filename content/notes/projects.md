---
title: "Personal Projects"
tags:
  - "inbox"
publish: true
date_created: 2025-02-24T19:42:14
date: 2025-04-05T20:03:50
---

## Personal Technical Projects

### nvim

#### Markdown Workflow

- DONE: Disable [Marksman](https://github.com/artempyanykh/marksman/tree/mainhttps://github.com/artempyanykh/marksman/tree/main)
  - 2025-04-05: Begin. Seems to have been as simple as `:MasonUninstall`. I
    realized I needed to keep the other lazyvim markdown extras, so I left that in
    lazyvim.json in my dotfiles. Then I did the Mason Uninstall along with LSP
    restart.
- TODO: Create a script or nvim autocmd to apply autoformatting to all my
  markdown documents based on
  CommonMark rules
- TODO: In insert mode, automatically create a new bullet point in-line when
  carriage returning from a previous list line
- TODO: folding solution for markdown?

#### Pickers

- TODO: Snacks.lua picker enable wrapping
- TODO: Enable leader ff to search dotfiles as well and dot directories

#### Beancount LSP

### Tmux / State Management / Project Management

- TODO: tmux resurrect for persisting tmux sessions
  - See this [LinkedIn Post](https://www.linkedin.com/pulse/save-tmux-sections-automatically-zhenguo-zhang-nbz5c/)

### CLI Tools for Productivity

- TODO: Jira CLI
- TODO: CLI for browsing aliases

### Sysadmin Tools

- TODO: Set up k9s TUI

## Quartz Personal Website

- Image support
- Implement tag page
- Explore new plugins
- New plugin for parsing `date_created` in the frontmatter?

## Learning New Languages

- GoLang

## MacOS QOL

- TODO: toggle off special characters with alt prefix

### Unorganized

- [] How to better delineate public vs private content in quartz using:

  - quartz emitters customization
  - custom gitignore rules
  - standardized CI/CD approach
  - pre-commit hooks?

- Markdown RAG system
- Markdown knowledge garden version control. I can do this using an obsidian git
  plugin that auto-pushes to a repository every so often.
  - would require some sort of cron job
- Self-hosted Kanban tools?
- Add yabai config file to dotfiles and add alt direction motions
- Figure out the issue with mason-lspconfig and why some LSP servers aren't
  changing
- Change default color scheme for neovim and alacrity to slate
- Markdown-based static website design
- Sync task warrior with Git. How can I integrate the data with other
  applications?
  - 2024-12-25T07:17:41: not really using task warrior anymore
- MacOS package management solutions. Keep track of brew installs
- Sync configuration for Arc browser between Mac and and mobile
- Catalog the command line tools I use most frequently
- Explore multi-agent AI
- Customize neovim terminal so that it automatically sources bashrc
- configure telescope pickers to wrap file names
- [] Zenmode plugin for neovim
  - toggled off as of 2025-02-24T19:43:57 IIRC
- [x] Markdown LSP, intelligence
