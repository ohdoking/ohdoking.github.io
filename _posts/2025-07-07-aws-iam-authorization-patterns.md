---
layout: post
title: "AWS IAM and Authorization Patterns"
date: 2025-07-07 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - aws
  - iam
  - security
blog_category: "cloud-devops"
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/AWS IAM and Authorization Patterns"
description: "IAM is a design surface for cloud systems. Good policies encode least privilege, clear ownership, and safe operational workflows."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

IAM is a design surface for cloud systems. Good policies encode least privilege, clear ownership, and safe operational workflows.

## Key Ideas

- Principals, actions, resources, and conditions form the core shape of an IAM policy.
- Roles are safer for workloads than long-lived access keys.
- Permission boundaries, service control policies, and resource policies help constrain blast radius.

## How I Would Use It

- Use separate roles for build, deploy, runtime, and human break-glass access.
- Review IAM changes like application code because they change system behavior.

## Watch-outs

- Wildcard actions and resources are fast during experiments but risky in production.
- Unused permissions should be removed before they become permanent.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
