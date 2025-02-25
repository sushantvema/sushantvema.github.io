---
title: Accelerating LLM Inference - Tradeoffs, Design, and New Ideas
date_created: 2025-02-23T18:54:45
date: 2025-02-23T18:54:48
publish: true
author: Sushant Vema
---

_I discuss methods, tradeoffs, and design patterns for accelerating inference of large language models with an eye towards memory management, latency, and throughput._

# Introduction

Most Large Language Models (LLMs) of today are based on autoregressive transformer models. These models are more parallelizable than their ancestor recurrence-based and convolutional models.

# Resources

1. [Accelerating Large Language Model Decoding With Speculative Sampling](https://arxiv.org/pdf/2302.01318)
