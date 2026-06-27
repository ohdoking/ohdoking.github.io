---
layout: post
title: "MS AI Agents Hackathon Notes"
date: 2026-03-02 09:00:00 +0100
category: blog
tags:
  - study
  - project
  - ai
  - agents
  - hackathon
study_category: "Project"
origin: notion
import_batch: notion-batch-2
source_note: "Project/MS AI Agents Hackathon"
---

> Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

## What I Wanted to Clarify

This note turns the MS AI Agents Hackathon material into a public reflection on what makes an agent project credible.

## Key Ideas

- An agent should have a clear task, tool boundary, memory strategy, and feedback loop.
- Tool calls need validation because the model can choose the wrong action.
- Agent demos are stronger when they show recovery from errors, not only the happy path.

## How I Would Use It

- Use hackathon constraints to quickly test whether an agent workflow is valuable.
- Document tool permissions, evaluation prompts, and submission criteria early.

## Watch-outs

- Calling every LLM workflow an agent makes the architecture harder to evaluate.
- A convincing demo still needs guardrails before real users can trust it.

## Practical Reflection

For project notes, I keep the public version centered on reusable engineering lessons: problem framing, architecture choices, demo constraints, and what I would improve next. That makes the note shareable without exposing private brainstorming, raw event logistics, or unfinished product strategy.

## Next Questions

- What would I measure to know this idea works in production?
- Where should this concept live in a real backend or AI system design?
