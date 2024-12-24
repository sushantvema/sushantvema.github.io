---
title: "My Thoughts On Organizing a Living Markdown Journal"
date_create: "2024-12-14T19:47:52"
date: "2024-12-14T19:47:56"
tags:
  - thoughts
publish: true
---

Markdown is a beautiful language. I've written a little bit about it already over here.

- [[markdownheadings]]
- [[yamlfrontmatterformarkdown]]

I use LazyVim, a simple neovim distribution. I've recently discovered it's possible to aggregate all todo comments across a directory and visualize them neatly in a buffer.

You can filter by severities, display todo's by severity (warn, info, note, etc)

Until today, I never bothered to use these markdown comments. Instead, I would create bespoke versions of to-do lists in one markdown file per day.

However, I have a new idea. With the power of markdown comment aggregation, symbol search, internal linking to resource documents, no-neckpain (and other QOL ui improvements), and logical limiting of individual files (e.g one file per month, etc), we can really create a powerhouse of an organization system.

# Rough Design

Let's design this out.

We want a master agenda file to contain links to each significant agenda file. So no folder structure and only two abstractions.

Each child node can hold pointers to web links, resource note links, and more. They shouldn't need to link to other child nodes.

Re. privacy. I never publish (in quartz) my agenda pages, because they are rich in personal context about my job, daily life housekeeping, finances, etc. However, trying to maintain the current system of daily markdown agenda notes in my (ideally) super-flat zettelklasten is proving to be tiring.

re. headings.
