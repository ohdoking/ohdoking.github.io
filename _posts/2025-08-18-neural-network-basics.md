---
layout: post
title: "Neural Network Basics"
date: 2025-08-18 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - neural-network
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/인공신경망"
description: "This note revisits the basic building blocks of neural networks: parameters, activations, layers, loss functions, and optimization."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

This note revisits the basic building blocks of neural networks: parameters, activations, layers, loss functions, and optimization.

## Key Ideas

- A neural network learns parameters that transform inputs into useful outputs.
- Activation functions add non-linearity, which lets stacked layers model complex relationships.
- Training adjusts weights to minimize a loss function over examples.

## How I Would Use It

- Use the simple input-layer-output mental model before jumping into deeper architectures.
- Connect model quality discussions to data, loss, optimization, and evaluation.

## Watch-outs

- More layers or parameters do not automatically mean better generalization.
- A model can fit training data while failing on real-world distributions.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
