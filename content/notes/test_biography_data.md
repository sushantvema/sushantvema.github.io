---
title: "Test Biography Data"
author: "Sushant Vema"
description: "Used for evaluating pain points and capabilities of LLM-driven summarization systems."
date_created: "2024-07-09T13:26:15"
date: "2024-07-10T17:37:14"
tags:
  - "technical"
---

```python
test_biography_data_list = [
    "My name is Sushant Vema.",
    "I am a man. ",
    "My pronouns are he/him/his",
    "I graduated from UC Berkeley in May 2024 with a major in Data Science.",
    "I currently work as a Data Scientist at Influential.co, building the search engine for prolifically-posting people (social media influencers).",
    "My ethnicity is South Asian.",
    "I like to swim and play water polo."
    "I live in Dublin, California in the Bay Area.",
    "I am currently single as a pringle and ready to mingle.",
    "I am a vegetarian but I eat eggs and dairy.",
    "I have no pets, but I would love to get a cat one day.",
    "I love to cook, play chess, and read books.",
]

test_biography_data_concatenated = " ".join(test_biography_data_list)

"""
My name is Sushant Vema. I am a man.  My pronouns are he/him/his I graduated from UC Berkeley in May 2024 with a major in Data Science. I currently work as a Data Scientist at Influential.co, building the search engine for prolifically-posting people (social media influencers). My ethnicity is South Asian. I like to swim and play water polo. I live in Dublin, California in the Bay Area. I am currently single as a pringle and ready to mingle. I am a vegetarian but I eat eggs and dairy. I have no pets, but I would love to get a cat one day. I love to cook, play chess, and read books. 
"""
index = [
    str(test_biography_data_list.index(item) + 1) for item in test_biography_data_list
]

test_biography_data_ordered_list = [
    index[i] + ". " + item for i, item in enumerate(test_biography_data_list)
]

test_biography_data_ordered_list_concatenated = "\n".join(
    test_biography_data_ordered_list
)

print(test_biography_data_ordered_list_concatenated)```
```

```
test_biography_data_ordered_list_concatenated = \
"""
1. My name is Sushant Vema.
2. I am a man. 
3. My pronouns are he/him/his
4. I graduated from UC Berkeley in May 2024 with a major in Data Science.
5. I currently work as a Data Scientist at Influential.co, building the search engine for p
rolifically-posting people (social media influencers).
6. My ethnicity is South Asian.
7. I like to swim and play water polo.I live in Dublin, California in the Bay Area.
8. I am currently single as a pringle and ready to mingle.
9. I am a vegetarian but I eat eggs and dairy.
10. I have no pets, but I would love to get a cat one day.
11. I love to cook, play chess, and read books.
"""


# Source of truth - System prompt for extractive summarization:

```python
# Summarize the following biographical information in a JSON with the following schema. 

schema = {
    "type": "object",
    "properties": {
        "personal_info": {
            "type": "object",
            "properties": {
                "gender_identity": {
                    "type": "string",
                    "enum": ["Male", "Female", "Non-Binary"],
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Unknown"
                },
                "pronouns": {
                    "type": "string",
                    "enum": ["She/Her/Hers", "He/Him", "They/Them", "Other"],
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Unknown"
                },
                "lgbtqia_plus": {
                    "type": "boolean",
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Unknown"
                },
                "account_type": {
                    "type": "string",
                    "enum": ["Individual Small-scale Creator", "Company/Organization", "Celebrity"],
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Unknown"
                }
            }
        },
        "life_events": {
            "type": "object",
            "properties": {
                "life_moments": {
                    "type": "array",
                    "items": {
                        "type": "string",
                        "enum": ["Engaged", "Just Married", "New Home", "New Baby", "New Job", "Just Graduated"]
                    },
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"}
                },
                "marital_status": {
                    "type": "string",
                    "enum": ["Single", "Married", "Prefer Not To Answer"],
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Unknown"
                }
            }
        },
        "family": {
            "type": "object",
            "properties": {
                "has_children": {
                    "type": "boolean",
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": None
                },
                "ages_of_children": {
                    "type": "array",
                    "items": {"type": "number"},
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"}
                }
            }
        },
        "lifestyle": {
            "type": "object",
            "properties": {
                "dietary_preferences": {
                    "type": "string",
                    "enum": ["Carnivore", "Vegetarian", "Vegan"],
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Unknown"
                },
                "pets": {
                    "type": "array",
                    "items": {
                        "type": "string",
                        "enum": ["Cat", "Dog", "Reptile/Amphibians", "Birds", "Small mammal (other pets)", "Rat", "Aquatic animals", "Farm Animals/Livestock"]
                    },
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"}
                }
            }
        },
        "interests": {
            "type": "object",
            "properties": {
                "hobbies": {
                    "type": "array",
                    "items": {
                        "type": "string",
                        "enum": ["Art", "Baking/Cooking", "Games", "Books/Reading", "Music/DJ/Instruments", "Fishing", "Camping", "Fitness"]
                    },
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"}
                },
                "sports": {
                    "type": "array",
                    "items": {
                        "type": "string",
                        "enum": ["Basketball", "Football", "Tennis", "Soccer", "Water Sports", "Mountain Sports", "Pickleball", "Baseball/Softball"]
                    },
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"}
                },
                "athlete_status": {
                    "type": "string",
                    "enum": ["Professional Athlete", "College Athlete", "Not an Athlete"],
                    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
                    "reasoning": {"type": "string"},
                    "default": "Not an Athlete"
                }
            }
        }
    }
}
```


# Meta Llama 3 70B Instruct Response:

