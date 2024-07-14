---
title: "Knowledge Scripting"
description: "A guide to building tools using bash scripts to orchestrate knowledge curation processes within a markdown-based personal knowledge management system."
date_created: "2024-07-09T12:56:34"
date: "2024-07-09T13:11:37"
tags:
  - "evergreen"
  - "technical"
publish: true
---

References:

- [[neovim_wishlist|My Neovim Wishlist]]
- [[computer_security#Quotes|Slightly relevant quotes about computer security and privacy]]
- Look at [gh/mischavandenburg/dotfiles/scripts](https://github.com/mischavandenburg/dotfiles/tree/main/scripts) for inspiration since he is one of my role models

# Wishlist
- hook (probably in neovim as an autocommand) to automatically add the `description` field of the YAML frontmatter in a .md file at the beginning of the page to improve searchability on my static site generator.
  - Note: Maybe I can configure quartz search directly to include YAML frontmatter. 
- script to create a timeline of documents based on `date_created` in the frontmatter of each file
- Neovim hook (probably autocommand) to add `diso` to the `date` frontmatter field whenever I save. 
- Neovim hook (probably an autocommand) to keep track of a counter of "significant changes" upon saves based on size of diff made
- script to automatically pull out all quotes from a knowledge base and put them into a document. Maybe AI integration or API for service to manage and track personal quotes. 
