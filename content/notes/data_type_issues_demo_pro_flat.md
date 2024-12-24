---
title: "Data Type Issues in Demo Pro Flat Table"
tags:
  - "Task"
  - "Influential"
  - "Databricks"
date_created: "2024-11-05T18:25:27"
date: "2024-11-05T19:48:16"
---

This document is for fixing a bug that Cyrus assigned to me. 

# Resources:
- [Demo Pro Flat Creation Query (demo_pro_flat_one_time_load)](https://dbc-35bfa1f1-1292.cloud.databricks.com/editor/queries/568133647164448?o=1016658646341465)

# Context
> Cyrus Mohammadian
  7:20 PM
@Sushant Vema
 If you're working tomorrow, I have one task for you related to your ETL work. The following table `etl_staging.search_index.demo_pro_flat`, has nested fields, each nested json field has an array of string keys and values. These values should all be float. 99% of them are float but every now and then there is one or two integers to be found. Please update that table such that all values are rendered as  floats. Below is an example of floats and integers in the same mix, all should be float. Thanks! (edited) 

Alex Begg
  7:37 PM
@Cyrus Mohammadian
, 
@Ryan Uhlmeyer
 and I are aware of that issue, that is caused by named_struct function. It does not matter what casting we do, it forces it into a string


Cyrus Mohammadian
  7:37 PM
Then you convert to string, add a zero, then cast again


Alex Begg
  7:37 PM
oh you found the solution
7:38
we tried things but what we tried didn't work


Cyrus Mohammadian
  7:38 PM
I dont know, i just assume that would work
7:38
Did you try converting to string first?


Alex Begg
  7:38 PM
I do not think so


Cyrus Mohammadian
  7:38 PM
In the future if you cant find a solution, please do not simply leave it for others to stumble into...


Alex Begg
  7:39 PM
We asked Sagar if it was fine as a string
7:39
so it was not something we ignored
:+1::skin-tone-4:
1

Cyrus Mohammadian
  7:39 PM
Come to me and I'll see what I can do to unblock you and at the very least it would be flagged for me.
7:39
Sure but im the team lead, i need to know what blockers there are, specially ones youve decided not to resolve
7:42
@Alex Begg
 can you please point me to the notebook that generated etl_staging.search_index.demo_pro_flat

Alex Begg
  7:43 PM
The "demo_pro_flat_one_time_load" query: https://dbc-35bfa1f1-1292.cloud.databricks.com/editor/queries/568133647164448?o=1016658646341465
:pray::skin-tone-4:
1

Cyrus Mohammadian
  7:43 PM
Thanks
7:45
@Sushant Vema
 For tomorrow, please read the messages here and update the following sql notebook:
https://dbc-35bfa1f1-1292.cloud.databricks.com/editor/queries/568133647164448?o=1016658646341465
such that the problematic values are cast as strings, have a decimal and a zero added, then cast as float. Thanks!

Alex Begg
  7:52 PM
The same issue is happening in the media column I worked on (and I have passed to sushant). In that case we are including a media_index for the purpose of media ordering, and currently it goe returned as a string in the struct instead of an int (edited) 

7:52
so I will also work on fixes there

# Analysis
- "Please update that table such that all values are rendered as floats."
- It took me 2.5 minutes to run the entire demo_pro_flat table creation, so it is relatively quick to iterate
- I don't know a lot about demo pro data as of now
- No changes have been made to the demo_pro_flat_one_time_load query since at least a week before this issue was flagged, so the problem persists as of 2024-11-05T18:51:01

# Estimation
I am limiting the entire task work to one hour, and then I will reach out for help. 

# Action Items
- [x] Create a test table called `dev.search_index.demo_pro_flat_struct_data_testing` 
- [x] Try to find examples of rows in the above table of structs with wrong data types
- [x] [Writeup in Slack Thread](https://influential-dev.slack.com/archives/C07BU78HH41/p1730863793945559?thread_ts=1730776842.724589&cid=C07BU78HH41)

# Conclusion
- Cyrus ingested data from this table into qdrant and discovered that the resulting data in qdrant is integers where applicable.
- We will investigate on 11/06/2024
- Databricks has UI idiosyncrasies as explained in the writeup
