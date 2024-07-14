---
title: "Quartz Wishlist"
description: "Configuration I would like to implement for my quartz static site generator and features I would like to see implemented in the source code if they really are not available already."
author: "Sushant Vema"
date_created: "2024-07-09T13:30:09"
date: "2024-07-11T07:45:04"
tags:
  - "evergreen"
publish: true
---

# Todo
- Figure out a workflow to locally build and serve private pages but make sure they don't get added to the public build when I run `quartz sync` and stuff
  - ideas: hacks with `.gitignore`, glob patterns, modified YAML frontmatter to toggle visibility in local builds
- Rendering [Unicode](https://home.unicode.org/) in order to write other languages primarily
  - Check out this article: [How to Insert Unicode Characters in Neovim/Vim - jdhao](https://jdhao.github.io/2020/10/07/nvim_insert_unicode_char/)

# Done  
- 2024-07-11T07:44:24: Use the [ExplicitPublish plugin](https://quartz.jzhao.xyz/plugins/ExplicitPublish) instead of the [RemoveDrafts plugin](https://quartz.jzhao.xyz/plugins/RemoveDrafts) universally across my knowledge ocean.
  - Reason: digital presence is important, and I need to make sure that only what I absolutely intend on making public becomes publically accessible.
