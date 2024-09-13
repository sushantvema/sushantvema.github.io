---
title: "Reference Performance Metrics Extraction Design"
date_created: "2024-08-05T08:16:01"
date: "2024-08-05T08:16:03"
author: "Sushant Vema"
publish: false
tags:
  - "projects"
---

This project is affiliated with [[alix_partners|Alix Partners]]. 

# Documents
- [Automating RPM Extraction from Documents](https://alixpartners-my.sharepoint.com/:w:/p/nconnolly/EdXO4ln6Er1PnZZOIO3khE4B_acCODj1_UvgrfAXISfDRQ?e=8OUI06&wdLOR=c304F2E42-122F-AC46-9437-4CCA7188DD89)

# Meetings
[[2024-08-05#12-12:30 - AP RPM Project Kickoff]]

# Introduction
Org transformation at AlixPartners results in estimating reference performance metrics (RPMs) for clients. An RPM is a combination of 3 values. Lower and upper limits for given industry, current value of company's RPM. 

Lots of documents have been collected. Creating RPM database which will serve as unified resource for future org transformation work.

# Goals
Evaluate feasibility of automating extraction of RPM values using GenAI. 
- Company name
- Function
- Metric Name
- Metric lower range
- Metric upper range
- Metric current value
- Metric units

# Key People
- Adriana Maulini Buno
- Emil Succar
- Miro Samawil
- Carlo Voutta (Product owner) leads overall transformation/RPM workstream. Shared most of the initial documents for extraction.

Have regular meetings with core team. 
After initial feasibility assessment, plugged into larger org transformation efforts led by Chris Mulh and into the Deedi development work led by Mo Bhasin.

# Current Status
Some methods tried. All code in "Dandelion Dreams" Databricks workspace.

## Code 
- Experiments with Assistant API. Approach is promising but some issues to be addressed.
- Experiments with extracting RPMs from .pdfs converted to images and applying Phi3. Underwhelming results.

## Preliminary Feedback
There's a spreadhsheet that has been annotated with preliminary feedback. 
- Most errors are on the low range and upper range columns
- Inconsistencies on formatting the results. 
- Some issues with unnecessary slides read and/or slides missed.

## Appendix
There is a rest API to get data from something

# Scoping conversation with Claude from July 20 2024.
I work as a data scientist for a private equity firm. This firm has thousands of documents containing what are called "Reference Performance Metrics" (RPMs) for their portfolio companies. These documents are overwhelmingly screenshots (some sort of digital image) that may or may not be of an underlying spreadsheet or tabular style of data format. Each portfolio company has a different standard layout for these RPMs. The PE firm's goal is to automate the process of extracting useful information from all of these documents and ingesting them into a unified data architecture for use in downstream analytics applications as well as reporting. The data architecture in which the extracted information is to be stored is itself is besides the point, but the fact remains that each document may (likely) contain different metrics completely and, of course, different "formats" of visualizing those metrics. 

We want to use generative AI as well as OCR techniques to extract as much useful information as possible. Please help me get starting on constructing a technical action plan for this hypothetical project.

This is an interesting and complex project that combines several areas of data science and AI. Here's a high-level technical action plan to get you started:

1. Document Analysis and Categorization:
   - Develop a system to categorize the documents based on their layout and content.
   - Use computer vision techniques to identify whether the image is a spreadsheet, chart, or other format.
   - Create a metadata tagging system for easy retrieval and processing.

2. OCR Implementation:
   - Choose and implement a robust OCR solution (e.g., Tesseract, ABBYY FineReader, or cloud-based solutions like Google Cloud Vision API or Amazon Textract).
   - Fine-tune the OCR model for financial documents and tables if necessary.

3. Data Extraction Pipeline:
   - Develop a pipeline to process images through OCR and extract raw text.
   - Implement post-processing techniques to clean and structure the extracted text.

4. Generative AI for Information Extraction:
   - Utilize large language models (e.g., GPT-4 or similar) to interpret the extracted text and identify key metrics.
   - Train or fine-tune models to understand financial terminology and RPM-specific language.

5. Schema Mapping and Standardization:
   - Design a flexible schema that can accommodate various metrics across different portfolio companies.
   - Develop a mapping system to standardize diverse metrics into a unified format.

6. Data Validation and Quality Assurance:
   - Implement automated checks to ensure data accuracy and completeness.
   - Develop a system for human review of edge cases or low-confidence extractions.

7. Integration with Data Architecture:
   - Design APIs or ETL processes to ingest the extracted and standardized data into your unified data architecture.

8. Continuous Learning and Improvement:
   - Implement a feedback loop to improve extraction accuracy over time.
   - Regularly update and retrain models based on new data and error patterns.

9. Scalability and Performance Optimization:
   - Design the system to handle thousands of documents efficiently.
   - Implement parallel processing and batch operations where possible.

10. Reporting and Analytics Interface:
    - Develop dashboards or interfaces for users to access and analyze the extracted data.
    - Implement features for custom report generation and data exploration.

This plan provides a starting point. Each step will require further detailed planning and implementation. Would you like me to elaborate on any specific part of this plan?

What are some examples of "post-processing techniques to clean and structure the extracted text"?

Post-processing techniques are crucial for cleaning and structuring the extracted text from OCR. Here are some examples:

1. Text Normalization:
   - Convert all text to lowercase or uppercase for consistency
   - Remove extra whitespace, newlines, and tabs
   - Standardize special characters and punctuation

2. Error Correction:
   - Implement spell-checking algorithms to correct OCR mistakes
   - Use context-aware correction for financial terms and common metrics
   - Apply regular expressions to fix common OCR errors (e.g., '0' instead of 'O')

3. Number and Date Formatting:
   - Standardize number formats (e.g., thousands separators, decimal points)
   - Convert various date formats to a single standard (e.g., ISO 8601)
   - Handle currency symbols and conversions if necessary

4. Table Structure Recognition:
   - Identify table boundaries and cell divisions
   - Reconstruct table structure from OCR output
   - Handle merged cells and multi-line entries

5. Named Entity Recognition (NER):
   - Identify and tag entities like company names, financial metrics, and time periods
   - Use domain-specific NER models trained on financial documents

6. Noise Removal:
   - Remove headers, footers, and page numbers
   - Eliminate watermarks or background text not part of the main content

7. Text Classification:
   - Categorize text into relevant sections (e.g., revenue, expenses, KPIs)
   - Identify and separate explanatory notes from numerical data

8. Data Type Inference:
   - Determine whether a piece of text represents a number, date, percentage, or text
   - Convert to appropriate data types for database storage

9. Unit Standardization:
   - Detect and standardize units of measurement (e.g., convert all financial figures to millions)
   - Handle different scales (e.g., thousands, millions, billions) consistently

10. Contextual Analysis:
    - Use surrounding text to infer meaning and context of extracted data
    - Resolve ambiguities in metric names or values based on document context

11. Regex Pattern Matching:
    - Apply regular expressions to extract specific patterns (e.g., "Revenue: $X million")
    - Use regex to validate and format extracted data

12. Semantic Parsing:
    - Analyze sentence structure to extract relationships between entities and values
    - Map extracted information to a predefined schema or ontology

13. Cross-referencing and Validation:
    - Compare extracted data with known values or ranges for sanity checks
    - Cross-reference data points within the document for consistency

These techniques can be applied in combination, often in a pipeline, to progressively clean and structure the raw OCR output. The specific techniques used would depend on the nature of your documents and the desired output format. Would you like me to expand on any of these techniques or discuss how they might be implemented in your specific use case?
