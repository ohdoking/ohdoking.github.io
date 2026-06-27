---
layout: post
title: "Spring Data JPA, R2DBC, and Hibernate Reactive"
date: 2024-05-20 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - spring
  - jpa
  - r2dbc
blog_category: "java-spring"
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/Spring JPA, J2DBC, Hibernetes reactive"
description: "This note compares the mental models behind traditional ORM persistence and reactive database access. The important distinction is not only API style, but also..."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

This note compares the mental models behind traditional ORM persistence and reactive database access. The important distinction is not only API style, but also transaction scope, lazy loading, connection usage, and operational predictability.

## Key Ideas

- JPA is a mature object-relational mapping model with persistence contexts and entity lifecycle management.
- R2DBC provides non-blocking database access, but it does not reproduce every JPA behavior.
- Hibernate Reactive keeps ORM ideas but expects the application to stay inside a reactive execution model.

## How I Would Use It

- Use JPA when domain mapping, mature tooling, and transaction consistency matter more than non-blocking I/O.
- Use R2DBC for simple query flows where reactive end-to-end behavior is more important than ORM convenience.

## Watch-outs

- Do not choose a reactive driver if the rest of the stack is still blocking.
- Be explicit about transaction boundaries because async flows make hidden coupling harder to debug.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
