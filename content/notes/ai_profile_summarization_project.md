---
title: "AI-Enriched Profile Summarization Project"
author: "Sushant Vema"
date_created: "2024-08-07T08:05:22"
date: "2024-08-07T08:05:32"
tags:
  - "projects"
  - "influential"
publish: false  
---

# A. Introduction
This project is part of Search 2.0. The initiative is to intelligently extract key biographical information from accounts on different social media platforms and synthesize them accurately into a semantically-searchable summary.

Although developed locally on Sushant's laptop, this Markdown document will be synced with [MASTER DOC - AI Profile Summarization](https://influential-team.atlassian.net/wiki/spaces/DS1/pages/edit-v2/416808961?draftShareId=9619d0a4-e9ae-4521-98dd-3b6b9896d852) in Influential Data Science Confluence space.
- Last Synced: "2024-08-07T09:48:58"

From here on out whenever I say "table" I am referring to a [Delta Table on Databricks](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_universe_3304_with_biographies?o=1016658646341465). 

All **TODO:** notes are items which I am planning to implement in the near future. 

# B. Data Assets in Unity Catalog
## Account Filters
- [influential.poc.youtube_universe](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_universe?o=1016658646341465)
  - This Delta Table contains network_account_id's and share_of_sponsored_posts for 3304 accounts on Youtube. I believe these are the top 3304 share_of_sponsored_posts on the platform.
  - Created July 26 by Cyrus
