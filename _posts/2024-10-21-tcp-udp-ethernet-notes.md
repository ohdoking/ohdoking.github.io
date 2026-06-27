---
layout: post
title: "TCP, UDP, and Ethernet Notes"
date: 2024-10-21 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - network
  - tcp
  - udp
  - ethernet
blog_category: "security-networking"
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/TCP UDP and Ethernet"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

This note separates three layers that often get compressed into one mental model: Ethernet for local frames, IP for routing, and TCP or UDP for transport behavior.

## Key Ideas

- Ethernet frames move data within a local network segment.
- UDP is lightweight and message-oriented, but it does not guarantee delivery or ordering.
- TCP is connection-oriented and reliable, but that reliability has handshake and state costs.

## How I Would Use It

- Use UDP when the application can tolerate loss or builds its own reliability model.
- Use TCP when ordered reliable streams matter more than minimal overhead.

## Watch-outs

- A protocol choice should follow product behavior, not only performance assumptions.
- Observability should include packet loss, retransmits, and connection churn for network-sensitive systems.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
