---
title: "Influential Production ETL Checklist"
date_created: "2024-10-31T14:35:09"
date: "2024-10-31T14:35:12"
publish: false
tags:
  - checklist
---

# Tasks Ordered by Priority
- [x] Complete prod ETL to bronze as of Thursday October 31st
- [x] Create Flat Tables in Production
- [x] Ingest data in etl_staging catalog
- [x] Hotfix ingest image_recognition from dev to etl_staging
- [] Run an optimize operation on the image_recognition table
- [] Fix the logic in cippus one time and incremental to create lists instead of strings. One post can contain multiple different media_urls
- [] Implement CDF tracking on cippus_media 
- [] Create new cippus_flat in etl_staging to include the media url fields
- [] Create flat tables in etl_staging catalog
- [] Implement
