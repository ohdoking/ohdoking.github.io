---
layout: post
title: "GAN Study Notes"
date: 2025-10-27 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - gan
  - generative-ai
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/GAN"
description: "Generative adversarial networks frame generation as a competition between two models: one creates samples and the other tries to distinguish real from generated data."
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Generative adversarial networks frame generation as a competition between two models: one creates samples and the other tries to distinguish real from generated data.

## Key Ideas

- The generator learns to produce realistic samples.
- The discriminator learns to identify whether samples are real or generated.
- Training is a dynamic game rather than a single straightforward optimization problem.

## How I Would Use It

- Use GANs as a foundation for understanding image generation history.
- Study discriminator feedback as a way to think about learned quality signals.

## Watch-outs

- GAN training can be unstable and sensitive to architecture and hyperparameters.
- Mode collapse can make generated outputs look plausible but lack diversity.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
