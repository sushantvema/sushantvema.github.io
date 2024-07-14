---
title: "AI Profile Summarization Evaluation Strategy"
author: "Sushant Vema"
date_created: "2024-07-08T17:01:44"
date: "2024-07-09T09:54:53"
tags:
  - "technical"
publish: false
---

***Goal*** : Architect a framework for evaluating the performance of any given Retrieval-Augmented Generation system which outputs post-enriched profile summaries of various `network_account_id`'s. 

> With the rise of LLMOps (an extension of MLOps tailored for Large Language Models), the integration of CI/CE/CD (Continuous Integration/Continuous Evaluation/Continuous Deployment) has become indispensable for effectively overseeing the lifecycle of applications powered by LLMs. - Jane Huang, Microsoft Data Science

In order to create a common language for this application's development, I tried to define some commonly used compononents.

## Definitions

- **Profile** :
  - A profile is a collection of `network_account_id`'s and their associated metadata connected to one user in real life.

> [!WARNING]
> Currently we don't have a way of associating all of the `network_account_id`'s together for a user with high confidence. Currently we're creating summaries for enriched profiles where there is only one `network_account_id` in that entire profile. The three platforms we restricted ourselves to are: Tiktok, Youtube, and Instagram. 

- **Biographically-Enriched Profiles**:
  - A biographically-enriched profile is a profile and metadata in tabular format. For each `network_account_id` in the profile, we match all the users's posts on that network/platform across their timeline and filter for a predetermined set of metadata across the `network_account`'s and their posts. 
  - There is then an intelligent sampling process overseen by @Cyrus through which the thousands of rows in the joined profile set are filtered to some N number of rows, where each selected row is said to represent a post with significant biographical information content. The end result is a "biographically-enriched (intelligently-sampled) profile".

