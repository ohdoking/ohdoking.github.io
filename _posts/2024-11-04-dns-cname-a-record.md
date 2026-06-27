---
layout: post
title: "DNS CNAME and A Record Differences"
date: 2024-11-04 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - dns
  - network
blog_category: "security-networking"
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/DNS에서 CNAME과 A 레코드의 차이"
description: "DNS records are operational contracts. Knowing the difference between A records and CNAME records helps when configuring domains, certificates, CDN routing, and service..."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

DNS records are operational contracts. Knowing the difference between A records and CNAME records helps when configuring domains, certificates, CDN routing, and service migrations.

## Key Ideas

- An A record maps a name directly to an IPv4 address.
- A CNAME record aliases one hostname to another hostname.
- DNS TTL controls how quickly clients may observe changes after a record update.

## How I Would Use It

- Use CNAME records when delegating a subdomain to another managed service.
- Use A records when pointing directly to stable IP addresses.

## Watch-outs

- CNAME records are usually not valid at the zone apex unless the DNS provider offers an alias-like feature.
- DNS changes are not instant because resolvers cache records according to TTL.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
