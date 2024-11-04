---
title: "Monday September 23rd, 2024"
date_created: "2024-09-23T12:22:28"
date: "2024-09-23T12:22:30"
tags: 
  - "technical"
publish: true  
---

Polling an external endpoint asynchronously in Databricks without keeping a cluster running idle (which would be costly) can be achieved using a variety of strategies. Here are several approaches:

1. Databricks Jobs with Task Scheduling
How it works: Instead of keeping a cluster on indefinitely, you can use Databricks Jobs to schedule the polling task at specific intervals (e.g., every 10 minutes). When a task runs, it can start a new cluster, check the external endpoint, and shut down after the task completes.
Steps:
Write a Databricks notebook or a Python script that calls the external endpoint.
Set up a Databricks Job with a recurring schedule using a cron expression (e.g., every 10 minutes).
Use the cluster termination feature to automatically shut down the cluster after polling is complete.
This method avoids having a cluster idle and is cost-effective since the cluster is only active during actual polling events.

2. Leverage Databricks Workflows with REST API
How it works: You can use the Databricks REST API or the Jobs REST API to programmatically trigger your polling notebook or job based on external events.
Steps:
Write a script outside Databricks (e.g., using AWS Lambda, Azure Functions, or a simple cron job) that calls the Databricks Jobs REST API to kick off the job.
Once the job finishes, Databricks can automatically shut down the cluster.
This gives you full control over when the job runs, without needing to keep a cluster up.

3. Event-Driven Polling with Delta Live Tables
How it works: Use Delta Live Tables (DLT) to define data pipelines that automatically run when new data arrives in a source, or when triggered by an event. This could include triggering when an external system (e.g., a webhook or cloud event) notifies Databricks that data is available.
Steps:
Set up a cloud function (e.g., AWS Lambda, Azure Function) to listen for an event from the external service.
When new data is available, the cloud function can trigger a DLT pipeline in Databricks.
This approach avoids unnecessary polling and allows you to only trigger the process when needed.

4. Use Azure Logic Apps / AWS Step Functions for Scheduling
How it works: Offload the responsibility of scheduling and asynchronous polling to external cloud services like Azure Logic Apps or AWS Step Functions.
Steps:
Use a service like Azure Logic Apps or AWS Step Functions to schedule the polling at specific intervals.
Each time the service triggers, it can call a Databricks REST API to start a job.
This job would query the external endpoint and then shut down the cluster once complete.
Using external scheduling services allows you to keep the cluster idle and only start it when necessary, saving costs.

5. Databricks with Serverless
How it works: If your use case fits, you can use Databricks Serverless compute clusters. This service automatically manages resources and spins up the cluster only when needed, which minimizes idle cluster costs.
Steps:
Set up a job or notebook that polls the external endpoint.
Configure the job to use Databricks Serverless clusters, so that the cluster is only running while the job is active.
Note: Databricks Serverless might not be available in all regions or cloud environments yet, but it’s a great option if available.

6. Use Databricks SQL for Triggering Queries
How it works: If your external endpoint is a database or a service that can be queried using SQL, you can schedule queries in Databricks SQL instead of keeping a cluster alive.
Steps:
Use Databricks SQL endpoints to run queries on a schedule.
Use the results of these queries to determine whether further action is needed.
The SQL endpoint scales efficiently and shuts down when not in use.
This is efficient for specific scenarios where polling can be handled as part of scheduled SQL queries.

7. Use Webhooks or Pub/Sub Architecture
How it works: Rather than polling, use webhooks or Pub/Sub models. This offloads the responsibility of notifying Databricks when an event occurs.
Steps:
If the external service supports webhooks, set up a webhook that gets triggered when there’s an update.
Have the webhook trigger a cloud function, which then starts a Databricks job.
The Databricks job can handle the data processing as needed.
This avoids the need to poll entirely, relying on event-driven architectures instead.

8. Databricks Jobs with Webhook-based Triggers
How it works: If the external system allows for webhook integrations, you can combine that with Databricks Job APIs.
Steps:
Configure the external system to send a webhook when an update is available.
The webhook can call the Databricks API to start the polling job dynamically.
Each of these strategies minimizes the cost by not requiring an active cluster during idle times. The best solution depends on your specific use case (e.g., whether the external system supports webhooks or if you want to use Databricks APIs for triggering tasks).
