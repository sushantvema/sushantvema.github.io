---
title: "Active Learning Extension of Deedi's Roster Mapping Functionality"
date_created: "2024-08-05T08:21:30"
date: "2024-08-05T08:21:35"
tags:
  - "projects"
publish: false  
---

This project is associated with my contract for [[alix_partners|Alix Partners]]. 

# Documents
- [Active Learning Extension of Deedi's Roster Mapping Functionality](https://alixpartners-my.sharepoint.com/:w:/r/personal/nconnolly_alixpartners_com/_layouts/15/Doc.aspx?sourcedoc=%7B1268C712-DA90-4B30-9CC5-879870B15989%7D&file=DandelionDreams%20Extension%20Requirements.docx&action=default&mobileredirect=true)
# People, Product Owners, and Points of Contact
- Kashyap
-

# Meetings
- [[2024-08-05#9:15-9:30: AP Roster Mapping Improvements, Stakeholder requests, ideas]]

# Project
Deedi is a software module which includes a tool for "roster mapping". We want to extend that tool to include new ML models, visualization component, and an active learning mechanism. 
Goal: Provide more **accurate** and **interactive** job function mappings  

## Modelling Considerations
### New Model Development
- Develop libary of ML-trained models for different industries. 
  - For TMT (Telecommunications, Media, and Technology). , a model trained on "General + TMT industry taxonomy designations"
  - For Industrial Services, model trained on "" etc.
- Additionally, develop one or few-shot learnig model that will do mapping for industry with sparse training data.
  - Can take a custom taxonomy. This should be avoided and "official" AP taxonomy usage should be encouraged as much as possible.

### Model re-training: 
  - Two cases:
    - More data becomes available
    - New version of AP taxonomy released
  - Ensure that ground truth labels in training data align with those in taxonomy
    - Some code will do the matching.
    - Look at "Process New Industrials Rosters" notebook in DD space that does this.

### Model option inclusion into Deedi:
  - Introduce feature flag under "Roster Mapping" tool that allows user to select either a model from the library of models if their industry is included OR select "on-the-fly" option

## Deedi Interface Details - Label Feedback Without Active Learning:
- Key UI features requested:
    - After feature flags inclusion, we want to provide a degree of interactivity, initially without active learning.
    - Process for users to input feedback interactively as models goes through labeling process. Store feedback to train/improve models later.
    - Stakeholder input: serve labeled data to users per functional area. For example, table below shows all employees in "Finance" part of the organization.
      - User is expected to either accept or correct "Predicted AP Function" and "Predicted AP Sub_function" columns. Results stored not just for duration of session, but for future model re-training

- Important secondary features requested:
  - Allow user to correct labels if needed
    - Brainstorm UI integration
  - Two buttons providing feedback to ML model:
    - "Would have expected model to get this right" (red flag triggered, potentially the model needs re-training that specific area)
    - "No way model could have gotten this right" (ok for now if model didn't correctly label)

# Objectives (CB)
1. Data Handling for initial training and active learning component
2. Integrate new ML model for job function mapping
3. Develop visualization component based on pivot table for drilling down into reporting hierarchy
4. Implement active learning component to incorporate user feedback for continuous model improvement

# Requirements
## Training Data for Basic Model
Objective: Specify requirements for training data to develop initial machine learning model.

Requirements:
  - Data Sources
  - Data Volume
  - Data Quality
  - Data Storage

Specifications:
  - Feature Engineering
  - Class Imbalance Handling
  - Data Augmentation
  - Regular Updates

## New ML Model Integration  
Objective: Integrate new ML model.

Requirements:
  - Model Compatibility
  - API Integration
  - Scalability
  - Accuracy

Specifications:
  - Input: Employee data (ID, job title, dept)
  - Output: Job function mapping with associated probabilities
  - Performance Metrics: Precision, recall, F1-score, accuracy

## Visualization Component  
Objective: Pivot table visualization to explore reporting hierarcy and mapping results

Requirements:
  - Pivot table functionality
  - Interactive elements
  - Data display
  - User interface

Specifications:
  - Data points: employee ID, job title, dept, mapped job function, model probability score
  - Filters
  - Export options

## Active Learning Component  
Objective: Implement active learning mechanism to refine model based on user feedback

Requirements:
  - User Guidance
  - Feedback Collection
  - Model Retraining
  - Feedback Loop

Specifications:
  - Feedback input
  - Model update frequency
  - Version control
  - Performance monitoring

# Technical Considerations  
## Data Security and Privacy
Requirements:
  - Encryption
  - Access Control
  - Compliance

## System Integration
Requirements:
  - Comptibility 
  - APIs
  - Testing

## User Experience
Requirements:
  - Intuitive Design
  - Documentation
