---
title: All about CI/CD on Databricks
description: Video notes + takeaways about CI/CD on Databricks
date_created: 2025-05-07T09:49:37
date: 2025-05-07T09:49:39
author: Sushant Vema
tags:
  - resource
publish: true
---

## Video Notes

### Databricks CI/CD: Intro to Databricks Asset Bundles (DAB's)

Resources:

- [YouTube Link - Dustin Vannoy](https://www.youtube.com/watch?v=uG0dTF5mmvc)

Video Description:

> "Databricks Asset Bundles provide a way to use the command line to deploy and
> run a set of Databricks assets - like notebooks, Python code, Delta Live
> Tables pipelines, and workflows. This is useful both for running jobs that are
> being developed locally and for automating CI/CD processes that will deploy
> and test code changes. In this video I explain why Databricks Asset Bundles
> are a good option for CI/CD and demo how to initialize a project and setup
> your first GitHub Action using DABs."

Notes:

- DAB's are the successors to Terraform. Although Terraform is easy to use for
  tasks like deploying DBX workspaces, it is not conducive for deploying jobs and
  workflows.
- Terraform didn't have providers at the time to do that anyway. Terraform is
  hard to manage for data engineering teams.
- Patched together DBX REST API's and DBX CLI to get some sort of CI/CD
  progress. Build code, run tests, interact with workspaces.
- Use DAB's to make it simpler.
- Based on [2023 Data + AI Summit Presentation on DAB's](https://www.youtube.com/watch?v=uG0dTF5mmvc):
  - Use IAC with Databricks Terraform provider (workspaces, clusters)
  - Source code changes are not going to be managed by Terraform provider,
    rather the data team themselves
  - Solution as of 2023: Use [dbx by Databricks Labs](https://www.youtube.com/watch?v=uG0dTF5mmvc)
    - More accessible than Terraform, simpler than REST API's.
    - No formal support for any such Databricks Labs projects
  - Supported solution as of 2023:
    - Use Databricks REST API's directly
    - Downside is that it's low level. However, it's very scriptable, can make
      custom solutions
    - Error prone and brittle. Not recommended Hard to maintain. Having to page
      through responses, keeping up with versions etc.
    - We want the deployment flow to be as simple as possible
  - Officially introduced DAB's
    - Write code once, deploy everywhere
    - All YAML files specifying artifacts, resources, and configurations of a
      databricks project.
    - New databricks CLI has functions to validate, deploy and run DAB's using
      `bundle.yml` files.
    - Used in local environments via IDE and CI/CD processes.
- Demo - Getting started with DAB's

  - `databricks bundle init`. Creates a project with a default template.
  - Creates a lot of boilerplate for you including:
    - fixtures/
    - resources/
    - scratch/
    - src/
    - tests/
    - databricks.yml
    - .gitignore
    - pytest.ini
    - README.md
    - setup.py
  - `databricks.yml` defines a bundle name under the `bundle` header. Defines
    where to find the resources to be deployed under the `include` header.
    Defines targets (list of workspaces to deploy to) under the `targets` header.
  - The `dev` target can use a `mode: development` to "make sure everything
    deployed to this target gets a prefix". Development mode also disables any
    schedules and automatic triggers for jobs. For DLT pipelines, it enables the
    development mode.
  - All of the targets you define must have a `workspace` attribute which has
    a `host` attribute as well as an optional `root_path` attribute (which is
    defined for you automatically). Use cases for custom root paths can include
    defining a new directory for prod source code if using the same workspace as
    the dev and prod targets
  - What matters will be contained in the `resources/` directory of yaml files.
  - Each `resource.yml` file contains the etire specification of the job or DLT
    pipeline you want to deploy
  - The README.md that comes with `databricks bundle init` contains a detailed
    guide to deploy the bundles
  - `databricks bundle deploy --target dev`

    ```txt
    artifacts.whl.AutoDetect: Detecting Python wheel project...
    artifacts.whl.AutoDetect: Found Python wheel project at /mnt/c/Users/dvannoy/dev/datakickstart-devops/datakickstart_dabs
    artifacts.whl.Build(datakickstart_dabs): Building...
    artifacts.whl.Build(datakickstart_dabs): Build succeeded
    artifacts.whl.Upload(datakickstart_dabs-0.0.1-py3-none-any.whl): Uploading...
    artifacts.whl.Upload(datakickstart_dabs-0.0.1-py3-none-any.whl): Upload succeeded
    Starting upload of bundle files
    Uploaded bundle files at /Users/training@dustinvannoy.com/.bundle/datakickstart_dabs/dev/files!

    Starting resource deployment
    Resource deployment completed!
    dvannoy@DataKickstart-PC:
    ```

  - `databricks bundle run BUNDLE_NAME`

    ```txt
    dvannoy@DataKickstart-PC:~$ databricks bundle run datakickstart_dabs_job
    Run URL: https://adb-7923129632668114.14.azuredatabricks.net/?o=7923129632668114#job/75834993941612/run/581934979058233

    2023-09-15 15:46:20 "[dev training] datakickstart_dabs_job" RUNNING
    ```

  - When you log into the Workflows UI of your workspace, you will see job
    running with a dev prefix if that was your target
  - It will also print out notebook outputs!

    ```txt
    dvannoy@DataKickstart-PC:~$ databricks bundle run datakickstart_dabs_job
    Run URL: https://adb-7923129632668114.14.azuredatabricks.net/?o=7923129632668114#job/75834993941612/run/581934979058233

    2023-09-15 16:00:40 "[dev training] datakickstart_dabs_job" TERMINATED SUCCESS
    Output:
    =======
    Task notebook_task:

    =======
    Task main_task:

    +---------------------+---------------------+-------------+------------+------------+-------------+
    |tpep_pickup_datetime |tpep_dropoff_datetime|trip_distance|fare_amount|pickup_zip  |dropoff_zip  |
    +---------------------+---------------------+-------------+------------+------------+-------------+
    |2016-02-14 16:52:13  |2016-02-14 17:16:04  |4.94         |19.0        |10282       |10171        |
    |2016-02-08 14:44:19  |2016-02-08 14:46:08  |0.28         |3.5         |10110       |10110        |
    |2016-02-17 17:13:57  |2016-02-17 17:17:55  |0.51         |5.0         |10103       |10023        |
    |2016-02-10 10:36:01  |2016-02-10 10:38:07  |0.7          |6.0         |10022       |10017        |
    |2016-02-22 14:14:41  |2016-02-22 14:31:52  |4.51         |17.0        |10110       |10282        |
    +---------------------+---------------------+-------------+------------+------------+-------------+

    only showing top 5 rows
    ```

  - You can use it from GitHub as a GitHub Action or through Azure DevOps
  - Dustin sometimes uses the Workflows UI or VSCode extension, but deploying
    bundles via GitHub Action is nice

- GitHub Actions Demo:
  - Added example GitHub Actions yaml's from Data + AI Summit 2023 GitHub repo
    to `.github/workflows`
  - For example in the `dev.yml` action, he has specified a workflow like: When
    a pull request is opened or synchronized to `main`, certain steps will be
    run. In future there will be a unit test running locally step, will be
    implemented in future. Then you can have a `deploy` and a `pipeline_update` job sequentially. Uses `DATABRICKS_TOKEN` and `DATABRICKS_BUNDLE_ENV` as environment variables.
  - For the `staging.yml` action, the trigger is when a pull request is pushed
    to main.