> [!NOTE]
> Important information: 
>  - max_tokens=500
>  - num_output_tokens=500
>  - temperature=0.1
>  - inference time on Playground: ~10 seconds

Here is the JSON representation of your biographical information based on the provided schema:

```json
{
    "personal_info": {
        "gender_identity": {
            "value": "Male",
            "confidence": 1,
            "reasoning": "2"
        },
        "pronouns": {
            "value": "He/Him",
            "confidence": 1,
            "reasoning": "3"
        },
        "lgbtqia_plus": {
            "value": null,
            "confidence": 0,
            "reasoning": ""
        },
        "account_type": {
            "value": "Individual Small-scale Creator",
            "confidence": 0.8,
            "reasoning": "4, 5"
        }
    },
    "life_events": {
        "life_moments": {
            "value": ["Just Graduated"],
            "confidence": 1,
            "reasoning": "4"
        },
        "marital_status": {
            "value": "Single",
            "confidence": 1,
            "reasoning": "8"
        }
    },
    "family": {
        "has_children": {
            "value": false,
            "confidence": 1,
            "reasoning": ""
        },
        "ages_of_children": {
            "value": [],
            "confidence": 0,
            "reasoning": ""
        }
    },
    "lifestyle": {
        "dietary_preferences": {
            "value": "Vegetarian",
            "confidence": 1,
            "reasoning": "9"
        },
        "pets": {
            "value": [],
            "confidence": 1,
            "reasoning": "10"
        }
    },
    "interests": {
        "hobbies": {
            "value": ["Cooking", "Reading"],
            "confidence": 1,
            "reasoning": "11"
        },
        "sports": {
            "value": ["Swimming", "Water Polo"],
            "confidence": 1,
            "reasoning": "7"
        },
        "athlete_status": {
            "value": "Not an Athlete",
            "confidence": 1,
            "reasoning": ""
        }
    }
}```

Note: The confidence levels are subjective and based on the availability of information. The reasoning fields contain the numbers of

# Evaluation:

Let's think. We have 5 categories of information extracted:
  1. personal_info
    - gender_identity
    - pronouns
    - lgbtqia_plus
    - account_type
  2. life_events
    - life_moments
    - marital_status
  3. family
    - has_children
    - ages_of_children
  4. lifestyle
    - dietary_preferences
    - pets
  5. interests
    - hobbies
    - sports
    - athlete_status

We want to calculate metrics for each category of fields.

> [!NOTE]
> There's a schema validation step that I need to implement, but it might be stable enough to pass for now. 

For each category of fields:
  - We have to get the `value` -> either string or string list with one or more elements
  - We have to get all the possible values as defined by the 

```python
!pip install transformers # If you are using collab, "!" is required to download
!pip install bert-score
!pip install openai
dbutils.library.restart_python()

from transformers import BertTokenizer, BertForMaskedLM, BertModel
from bert_score import BERTScorer

# GET THE JSON OUT OF THE MODEL RESPONSE  

def string_to_list_of_integers(input_string):
    # Split the input string by comma and strip whitespace from each part
    parts = input_string.split(',')
    
    # Convert each part into an integer and store them in a list
    result = [int(part.strip()) for part in parts]
    
    return result

for information_grouping in extraction.keys():
    source_schema_info_grouping = schema["properties"][information_grouping]
    for field in extraction[information_grouping].keys():
        source_schema_field = source_schema_info_grouping["properties"][field]
        possible_values = source_schema_field["enum"] if "enum" in source_schema_field.keys() else [0, 1]
        value = field["value"] if field["value"] != None else "Uncertain"
        assert value in possible_values
        confidence = field["confidence"]
        reasoning_reference_numbers = string_to_list_of_integers(field["reasoning"])
        references = " ".join([test_biography_data_ordered_list[idx] for idx in reasoning_reference_numbers])
        

# Set up inputs for BERTScore
reference = references
candidate = f"Is information about {field} contained in the reference?"
# BERTScore calculation
scorer = BERTScorer(model_type='bert-base-uncased')
P, R, F1 = scorer.score([candidate], [reference])
print(f"BERTScore Precision: {P.mean():.4f}, Recall: {R.mean():.4f}, F1: {F1.mean():.4f}")


# Set up LLM as a Judge
from openai import OpenAI
import os

# How to get your Databricks token: https://docs.databricks.com/en/dev-tools/auth/pat.html
# DATABRICKS_TOKEN = os.environ.get('DATABRICKS_TOKEN')
# Alternatively in a Databricks notebook you can use this:
DATABRICKS_TOKEN = dbutils.notebook.entry_point.getDbutils().notebook().getContext().apiToken().get()

client = OpenAI(
  api_key=DATABRICKS_TOKEN,
  base_url="https://dbc-35bfa1f1-1292.cloud.databricks.com/serving-endpoints"
)

system_prompt="You are a detail oriented auditor. You are grading an information extraction process, looking at reference text and a student submitted answer for a retrieved value. Your goal is to score the student answer based on how close it is to the correct answer.This is a pass/fail test.  If the two answers are basically the same, the score should be 100. If the two answers are different, then the score should be 0. Please place your score in a 'score' field in a JSON, and any reasoning in a 'reason' field in a JSON."

user_prompt=f"Field to extract: {field}. Category of information just for your reference: {list(information_grouping.keys())[0]}. Value that the student selected: {value}. Possible values allowed as a response: {possible_values}."

chat_completion = client.chat.completions.create(
  messages=[
  {
    "role": "system",
    "content": "You are an AI assistant"
  },
  {
    "role": "user",
    "content": "Tell me about Large Language Models"
  }
  ],
  model="databricks-meta-llama-3-70b-instruct",
  max_tokens=500
)

print(chat_completion.choices[0].message.content)
```
