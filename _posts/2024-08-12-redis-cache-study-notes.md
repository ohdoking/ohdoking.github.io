---
layout: post
title: "Redis and Cache Study Notes"
date: 2024-08-12 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - redis
  - cache
blog_category: "data-messaging"
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/Redis"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Redis is often introduced as a cache, but production usage also involves data structures, expiration policy, memory limits, replication, and failure behavior.

## Key Ideas

- Redis keeps data in memory and offers structures such as strings, hashes, sets, sorted sets, and streams.
- TTL and eviction settings are part of application correctness, not only infrastructure tuning.
- Caching changes the consistency model between the source of truth and the read path.

## How I Would Use It

- Use Redis for hot reads, distributed rate limits, lightweight coordination, and temporary session-like state.
- Choose cache keys and invalidation rules before writing integration code.

## Watch-outs

- A cache stampede can overload the database when a popular key expires.
- Do not store critical source-of-truth data in Redis unless durability and recovery are designed.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
