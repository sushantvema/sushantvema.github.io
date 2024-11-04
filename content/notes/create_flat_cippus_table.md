---
title: "Creating the flat cippus table for sagar"
publish: false
tags:
  - influential
  - technical initiatives
---

What tables do I need still for flat table?
- silver network account 
- silver cippus
- network account
- silver cippus media
- silver image recognition
- silver media tags
- silver cippus text

What tables do I need to set up bronze to silver incremental ETL?
- bronze network account -> ready
- bronze cippus -> ready
- bronze cippus media -> 
- bronze image recognition -> todo
- bronze media tags -> todo
- bronze cippus text -> in progress, had to remove null rows

# Where to start

Why do we need to bring in every source table? If we try to transform 5 tables from bronze to silver all at once, we will have to rerun the entire loading and merging every time. 

The biggest issues are the cippus level tables: cippus, cippus_text, cippus publish type, cippus_media

For the one-time onboard: We definitely want to track changes (inserts or updates) in cippus, cippus_text, and cippus_media 

Image recognition needs to get partitioned 

Some things won't get changed. media tags won't get changed every days. media_tag is insert only
