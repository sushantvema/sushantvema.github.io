---
title: "ROUGE: Recall-Oriented Understudy for Gisting Evaluation"
date: 2024-07-08T14:51:19
tags:
  - "technical"
---

tl;dr: ROUGE is a simple framework for evaluating the lexical similarity between model-generated text and human-curated references using N-grams. Summarization falls under this umbrella. Given the vast possibilities of current AI-generated text, having a lexical similarity metric as part of an evaluation suite seems essential since there are less corner cases than for semantic understanding.  

Original Paper: [ROUGE: A Package for Automatic Evalation of Summaries - 2004](https://aclanthology.org/W04-1013/)

---

ROUGE (Recall-Oriented Understudy for Gisting Evaluation) is a set of metrics as well as a software package specifically designed for evaluating [automatic summarization](https://en.wikipedia.org/wiki/Automatic_summarization). 

In this article, I'll cover the main metrics used in this package. 

## ROUGE-N
ROUGE-N measures the number of matching [N-grams](https://en.wikipedia.org/wiki/N-gram) between the model-generated text and a human-produced reference. 

Consider the reference *R* and the candidate summary *C*:
  - *R*: "Sushant likes to cook in the kitchen."
  - *C*: "Sushant enjoys renovating the kitchen."

### ROUGE-1
Using *R* and *C*, we are going to compute the [precision, recall, and F1-score](https://blog.exsilio.com/all/accuracy-precision-recall-f1-score-interpretation-of-performance-measures) for the matching n-grams. Start by computing ROUGE-1 for 1-grams only.


> [!NOTE]
> **Definition**: ROUGE-1 precision can be computed at the ratio of the number of unigrams (1-grams) in *C* that appear also in *R*, over the number of unigrams in *C*. 


ROUGE-1 precision = 3/5 = 0.6. "Sushant", "the", and "kitchen" are all unigrams that are in both *R* and *C*, and there are 5 unigrams in *C*.

> [!NOTE]
 > **Definition:**  ROUGE-1 recall can be computed as the ratio of the number of unigrams in *R*  that appear also in *C*, over the number of unigrams in *R* .

The ROUGE-1 recall is 3/7 = 0.43.

The ROUGE-1 F1-score can be directly obtained from the ROUGE-1 precision and recall using the standard F1-score formula:

ROUGE-1 F1-score = 2 * (precision * recall) / (precision + recall) = 

This approach generalizes to N-grams such as ROUGE-2, 3 etc.

## ROUGE-L
ROUGE-L is based on the (longest common subsequence or LCS)[https://en.wikipedia.org/wiki/Longest_common_subsequence_problem] between our model output and reference, i.e the longest sequence of words (NOTE: not necessarily consecutive, but still in order) that is shared between both. The idea is that a longer shared sequence should indicate more similarity between the two sequences. 

> [!IMPORTANT]
> The LCS in our case is the 3-gram "Sushant the kitchen" (remember that the words are not necessarily consecutive), which appears in both *R* and *C*. 

ROUGE-L precision is the ratio of the length of the LCS over the number of unigrams in *C*. 

## ROUGE-S
ROUGE-S allows us to add some lenience to the n-gram matchiing performed previously. **ROUGE-S is a skip-gram concurrence metric. This allows to search for consecutive words from reference text that appear in the model output but are separated by one-or-more other words**  

## Pros and Cons of ROUGE
- *Pros:*
  1. Correlates positively with human evaluation
  2. Inexpensive to compute
  3. Language-independent
- *Cons:*
  1. ROUGE doesn't manage different words that have the same meaning as it measures syntactical matches rather than semantics. 

## ROUGE vs BLEU
In general:
  - BLEU focuses on precision: how much the words (and/or n-grams) in the candidate model outputs appear in the human reference.
  - ROUGE focuses on recall: how much the words (and/or n-grams) in the human references appear in the candidate model outputs. 

Akin to the precision-recall tradeoff, these results are complementing of each other.

## Computing ROUGE with Python
Thanks to the [Python ROUGE Library](https://github.com/pltrdy/rouge) (in which there is ROUGE-1, ROUGE-2, and ROUGE-L), implementation of these metrics in Python is easy.

Note that, although in the original ROUGE paper, ROUGE-S seems to be falling out of favor and it used less and less.

> [!WARNING]
> This library hasn't been maintained since 2021. 

The package provides a simple API for text inputs and outputs scores in JSON format. Here are some examples:

CLI: 
```bash
$rouge -h
usage: rouge [-h] [-f] [-a] hypothesis reference

Rouge Metric Calculator

positional arguments:
  hypothesis  Text of file path
  reference   Text or file path

optional arguments:
  -h, --help  show this help message and exit
  -f, --file  File mode
  -a, --avg   Average mode
```

As a package in python:
```Python
from rouge import Rouge 

hypothesis = "the #### transcript is a written version of each day 's cnn student news program use this transcript to he    lp students with reading comprehension and vocabulary use the weekly newsquiz to test your knowledge of storie s you     saw on cnn student news"

reference = "this page includes the show transcript use the transcript to help students with reading comprehension and     vocabulary at the bottom of the page , comment for a chance to be mentioned on cnn student news . you must be a teac    her or a student age # # or older to request a mention on the cnn student news roll call . the weekly newsquiz tests     students ' knowledge of even ts in the news"

rouge = Rouge()
scores = rouge.get_scores(hypothesis, reference)

# OUTPUT:
# [
#   {
#     "rouge-1": {
#       "f": 0.4786324739396596,
#       "p": 0.6363636363636364,
#       "r": 0.3835616438356164
#     },
#     "rouge-2": {
#       "f": 0.2608695605353498,
#       "p": 0.3488372093023256,
#       "r": 0.20833333333333334
#     },
#     "rouge-l": {
#       "f": 0.44705881864636676,
#       "p": 0.5277777777777778,
#       "r": 0.3877551020408163
#     }
#   }
# ]

```

## Alternatives to ROUGE.
In exchange for being so simple to calculate, the downside of ROUGE is that it doesn't take into account semantic meaning of words. Introducting [BERTScore: Evaluating TExt Generation with BERT](https://arxiv.org/abs/1904.09675).

BERTScore calculates the similarity between a summary and reference texts based on the outputs of BERT (Bidirectional Encoder Representations from Transformers), a powerful language model.
