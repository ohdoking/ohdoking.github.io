---
title: "GraphQL for Backend Developers"
layout: post
date: 2024-10-15 09:00
image: /assets/images/markdown.jpg
headerImage: false
star: true
category: blog
tags:
  - GraphQL
  - Backend
  - API
study_category: Programming
author: Dokeun Oh
description: A practical backend-focused introduction to GraphQL queries, schemas, and when it differs from REST or SQL.
---

# GraphQL for Backend Developers

GraphQL is often misunderstood because the name ends with "QL". It is not a database query language like SQL. SQL is used between an application and a database. GraphQL is usually used between a client and an API server.

The main idea is simple: the client asks for the exact shape of data it needs, and the server resolves that request through a typed schema.

## Why GraphQL Exists

In a REST API, the backend usually defines fixed endpoints:

```text
GET /contents/1
GET /contents/1/comments
GET /users/10
```

That works well, but it can create two common problems.

First, the client may receive too much data. Second, the client may need several round trips to collect related data. GraphQL addresses this by letting the client describe the response shape in one request.

```graphql
{
  content(id: 1) {
    contentId
    contentTitle
    comments {
      commentId
      commentBody
    }
  }
}
```

The response follows the same shape.

## Core Query Concepts

### Fields

Fields are the properties requested from an object.

```graphql
{
  content {
    contentId
  }
}
```

Here `contentId` is a field.

### Arguments

Arguments let the client pass values to a field.

```graphql
{
  content(id: 1) {
    contentId
    contentTitle
  }
}
```

Arguments are similar to request parameters in REST, but they are part of the GraphQL query language.

### Aliases

Aliases are useful when calling the same field more than once with different arguments.

```graphql
{
  firstContent: content(id: 1) {
    contentId
  }
  secondContent: content(id: 2) {
    contentId
  }
}
```

Without aliases, the response would have two fields named `content`, which creates ambiguity.

### Fragments

Fragments reduce repetition in queries.

```graphql
{
  firstContent: content(id: 1) {
    ...contentFields
  }
  secondContent: content(id: 2) {
    ...contentFields
  }
}

fragment contentFields on Content {
  contentId
  contentTitle
}
```

This is useful when several parts of a query need the same fields.

### Operation Names and Variables

In real applications, queries should usually have operation names and variables.

```graphql
query GetContent($contentId: ID!) {
  content(id: $contentId) {
    contentId
    contentTitle
  }
}
```

Variables avoid hard-coded values and make queries easier to log, test, and reuse.

## Schema and Types

The schema is the contract between the client and server. It defines available objects, fields, queries, and mutations.

```graphql
type Content {
  contentId: ID!
  contentTitle: String!
  contentBody: String
  comments: [Comment]
}

type Comment {
  commentId: ID!
  commentBody: String
}

type Query {
  content(id: ID!): Content
  contentList: [Content]
}

type Mutation {
  writeContent(title: String!, body: String): ID
}

schema {
  query: Query
  mutation: Mutation
}
```

Important details:

- `!` means the field is non-null.
- `[Comment]` means the field returns a list.
- `Query` is for reads.
- `Mutation` is for writes.

## Backend Lifecycle

A GraphQL request usually follows this flow:

1. Client sends a query.
2. Server parses and validates the query against the schema.
3. Resolver functions fetch data from databases, services, or other APIs.
4. Server assembles the response in the requested shape.
5. Client receives only the fields it asked for.

The resolver layer is where backend architecture matters. A GraphQL API can still call SQL databases, REST services, Kafka-backed read models, or other microservices behind the scenes.

## Things to Watch

GraphQL is powerful, but it is not free.

N+1 query problems can happen when nested fields trigger repeated database calls. Use batching and caching tools such as DataLoader or query-level optimization.

Authorization needs field-level care. A user may be allowed to read a `Content` object but not every field inside it.

Caching is different from REST. Since most requests go to one endpoint, HTTP caching alone is often not enough.

## Recap

GraphQL is best understood as an API contract and query layer between clients and backend systems. It is useful when clients need flexible response shapes, strong typing, and fewer round trips. For backend developers, the important work is schema design, resolver performance, authorization, and operational discipline.
