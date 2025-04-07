---
title: Neovim Quality of Life
description: Useful motions, understanding, etc
date_created: 2025-04-05T20:13:30
date: 2025-04-05T20:13:31
tags:
  - resource
publish: true
---

## Editing

- 2025-04-05: Frequently when I'm editing (appending) to long-running Markdown
  documents, I find myself nearing the bottom of the buffer. The naive solution is
  to carriage return until I have more "space" in the form of new lines which when
  I save the document will be automatically removed via linter. However, the
  "neovimial" solution is simple: `zz`. This "moves the buffer preview" such that
  your cursor is centered.
- Long before 2025-04-05: At some point I decided that I wanted to adhere to the
  CommonMark specification of markdown which requires that lines be no longer
  than 80 characters long. It's grueling to do that manually. Consider situations
  where you have long quotes or generally stylized markdown text. Imagine carriage
  returning over and over and inserting those brackets. Neovimial solution:
  `gwgw` on visually selected lines. There's some other configuration here I
  will try to reference.