- **Extractive Profile Summary**:
  - An extractive profile summary is JSON object with fields representing pertinent caetgories of information as requested by Mack in the following spreadsheet, in the "Future Wishlist" sheet: [Search 2.0 Fields/Filters/Results Requirements](https://docs.google.com/spreadsheets/d/1G5tik5h-ObRDtcxKQMkEgSTmBLoYZFjwDU4ey7hsKjs/edit?gid=1256365428#gid=1256365428). Not all of the fields in the spreadsheet are possible to extract from the enriched profiles; the schema below will be the source of truth for what I believe is possible to extract. 
  - Also refer to the following spreadsheet for specific values that are desired: [Influencer Summary Wishlist](https://docs.google.com/spreadsheets/d/10tOt5hY5so9qKCXhRy6r9rDspNvw443JBmuYPv6rVQA/edit?gid=0#gid=0)

To create an open-source model that outputs a JSON with a specific schema as an extractive summary, we will follow theses steps:
  1. Define the schema, including Enum classes for predetermined choices. 
  2. Modify the model: Adapt an existing open-source summarization model to output the desired JSON format instead of plain text.
  3. Implement Enum classes: Define Enum classes in the code to represent the predetermined choices for each field. 
  4. Post-processing: Add a post-processing step that converts the model's output into the required JSON format if necessary, ensuring that it adheres to the schema and uses the Enum values. 
  5. Fine-tuning: Fune-tune the model on a dataset of text-JSON summary pairs to improve its performance in generating summaries in the desired format. 

To evaluate this system, we consider the following methods:
  1. Schema Compliance: Verify that the output JSON always follows the predefined schema and uses only valid Enum values. 
  2. Content relevance: Assess how well the extracted information represents the key points of the input text.
  3. Extractive accuracy: Compare the model's output to human-generated extractive summaries using metrics like ROUGE or BLEU.
  4. Information completeness: Evaluate whether the summary captures all essential information required by the schema. 
  5. Consistency: Check if the model produces consistent results for similar inputs. 
  6. Human Evaluation: Have human raters assess the quality and usefulness of the generated summaries. 
  7. Task-specific metrics: Develop custom metrics based on the specific use case, requirements, and domain. 

```python
from enum import Enum

class Gender(Enum):
   Male: "male"
   Female: "female"
   Nonbinary: "non-binary"

class Pronouns(Enum):
   She_series: "she/her/hers"
   He_series: "he/him"
   They_series: "they/them"
   Other: "other"

class LifeMoments(Enum):
   Engaged: "engaged"
   Just_married: "just married"
    
    
```

  - Here is an tentative example of the schema of this JSON object:

```json
{
  age_range" : 
    {
      "estimate": AGE_RANGE,
      "confidence_level": CONFIDENCE_LEVEL
    },
  "location": 
    {
      "estimate": LOCATION_NAME,
      confidence_level: CONFIDENCE_LEVEL
    },
  "occupation":
    {
      "estimate":  OCCUPATION_ESTIMATE,
      confidence_level: CONFIDENCE_LEVEL 
    },    
  "ethnicity":
    {
      "estimate": ETHNICITY,
      confidence_level: CONFIDENCE_LEVEL
    },
  gender:
    {
      "estimate": GENDER_ENUM,
      confidence_level: CONFIDENCE_LEVEL
    },
  suggested:
    {
      "NOT SURE": "NOT SURE"
    }
}

```

> [!WARNING]
> I'm not quite sure what "Account: Suggested | Accounts we have put on a list" means. @Mack will have to clear that up.

  - **Abstractive/Narrative Profile Summary**:
    - An abstractive or narrative profile summary attempts to take a biographically-enriched profile, and generate a long-form, story-like overview of the the user's history. 
    - This approach is inspired by @Anj and needs further iteration to design
    - This flavor of summary is NOT meant to be easily queryable for information. It is meant to represent a creative, fresh take on the user which might be insightful to our analysts and operations teams.
    - TODO: Add an example of what this might look like.

## Evaluation Philosophy

References:
  - [[rouge|ROUGE: Recall-Oriented Understudy for Gisting Evaluation]]
  - [[bertscore|BERTScore: Evaluating Text Generation Semantically with BERT]]

Large-language models are now capable of accomplishing many different tasks with limited support. When models become powerful enough, they are capable of [zero-shot learning](https://en.wikipedia.org/wiki/Zero-shot_learning), where they can solve tasks with reasonable to high fidelity without seeing ground-truth examples of how to do so. 

Our overall task of profile summarization is multiple steps, but is also highly iterative in nature:
  1. Semantic data retrieval to get biographical information from an entire timeline
  2. Extractive text summarization to output JSON
  3. Abstractive/narrative text summarization
  4. Expose our curated output summary on our interface
  5. Evaluation and alignment for each paradigm of summary

This document will dive deep in step 5) but it should be noted that aspects of evaluation and alignment will we incorporated in all stages of the pipeline.

## Phase 1 Evaluation Strategy - By Friday July 12th, 2024

***Goal:***
1. Research different metrics to use in our test suite
2. Standardize input prompt schema
3. Make sure we get the remaining profile-level information into the enriched profiles. 
  - Cippus dates integrations
  - Network account type (what platform)
  - @Cyrus, @Ryan, what am I missing?
4. Agree on schema for extractive summarization
5. Decide on a scope for which `network_account_id`'s to use in our sample.
  - Since we're not finetuning anything, we can treat all of the `network_account_id`'s as a test set.

Metrics: ROUGE + BERTScore. TODO: LLM as a judge / G-Eval
- Which model to use for BERTScore? Maybe the same one that @Cyrus is using?

Looks like we shouldn't use ROUGE for the extractive summary. 

### Sample
TODO: We use a sample of X `network_account_id`'s from the dataset located at [dab/Volumes/Influential/shared/tables](https://dbc-35bfa1f1-1292.cloud.databricks.com/explore/data/volumes/influential/shared/tables?o=1016658646341465) in Databricks. 

- `ai_sample.csv` is the original sample
- `ai_sample_2.csv`, `ai_sample_200.csv`, and `ai_sample_50.csv` are datasets with more `network_account_id`'s.
  - These might not be nicely curated biographically as the original dataset.

### Algorithm
For each network_account_id in enriched_profiles:
  - `create_input_text()`
    - TODO: text preprocessing to remove uninformative tokens
    - TODO: Add cippus dates 
    - TODO: Add instructions to the top
  - `generate_summary()`
    - Use selected model and prompt to generate zero-shot summary from input, from a given specification (extractive or abstractive)
  - `evaluate()`
    - TODO: Calculate metrics and store as list of dictionaries. Standardize metrics logging

## Phase 2 Evaluation Strategy - By end of July, 2024

@Sagar please audit this part if you will :)

***Goal:***
1. Design monitoring integrations in Databricks and choose what information to track
2. Prompt version control and experimentation
3. Decide if we need a few-shot approach. How would we then create a ground-truth dataset?
  - Anecdotally, synthetically-generating datasets using LLMs is not very good
  - LLM as a judge as been promising in order to gain some subjective understanding of contextual relevance
4. Decide if we need a query reranking step in order to maximize model attention. Depends on a case coverage analysis on the retrievals + summaries. 

## Current Reading List:
  - [LLM-based NLG Evaluation: Current Status and Challenges - 2024](https://arxiv.org/pdf/2402.01383)
  - [G-Eval: NLG Evaluation using GPT-4 with Better Human Alignment](https://arxiv.org/pdf/2303.16634)
  - [OpenAI Cookbook: How to evaluate a summarization task - 2023](https://cookbook.openai.com/examples/evaluation/how_to_eval_abstractive_summarization)

