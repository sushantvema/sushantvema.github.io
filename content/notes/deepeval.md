---
title: "DeepEval: an open-source LLM evaluation framework"
author: "Sushant Vema"
date_created: "2024-07-15T13:33:35"
date: "2024-07-15T13:33:38"
tags:
  - "technical"
  - "Large Language Models (LLMs)"
publish: true
---

This document will represent my takeaways from doing a deep-dive on DeepEval, an open-source LLm evaluation framework. This research is motivated by a current initiative to build robust evaluation pipelines during my [[letter_to_potential_employers#Data Science / ML Engineering @ Influential.co|contract project at Influential.co]]. 

# References and Communities
- [Confident AI Weekly Newsletter](https://www.confident-ai.com/blog)
- [DeepEval Official Discord community](https://discord.com/invite/a3K9c8GRGt)
# Takeaways
DeepEval provides an easily understandable and extensible taxonomy within its API for building evaluation frameworks. It comes with a full-featured CLI tool and Python API.

The most important component is its [metrics](https://github.com/confident-ai/deepeval/tree/main/deepeval/metrics). It represents a list of curated categories of metrics which we can pick and choose per the nature of our LLM application and domain. Here's a list of natively-supported metrics, but there is [documentation on how to create custom metrics for yourself](https://docs.confident-ai.com/docs/metrics-custom). 
- answer_relevancy
- bias
- contextual_precision
- contextual_recall
- contextual_relevancy
- faithfulness
- g_eval
- hallucination
- knowledge_retention
- summarization
- toxicity
- ragas (most of the same metrics as above, but evaluated with ragas)

> [!NOTE]
> > "DeepEval and RAGAs have very similar implementations, but RAGAs metrics are not self-explaining, mkaing it much harder to debug unsatisfactory results." - [Top 5 Open-Source LLM Evaluation Frameworks in 2024](https://dev.to/guybuildingai/-top-5-open-source-llm-evaluation-frameworks-in-2024-98m#:~:text=DeepEval%20and%20RAGAs%20have%20very,harder%20to%20debug%20unsatisfactory%20results.)
There is a notion of a `Dataset` (an evaluation dataset) which is a collection of `LLMTestCase`s and/or `Golden`s. There are two paradigmatic approaches to evaluating datasets in `deepeval`:
  - using `@pytest.mark.parametrize` and `assert_test`
  - using `evaluate`

> [!NOTE]
  > A `Golden` is very similar to an `LLMtestCase` but they are more flexible since they don't require an `actual_output` at initialization. *While test cases are always ready for evaluation, a `Golden` isn't.*   

There's almost something called a [Synthesizer](https://docs.confident-ai.com/docs/evaluation-datasets-synthetic-data) which looks interesting. This feels like some sort of iterative process to generate at best a "realistic" "out of sample" evaluation dataset or at worst, a vast corpus of data of different complexities, which might cover unexpected edge cases. Here's a [great article about how deepeval's Synthesizer was built](https://www.confident-ai.com/blog/the-definitive-guide-to-synthetic-data-generation-using-llms).

Another useful abstraction is [Metrics](https://docs.confident-ai.com/docs/metrics-introduction) and [Test Cases](https://docs.confident-ai.com/docs/evaluation-test-cases). Think of metrics as "rulers" and test cases as what you're actually measuring. There are custom and default metrics. Metrics can be other `LLM-Eval` or `classic` metrics. A classic metric is one whose criteria isn't evaluated using an LLM. This quote from the docs provides great insight into how DeepEval implements LLM evaluations:
> deepeval also offers default metrics. Most default metrics offered by deepeval are LLM-Evals, which means they are evaluated using LLMs. This is deliberate because LLM-Evals are versatile in nature and better align with human expectations when compared to traditional model based approaches.
deepeval's LLM-Evals are a step up to other implementations because they:
- are extra reliable as LLMs are only used for extremely specific tasks during evaluation to greatly reduce stochasticity and flakiness in scores.
- provide a comprehensive reason for the scores computed.
All of deepeval's default metrics output a score between 0-1, and require a threshold argument to instantiate. A default metric is only successful if the evaluation score is equal to or greater than threshold.

DeepEval allows us to [use any custom LLM for evaluation](https://docs.confident-ai.com/docs/metrics-introduction#using-a-custom-llm). Although not explicitly mentioned, we should be able to use the OpenAI API with our model-serving endpoint on Databricks with no problem

There are also protocols for Async and debugging metrics.

DeepEval is a framework developed by Confident AI. DeepEval can integrate into their platform which is similar to other monitoring platforms. But it isn't self-hostable. I need to work on designing an integration between DeepEval and MLflow, since MLflow is default in Databricks platforms.

DeepEval documentation also provides an assortment of useful guides, similar to [OpenAI Cookbook](https://cookbook.openai.com/):
  - [RAG Evaluation using DeepEval](https://docs.confident-ai.com/docs/guides-rag-evaluation)
  - [Optimizing Hyperparameters Using DeepEval](https://docs.confident-ai.com/docs/guides-optimizing-hyperparameters)
  - [Regression Testing LLM Systems in CI/CD Using DeepEval](https://docs.confident-ai.com/docs/guides-regression-testing-in-cicd)
  - [Building Custom LLM Metrics in DeepEval](https://docs.confident-ai.com/docs/guides-building-custom-metrics)
  - [Answer Correctness Metric in DeepEval](https://docs.confident-ai.com/docs/guides-answer-correctness-metric)

# Intro to DeepEval
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

Finally, run `test_chatbot.py` in the CLI:
  - `deepeval test run test_chatbot.py`

This test should have passed. Here's a breakdown of what happened:
  - Variable `input` mimics user input, and the `actual_output` is a placeholder for chatbot's intended output based in `input`
  - `retrieval_context` contains relevant information from knowledge base and `AnswerRelevancyMetric(threshold=0.5)` is out-of-the-box metric provided by DeepEval. Helps evaluate relevancy of LLM output based on context.
    - TODO: How does this really work under the hood?
  - Metric score ranges from 0-1. `threshold=0.5` threshold determines whether test has passed or not, similar to [logistic regression](https://en.wikipedia.org/wiki/Logistic_regression#:~:text=Logistic%20regression%20is%20a%20supervised,based%20on%20patient%20test%20results.). 

[Here are additional docs](https://docs.confident-ai.com/docs/getting-started) for more information on how to:
  - use additional metrics
  - create custom metrics
  - tutorials on how to integrate with other tools like LangChain and LlamaIndex


## Evaluating Without Pytest Integration
This is best suited for notebook-based environments. 

```python
from deepeval import evaluate
from deepeval.metrics import AnswerRelevancyMetric
from deepeval.test_case import LLMTestCase

answer_relevancy_metric = AnswerRelevancyMetric(threshold=0.7)
test_case = LLMTestCase(
    input="What if these shoes don't fit?",
    # Replace this with the actual output from your LLM application
    actual_output="We offer a 30-day full refund at no extra costs.",
    retrieval_context=["All customers are eligible for a 30 day full refund at no extra costs."]
)
evaluate([test_case], [answer_relevancy_metric])
```

## Using Standalone Metrics
DeepEval is "extremely modular", maling it easy for anyone to use their metrics. 

```python
from deepeval.metrics import AnswerRelevancyMetric
from deepeval.test_case import LLMTestCase

answer_relevancy_metric = AnswerRelevancyMetric(threshold=0.7)
test_case = LLMTestCase(
    input="What if these shoes don't fit?",
    # Replace this with the actual output from your LLM application
    actual_output="We offer a 30-day full refund at no extra costs.",
    retrieval_context=["All customers are eligible for a 30 day full refund at no extra costs."]
)

# Note the new API for evaluation
answer_relevancy_metric.measure(test_case)
print(answer_relevancy_metric.score)
# Most metrics also offer an explanation
print(answer_relevancy_metric.reason)
```

## Evaluating a Dataset / Test Cases in Bulk
> [!NOTE]
> In DeepEval, a dataset is simply a collection of test cases. Here is how you can evaluate them in bulk:

```python
import pytest
from deepeval import assert_test
from deepeval.metrics import HallucinationMetric, AnswerRelevancyMetric
from deepeval.test_case import LLMTestCase
from deepeval.dataset import EvaluationDataset

first_test_case = LLMTestCase(input="...", actual_output="...", context=["..."])
second_test_case = LLMTestCase(input="...", actual_output="...", context=["..."])

dataset = EvaluationDataset(test_cases=[first_test_case, second_test_case])

@pytest.mark.parametrize(
    "test_case",
    dataset,
)
def test_customer_chatbot(test_case: LLMTestCase):
    hallucination_metric = HallucinationMetric(threshold=0.3)
    answer_relevancy_metric = AnswerRelevancyMetric(threshold=0.5)
    assert_test(test_case, [hallucination_metric, answer_relevancy_metric])
```

Run this in the CLI, you can also add an optional `-n` flag to run tests in parallel.
`deepeval test run test_<filename>`

Alternatively, we can evaluate a dataset/test cases without using Pytest integration:

```python
from deepeval import evaluate
...

evaluate(dataset, [answer_relevancy_metric])
# or
dataset.evaluate([answer_relevancy_metric])
```

# Real-time Evaluations on Confident AI
There is a free web platform to:
1. Log and view all the test results / metrics data from DeepEval's test runs.
2. Debug evaluation results via LLM traces. 
3. Compare and pick optimal hyperparameters as mentioned previously.
4. Create, manage, and centralize evaluation datasets. 
5. Track events in production and augment evaluation dataset for [continuous evaluation of LLMs](https://semaphoreci.com/blog/llms-continuous-evaluation)
6. Track events in production, view evaluation results and historical insights. 

Everything on Confident AI integration is located [here](https://docs.confident-ai.com/docs/confident-ai-introduction).

# References
- [[llm_evaluation|LLM Evaluation]]
