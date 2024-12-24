---
title: "OpenAI Structured Outputs Documentation Page"
description: "Quick Markdown formatting for LLM Agent Use"
tags: "resource"
publish: true
author: "Sushant Vema"
date_created: "2024-12-08T13:13:14"
date: "2024-12-08T13:13:19"
---

tokens: ~2000
generated using: copy paste docs -> chatgpt

Sure! Below is a neatly formatted Markdown version of the OpenAI documentation you've pasted.

---

# OpenAI Structured Outputs Documentation

## Introduction

**JSON** is one of the most widely used formats for applications to exchange data.

**Structured Outputs** is a feature that ensures the model will always generate responses that adhere to a supplied JSON Schema. This eliminates worries about the model omitting a required key or hallucinating an invalid enum value.

### Benefits of Structured Outputs:
- **Reliable type-safety**: No need to validate or retry incorrectly formatted responses.
- **Explicit refusals**: Safety-based model refusals are now programmatically detectable.
- **Simpler prompting**: No need for strongly worded prompts to achieve consistent formatting.

### Use Cases
- **With Function Calling**: Suitable for building applications where models call functions or tools.
- **With `response_format`**: Ideal for defining structured schemas when the model responds directly to the user.

### Supported Models:
Structured Outputs are available with the following models:
- `gpt-4o-mini`, `gpt-4o-2024-07-18`, `gpt-4o-2024-08-06`, and later.

## Structured Outputs vs JSON Mode

### **Structured Outputs**:
- **Ensures schema adherence**: Guarantees that outputs match the supplied schema.
- **Compatible models**: Available for `gpt-4o-mini`, `gpt-4o-2024-08-06`, and later.
- **Required fields**: All fields must be required.

### **JSON Mode**:
- **Validates JSON**: Ensures the model produces valid JSON, but does not guarantee schema matching.
- **Compatible models**: Available for `gpt-3.5-turbo`, `gpt-4-*` models.
- **No schema enforcement**: Useful for cases where schema adherence is not critical.

**Recommended Approach**: Always use Structured Outputs over JSON mode, when possible.

## How to Use Structured Outputs

### Step 1: Define Your Object

Create a class or schema that defines the structure of your output.

```python
from pydantic import BaseModel

class CalendarEvent(BaseModel):
    name: str
    date: str
    participants: list[str]
```

### Step 2: Supply Your Object in the API Call

Pass the schema and make the request to the OpenAI API.

```python
completion = client.beta.chat.completions.parse(
    model="gpt-4o-2024-08-06",
    messages=[
        {"role": "system", "content": "Extract the event information."},
        {"role": "user", "content": "Alice and Bob are going to a science fair on Friday."},
    ],
    response_format=CalendarEvent,
)
```

### Step 3: Handle Edge Cases

If the model refuses to respond or encounters an issue, ensure you handle it properly in your code.

```python
if (completion.choices[0].message.refusal):
    print(completion.choices[0].message.refusal)
else:
    print(completion.choices[0].message.parsed)
```

### Step 4: Use the Generated Structured Data

Once you receive the structured response, use it in a type-safe manner.

---

## Example 1: Structured Outputs for Math Tutoring

You can guide the model to solve problems step-by-step, with each step explaining the process and providing intermediate results.

### Code Example:

```python
from pydantic import BaseModel

class Step(BaseModel):
    explanation: str
    output: str

class MathReasoning(BaseModel):
    steps: list[Step]
    final_answer: str

completion = client.beta.chat.completions.parse(
    model="gpt-4o-2024-08-06",
    messages=[
        {"role": "system", "content": "You are a helpful math tutor. Guide the user through the solution step by step."},
        {"role": "user", "content": "How can I solve 8x + 7 = -23?"}
    ],
    response_format=MathReasoning,
)
```

### Example Response:

```json
{
  "steps": [
    {
      "explanation": "Start with the equation 8x + 7 = -23.",
      "output": "8x + 7 = -23"
    },
    {
      "explanation": "Subtract 7 from both sides to isolate the term with the variable.",
      "output": "8x = -23 - 7"
    },
    {
      "explanation": "Simplify the right side of the equation.",
      "output": "8x = -30"
    },
    {
      "explanation": "Divide both sides by 8 to solve for x.",
      "output": "x = -30 / 8"
    },
    {
      "explanation": "Simplify the fraction.",
      "output": "x = -15 / 4"
    }
  ],
  "final_answer": "x = -15 / 4"
}
```

---

## Refusals in Structured Outputs

When the model refuses a request, the response will include a `refusal` field.

### Example of a Refusal:

```json
{
  "id": "chatcmpl-9nYAG9LPNonX8DAyrkwYfemr3C8HC",
  "object": "chat.completion",
  "created": 1721596428,
  "model": "gpt-4o-2024-08-06",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "refusal": "I'm sorry, I cannot assist with that request."
      },
      "logprobs": null,
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 81,
    "completion_tokens": 11,
    "total_tokens": 92
  }
}
```

---

## Tips and Best Practices

### Handling User-Generated Input

Make sure to specify how to handle cases where the input may not result in a valid response. The model will adhere to the schema, but this can result in hallucinations if the input is unrelated to the task.

### Handling Mistakes

If mistakes occur, adjust your instructions, provide more examples, or break down tasks into simpler subtasks to help the model succeed.

---

## Key Schema Limitations

### Object Limitations:
- **Maximum 100 properties** per object.
- **Maximum 5 levels of nesting**.
- **`additionalProperties: false`** must always be set in objects.

### String Size:
- The total string length for **property names**, **definition names**, **enum values**, and **const values** cannot exceed 15,000 characters.

### Enum Size:
- A schema can have up to **500 enum values** across all properties.
- A single enum property with more than 250 values cannot exceed 7,500 characters in total length.

---

## Supported Types in Structured Outputs

- **String**
- **Number**
- **Boolean**
- **Integer**
- **Object**
- **Array**
- **Enum**
- **anyOf** (but not at the root level)

### Required Fields
- All fields must be **required** in Structured Outputs.

---

## Example of Schema Definition

Here’s an example of a weather-fetching schema.

```json
{
  "name": "get_weather",
  "description": "Fetches the weather in the given location",
  "strict": true,
  "parameters": {
    "type": "object",
    "properties": {
      "location": {
        "type": "string",
        "description": "The location to get the weather for"
      },
      "unit": {
        "type": "string",
        "description": "The unit to return the temperature in",
        "enum": ["F", "C"]
      }
    },
    "additionalProperties": false,
    "required": ["location", "unit"]
  }
}
```

---

## Recursive Schemas

Structured Outputs supports **recursive schemas**, allowing you to define structures where objects can reference themselves.

### Example:

```json
{
  "type": "object",
  "properties": {
    "linked_list": {
      "$ref": "#/$defs/linked_list_node"
    }
  },
  "$defs": {
    "linked_list_node": {
      "type": "object",
      "properties": {
        "value": {
          "type": "number"
        },
        "next": {
          "anyOf": [
            { "$ref": "#/$defs/linked_list_node" },
            { "type": "null" }
          ]
        }
      },
      "required": ["next", "value"],
      "additionalProperties": false
    }
  },
  "required": ["linked_list"],
  "additionalProperties": false
}
```

---

## Conclusion

Structured Outputs ensures that the model's responses are type-safe, schema-compliant, and easy to use in applications. Whether you need reliable responses or want to integrate the model with your tools and systems, Structured Outputs is the preferred solution.