## Account Metadata
- [redshift_social_hoarder.public.network_account_bio](https://dbc-35bfa1f1-1292.cloud.databricks.com/?o=1016658646341465#notebook/967284897779063/command/967284897779096)
  - This Delta Table contains network_account_id's as well as relevant account-level biography data (about, description, headline) for all of the youtube accounts in Redshift at a certain time. Around 1 million unique accounts are covered.
  - Created on July 16 by Alex Begg and updated by Sagar on July 22
## Semantic Retrieval
- [influential.poc.youtube_rag_posts](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_rag_posts?o=1016658646341465)
  - This Delta Table contains sampled cippus data for ~5.5k different network accounts on Youtube (?). There are around 700k total rows, where each row is one cippus post.
## Raw Data, Intermediary Outputs, and Final Results
### POC - Early August
There are quite a few data assets that had to be created just for our POC demos. 
- [influential.poc.youtube_universe_3304_with_biographies](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_universe_3304_with_biographies?o=1016658646341465)
  - This table contains the set of all semantically-retrieved posts for 3304 specified accounts in influential.poc.youtube_universe. Each row is also tagged with the profile level concatenated biography which is referred to in [[ai_profile_summarization_project#Preprocessing the Data for Summarization]]. This will then be grouped to the network_account granularity and then processed for inference. 
- [influential.poc.youtube_universe_3304_preprocessed_for_summarization](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_universe_3304_preprocessed_for_summarization?o=1016658646341465)
  - This table contains all the input data we need to run summarization without having to do any text processing.
- [influential.poc.youtube_24_summarization](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_24_summarization?o=1016658646341465)
  - This table represents the summaries for the 24 accounts with the most posts in our youtube_universe. 
  - NOTE: 3 of these accounts have summaries in a non-English language, despite many efforts in prompt engineering to only output English summaries. Fortunately, this issue is only for accounts where all of the posts are in a different language, and the resulting language the summaries are in are in that same language. When translated with google translate, the non-English summaries are indeed proper, and not gibberish.
- [influential.poc.youtube_summarization_running](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/influential/poc/youtube_summarization_running?o=1016658646341465)
  - This table contains summaries for the 138 accounts with the highest share of sponsored posts as enumerated in (TODO: Don't remember where the 138 accounts were enumerated). 
  - As we proceed with running summaries for the entire 3304 set of viable youtube accounts, we are going to incrementally add new summaries into this table. 

# C. Notebooks in Databricks, Arranged by Function
All of the code for this project is located in [summarization_code_final](https://dbc-35bfa1f1-1292.cloud.databricks.com/browse/folders/2494724513198150?o=1016658646341465). 

## Loading and Synthesizing Data
 [load_and_join_data](https://dbc-35bfa1f1-1292.cloud.databricks.com/?o=1016658646341465#notebook/967284897779063/command/967284897779096)
  - This notebook loads influential.poc.youtube_rag_posts and redshift_social_hoarder.public.network_account_bio. 
  - It writes a table to `output_table` (currently influential.poc.youtube_universe_3304_with_biographies) that is the same as the table at `youtube_universe_df_path` but with one extra column called biography which is the concatenation of about, description, and headline from the network_account_bio table.
## Preprocessing the Data for Summarization
- [summarization_preprocessing](https://dbc-35bfa1f1-1292.cloud.databricks.com/?o=1016658646341465#notebook/2494724513198152/command/967284897779056)
  - This notebook takes in the set of accounts + biographies from `input_table` (currently influential.poc.youtube_universe_3304_with_biographies) and does the following key operations:
    - Cleans each cippus_text: Converts all web links to `[URL_PLACEHOLDER]` and removes new line characters from the text (`\n\n` -> ``). 
    - For each cippus text, add the time_posted as `YYYY-MM-DD` in front of the text value. For example: `2002-02-10: Sushant was born!`. The idea is that by "indexing" cippus posts with the day that they were posted will provide chronological context to the LLM, whose task is to synthesize a lot of sparse information into one concrete narrative summary about an account.
    - Group by network_account_id. Return a dataframe with the network_account_id as the primary key and other fields being:
      - TODO: Sort by `time_posted` ascending
      - The biography concatenation for that account called `unique_biography`, 
      - A list called `text_preprocessed_with_time_posted_list` which contains all of the time-indexed cippus_text's for that account
      - A list called `cippus_id_list` which contains all of the unique ID's for each cippus post in the list. This allows us to backtrack and see more data about individual posts from our backend databases if we need to.
    - Create a new field called `text_preprocessed_with_time_posted_ordered_list_concatenated` that is basically a multi-line string that contains all the time-indexed cippus posts for an account as well as each one's positional index. 
    - Create a new field called context which is a multi-line string where the `unique_biography` is prepended to the previously-mentioned field. This becomes the entire chunk of text we are passing into the LLM as a "user", right after we "system prompt" the LLM with a description of our task.
    - Write the resulting table (where one row represents one network_account) to the `output_table` path in Unity Catalog (currently influential.poc.youtube_universe_24_preprocessed_for_summarization)
## Running Summarization using Batch Inference and Provisioned Throughput Endpoint
- [batch_inference_caller_for_summarization](https://dbc-35bfa1f1-1292.cloud.databricks.com/?o=1016658646341465#notebook/1199737090581057/command/2152236646970918)
  - This notebook does the following:
    - Reads configuration parameters from notebook widgets. Runs basic unit tests on loaded widget values to prevent errors. 
    - Creates a [provisioned throughput endpoint](https://docs.databricks.com/en/machine-learning/foundation-models/deploy-prov-throughput-foundation-model-apis.html) with the selected foundation model with a specified range of upper and lower bounds of tokens/second.
      - This is wrapped by retry logic that posts data to the serving endpoint API until the endpoint is successfully queued to be created. 
      - There is additional logic to poll the endpoint until the endpoint is confirmed to be fully spun up and ready for use.
    - Remotely runs another notebook with a specified set of configuration widget values, as well as a timeout parameter. This produces a "run" artifact which shows clearly the executed remote notebook and any errors that may be raised.
    - If this remote notebook runs successfully without errors, then send a delete request to the serving endpoints API to delete the provisioned throughput endpoint immediately. 

- [summarization_batch_inference_udf](https://dbc-35bfa1f1-1292.cloud.databricks.com/?o=1016658646341465#notebook/2494724513198241/command/967284897779180) 
  - This notebook does the following:
    - Loads the configuration parameters from notebook widgets
    - Creates a `ChatClient` class which wraps an [mlflow deployment client](https://mlflow.org/docs/latest/python_api/mlflow.deployments.html).
    - Writes a function decorated by [pandas_udf](https://spark.apache.org/docs/3.1.2/api/python/reference/api/pyspark.sql.functions.pandas_udf.html), which does the following. For each value in the selected `config_input_column` (in this case, `context` column):
      - Initializes a ChatClient object. 
      - Call the ChatClient.predict function parametrized by the input context
      - Return a Dataframe with a schema specified by the pandas_udf decorator, which includes the summary, the total_tokens consumed in the inference, and any errors if thrown.
    - Loads the input table from `config_input_table_name` and optionally limits the number of rows to `config_input_num_rows`.
    - Runs batch inference on the dataframe:
      - The batches in this case are the partitions of the dataframe, which is repartitioned with `config_concurrency` number of partitions. 
      - The pandas_udf is applied to `config_input_column` and the output values are extracted into new fields into the dataframe.
    - The results are written to a table at `output_table_name` (currently influential.poc.youtube_24_summarization).

> [!NOTE]
    > Here is the current summarization system prompt as of 2024-08-07T09:23:31:

```txt
The following are a series of captions in different languages as well as an account-level biography/headline/description from various videos on an individual's Youtube Channel. Each caption is preceded by the date it was posted. The caption with the earliest date IS NOT NECESSARILY when the individual started to post videos on Youtube. Your task is to read between the lines and come up with a factual yet overarching narrative IN ENGLISH of the individual's life, based on what you can extract from the captions. Write 1 long cohesive paragraph that tries to capture the story of the individual's life in detail IN ENGLISH ONLY. If you are able to gather the following information from the captions alone, include the individual's: gender, education, family structure, work, hobbies, and accomplishments. Otherwise, mention that you are unsure of that specific field of information. Remember that the output should be only 1 long paragraph. Make sure the output language is only in ENGLISH. 
```

## Evaluating the Summaries using LLM-based Metrics
TODO. 
### Deprecated Evaluation Notebooks
- [deprecated_summarization_evaluation](https://dbc-35bfa1f1-1292.cloud.databricks.com/?o=1016658646341465#notebook/2494724513198154)
# D. Execution Flow and Orchestration
The processes described in [[ai_profile_summarization_project#C. Notebooks in Databricks, Arranged by Function]] can be run sequentially, but each component needs a different compute configuration. 

Each component can be modularized into a notebook with associated widgets containing parameter values for:
  - input table path,
  - output table path,
  - all other relevant hyperparameters which need to be specified for that task

By setting widget values in this way, we can remotely call one notebook from a different orchestrator notebook. 

> [!WARNING]
 > It doesn't make sense for me to to incorporate all of my "callee" notebooks into one orchestrator notebook because any notebook that is run within a different notebook uses the latter notebook's cluster ONLY. I should be able to have evaluation callee notebook get called through the summarization caller notebook. 
