---
layout: post
title: "Database Study Map"
date: 2025-04-14 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - database
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/DB"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

This note collects the database topics I repeatedly return to as a backend engineer: modeling, transactions, indexing, replication, isolation, backups, and observability.

## Key Ideas

- Data modeling translates product behavior into storage shape.
- Indexes speed selected reads but add write cost and maintenance overhead.
- Transactions and isolation levels define what concurrent users can observe.

## How I Would Use It

- Review query plans and metrics before treating the database as a black box.
- Document which tables or collections are source-of-truth for each workflow.

## Watch-outs

- Denormalization can improve reads while increasing consistency work.
- A backup that has never been restored is only an assumption.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
