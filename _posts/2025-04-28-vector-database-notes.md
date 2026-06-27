---
layout: post
title: "Vector Database Notes"
date: 2025-04-28 09:00:00 +0100
category: blog
tags:
  - study
  - programming
  - ai
  - vector-database
  - embeddings
blog_category: "ai-llm"
study_category: "Programming"
origin: notion
import_batch: notion-batch-2
source_note: "Programming/Vector DB"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Vector databases are becoming a common backend component for semantic search and RAG systems. The core idea is to retrieve by similarity over embeddings instead of exact keys.

## Key Ideas

- Embeddings map text, images, or other inputs into numerical vectors.
- Similarity search finds vectors near a query vector under a chosen distance metric.
- Metadata filtering and chunk identity are as important as vector distance.

## How I Would Use It

- Use vector search for semantic retrieval, recommendation, deduplication, and document Q&A.
- Store enough metadata to trace every generated answer back to source material.

## Watch-outs

- A high similarity score does not guarantee factual relevance.
- Chunking strategy can dominate retrieval quality more than the database choice.

## Practical Reflection

For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
