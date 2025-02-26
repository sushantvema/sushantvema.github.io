---
title: X API (v2) Summary, LLM-Processed
date_created: 2025-02-24T21:50:23
date: 2025-02-24T21:50:25
author: Sushant Vema
tags:
  - terminal-ui-programs
  - platform-apis
publish: true
---

## Query

I asked GPT-4o mini (via API through the BoltAI interface) the following, having pasted the X API Developer Agreement in
the context:

> Based on this Developer Agreement, tell me everything I need to know with
> respect to my goal: I want to build a Terminal UI program that can read my
> Twitter/X feed and occasional programmatically make a post to the platform,
> all under the free tier. Is this allowed?

## Response

To achieve your goal of building a Terminal UI program that can read your
Twitter/X feed and occasionally make posts to the platform under the free tier,
here are the key points from the X Developer Agreement that you need to
consider:

### Allowed Actions

1. **Reading Your Twitter/X Feed**:

   - You can use the X API to access your Twitter feed. The API allows for
     integration of X Content into your Services (your Terminal UI program).
   - Ensure you are complying with the API Restricted Use Rules and the
     guidelines established in the Incorporated Developer Terms.

2. **Making Posts**:
   - The agreement allows you to programmatically make posts to the platform,
     provided you are using the X API as permitted by the Agreement.

### Free Tier Usage

- The Developer Agreement mentions that there are different tiers of access to
  its licensed materials, including potentially a free tier.
- It’s important to check the specific features and limitations of the free tier
  on the [X Developer Site](https://developer.x.com) to ensure that your intended
  use (reading and posting) is supported without incurring costs.

### Restrictions to Keep in Mind

1. **Non-Commercial Use**:

   - If your Terminal UI program is for personal use (non-commercial), you can
     use the Licensed Material as intended without needing to worry about
     Commercial Use restrictions.
   - The definition of Commercial Use suggests that any service that primarily
     aims to earn revenue would fall under stricter limitations.

2. **Rate Limits**:

   - Be aware of any rate limits associated with API calls under the free tier
     to avoid having your access temporarily suspended or permanently blocked.
     This includes limits on how often you can read your feed and how frequently
     you can post.

3. **Security Measures**:

   - You must maintain security for any tokens or credentials used to access the
     API. Ensure that your program uses best practices to secure this information.

4. **Compliance with Additional Terms**:

   - Your program must comply with:
     - The X Developer Policy
     - The API Restricted Use Rules
     - Other incorporated terms governing the API usage.

5. **Confidentiality**:

   - You will need to keep any confidential information related to the API and
     your usage secure and not disclose it to third parties.

6. **Updates to the API**:
   - You are obliged to keep your integration updated with the latest version of
     the API, which may change from time to time.

### General Recommendations

- **Check Available Features**: Review the documentation and features available
  under the free tier on the [X Developer Site](https://developer.x.com) to
  confirm they support your use case.
- **Account for Legal Age**: Ensure you meet any age requirements (at least 18
  years old, or have parental consent).
- **Managing Your Subscription**: Since you intend to use the free tier, make
  sure you manage your account properly to avoid unwanted charges.

If you follow these guidelines and requirements, you should be able to create a
Terminal UI program to read and post to your Twitter/X feed under the free tier.
However, ensure you stay informed about any changes in the Developer Agreement
or API functionalities that could affect your project.

## Additional Resources

(from the X Developer Website, describing the Free Tier)

### Free

For write-only use cases and testing the X API

- Rate-limited access to v2 posting and media upload endpoints
- 500 posts per month - posting limit at the user level
- 500 posts per month - posting limit at the app level
- 100 reads per month
- 1 app ID
- Login with X
- Access to Ads API
- Free

It sounds like reads will be EXTREMELY limited, but we'll see.
