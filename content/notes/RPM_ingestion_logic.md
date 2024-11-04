---
title: "RPM Ingestion Logic Working Document and Process"
date_created: "2024-09-17T15:37:57"
date: "2024-09-17T15:38:00"
tags:
  - "agenda"
publish: false
---

# RPM Ingestion Logic

Stakeholders: Adriana, Kari, Sushant, Carlos, 

## Task
I have a few spreadsheets worth of RPM data which I need to ingest into a database. Here are the steps to make that happen:
  - Get a hold of spreadsheets with RPM data to ingest
  - For each implicit company in the spreadsheet, wrangle all of the RPM data according to a specified schema
  - For each implicit company with RPMs, find the associated 

The RPM database schema as of 2024-09-17 has simplified the complexity of representing RPM data to the following schema represented within the API calls in the following subprocesses. 

Source: [RPMs API Database Schema & Endpoints PPT](https://alixpartners-my.sharepoint.com/:p:/r/personal/amaulinibuno_alixpartners_com/_layouts/15/Doc.aspx?sourcedoc=%7B6A785BA5-38F2-4238-B126-64541BBEF81B%7D&file=RPMs%20API%20Database%20schema%20%26%20endpoints.pptx&action=edit&mobileredirect=true)

## Create Company

```bash
curl --request POST \​
  --url https://apuse2rpmsstgwes01web.azurewebsites.net/api/company \​
  --header 'Content-Type: application/json' \​
  --header 'RadialApiKey: {Master key}' \​
  --data '{​
  "HeadCount": 25000,​
  "BaselineRevenue": 300000000,​
  "GrossProfits": 150000000,​
  "EBITDA": 100000000,​
  "RevenueGrowth": 3,​
  "MainIndustry": "Technology",​
  "HQCountry": "United States of America"​
}'​
```
Python version (untested):

```python
import requests

url = 'https://apuse2rpmsstgwes01web.azurewebsites.net/api/company'
headers = {
    'Content-Type': 'application/json',
    'RadialApiKey': '{Master key}'
}

data = {
    "HeadCount": 25000,
    "BaselineRevenue": 300000000,
    "GrossProfits": 150000000,
    "EBITDA": 100000000,
    "RevenueGrowth": 3,
    "MainIndustry": "Technology",
    "HQCountry": "United States of America"
}

response = requests.post(url, headers=headers, json=data)

# Check if the request was successful
if response.status_code == 200:
    print('Success:', response.json())
else:
    print('Failed:', response.status_code, response.text)
```


## Update RPMS of Existing? Company
```bash
curl --request PUT \​
  --url https://apuse2rpmsstgwes01web.azurewebsites.net/api/roster \​
  --header 'Content-Type: application/json' \​
  --header 'RadialApiKey: {Master key}' \​
  --data '{​

  "companyId": 1,​
  "JobFunction": "IT",​
  "JobSubFunction": "(Blank)",​
  "rpms":[​
     {​
       "Name": "Functional FTE as % of Total Employees",​

       "MetricType": "Operational",​
       "DataType": "Percentage",​
       "CurrentValue": 0.0055,​
       "LowerLimit": null,​
       "HigherLimit": null,​
       "LowerTarget": null,​
       "IsSingleTarget": false,​

       "IsCustom": true,​
      },​

     {​
       "Name": "Functional Expenses as % of Revenue",​

       "MetricType": "Financial",​
       "DataType": "Percentage",​
       "CurrentValue": 0.0030,​
       "LowerLimit": null,​
       "HigherLimit": null,​
       "LowerTarget": null,​
       "IsSingleTarget": false,​

       "IsCustom": true,​
      },​
   ]      ​
}​
'​
```
