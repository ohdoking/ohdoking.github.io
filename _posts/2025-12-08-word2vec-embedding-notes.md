---
layout: post
title: "Word2Vec and Embedding Notes"
date: 2025-12-08 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - word2vec
  - embeddings
  - nlp
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/Word2Vec"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Word2Vec is a useful entry point for understanding embeddings: words become vectors that capture distributional relationships from text.

## Key Ideas

- Embedding models map tokens into dense numerical vectors.
- Similar contexts tend to produce vectors that are close in embedding space.
- Skip-gram and CBOW are two classic Word2Vec training objectives.

## How I Would Use It

- Use embedding intuition when building semantic search or recommendation features.
- Think of modern text embeddings as a more powerful continuation of this idea.

## Watch-outs

- Embeddings inherit bias and coverage limitations from training data.
- Vector similarity is not the same as factual correctness.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
