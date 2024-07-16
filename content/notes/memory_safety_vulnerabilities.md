---
title: "Memory Safety Vulnerabilities"
date_created: "2024-07-08T20:32:01"
date: "2024-07-08T20:32:12"
tags:
  - "technical"
publish: true
---

Part of my notes on [[computer_security|Computer Security]].

This is a document about memory safety vulnerabilities in C. 

This page is growing out of Chapter 2, 3, and 4 from the [open-sourced Computer Security Textbook](https://textbook.cs161.org/) written by Wagner, Weaver, Kao, Shakir, Law, and Ngai from UC Berkeley, for UC Berkeley CS161. It provides a brief surver over common topics in computer security including:
  - Memory safety
  - Cryptography
  - Web security
  - Network security

Memory Safety means software security. We will be looking at issues that arise out of software implementation oversights. 

> You may have a perfect design, a perfect specification, perfect algorithms, but still have implementation vulnerabilities. In fact, after configuration errors, implementation errors are probably the largest single class of security errors exploited in practice. 

> [!NOTE]
> ***Definition:*** Memory safety refers to ensuring that attackers cannot read or write to memory locations other than those intended by the programmer.

Because many security-critical applications are written in C, and becuase C is NOT a memory-safe language, we will study memory safety vulnerabilities as well as defenses in C.

> [!NOTE]
> ***Reflection:*** What are the most "security-critical applications" commonly used which are written in C? What are their histories? Are there modern alternatives being designed as replacements? 

## x86 Assembly and Call Stack

## Memory Safety Vulnerabilities

## Mitigating Memory Safety Vulnerabilities
