---
title: "AWS Logs"
description: "Using awslogs to stream CloudWatch into a local environment"
date_created: 2025-04-07T13:52:13
date: 2025-04-07T13:52:15
tags:
  - resource
  - aws
publish: true
author: Sushant Vema
---

## Key Challenges of Working with AWS CloudWatch Logs

### Difficulties Using AWS CloudWatch Logs with `awscli`

- **Limited Querying and Filtering**: The `awscli` lacks the expressiveness and
  flexibility of traditional log analysis tools. You can filter by log group, log
  stream, and patterns, but complex querying (e.g. joins, regex grouping, or
  aggregations) is either impossible or painfully slow.

- **Poor Developer Experience**: Crafting commands to fetch logs is verbose and
  unintuitive. Even basic tasks like tailing logs or filtering by timestamp
  require multiple flags and knowledge of specific formatting quirks.

- **Pagination and Rate Limits**: Results are paginated, and the CLI won’t
  stream logs naturally like `tail -f`. Handling pagination manually can be
  clunky, and rate limiting often adds frustration for large queries.

- **Timestamp Handling is Awkward**: Dealing with start and end times requires
  precise epoch time formatting in milliseconds, which isn’t human-friendly. This
  makes quick troubleshooting or ad-hoc exploration time-consuming.

- **Slow Performance at Scale**: For large-scale log groups, queries via the
  CLI can be very slow. This is especially frustrating during debugging sessions
  when you need fast feedback loops.

- **Disjointed UX for Logs Insights**: While CloudWatch Logs Insights offers a
  powerful query language, accessing it through `awscli` is less intuitive than
  using the web console — and lacks the rich output formatting developers expect
  from query tools.

- **No Good Local Caching or State**: There’s no built-in way to cache or track
  what you've already seen. Every query re-downloads logs, even if only a few new
  entries have appeared.

These issues often lead teams to build wrapper scripts, adopt/purchase
third-party log aggregators (like Datadog, Loki, or Sumo Logic), or invest time
in log exporting pipelines — just to make logs more usable.

## Introducing `awslogs`

`awslogs` is a command-line tool designed to make interacting with AWS
CloudWatch Logs more user-friendly and efficient. It addresses many of the
challenges associated with the native AWS CLI by offering features that enhance
usability and composability.

### Key Features of `awslogs`

- **Aggregated Log Retrieval**: Easily fetch logs from multiple streams within a
  log group, supporting regular expressions to match specific streams.

- **Human-Friendly Time Filtering**: Use intuitive time expressions like `'2h
ago'`, `'2d ago'`, or specific timestamps to filter logs, simplifying the
  process of specifying time ranges.

- **Real-Time Log Streaming**: Monitor logs as they are generated with the
  `--watch` flag, providing functionality similar to `tail -f` for real-time
  debugging.

- **Colored Output**: Enhances readability by colorizing log output, making it
  easier to distinguish between different log entries.

- **Integration with Unix Pipelines**: Outputs plain text, allowing seamless use
  with Unix tools like `grep`, `awk`, and `sed` for further processing.

### Composable Workflows Using `awslogs`

By leveraging `awslogs` in combination with standard Unix utilities, you can
create powerful and efficient log processing workflows. Here are some examples:

- **Filter Logs for Specific Errors**: Retrieve logs from the past two hours and
  filter for lines containing the word "ERROR":

```bash
awslogs get /var/log/syslog --start='2h ago' | grep 'ERROR'
```

This command helps in quickly identifying error messages within a specific
timeframe.

- **Count Occurrences of a Specific Event**: Count how many times the phrase
  "User logged in" appears in the logs from the past day:

```bash
awslogs get /application/logs --start='1d ago' | grep 'User logged in' |
wc -l
```

This could provide a quick tally of user login events over the last day.

- **Monitor Logs in Real-Time for Specific Patterns**: Watch logs as they are
  generated and highlight lines containing the word "CRITICAL":

```bash
awslogs get /var/log/syslog --watch | grep --color=always 'CRITICAL'
```

This is useful for real-time monitoring of critical issues as they occur.

By integrating `awslogs` with standard command-line tools, you can create
customized workflows tailored to your specific log analysis needs, enhancing
both efficiency and effectiveness in managing AWS CloudWatch Logs.

## 4.7.25 Demo

1. Explanation of the status quo for CLI-based CloudWatch parsing
2. Run some sample queries using `awslogs`
