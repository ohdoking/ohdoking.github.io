---
layout: post
title: "Cross Entropy and KL Divergence Notes"
date: 2026-01-19 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - loss
  - cross-entropy
  - kl-divergence
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/Cross Entropy and KL Divergence"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Cross entropy and KL divergence show up repeatedly in classification and probabilistic modeling. They help compare predicted distributions with target distributions.

## Key Ideas

- Cross entropy measures how well predicted probabilities match the target labels.
- KL divergence measures how one probability distribution differs from another.
- Softmax is often paired with cross entropy for multi-class classification.

## How I Would Use It

- Use cross entropy to reason about confidence, calibration, and classification errors.
- Use KL divergence concepts when studying VAEs, distillation, or distribution matching.

## Watch-outs

- High confidence wrong predictions can dominate loss.
- Loss values are easier to interpret when compared across the same dataset and setup.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
