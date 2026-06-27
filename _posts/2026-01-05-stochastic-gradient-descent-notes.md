---
layout: post
title: "Stochastic Gradient Descent Notes"
date: 2026-01-05 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - optimization
  - sgd
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/Stochastic Gradient Descent"
description: "Stochastic gradient descent is the foundation behind many training loops. The core idea is to update parameters using gradient estimates from small batches of data."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Stochastic gradient descent is the foundation behind many training loops. The core idea is to update parameters using gradient estimates from small batches of data.

## Key Ideas

- Gradient descent moves parameters in the direction that reduces loss.
- Stochastic updates use subsets of data, which makes training scalable.
- Learning rate controls the size of each update step.

## How I Would Use It

- Use SGD intuition to interpret training curves and convergence behavior.
- Compare optimizers by how they adapt update direction and step size.

## Watch-outs

- A learning rate that is too high can make training diverge.
- A learning rate that is too low can make training appear stuck.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
