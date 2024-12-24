---
title: "Structured Data Extraction for Long-Form Documents from Basics"
date_created: "2024-12-05T08:57:27"
date: "2024-12-05T08:57:31"
tags:
  - "resource"
  - "technical"
publish: false  
---
- Better confidence scores function taking into account distributional characteristics of logprobs
- Meta prompting for best system prompts
- Least viable size for ground truth dataset
- Prompt for confidence or use logprobs?
- 128000 - len(system_prompt) - len(fewshot_examples) = tokens_available_for_document
- How many fewshot examples?

> Use the system message to create the program for the LLM. These are general instructions and directives. Use the user role to submit the tasks that the model will perform using its system message.

## Best Practices for In-context learning

- Clear Task Description: Provide a concise and unambiguous description of the task.
- Relevant Examples: Include diverse, high-quality examples that cover various aspects of the task.
- Structured Format: Use a consistent format for presenting task information and examples.
  - Markdown with JSON
- Gradual Complexity: Start with simpler examples and progressively increase complexity if needed.
- Explicit Instructions: Clearly state any specific requirements or constraints for the task.
- Context Management: Prioritize the most relevant information within the limited context window.
  - Most relevant page?


Resources:
  - [In-context Learning Guide](https://www.prompthub.us/blog/in-context-learning-guide)

- automate the creation of ground truth data
