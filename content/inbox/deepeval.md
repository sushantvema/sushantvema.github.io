---
title: "DeepEval: an open-source LLM evaluation framework"
author: "Sushant Vema"
date_created: "2024-07-15T13:33:35"
date: "2024-07-15T13:33:38"
tags:
  - "technical"
publish: true
---

[DeepEval](https://github.com/confident-ai/deepeval) is an open-source LLM evaluation framework created in August 2023 by [Confident AI](https://www.confident-ai.com/).
> Pytest unit-testing but for LLM outputs

Uses metrics such as:
  - G-Eval
  - hallucination
  - answer relevancy
  - RAGAS

These metrics use LLMs and other NLP models which run locally on machine for evaluation. 

For applications ranging from RAG to finetuning, built on LlamaIndex to LangChain, deepeval provides coverage. We can use it to:
  - Determine hyperparameters to improve RAG pipeline
  - Prevent [prompt drifting](https://cobusgreyling.medium.com/prompt-drift-4873f37c43c8)
  - Transitioning from OpenAI to LlamaN with confidence

# Metrics and Features
> Large variety of ready-to-use LLM evaluation metrics (all with explanations) powered by ANY LLM of your choice, statistical methods, or NLP models that runs locally on your machine:
  - G-Eval
  - Summarization
  - Answer relevancy
  - Faithfulness
  - Contextual recall
  - Contextual precision
  - RAGAS
  - hallucination
  - Toxicity
  - Bias
  - "etc"

- Promises parallel evaluation in under 20 lines of python code. Can use a CLI like Pytest or through the `evaluate()` function. 
- Create custom metrics that are automatically integrated with DeepEval's ecosystem by inheriting base metric class. TODO: Examples?
- Integrates seamlessly with any CI/CD environment
- Benchmark any LLM on popular benchmarks in under 10 lines of code.
  - [MMLU](https://paperswithcode.com/sota/multi-task-language-understanding-on-mmlu)
  - [HellaSwag](https://rowanzellers.com/hellaswag/)
  - [DROP](https://allenai.org/data/drop)
  - [Big-Bench Hard](https://github.com/suzgunmirac/BIG-Bench-Hard)
  - [TruthfulQA](https://arxiv.org/abs/2109.07958)
  - [HumanEval](https://github.com/openai/human-eval)
  - GSM8k

- Automatically integrated with Confident AI for continuous evaluation throughout the lifetime of the app. 
  - Log evaluation results and analyze metrics pass / fails
  - Compare and pick the optimal hyperparameters (e.g prompt templates, chunk size, models used, etc) based on evluation results
  - Debug evaluation results using [LLM tracing](https://langfuse.com/docs/tracing)
  - Manage evaluation test-cases / datasets in one place
  - Track events to identify live LLM responses in production
  - real-time evalution in production
  - add production events to existing evaluation datasets to strengthen eval over time


Integrations:
  - LlamaIndex, [unit test rag applications in CI/CD](https://docs.confident-ai.com/docs/integrations-llamaindex)
  - Huggingface, [enable real-time evaluations during LLM fine-tuning](https://docs.confident-ai.com/docs/integrations-huggingface)
# Quickstart Tutorial
Let's assume my LLM application is a RAG-based [customer support chatbot](https://sendbird.com/blog/ultimate-guide-to-ai-customer-service-chatbots); here's how we can use DeepEval to help test our app.

`pip install -U deepeval`

> [!NOTE]
> There's an option to create an account on the platform (Confident AI). This is optional and we can totally run test cases even without being logged in. To login, run: `deepeval login`. Follow the instructions in the CLI to create account, copy API key, and paste into CLI. All test cases will be logged automatically. Here is [information about data privacy](https://docs.confident-ai.com/docs/data-privacy)

## Writing our first test case
Create a test file:
`touch test_chatbot.py`

Open the file and write our first test case using DeepEval:

```python
import pytest
from deepeval import assert_test
from deepeval.metrics import AnswerRelevancyMetric
from deepeval.test_case import LLMTestCase

def test_case():
    answer_relevancy_metric = AnswerRelevancyMetric(threshold=0.5)
    test_case = LLMTestCase(
        input="What if these shoes don't fit?",
        # Replace this with the actual output from your LLM application
        actual_output="We offer a 30-day full refund at no extra costs.",
        retrieval_context=["All customers are eligible for a 30 day full refund at no extra costs."]
    )
    assert_test(test_case, [answer_relevancy_metric])
```

Set `OPENAI_API_KEY` as environment variable (can also evaluate using custom models; [check out these docs for using custom models](https://docs.confident-ai.com/docs/metrics-introduction#using-a-custom-llm))

