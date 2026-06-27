---
layout: post
title: "Backpropagation Study Notes"
date: 2025-09-01 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - backpropagation
  - optimization
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/BackPropagation"
description: "Backpropagation is the mechanism that makes neural network training practical. It computes how much each parameter contributed to the loss by applying the chain rule..."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Backpropagation is the mechanism that makes neural network training practical. It computes how much each parameter contributed to the loss by applying the chain rule backward through the model.

## Key Ideas

- Forward pass computes predictions and loss.
- Backward pass computes gradients from the loss back to each parameter.
- An optimizer uses gradients to update weights.

## How I Would Use It

- Use backpropagation intuition to understand why vanishing gradients, exploding gradients, and learning rate matter.
- Debug training by watching loss curves, gradient norms, and validation behavior.

## Watch-outs

- Gradients show local direction, not guaranteed global optimality.
- Bad scaling or initialization can make training unstable even when the architecture is correct.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
