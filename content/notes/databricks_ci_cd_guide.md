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

Last modified by Sushant: 2025-05-07

Resources:

- [YouTube Link - Dustin Vannoy - Oct 4 2023](https://www.youtube.com/watch?v=uG0dTF5mmvc)
- [Code Examples](https://github.com/datakickstart/datakickstart_dabs)

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
    a pull request is opened or synchronized to `main`, certain steps will be run.
    In future there will be a unit test running locally step, will be implemented
    in future. Then you can have a `deploy` and a `pipeline_update` job
    sequentially. Uses `DATABRICKS_TOKEN` and `DATABRICKS_BUNDLE_ENV` as
    environment variables.
  - For the `staging.yml` action, the trigger is when a pull request is pushed
    to main.

### Databricks Asset Bundles: Advanced Examples

Last modified by Sushant: 2025-05-07

Resources:

- [YouTube Link - Dustin Vannoy - June 25 2024](https://www.youtube.com/watch?v=ZuQzIbRoFC4)
- [Dustin's Blog Post with Examples](https://dustinvannoy.com/2023/10/03/databricks-ci-cd-intro-to-asset-bundles-dabs/)

Video Description:

- > "Databricks Asset Bundles is now GA (Generally Available). As more
  > Databricks users start to rely on Databricks Asset Bundles (DABs) for their
  > development and deployment workflows, let's look at some advanced patterns
  > people have been asking for examples to help them get started."

My notes:

- DAB's are now in GA (Generally Available). Approved for production for all
  customers from DBX perspective
- Databricks Asset Bundles are a method for storing source code and jobs and
  workflows together in version control and deploying them with the Databricks CLI
- Monorepo project setup demo:
  - One repository with multiple projects in the same repository. Separate
    deploy pipeline for each one. Rather than have a `databricks.yml` defined at
    the top level of the monorepo, there will be one in each one of the
    sub-projects.
  - If you want to deploy all projects together, you could one single bundle at
    the root level - will be searching for all artifacts together as one unit
- Deploy and view in UI:
  - When you're cd'ed in the project of choice, run `databricks bundle deploy`. Can run `databricks bundle validate` before.
  - In development the deployed workflows will be prefixed with `[dev USERNAME]`
  - The task source code paths will be pointing to paths lining up with bundle
    target
  - There will be a notification that the job is deployed via DAB's (`Connected
to Databricks Asset Bundles`). Prevents changing job parameters etc. Points to
    which git repostory from which branch it was deployed from. Can see all of the
    settings, but immutable.
  - If you really need to make temporary changes without re-deploying from local
    environemnt, you can `Disconnect from source` after accepting a warning that
    this is an anti-pattern
- Config re-use (YAML anchor):
  - Examples of doing some unit testing from within the `complex_project` in his
    code examples, will be covered in future video
  - Different `databricks.yml`. Added some variables under the `variables`
    header. Example includes `cluster_spark_version` and `cluster_node_type`
  - Start with `jobs_group1.yml` which shows examples of sharing variables
    defined in the project bundle
  - Created a "YAML Anchor" under a `definitions` header
  - `job_clusters: &mycluster` and `tags_configuration: &tags_configuration`
  - In the `resources` header when you are definining individual jobs, you can
    specify `job_clusters: *mycluster` via the anchor definition
- Shared Python Package (Wheel)
  - in `datakikstart_shared_lib_job.yml`, you can specify a python wheel already
    in the workspace as `whl: PATH.whl`
  - in `python_wheel_upload.sh` Dustin has a simple script to build the wheel,
    create a workspace directory via DBX CLI, and import the built wheel into the
    workspace from local environment
- Serverless compute:
  - Can create a serverless compute environment for the job/task definition in
    the resource
- Modify in UI:
  - Can modify/have a workflow in the UI, then more or less copy paste the YAML
    into a bundle. Might have to toggle off some settings / remove some prefixes
- GitHub integration:
  - You can specify source code to come from an external github repository
    instead of the Workspace, and specify a `git_source` subheader for each job in
    the bundle
- MLOps:
  - Follow this DAB template: [databricks/mlops-stacks](https://github.com/databricks/mlops-stacks)
- Comments section of the video has some good points brought up

### TODO future: Databricks CI/CD: Azure DevOps Pipeline + DABs

### 7 Best Practices for Development and CICD on Databricks

Resources:

- [YouTube - 7 Best Practices for Development and CICD on Databricks - Dec 20 2024](https://www.youtube.com/watch?v=IWS2AzkTKl0)

Video Description:

- > "In this video I share why developer experience and best practices are
  > important and why I think Databricks offers the best developer experience for a
  > data platform. I'll cover high level developer lifecycle and 7 ways to improve
  > your team's development process with a goal of better quality and reliability."

My Notes:

- He needed to setup up developer environments and deployment standardization
  for ~5 team members
- [Databricks Connect](https://docs.databricks.com/aws/en/dev-tools/databricks-connect/python) was around for scripting for local or workspace.
- Tried to implement these approaches in other platforms like Snowflake etc.
- Decided he wanted to work exclusively with Databricks for a while.
  Transitioned to Solutions Architect at Databricks.
- For teams who don't feel like they have the best dev ex or practices right
  now, tips:
  - Slides from Kimberly Mahoney
  - Planning -> Development -> Does it Work? -> Release
  - "Does it work?" is a feedback loop, but also product expectations is a
    feedback loop
  - Use version control
  - Run automated code tests. Pyspark in notebooks, sql code (less mature),
    testing after build and after changes.
  - Deploying code and jobs to separate isolated environments.
  - Run automated system test (health check)
  - Run data quality tests
  - Automate data schema deployments
  - Automated rollback on failure

### Developer Best Practices on Databricks: Git, Tests, and Automated Deployment

Resources:

- [YouTube - Dustin Vannoy - Jan 6 2025](https://www.youtube.com/watch?v=MolLJRD8kgM)

Video Description:

- > "Data engineers and data scientists benefit from using best practices
  > learned from years of software development. This video walks through 3 of the
  > most important practices to build quality analytics solutions. It is meant to be
  > an overview of what following these practices looks like for a Databricks
  > developer.
  > This video covers:
  >
  > - Version control basics and demo of Git integration with Databricks workspace
  > - Automated tests with pytest for unit testing and Databricks Workflows for
  >   integration testing
  > - CI/CD including running tests prior to deployment with GitHub Actions"

My Notes:

- Basic intro to version control (GitHub) and feature branching.
- Basic demonstration of mounting a git provider repo
- Unit Tests + Integration Tests:
  - The test pyramid.
    - Unit tests should be fast and inexpensive. They should test single
      functions
    - Integration tests test one step in pipeline. Slightly slower and more
      expensive.
    - End-to-end / system tests: Test a full pipeline from source to target.
      These might run in staging before we get to production
  - "A lot of the times, what we'll do to better structure our code to make
    testing easier is we will want to build reusable functions in pyspark and
    import those into python files or notebooks". Modularity
  - Walks through example of running unit tests with feedback on VScode.
    Organized in a tests directory. Uses Databricks connect. Runs majority of this
    code against a databricks cluster or serverless compute.
  - When he needs to test spark, use Databricks connect. This is recommended so
    that you reduce the number of inconsistencies between spark environments
    in local vs databricks workspace
  - His tests/ directory has one more layer for delineating integrations and
    unit tests
  - `DatabricksSession.builder.getOrCreate()` -> pytest fixture
  - Common pattern is to use the fixture spark session via databricks connect,
    create a dataframe via list of lists. Build up an expected dataframe
  - Dataframe comparisons - instead of pyspark.testing.utils can use
    [MrPowers/chispa](https://github.com/MrPowers/chispa) which has some really
    nice capabilities
  - Logical difference between unit tests and integration tests can be a bit
    blurry in this case
  - From the databricks workspace there is no built-in pyspark runner like there
    is with VSCode. So, build a testing notebook
  - todo: continue
