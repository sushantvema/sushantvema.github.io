---
title: "Overview of Important Unix Commands and Principles"
date_created: 2024-12-25T07:39:55
date: 2024-12-25T07:39:58
publish: true
tags:
  - technical
---

> UNIX is basically a simple operating system, but you have to be a genius to understand it's simplicity. - [Dennis Ritchie](https://en.wikipedia.org/wiki/Dennis_Ritchie)

> The Unix philosophy, originated by [Ken Thompson](https://en.wikipedia.org/wiki/Ken_Thompson), is a set of cultural norms and philosophical approaches to minimalist, modular software development.

A core principle of Unix is writing code that is:

- simple
- compact
- clear
- modular
- extensible
- maintainable

This philosophy favors composability over monolithic design.

Directly quoted from the wikipedia page:

# The Unix Philosophy

The Unix philosophy is documented by [Doug McIlroy](https://en.wikipedia.org/wiki/Doug_McIlroy) in the Bell System Technical Journal from 1978:

1. Make each program do one thing well. To do a new job, build afresh rather than complicate old programs by adding new "features".
2. Expect the output of every program to become the input to another, as yet unknown, program. Don't clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don't insist on interactive input.
3. Design and build software, even operating systems, to be tried early, ideally within weeks. Don't hesitate to throw away the clumsy parts and rebuild them.
4. Use tools in preference to unskilled help to lighten a programming task, even if you have to detour to build the tools and expect to throw some of them out after you've finished using them.

It was later summarized by [Peter H. Salus](https://en.wikipedia.org/wiki/Peter_H._Salus) in _A Quarter-Century of Unix_ (1994):

- Write programs that do one thing and do it well.
- Write programs to work together.
- Write programs to handle text streams, because that is a universal interface.

In their Unix paper of 1974, Ritchie and Thompson quote the following design considerations:

- Make it easy to write, test, and run programs.
- Interactive use instead of batch processing.
- Economy and elegance of design due to size constraints ("salvation through suffering").
- Self-supporting system: all Unix software is maintained under Unix.

# GNU Core Utilities - coreutils

[GNU Core Utilities Wikipedia Page](https://en.wikipedia.org/wiki/GNU_Core_Utilities)

With all of this context in mind, over the generations Unix-developers have put together a broad range of modular, composable software, and extremely simple tools to do very specific text-based tasks very well.

Here are some of those tools that I use on the daily basis. I spend a vast majority of my time online within my terminal (taking notes, writing code, version control, process monitoring, etc).

We can broadly [categorize these tools into three buckets](https://en.wikipedia.org/wiki/List_of_GNU_Core_Utilities_commands): file utilities, text utilities, and shell utilities. I wouldn't be surprised if 99.99% of higher level software applications which do one or many of these functions actually use coreutils tools under the hood.

## File Utilities

## Text Utilities

The majority of these tools are actually cryptography-related. I use a very select subset of them.

## Shell Utilities

Lot of cool ones here. Useful for digging into system and platform information. Advanced developers will frequently use some of these in their systems.
