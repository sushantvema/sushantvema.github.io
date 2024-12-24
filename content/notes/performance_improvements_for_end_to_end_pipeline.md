---
title: "Contract Evaluation CLI: Performance Improvements for End-to-End Pipeline"
date_created: "2024-11-04T10:02:12"
date: "2024-11-06T21:19:35"
tags:
  - "AlixPartners"
  - "Parallel Processing in Python"
  - "Task"
publish: false
---

Start Date: Monday November 4th

Objective:
  - Currently the contract evaluation CLI handles field extractions and LLM as judge processes sequentially with respect to documents and fields in a schema. 
  - The runtime of the system currently is around O(n). However, if we can bring it down to ~log(n), the time/friction required for iterative improvements in the system would be greatly reduced.

# Technical Requirements
- We have a custom extract_fields function. This differs significantly from the default implementation in ExtractorManager
- We have different levels of parallel processing required:
  - extracting fields
  - citation relevance
  - ground truth accuracy evaluation 

# Status
- Parallelized `extract_fields` capability

Completed
