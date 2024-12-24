---
title: "Influential Production ETL Checklist"
date_created: "2024-10-31T14:35:09"
date: "2024-11-04T14:49:16"
publish: false
tags:
  - "Initiative"
  - "Influential"
---

This document represents the work cut out for me regarding implementation, scaling, testing, and deployment of production grade ETL pipelines for our data ecosystem in Influential.

There is a mandate on our team from Anj to reach the following milestones by November 15th:
  - The following networks of data will be populated into qdrant by EOD Tuesday November 5th: 
    - youtube
    - instagram
    - tiktok
    - facebook
    - snapchat
  - End-to-end testing of our data pipelines for the following stages should be completed by EOD Tuesday November 5th at the latest:
    -

# Todo:
- [] (11.12) 

# Completed
- [x] (11.4) Optimize `dev.bronze_mariadb_social_hoarder.image_recognition`
- [x] (11.4) Touch base with Alex about the new media_data structure at 4:30
- [X] Schedule meeting with Raphael for Wednesday morning.
- [X] Create Walkthrough Guide of End-to-End Production ETL Process
- [x] [(11.4 and 11.6) Data Type Issues in Demo Pro Flat](data_type_issues_demo_pro_flat)
- [x] (11.6) Fix Demo Pro Nested Key Names
- [X] Prepare for end-to-end testing
- [x] Fix the data type issues in cippus_flat media struct
- [X] (11.5) Refresh all flat tables
 Completed

cippus media. direction we were going was concatenation. you can have many thumbnail urls. what if some of them are images and some are videos? Alex proposes a list of structs. At this point we have to finalize the media schema. Talked with Adam about one thing. There is a backlog of cippus_media which haven't been processed yet. Many posts where the media_count value doesn't match the cippus_media posts. 3.2 million instagram posts that don't have matching media_count's and cippus_media rows. media_count is the count provided by the actual network. Implement change data feed for cippus_media as well. 

- pre-validate the data
  - make sure we have a thumbnail URL and content_url which is a null or string
  - media type 
- implement the struct logic 
  - worst case scenario. one media doesn't include a media_type. 
- optimize dev image_recognition. early last week, that table was not clustered. applied clustering to that.   

- etl_staging
- copy tables from dev to a certain timestamp 
- create the flat tables
- incrementally update bronze
- incrementally update the flat tables

# Virtual Scrum Updates

## Monday November 4th
N/A

## Tuesday November 5th
N/A

## Wednesday November 6th
Today:
- Touched base with Cyrus this morning to resolve DBX/qdrant data display inconsistencies and filtering issues
- Updated demo_pro schema to adhere to variable naming conventions
- Met with Raphael from DBX to deep dive into ETL and compute sizing
- Added remaining fields to network account flat and cippus flat ETL processes
- Touched base with William about demo pro filters on UI side
- Put together workflow for simulating end-to-end production grade ETL for search - monitoring tonight. Updated compute configs for certain sub tasks
- Updated data-engineering related tickets

## Thursday November 7th (Posted Friday morning)
Yesterday:
- Massive progress on production ETL end-to-end testing. Discovered a curious Databricks bug where there is an inconsistency between a workflow execution of a SQL query versus the ad-hoc IDE execution of the same query. Opened a support ticket yesterday to follow up. Hoping to hear back from DBX today, we're running out of ideas to troubleshoot.
- Compute sizing; created new SQL Warehouses for our needs.
- Completed adhoc request from Cyrus to generate data about number of posts per account per platform, and population statistics on that topic.
- Refreshed "flat" tables for our team to use/test downstream
- Hoping to complete first version of end-to-end ETL process today

## Friday November 8th
Today:
- Resolved blocker for production ETL e2e testing and closed support tickets
- Performance improvements implemented in various parts of that workflow
- Created and updated many data engineering related tickets for search 2.0
