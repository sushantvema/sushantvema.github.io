---
title: "BrickFlow - CLI for Declarative Python-based Databricks Workflows Deployment"
date_created: "2024-09-23T11:42:24"
date: "2024-09-23T11:42:26"
tags:
  - "technical"
  - "databricks"
publish: true
---

[BrickFlow documentation pages](https://engineering.nike.com/brickflow/v1.2.0/). 
[BrickFlow Github Repository](https://github.com/Nike-Inc/brickflow).

# BrickFlow Intro Meeting from Sagar
DSL - Domain Specific Language
Lots of examples of Domain Specific Languages. 
Day in day out, we are writing a lot of notebooks, python components, etc. We want these components to orchestrate. Should be able to be deployed in a repeatable fashion. Teams use DSLs to simplify. Sagar helped build this workflow
By default, Databricks came with their own orchestrator. First people to commit to Airflow. The entire world uses airflow today for running and orchestrating data pipelines. 
Workflows and airflow orchestration was not that seamless. So relevant today that many folks use it. Nike runs everything in Brickflow. 

Whatever ETLs we create in the team, all the ETLs should follow one standard structure. Today, we all write them very differently. We need to remove the guessing game from the structure, deployment, management. Opinionated framework. 

1. Go to Concepts and read that instead of the quickstart. 
2. Write a small demo ETL. Put it in Github. Kick off a CI/CD pipeline. 

Become a master in the concepts and the whole setup. 
How we can start templatize ETLs. 

Monorepo style. Make a confluence document with learnings from this.

## Introduction
[Brickflow - An opinionated python framework to help build and deploy Databricks workflows at scale](https://community.databricks.com/t5/data-engineering/brickflow-an-opinionated-python-framework-to-help-build-and/td-p/60252)



##  Task
- Figure out the high level concepts
- Come up with a pitch for a small demo to Cyrus and Sagar
- Implement the demo
- Figure out the usecases. 

##  High Level Taxonomy

| Object                               | Airflow                               | Brickflow                                           |
|--------------------------------------|---------------------------------------|----------------------------------------------------|
| Collection of Workflows              | Airflow Cluster (Airflow Dag Bag)     | Project/Entrypoint                                 |
| Workflow                             | Airflow Dag                          | Workflow                                           |
| Task                                 | Airflow Operator                     | Task                                               |
| Schedule                             | Unix Cron                            | Quartz Cron                                        |
| Inter Task Communication             | XComs                                | Task Values                                        |
| Managing Connections to External Services | Airflow Connections                   | Mocked Airflow connections or Databricks Secrets   |
| Variables to Tasks                   | Variables                            | Task Parameters [ctx.get_parameter(key, default)]  |
| Context values (execution_date, etc.) | Airflow Macros, context["ti"]         | ctx.<task parameter>                               |

## Example Workflow

```python

from datetime import timedelta
from brickflow import (Workflow, Cluster, WorkflowPermissions, User, 
    TaskSettings, EmailNotifications, PypiTaskLibrary, MavenTaskLibrary, JobsParameters)

# Workflow definition which constructs the workflow object
wf = Workflow(  
    "wf_test",  
    # The default cluster used for all the tasks in the workflow. This is an all-purpose cluster, but you can also create a job cluster
    default_cluster=Cluster.from_existing_cluster("your_existing_cluster_id"),  

    # Optional parameters below
    schedule_quartz_expression="0 0/20 0 ? * * *",  # Cron expression in the Quartz format
    timezone="UTC",  # Define timezone for the workflow; By default, UTC
    schedule_pause_status="PAUSED",  # Define the schedule pause status. It is defaulted to "UNPAUSED"
    default_task_settings=TaskSettings(  
        email_notifications=EmailNotifications(
            on_start=["email@nike.com"],
            on_success=["email@nike.com"],
            on_failure=["email@nike.com"],
            on_duration_warning_threshold_exceeded=["email@nike.com"]
        ),
        timeout_seconds=timedelta(hours=2).seconds
    ),
    # Libraries that need to be installed for all the tasks
    libraries=[  
        PypiTaskLibrary(package="requests"),
        MavenTaskLibrary(coordinates="com.cronutils:cron-utils:9.2.0"),
    ],
    # Tags for the resulting workflow and other objects created during the workflow.
    tags={  
        "product_id": "brickflow_demo",
        "slack_channel": "nike-sole-brickflow-support"
    },
    # Define the maximum number of concurrent runs
    max_concurrent_runs=1,  
    # Permissions for the workflow
    permissions=WorkflowPermissions(  
        can_manage_run=[User("abc@abc.com")],
        can_view=[User("abc@abc.com")],
        can_manage=[User("abc@abc.com")],
    ),
    # Prefix for the name of the workflow
    prefix="feature-jira-xxx",  
    # Suffix for the name of the workflow
    suffix="_qa1",  
    common_task_parameters={  
        "catalog": "development",
        "database": "your_database"
    },
    # Define health check condition that triggers "duration warning threshold exceeded" notifications
    health = { 
        "metric": "RUN_DURATION_SECONDS",
        "op": "GREATER_THAN",
        "value": 7200
    },
    # Define parameters on workflow level
    parameters=[JobsParameters(default="INFO", name="jp_logging_level")],  
)


# Define a workflow task and associate it to the workflow
@wf.task()  
def task_function(*, test="var"):
    return "hello world"
```


