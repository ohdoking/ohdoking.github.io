---
title: "Understanding Transformer Self-Attention"
layout: post
date: 2025-04-22 09:00
image: /assets/images/markdown.jpg
headerImage: false
star: true
category: blog
blog_category: ai-llm
tags:
  - AI
  - Transformer
  - Machine Learning
study_category: AI
author: Dokeun Oh
description: A step-by-step explanation of self-attention, query/key/value vectors, and why Transformers handle context well.
---

# Understanding Transformer Self-Attention

Self-attention is the core mechanism behind Transformer models. It lets each token in a sequence decide which other tokens are important for understanding its own meaning.

For example:

```text
The cat sat on the mat because it was warm.
```

What does `it` refer to? Depending on the context, it may refer to the cat or the mat. Self-attention gives the model a way to assign relevance scores between words instead of reading the sentence only from left to right.

## Quick Summary

- Each token produces query, key, and value vectors.
- Attention scores are computed from query-key similarity.
- Scores are scaled, normalized with softmax, and used to mix value vectors.
- Multi-head attention repeats this process in parallel from different learned perspectives.
- Positional information is still needed because attention alone does not know token order.

## The Main Idea

Each token is converted into three vectors:

- Query: what this token is looking for
- Key: what this token offers for matching
- Value: the information this token can contribute

These are usually written as `Q`, `K`, and `V`.

```text
Q = X @ Wq
K = X @ Wk
V = X @ Wv
```

`X` is the input embedding matrix. `Wq`, `Wk`, and `Wv` are learned weight matrices.

## A Small Example

Assume this short sentence:

```text
I love NLP
```

Each word starts as an embedding vector. The model transforms those embeddings into query, key, and value vectors.

Then it compares each query with every key. In the Transformer paper, this is scaled dot-product attention:

```text
Attention(Q, K, V) = softmax(QK^T / sqrt(d_k))V
```

`d_k` is the dimension of the key vectors. The scaling factor keeps dot products from becoming too large as the vector dimension grows.

If the score between token `i` and token `j` is high, token `i` pays more attention to token `j`.

## From Scores to Weights

Raw scores are scaled and normalized with softmax.

```text
attention_weights = softmax(scores / sqrt(d_k))
```

After softmax, the weights sum to 1. A token may assign high weight to one related token and low weight to unrelated tokens.

Then the final representation is computed as a weighted sum of value vectors.

```text
attention_output = attention_weights @ V
```

This means every token representation becomes context-aware.

## Why Self-Attention Works Well

Self-attention has three important advantages.

First, it captures long-range dependencies. A token can directly attend to another token even if they are far apart.

Second, it is parallelizable. Unlike RNN-style sequence processing, a Transformer can compute attention over many tokens at the same time.

Third, it is dynamic. The same word can produce a different representation depending on the sentence around it.

There is one important caveat: self-attention by itself does not encode token order. Transformer models add positional information so the model can distinguish "dog bites man" from "man bites dog".

## Multi-Head Attention

Instead of running one attention calculation, Transformers run several attention heads in parallel.

Each head can learn a different relationship:

- grammar relationships
- subject/object references
- positional patterns
- semantic similarity
- long-range dependencies

The outputs from all heads are concatenated and projected into the next layer.

This is why the mechanism is called multi-head attention.

## Self-Attention in One Pass

The full flow is:

1. Convert tokens to embeddings.
2. Add positional information.
3. Create Q, K, and V vectors.
4. Compare Q with K to produce attention scores.
5. Scale and normalize scores with softmax.
6. Use the weights to combine V vectors.
7. Produce context-aware token representations.

## Recap

Self-attention lets a model decide which tokens matter for each token in a sequence. Query, key, and value vectors make this comparison trainable. Scaling and softmax turn raw similarity scores into usable weights. Multi-head attention repeats the process from several perspectives, which gives Transformers their strong ability to model context.

## References

- [Attention Is All You Need](https://arxiv.org/abs/1706.03762)
