---
title: Signal in the Noise - Evaluating and Comparing AI OCR Libraries
date_created: 2024-12-24T17:46:21
date: 2024-12-24T17:46:24
publish: true
tags:
  - technical
  - llms
  - OCR - Optical Character Recognition
---

It is understood that in order to best harness the "multimodal" capabilities of LLM systems, it is required for users to have a solid text representation of the modality. This is especially true for PDFs, Powerpoints, Excel sheets, etc.

Businesses want intelligence layers on all modalities of business resources. Engineers in the open source community are hastily putting together libraries and frameworks to deliver that key capability - to first transform the native modality into a text representation suitable for the LLM and task at hand.

There are so many of these libraries that are popping up in the wild like pokemon. Overzealous LinkedInfluencers are busy running free advertising campaigns for these projects. I will try to document the history of popular AI-powered OCR libraries and do a technical analysis of their capabilities, design patterns, and tradeoffs. I have no stake in any of these projects.

To pre-empt any of this discussion, I am still trying to find out ways to standardize benchmarking for these methods. Without reproducible benchmarks, it's all anecdotal. Very few of these frameworks will be used in enterprise as a standard.

The code-block formatted titles like `organization/project_name` represent GiHub repositories.

# 2021

## December 14th, 2021: `deepdocdetection/deepdocdetection`

> "Not every document class needs to be processed in the same way:
>
> - Native PDF documents do not require a computationally intensive OCR process.
> - For pure text extraction, you may want to consider tables separately or not at all.
> - However, you may also want to perform text or token classification with Foundation Models.
>   With deepdoctection, individual tasks (layout analysis, OCR, PDF text mining, LayoutLM call) can be combined in a pipeline. The components of a pipeline can be some that call models but also components that are purely rule-based."

### My Analysis

This repo is an example of an archetypal NLP/deep learning based solution for document analysis.
Slow adoption until April 26th 2023 and then it exploded in popularity ([GitHub Star History](https://star-history.com/#deepdoctection/deepdoctection&Date)), with continued vigorous adoption.

# 2024

## September 20th, 2024: `microsoft/OmniParser`

title: "OmniParser: Screen Parsing Tool for Pure Vision Based GUI Agent"

> OmniParser is a comprehensive method for parsing user interface screenshots into structured and easy-to-understand elements, which significantly enhances the ability of GPT-4V to generate actions that can be accurately grounded in the corresponding regions of the interface.

### My Testing

- TODO

### My Analysis

This is one of a few notable image-to-text libraries that came from a large enterprise (Microsoft Research and MS GenAI).

> [!IMPORTANT]
> This tool is NOT for traditional OCR. It specializes in representing digital User Interfaces as text. This is a huge field of research for making agentic AI systems more reliable.

As stated, they have developed the solution to complement GPT-4V models since Microsoft has a vested interest in OpenAI.

- This is interesting because Microsoft has it's own [Phi-3 family of open models](https://azure.microsoft.com/en-us/products/phi). In August, they released [Phi-3.5-vision-instruct](https://huggingface.co/microsoft/Phi-3.5-vision-instruct) with 4 billion parameters. Haven't tested this out yet.

There is a markdown asymptotic trend for the repo's [Github Star History](https://star-history.com/#microsoft/OmniParser&Date). I suspect the initial explosion in stars was due to LinkedInfluencer hype.
