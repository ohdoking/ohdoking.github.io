---
layout: post
title: "PostgreSQL Redundancy Notes"
date: 2025-03-17 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - postgres
  - database
  - reliability
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/PostgreSQL Redundancy"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Redundancy in PostgreSQL is about recovery objectives, replication behavior, failover process, backups, and operational testing.

## Key Ideas

- Streaming replication can keep standby instances close to the primary.
- Synchronous and asynchronous replication trade latency for durability guarantees.
- Backups and point-in-time recovery solve a different problem from high availability.

## How I Would Use It

- Define RPO and RTO before choosing replication and backup strategy.
- Test failover and restore procedures regularly, not only during incidents.

## Watch-outs

- A replica can faithfully replicate bad data or destructive writes.
- Read replicas can introduce stale-read behavior if application logic assumes immediate consistency.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
