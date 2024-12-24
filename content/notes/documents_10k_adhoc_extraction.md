---
title: "Adhoc Request for Extraction and Evaluating Information from 10-K Documents"
date_created: "2024-11-04T14:03:00"
date: "2024-11-04T14:03:06"
tags:
  - "Task"
  - "AlixPartners"
publish: false
---

Notes:
  - William Carson joined a week ago and working on the extractor. Monty reached out to Mo about getting infromation from a set of 10-K documents.
  - 6 10-K's for beauty product distributor companies. 
  - The task was to extract all of the members from the 6 companies. These 6 companies sell to local distributors.
  - All the franchisers are called members. Sales leaders. Distributors.
  - In the example he walked through, they have to be added together.
  - What was the purpose of this? Low pressure on this. Needed next week. This is a manual process
  - He emphasized the need for precision.
  - People need to testify on this as expert witnesses.
  - Have to think about handling longer documents.
  - Doesn't neatly fit into the extractor capability that we have. This is more adhoc because we're adding up numbers and whatnot. File Q&A might work better?
  - Table extraction already exists.
  - The ask is them trying to test out Deedi.
  - Try doing it in dev first. Use either Single file search. This has been a little finicky. Under the advanced menu in the left, put it in there.
  - Deedi chat created ephemeral storage in the OpenAI side. Creates its own vector store, mini RAG.
  - File Q&A is a much more customized process. Dev-specific blob storage. Because these are individual files.
  - Milton can actually help with ingestion process. Then use File Q&A. Then go back to Monty with the results.
  - Extractor is a template-based system, so we want something that's generalizable across different types of documents.
  - Ping this group after the single file search.
  - Chloe is working on the interactive table of results
  - Kevin is inclined to remove the citation piece altogether. One output table of final results.
  - Consultants need the ability to have a final list of everything.
  - Dynamic template creation was not flowing through. Template was not being passed through or created properly.
  - Some of the past failures are difficulties of instructor enforcing the output schema. Max token error, generating too many tokens for the output.
  - Kevin started rewriting it over the weekend with structured outputs. We have error capturing in the single file case. 
