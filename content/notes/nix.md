---
title: "Nix - Deterministic environments and package management"
date_created: 2026-08-30T18:01:40
date: 2026-08-30T18:01:46
publish: true
author: "Sushant Vema"
tags:
  - "software-engineering"
---

Nix is a cross-platform package manager for unix and unix-like systems, a
functional programming language, and a operating system distribution (NixOS)
based on the preceding two items.

Nix is a tool that allows the creation of "reproducible, declarative, and
reliable systems".

**Reproducible**:
Nix builds packages in isolation from each other. That means that packages
cannot have undeclared dependencies. So, if a packages works on one machine, it
will be guaranteed to work on another.

Food for thought: How does package building work in other systems such as Node
(npm), homebrew, etc?

**Declarative**:
Through the functional programming language and constructs like Nix Flakes, Nix
makes it trivial to share development and build environments for projects,
irrespective of the toolchains and languages.

Food for thought: How is something like Nix Flakes comparable or better to
something like a Brewfile or requirements.txt?

**Reliable**:
Nix ensures that installing or upgrading a package on a host cannot break other
packages. It allows rollbacks of individual packages to previous versions. So,
nix makes sure that no package is left in an inconsistent state during regular
package management operations.

Some immediate high visibility features include:

- The ability to try new tools without fear using `nix-shell`
- Multiple languages can use the same tool.
- You can use `nix-shell` and `.nix` files to have declarative development
  environments which can be shared
- You can use `nix-build` to create a Docker image of nix packages
- You can use nix to build cloud images like an EC2 container.
- You can test environment configurations (in NixOS for example) using
  `nix-build`
