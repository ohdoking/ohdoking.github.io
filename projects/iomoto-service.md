---
layout: page
title: "Iomoto Service Case Study"
description: Case study for Iomoto Service, a production microservice platform for mobility services built at ZF car eWallet.
permalink: /projects/iomoto-service/
---

<div class="case-study">
  <div class="case-study__hero">
    <p class="case-study__eyebrow">Production backend platform</p>
    <h1>Iomoto Service</h1>
    <p class="case-study__summary">
      A microservice platform for mobility services, where the work centered on implementing and maintaining backend services across messaging, data, cloud infrastructure, and long-running production operations.
    </p>
  </div>

  <div class="case-study__meta">
    <span>Role: Backend developer</span>
    <span>Context: ZF car eWallet</span>
    <span>Focus: Java microservices, messaging, databases, cloud operations</span>
  </div>

  <section class="case-study__section">
    <h2>Problem</h2>
    <p>
      Mobility platforms do not fail only because of one endpoint or one database query. The challenge is keeping many services, data stores, and async workflows stable enough to support real product behavior over time.
    </p>
  </section>

  <section class="case-study__section">
    <h2>What I Worked On</h2>
    <p>
      I implemented and maintained production microservices in a system that depended on Java services, messaging, multiple databases, and cloud infrastructure. The value of the work was not one isolated feature, but steady delivery inside a complex backend platform.
    </p>
    <ul>
      <li>Worked on Java-based services using Spring Boot, Spring Core, Hibernate, and Quarkus.</li>
      <li>Handled production concerns across Postgres, MongoDB, RabbitMQ, Azure, Kubernetes, and Terraform.</li>
      <li>Built experience with service boundaries, operational reliability, and real-world platform maintenance.</li>
    </ul>
  </section>

  <section class="case-study__section">
    <h2>Backend Lessons</h2>
    <p>
      This project was formative because it reinforced how much backend quality depends on integration boundaries, not just business logic. Messaging, persistence, deployment, and observability all shape whether a service is actually dependable.
    </p>
    <ul>
      <li>Microservices create organizational and operational tradeoffs as much as code-level ones.</li>
      <li>Async workflows need careful ownership and failure handling.</li>
      <li>Production backend work is cumulative: small improvements to reliability and maintainability matter.</li>
    </ul>
  </section>

  <section class="case-study__section">
    <h2>What This Demonstrates</h2>
    <ul>
      <li>Experience working inside a long-running production platform instead of only greenfield builds.</li>
      <li>Comfort across code, data, messaging, cloud deployment, and operational debugging.</li>
      <li>Ability to reason about backend systems as a whole, not only by framework.</li>
    </ul>
  </section>

  <section class="case-study__section">
    <h2>Related Writing</h2>
    <ul>
      <li><a href="{{ site.url }}/http-backend-contracts/">HTTP as a Backend Contract</a></li>
      <li><a href="{{ site.url }}/grpc-service-boundaries/">gRPC Service Boundaries</a></li>
      <li><a href="{{ site.url }}/postgresql-redundancy-notes/">PostgreSQL Redundancy Notes</a></li>
    </ul>
  </section>
</div>
