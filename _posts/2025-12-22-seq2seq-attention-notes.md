---
layout: post
title: "Seq2Seq and Attention Notes"
date: 2025-12-22 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - seq2seq
  - attention
  - nlp
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/Seq2seq+Attention"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Seq2Seq models helped frame tasks like translation as encoder-decoder learning. Attention improved the model by allowing the decoder to focus on relevant encoder states.

## Key Ideas

- The encoder converts an input sequence into hidden representations.
- The decoder generates an output sequence step by step.
- Attention gives the decoder a weighted view over source positions.

## How I Would Use It

- Use this as a bridge between RNN-based NLP and transformer models.
- Study attention weights to understand alignment between input and output tokens.

## Watch-outs

- Attention visualization can be helpful but is not always a complete explanation.
- Long sequences still create computational and evaluation challenges.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
