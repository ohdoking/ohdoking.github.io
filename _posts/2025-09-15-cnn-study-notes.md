---
layout: post
title: "CNN Study Notes"
date: 2025-09-15 09:00:00 +0100
category: blog
tags:
  - study
  - ai
  - cnn
  - computer-vision
blog_category: "ai-llm"
study_category: "AI"
origin: notion
import_batch: notion-batch-2
source_note: "AI/CNN"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

Convolutional neural networks are designed around local spatial structure. They are especially useful when nearby features matter, such as in images.

## Key Ideas

- Convolution filters scan across input to detect local patterns.
- Pooling can reduce spatial resolution while keeping important signals.
- Stacked convolutional layers can learn increasingly abstract visual features.

## How I Would Use It

- Use CNN concepts to understand image classifiers, object detection backbones, and visual feature extractors.
- Study receptive fields when reasoning about what part of an image influences a prediction.

## Watch-outs

- CNNs can be sensitive to data distribution, augmentation, and preprocessing.
- High validation accuracy may hide failures on edge cases or shifted image sources.

## Practical Reflection

For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
