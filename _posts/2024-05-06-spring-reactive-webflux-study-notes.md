---
layout: post
title: "Spring Reactive and WebFlux Study Notes"
date: 2024-05-06 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - spring
  - webflux
  - reactive
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/Spring reactive and WebFlux"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

I wanted to separate where reactive programming helps from where it only adds complexity. WebFlux is useful when a service spends a lot of time waiting on network I/O, but it is not a blanket replacement for simple servlet-based APIs.

## Key Ideas

- Reactive streams model demand with backpressure, so producers should not overwhelm consumers.
- WebFlux uses non-blocking request handling, which means blocking database calls or file I/O can erase the benefit.
- Reactive code needs explicit thinking around error handling, retries, timeouts, and context propagation.

## How I Would Use It

- Use it for gateway-like services, streaming APIs, fan-out calls, and high-concurrency I/O workloads.
- Keep a clear boundary between reactive adapters and domain logic so the whole codebase does not become harder to read.

## Watch-outs

- Do not mix blocking JPA calls into an event-loop path without isolating them.
- Prefer measuring latency and thread usage before deciding that WebFlux is the right tool.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
