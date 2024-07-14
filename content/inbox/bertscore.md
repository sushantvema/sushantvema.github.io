---
title: "BERTScore: Evaluating Text Generation with BERT"
author: "Sushant Vema"
date: "2024-07-08T15:43:32"
tags:
  - "technical"
  - "LLM Evaluation"
---

**tl;dr: Semantic similarity scoring of model-generated and reference texts is important to incorporate in an evaluation suite. BERTScore using contextual embeddings, vector cosine similarity, token matching to compute precision/recall/F1 metrics, and, importantly, importance weighting in order to assess the contextual relevance of of candidate material to reference material. The choice of BERT model for the task is an important design decision to make and can affect the evaluation performance in novel domains. ** 

Original paper: [BERTScore: Evaluating Text Generation with BERT - 2019](https://arxiv.org/abs/1904.09675)

Github: [Tiiiger/bert_score](https://github.com/Tiiiger/bert_score)
Spreadsheet with best BERT models on WMT16 benchmark: [BERTScore Default Layer Performance on WMT16](https://docs.google.com/spreadsheets/d/1RKOVpselB98Nnh_EOC4A2BYn8_201tmPODpNWu4w7xI/edit?gid=0#gid=0)

BERTScore has emerged as a significant alternative metric to traditional evaluation methods. 

## Addressing issues in N-gram based metrics

There are two common issues in N-gram based metrics such as [[rouge]]:
  - N-gram models tend to incorrectly match paraphrases since semantically accurate expressions may differ from the surface form of the reference text, which can lead to incorreect performance estimation. BERTScore uses contextualized token embeddings which are shown to be effective for [entailment detection](https://en.wikipedia.org/wiki/Textual_entailment). 
  - N-gram models cannot capture long-range dependencies and penalize semantically-significant reordering. 

## BERTScore Architecture
Here are the processes that consitute BERTScore.
1. *Contextual Embeddings:* Reference and candidate sentences (model generated sentences) are represented using contextual embeddings based on surround words. 
  - These contextual embeddings can be computed by models like BERT, Roberta, XLNET, and XLM.
2. *Cosine Similarity:* The similarity between contextual embeddings of reference and candidate sentences. 
3. *Token Matching for Precision and Recall: * Each *token*  in the candidate setence is matched to the most similar token in the reference sentence and vice versa in order to compute recall and precision which are then combined to calculate the F1 score using the usual methodology. 
4. *Importance Weighting: * Rare words' importance is considered using [Inverse Document Frequency or IDF](https://en.wikipedia.org/wiki/Tf%E2%80%93idf) which can be incorporated into BERTScore equations. 
  - This is optional and domain-dependent. For extractive summary systems in a specialized domain, I would gander that importance weighting would be highly beneficial. 
5. *Baseline Rescaling: * BERTScore values are linearly rescaled to improve human readability. This ensures they fall within a more intuitive range based on [Common Crawl Monolingual Datasets](https://commoncrawl.org/).

## BERTScore in Python
```python
!pip install transformers # If you are using collab, "!" is required to download
!pip install bert-score

from transformers import BertTokenizer, BertForMaskedLM, BertModel
from bert_score import BERTScorer

# Example texts
reference = "This is a reference text example."
candidate = "This is a candidate text example."
# BERTScore calculation
scorer = BERTScorer(model_type='bert-base-uncased')
P, R, F1 = scorer.score([candidate], [reference])
print(f"BERTScore Precision: {P.mean():.4f}, Recall: {R.mean():.4f}, F1: {F1.mean():.4f}")

### Outputs : BERTScore Precision: 0.9258, Recall: 0.9258, F1: 0.9258
```

```python
# Step 1: Import the required libraries
from transformers import BertTokenizer, BertModel
import torch
import numpy as np

# Step 2: Load the pre-trained BERT model and tokenizer
tokenizer = BertTokenizer.from_pretrained("bert-base-uncased")
model = BertModel.from_pretrained("bert-base-uncased")

# Step 3: Define the two texts to compare
text1 = "This is an example text."
text2 = "This text contains an example sentence."

# Step 4: Prepare the texts for BERT
inputs1 = tokenizer(text1, return_tensors="pt", padding=True, truncation=True)
inputs2 = tokenizer(text2, return_tensors="pt", padding=True, truncation=True)

# Step 5: Feed the texts to the BERT model
outputs1 = model(**inputs1)
outputs2 = model(**inputs2)

# Step 6: Obtain the representation vectors
embeddings1 = outputs1.last_hidden_state.mean(dim=1).detach().numpy()
embeddings2 = outputs2.last_hidden_state.mean(dim=1).detach().numpy()

# Step 7: Calculate cosine similarity
similarity = np.dot(embeddings1, embeddings2.T) / (np.linalg.norm(embeddings1) * np.linalg.norm(embeddings2))

# Step 8: Print the result
print("Similarity between the texts: {:.4f}".format(similarity[0][0]))

### Output: Similarity between the texts: 0.9000

```

## Conclusion
- BERTScore is increasingly being considered an important metric enhancing text similarity measurement. 
- Combining precision and recall makes text similarity measurement more accurate and balanced. 
- The choice of BERT model to use is a hyperparameter.
- It stands to reason that with a large amount of data, it could be feasible to pretrain a BERT or transformer model for this task.

## Further Reading

Paper: [BERTTune: Fine-Tuning Neural Machine Translation with BERTScore](https://arxiv.org/pdf/2106.02208)
