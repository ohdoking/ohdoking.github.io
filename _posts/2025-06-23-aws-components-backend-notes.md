---
layout: post
title: "AWS Components for Backend Systems"
date: 2025-06-23 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - aws
  - cloud
  - backend
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/AWS components"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

AWS services are easier to reason about when grouped by backend responsibility: compute, storage, networking, messaging, identity, observability, and deployment.

## Key Ideas

- Compute choices such as Lambda, ECS, EKS, and EC2 trade operational control for management overhead.
- S3, RDS, DynamoDB, and ElastiCache serve different data access patterns.
- SQS, SNS, EventBridge, and Kinesis support different async communication models.

## How I Would Use It

- Pick services from workload requirements instead of popularity.
- Write architecture notes that explain why each managed service was chosen.

## Watch-outs

- Managed does not mean maintenance-free; quotas, IAM, cost, and monitoring still matter.
- Too many services can increase cognitive load for small teams.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
