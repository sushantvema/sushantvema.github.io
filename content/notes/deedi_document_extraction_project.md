---
title: "Deedi Document Extraction Development"
date_created: "2024-09-19T12:12:52"
date: "2024-09-19T12:12:55"
tags: 
  - "AlixPartners"
publish: false  
---

# Objective

# Tasks

# Meetings

## 2024-09-19 - Deedi Contracts Checkin
Sushant and Kevin Madura. 

Questions:
  - This week I was getting familiar with the code. Reviewed most of the active work items in the Deedi board. 
  - Laptop was finally activated last night. IT had an outage which affected other new laptops.
  - All dev tools configured except Python. IT ticket underway to setup python properly. Currently using ETS VDI to run Deedi and access Azure services. 
  - Branches: How far off is km2/batch-contract-processing from dev-pipeline? Based on some git diffing, the main difference is adding the batch processing capabilities for contracts and some modifications in the class_library pydantic templates for the extractor tool. 
  - Development workflow advice? How to test? How to use logging on a per run basis? Are all of the current branches features in development? Many stale ones. 
  - Get added to the sprint process so I'm aware of what's going on. 
  - Wiki is only on the main branch
  - Any relevant weekly meetings?

Notes:
  - See what the major differences are between km branch and ian's branch. 
  - Backend work. Error handling. See how bad the potential merge conflicts. 
  - RItemselatively separate from everything. 
  - The only real dependencies are the different managers. 
  - Some of the stuff Ian has done might be relevant. Ian is going to be adding a highlighting capability. Prompt library. 
  - Citations: If the user wants it, have additional columns to columns. 
  - Test dataset. Two things that can be sent. 
  - Housekeeping items first. 
  - Longterm: Prompt library. Ways to process longform files. Nitty gritty things about specific documents. Will depend on the input files and specific things. 
  - Evaluation framework. 
  - Retry logic is still in play. 
  - User flow: 
  - New dataset that Kevin is annotating. 
  - Right now we blindly process things. Whatever the model spits out, it splits out. Eventually we want to build in some logic that if we .. from data room, here's a list of credit agreements, loan agreements, purchase agreements, etc. 
  - Long term vision is that each category is associated to a well-defined set of schemas
  - Can't create my own batch. 
  - Asked Ian to add a progress bar to this. 
  - Moving towards a global deployment of OpenAI. All environments will share an aggregate OpenAI instance. 

Action Items:
  - Auto-retry logic or option to do it again. At somepoint figure out a offboard logic. 
  - Failure modes: JSON validation errors. Add additional retries. Another reason is that it fails to be processed by document intelligence. Owned by doc intelligence team. 
  - Touchpoint with Ian. Talk with Mo and see how we want to figure this out. Not being tracked the same way as everything else. 
  -
