---
title: "Contract Evaluation/Optimization CLI Tool"
date_created: "2024-11-04T09:51:29"
date: "2024-11-05T11:47:48"
tags:
  - "AlixPartners"
  - "Information Extraction"
publish: false
---

This document contains information about my work developing a CLI tool for contracts. The tool has many functions. 

# Targets
- [x] [(Monday November 4) Performance Improvements for End-to-End Pipeline](performance_improvements_for_end_to_end_pipeline)
- [WILL NOT COMPLETE] [(Wednesday November 7) A/B Test Extraction Performance Between Instructor and Structured Outputs API](ab_test_extraction_performance_instructor_structured_outputs)
- [x] [(TBD) 10-K Document Extraction and Evaluation](documents_10k_adhoc_extraction)

# Meeting Notes

- Sometimes 
- Organic schema builder
- Initial draft of the ground truth evaluation framework
- Supporting documents that exceed the context window. 
- Shift focus to using longer form documents and use. 
- Create a batch of files which we assume exceed the token window. 
- Supporting long form documents
- Qusi RAG style, chunk the document. Splitting markdown headers. 
- Accumulator. Final output schema. Go 80000 tokens at a time. Most promising. 
- In litigation, it's important to have citations down to the line and the word. It's not always required. It's a core feature that we should support. Doing it the right way is somewhat subjective. How we present it to the user ultimately is subjective. 
- Never had an issue with citations. 
- Each field should be derived from something in the document. 
- Detecting specific legal clauses and language. Does this exist or not?
- Do a vector query based on the field that we're looking for. 
- We have the pieces in place. 

# int-team-dd-daily-updates
## November 4 - 5

## November 13
11/13
- continuing push for long-form documents capability in Extractor. Rolling window algorithm is coming together
- testing a modification of our contract schemas to consistently output one default value; this would address the issue of Structured Outputs not supporting Pydantic Field defaults natively; my fix looks promising
- going to start putting together a dataset of extremely large documents to begin quality testing
