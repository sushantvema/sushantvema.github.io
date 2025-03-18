---
title: "Building an LLM Inference Engine 'From Scratch'"
date_created: 2025-02-19T19:40:30
date: 2025-02-19T19:40:32
tags:
  - open-source
  - personal project
author: Sushant Vema
publish: true
---

Let's learn how to build a llm inference engine from scratch.

## Philosophy

> Abstraction forces you to reach the highest level of the basics. - Alan Soffer

### Introduction

In the rapidly evolving field of Artificial Intelligence (AI), I have observed
that large language models (LLMs) have emerged as powerful tools for generating
human-like text, understanding context, and performing various language-related
tasks. As an AI engineer, I find that building an LLM inference engine from
scratch presents a unique opportunity to deepen my understanding of these
complex systems and contribute to rapidly innovating projects.

Creating my own LLM inference engine allows me to tailor the architecture and
functionality to specific needs, enhancing my capacity to innovate and solve
real-world problems. While established companies have dominated this space due
to their resources and infrastructure, I believe that developing a custom
inference engine can lead to a better grasp of the underlying mechanics of
transformers and their scalability in handling large datasets.

This exploration not only equips me with practical skills in model deployment
and optimization but also opens avenues for experimentation and creativity in AI
applications. In this document, I will delve into the significance of building
an LLM inference engine, the challenges it presents, and the potential benefits
for both individual engineers and the broader AI community.

### Pricing of AI Inference Vendors

LLM inference pricing is influenced by several key factors across different
platforms:

1. Token usage: Both input and output tokens contribute to costs. For example:

   - OpenAI's GPT-4 charges $0.03 per 1K input tokens and $0.06 per 1K output
     tokens.
   - Together.ai's Llama 3.2 3B model costs $0.06 per million tokens.

2. Model complexity: More sophisticated models with higher performance metrics
   generally cost more. For instance:

   - GPT-4 (MMLU score 83) is more expensive than GPT-3.5.

3. API call volume: Some providers offer tiered pricing based on the number of
   API calls made.

4. Context window size: Larger context windows typically increase costs.

5. Response time requirements: Lower latency often comes at a premium.

6. Media type: Processing audio or video is generally more expensive than text.

7. Tokenization method: Different methods (e.g., Byte-Pair Encoding, WordPiece,
   SentencePiece) can affect token counts and costs.

8. Language: English often requires fewer tokens compared to other languages.

9. Special characters: These may incur extra costs in some pricing models.

10. Subscription vs. pay-per-use: Many providers offer both options, with
    different pricing structures.

11. Fine-tuning and customization: Customized models often come with additional
    costs.

12. Hardware requirements: Models requiring specialized hardware (e.g., NVIDIA's
    Blackwell AI chips) may have higher associated costs.

Concrete examples of pricing models:

- Microsoft Copilot: Free version with limited credits, Pro plan at $20/month
  for preferred model access.
- Google Gemini: Basic free plan with 2.0 Flash model access, Advanced plan at
  $19.99/month for 2.0 Pro experimental model.
- OpenAI: Tiered pricing from free to enterprise levels, with Plus plan at
  $20/month and Pro plan at $200/month offering different usage limits and model
  access.
- Claude.ai: Free plan with limited usage, Pro plan at $18/month (billed
  annually) for Claude 3.5 Sonnet & Opus access.

These factors and pricing models illustrate the complex landscape of LLM
inference costs across platforms, with providers balancing performance,
accessibility, and profitability.

Citations: [1]
<https://www.reddit.com/r/LocalLLaMA/comments/1gpr2p4/llms_cost_is_decreasing_by_10x_each_year_for/>
[2]
<https://www.restack.io/p/large-language-models-answer-cost-analysis-llm-inference-cat-ai>
[3] <https://research.aimultiple.com/llm-pricing/> [4]
<https://a16z.com/llmflation-llm-inference-cost/> [5]
<https://www.baeldung.com/cs/llm-cost> [6]
<https://symflower.com/en/company/blog/2024/managing-llm-costs/> [7]
<https://www.tensorops.ai/post/understanding-the-cost-of-large-language-models-llms>
[8] <https://www.superagent.sh/blog/the-future-of-llm-costs> [9]
<https://insights.encora.com/insights/the-economics-of-llms>

### Privacy

## Requirements

- MacOS support
- high throughput
- memory efficient
-

### Achieving High Throughput

> High throughput serving of large language models (LLMs) requires batching
> sufficiently many requests at a time. However, existing systems struggle
> because the key-value cache (KV cache) memory for each request is huge and
> grows and shrinks dynamically. (Kwon et al. 2023)

### Mechanisms of LLM Inference

### Self-Attention

$$ \text{Attention}(Q, K, V) = \text{softmax}(\frac{QK^T}{\sqrt{d_k}})V $$

Where $Q$ is the query matrix, $K$ is the key matrix and $V$ is the value
matrix.

At the beginning of a transformer layer, _each token corresponds to an embedding
vector_ ($x$).

$x$ is multiplied by three different matrices to generate the query, key, and
value vectors and matrices like so:

- $q = W_qx$
- $K = W_kx$
- $V = W_vx$

$Q, K, V$ are all matrices learned from data.

The query vector $q$ is the representation of the new token in this latest
decoder step. The key matrix $K$ is the previous context that the model should
"attend to". The value matrix $V$ is the weighted sum over the previous context

- looking carefully at the

## Resources (Academic Papers)

1. [Efficient Memory Management for Large Language Model Serving with
   _PagedAttention_](https://arxiv.org/pdf/2309.06180)
