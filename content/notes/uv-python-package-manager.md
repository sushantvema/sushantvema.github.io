---
title: uv - The Next Generation Python Package Manager
date_created: 2025-02-24T20:57:20
date: 2025-02-24T20:57:22
tags:
  - python
  - dependency-management
author: Sushant Vema
publish: true
---

`uv` is "An extremely fast Python package and project manager, written in Rust."

Their README promises that the tool can fully replace all of the Python package
managers we know, love, and hate including `pip` (claiming a speed increase of
10-100x), `pipx`, `poetry`, `virtualenv`
and more.

Shiny features:

- Cross-platform
- Universal lockfile
- Individual script-running
- Backwards-compatible with pip (shared interface)

There are a few other features like "Cargo-style workspaces for scalable
projects", "global cache", "runs and installs tools published as Python
packages" that I will expound on later

Let's get started.

## Installation

I am using a standalone installation process as follows:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

```console
downloading uv 0.6.3 aarch64-apple-darwin
no checksums to verify
installing to /Users/svema/.local/bin
  uv
  uvx
everything's installed!
```

## Resources

- [GitHub: astral-sh/uv](https://github.com/astral-sh/uv)
