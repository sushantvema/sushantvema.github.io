---
title: "Streamlit - Pure Python Webapp Framework"
date_created: 2024-12-25T08:24:57
date: 2024-12-25T08:25:00
publish: true
tags:
  - technical
  - web dev
---

[Streamlit GitHub Repository Link](https://github.com/streamlit/streamlit)

> [Streamlit](https://streamlit.io/) turns data scripts into shareable web apps in minutes.
> All in pure Python. No front‑end experience required.

I've never formally studied web development. Neither have I done any frontend engineering with popular frameworks like React.js. However, I have, over the last few years, worked on academic and enterprise software projects with a Streamlit frontend.

The promise of this new framework on the block is that it can simplify the time to delivery of full-stack applications for Python professionals. In their docs itself they say that:

> Streamlit is an open-source Python framework for data scientists and AI/ML engineers to deliver dynamic data apps with only a few lines of code. Build and deploy powerful data apps in minutes.

# Fundamentals

## Data Flow

Streamlit architecture is designed to allow for UI components to be defined within plain python scripts. In order to make this happen, Streamlit apps rerun entire python scripts whenever updates need to be propagated.

- when application source code is updated
- when user interacts with a widget in the app

It stands to reason that because of this constant reloading, streamlit applications are on the slower side.

However, there are certain optimizations which can be done in order to cache data between reloads in a session... e.g the `@st.cache_data` [decorator](https://peps.python.org/pep-0318/) which I will cover later.
