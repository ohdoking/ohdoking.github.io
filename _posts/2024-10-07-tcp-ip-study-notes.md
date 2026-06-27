---
layout: post
title: "TCP/IP Study Notes"
date: 2024-10-07 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - network
  - tcp
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/TCP IP"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

TCP/IP remains essential background knowledge for backend debugging. Many application symptoms are easier to explain when the transport layer is not treated as magic.

## Key Ideas

- IP handles addressing and routing across networks.
- TCP adds ordered delivery, retransmission, congestion control, and flow control.
- Application latency can be affected by DNS, handshakes, packet loss, congestion, and server processing.

## How I Would Use It

- Use packet captures, connection metrics, and load balancer logs when application logs are not enough.
- Think about connection reuse before increasing service concurrency.

## Watch-outs

- Retrying after network errors can duplicate writes unless the API is idempotent.
- Long-lived connections need health checks, keep-alives, and clear timeout strategy.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
