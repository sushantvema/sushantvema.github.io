---
title: "All about MLflow - A Machine Learning Lifecycle Platform"
author: "Sushant Vema"
tags:
  - "technical"
  - "databricks"
publish: true
---

[MLflow](https://github.com/mlflow/mlflow) is a platform to streamline machine learning development including:
  - tracking experiments,
  - packaging code intro reproducible runs
  - sharing and deploying models

MLflow is a set of lightweight APIs which can be used with any ML application or library ([TensorFlow](https://www.tensorflow.org/), [Pytorch](https://pytorch.org/), [XGBoost](https://xgboost.readthedocs.io/en/stable/)) in any environment used to run ML code (notebooks, standalone applications, or the cloud).

# MLflow components
- Tracking: 
  - Log parameters, code, results from ML experiments and compare them using an interactive UI
- Projects:
  - Code packaging format for reproducible runs using Conda and Docker
- Models:
  - Model packaging format and tools allowing easy deployment of the same model to batch and real-time scoring on platforms like Docker, Apache Spark, Azure ML, and AWS Sagemaker
- Model Registry: Centralized model store, set of APIs, and UI to collaboratively manage full lifecycle of MLflow Models



