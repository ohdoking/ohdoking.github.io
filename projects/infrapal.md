---
layout: page
title: "InfraPal Case Study"
description: Case study for InfraPal, a multi-agent AI infrastructure product for cloud optimization and Infrastructure as Code automation.
permalink: /projects/infrapal/
---

<div class="case-study">
  <div class="case-study__hero">
    <p class="case-study__eyebrow">AI infrastructure product</p>
    <h1>InfraPal</h1>
    <p class="case-study__summary">
      A multi-agent system for cloud optimization and Infrastructure as Code automation, built to turn cloud analysis and execution workflows into a more usable backend product.
    </p>
  </div>

  <div class="case-study__meta">
    <span>Role: CTO and backend architect</span>
    <span>Context: Serverless Salad</span>
    <span>Focus: cloud optimization, AI workflows, IaC</span>
  </div>

  <section class="case-study__section">
    <h2>Problem</h2>
    <p>
      Cloud optimization tools often stop at static analysis or dashboards. The harder product problem is connecting infrastructure context, AI reasoning, execution boundaries, and operational safety in one coherent workflow.
    </p>
  </section>

  <section class="case-study__section">
    <h2>What I Built</h2>
    <p>
      I designed the backend and platform shape for a product that combines infrastructure data, agent workflows, and Infrastructure as Code automation. The work centered on turning AI-assisted cloud recommendations into something structured enough to operate, extend, and secure.
    </p>
    <ul>
      <li>Designed a FastAPI-based backend for orchestration, API surfaces, and workflow boundaries.</li>
      <li>Used AWS, Kubernetes, and Terraform as the operational base for deploying and evolving the platform.</li>
      <li>Framed multi-agent behavior around practical cloud tasks instead of generic agent demos.</li>
    </ul>
  </section>

  <section class="case-study__section">
    <h2>Architecture Thinking</h2>
    <p>
      The important backend question was not only how to call models, but how to keep cloud context, execution permissions, and system behavior legible. Agentic infrastructure tooling becomes dangerous quickly if recommendations, actions, and auditability are not clearly separated.
    </p>
    <ul>
      <li>Cloud context and execution paths need strong boundaries.</li>
      <li>AI output has to be shaped into reviewable infrastructure actions.</li>
      <li>Security, secrets, IAM, and operational traceability are part of the product design, not cleanup work.</li>
    </ul>
  </section>

  <section class="case-study__section">
    <h2>What This Demonstrates</h2>
    <ul>
      <li>Ability to bridge backend engineering with AI product design.</li>
      <li>Comfort with cloud-native architecture, deployment, and operational tradeoffs.</li>
      <li>Practical judgment about where automation should stop and human review should begin.</li>
    </ul>
  </section>

  <section class="case-study__section">
    <h2>Related Writing</h2>
    <ul>
      <li><a href="{{ site.url }}/aws-components-backend-notes/">AWS Components for Backend Systems</a></li>
      <li><a href="{{ site.url }}/aws-iam-authorization-patterns/">AWS IAM and Authorization Patterns</a></li>
      <li><a href="{{ site.url }}/langchain-ai-web-service/">Creating an AI Web Service with LangChain</a></li>
    </ul>
  </section>
</div>
