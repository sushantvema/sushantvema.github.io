---
title: "Jenkins"
description: "Learning about Jenkins as a build framework"
date_created: 2025-04-11T08:45:21
date: 2025-04-14T09:45:29
publish: true
author: Sushant Vema
tags:
  - resource
---

## What is Jenkins?

Jenkins is an open-source automation server. It is implemented in Java and
provides a vast ecosystem of over 2000 plugins which can effectively automate
everything.

Jenkins is commonly used in the industry as a framework for automating
Continuous Integration / Continuous Delivery (CI/CD) processes such as:

- Building a project
- Runnings tests to detect bugs and issues as they are introduced
- Static code analysis
- Deployment to various environments

## Building a Multi-branch CI/CD Pipeline

```jenkins
pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            spec:
              containers:
                - name: python
                  image: python:3.11-slim
                  command: ["cat"]
                  tty: true
            """
        }
    }
    environment {
        DATABRICKS_HOST = "https://dbc-35bfa1f1-1292.cloud.databricks.com"
    }

    stages {
        stage('Verify Python') {
            steps {
                container('python') {
                    sh '''
                    python --version
                    which python
                    '''
                }
            }
        }

        stage('Install Databricks CLI') {
            steps {
                container('python') {
                    sh '''
                        apt-get update && apt-get install -y curl bash unzip
                        curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | bash
                        databricks --version
                    '''
                }
            }
        }

        stage('Authenticate with Databricks') {
            steps {
                container('python') {
                  withCredentials([
                      string(credentialsId: 'databricks-client-id', variable: 'DATABRICKS_CLIENT_ID'),
                      string(credentialsId: 'databricks-oauth-secret', variable: 'DATABRICKS_CLIENT_SECRET')
                  ]) {
                      sh """
                      databricks clusters list | head -n 10
                      """
                  }
                }
            }
        }

        stage('Install BrickFlow') {
            steps {
                container('python') {
                    sh '''
                    pip install brickflows
                    bf --help
                    '''
                }
            }
        }
    }
}
```
