require "fileutils"

POSTS = [
  {
    date: "2024-05-06",
    slug: "spring-reactive-webflux-study-notes",
    title: "Spring Reactive and WebFlux Study Notes",
    study_category: "Programming",
    tags: %w[study programming spring webflux reactive],
    source_note: "Study/Programing/Spring reactive and WebFlux",
    summary: "I wanted to separate where reactive programming helps from where it only adds complexity. WebFlux is useful when a service spends a lot of time waiting on network I/O, but it is not a blanket replacement for simple servlet-based APIs.",
    key_ideas: [
      "Reactive streams model demand with backpressure, so producers should not overwhelm consumers.",
      "WebFlux uses non-blocking request handling, which means blocking database calls or file I/O can erase the benefit.",
      "Reactive code needs explicit thinking around error handling, retries, timeouts, and context propagation."
    ],
    applications: [
      "Use it for gateway-like services, streaming APIs, fan-out calls, and high-concurrency I/O workloads.",
      "Keep a clear boundary between reactive adapters and domain logic so the whole codebase does not become harder to read."
    ],
    watch_outs: [
      "Do not mix blocking JPA calls into an event-loop path without isolating them.",
      "Prefer measuring latency and thread usage before deciding that WebFlux is the right tool."
    ]
  },
  {
    date: "2024-05-20",
    slug: "spring-data-jpa-r2dbc-hibernate-reactive",
    title: "Spring Data JPA, R2DBC, and Hibernate Reactive",
    study_category: "Programming",
    tags: %w[study programming spring jpa r2dbc],
    source_note: "Study/Programing/Spring JPA, J2DBC, Hibernetes reactive",
    summary: "This note compares the mental models behind traditional ORM persistence and reactive database access. The important distinction is not only API style, but also transaction scope, lazy loading, connection usage, and operational predictability.",
    key_ideas: [
      "JPA is a mature object-relational mapping model with persistence contexts and entity lifecycle management.",
      "R2DBC provides non-blocking database access, but it does not reproduce every JPA behavior.",
      "Hibernate Reactive keeps ORM ideas but expects the application to stay inside a reactive execution model."
    ],
    applications: [
      "Use JPA when domain mapping, mature tooling, and transaction consistency matter more than non-blocking I/O.",
      "Use R2DBC for simple query flows where reactive end-to-end behavior is more important than ORM convenience."
    ],
    watch_outs: [
      "Do not choose a reactive driver if the rest of the stack is still blocking.",
      "Be explicit about transaction boundaries because async flows make hidden coupling harder to debug."
    ]
  },
  {
    date: "2024-06-03",
    slug: "jdbc-datasource-boundaries",
    title: "JDBC and DataSource Boundaries",
    study_category: "Programming",
    tags: %w[study programming java jdbc database],
    source_note: "Study/Programing/JDBC, DataSource",
    summary: "JDBC looks simple at the API level, but production behavior depends heavily on connection management. This note focuses on the boundary between application code, a DataSource, the connection pool, and the database.",
    key_ideas: [
      "A DataSource is the application-facing abstraction for obtaining database connections.",
      "Connection pools control concurrency, reuse, validation, timeout behavior, and failure recovery.",
      "Prepared statements, transaction isolation, and resource closing are core reliability concerns."
    ],
    applications: [
      "Treat pool configuration as production infrastructure, not a default setting.",
      "Keep repository code small and predictable when direct JDBC is clearer than a larger ORM layer."
    ],
    watch_outs: [
      "A pool that is too large can move pressure from the JVM to the database.",
      "A missing timeout can turn a downstream database issue into a full service outage."
    ]
  },
  {
    date: "2024-06-17",
    slug: "java-servlet-spring-request-lifecycle",
    title: "Java Servlet and Spring Request Lifecycle",
    study_category: "Programming",
    tags: %w[study programming java servlet spring],
    source_note: "Study/Programing/Java Servlet and spring",
    summary: "This note revisits the servlet model that still shapes a lot of Spring MVC applications. Understanding the request lifecycle makes filters, interceptors, controllers, exception handlers, and security chains easier to reason about.",
    key_ideas: [
      "A servlet container accepts HTTP requests and dispatches them through a configured processing chain.",
      "Spring MVC adds handler mapping, argument resolution, validation, binding, and response rendering on top.",
      "Filters run at the servlet layer, while interceptors and controller advice live closer to Spring MVC."
    ],
    applications: [
      "Use filters for cross-cutting HTTP concerns like correlation IDs, logging, and security integration.",
      "Use Spring MVC extension points when the logic depends on controller semantics."
    ],
    watch_outs: [
      "Ordering matters because security, logging, and exception handling can interact unexpectedly.",
      "Keep request-scoped assumptions explicit when introducing async processing."
    ]
  },
  {
    date: "2024-07-01",
    slug: "jvm-runtime-study-notes",
    title: "JVM Runtime Study Notes",
    study_category: "Programming",
    tags: %w[study programming java jvm],
    source_note: "Study/Programing/JVM",
    summary: "The JVM is more than a Java execution engine. For backend systems, its memory model, class loading, just-in-time compilation, garbage collection, and observability hooks directly affect service reliability.",
    key_ideas: [
      "Bytecode gives JVM languages a common runtime target.",
      "JIT compilation optimizes hot paths based on runtime behavior.",
      "Heap, stack, metaspace, threads, and native memory all matter when debugging production issues."
    ],
    applications: [
      "Use JVM metrics and thread dumps as first-class debugging tools.",
      "Connect performance tuning decisions to measured allocation rate, latency, and garbage collection behavior."
    ],
    watch_outs: [
      "Do not tune JVM flags blindly from a checklist.",
      "A memory leak can live outside the Java heap through native buffers or thread-local references."
    ]
  },
  {
    date: "2024-07-15",
    slug: "garbage-collection-backend-services",
    title: "Garbage Collection for Backend Services",
    study_category: "Programming",
    tags: %w[study programming java jvm gc],
    source_note: "Study/Programing/Garbage collection",
    summary: "Garbage collection is a runtime feature, but it becomes an application concern when latency, allocation rate, and memory pressure affect user-facing behavior.",
    key_ideas: [
      "GC works by finding objects that are no longer reachable and reclaiming their memory.",
      "Modern collectors optimize for different goals such as throughput, pause time, and heap size.",
      "Allocation patterns often matter more than object count alone."
    ],
    applications: [
      "Watch allocation rate, pause percentiles, heap occupancy, and promotion behavior in production.",
      "Reduce unnecessary short-lived allocations in hot paths only after profiling."
    ],
    watch_outs: [
      "A larger heap can reduce collection frequency while increasing worst-case pause or recovery time.",
      "GC tuning cannot fix unbounded caches, retained references, or missing backpressure."
    ]
  },
  {
    date: "2024-07-29",
    slug: "completablefuture-async-java",
    title: "CompletableFuture and Async Java",
    study_category: "Programming",
    tags: %w[study programming java async concurrency],
    source_note: "Study/Programing/CompleteFuture",
    summary: "CompletableFuture is useful for composing asynchronous work, but its readability depends on disciplined executor usage and explicit error handling.",
    key_ideas: [
      "A CompletableFuture represents a value that may complete later, either successfully or exceptionally.",
      "Composition methods such as thenApply, thenCompose, and allOf model different dependency shapes.",
      "The executor behind async stages determines where work actually runs."
    ],
    applications: [
      "Use it for independent I/O calls, fan-out aggregation, and timeout-wrapped integrations.",
      "Name executors and separate CPU-bound work from blocking I/O tasks."
    ],
    watch_outs: [
      "The common ForkJoinPool is not a safe default for every backend workload.",
      "Exceptions can be swallowed or wrapped if completion stages are not handled deliberately."
    ]
  },
  {
    date: "2024-08-12",
    slug: "redis-cache-study-notes",
    title: "Redis and Cache Study Notes",
    study_category: "Programming",
    tags: %w[study programming redis cache],
    source_note: "Study/Programing/Redis",
    summary: "Redis is often introduced as a cache, but production usage also involves data structures, expiration policy, memory limits, replication, and failure behavior.",
    key_ideas: [
      "Redis keeps data in memory and offers structures such as strings, hashes, sets, sorted sets, and streams.",
      "TTL and eviction settings are part of application correctness, not only infrastructure tuning.",
      "Caching changes the consistency model between the source of truth and the read path."
    ],
    applications: [
      "Use Redis for hot reads, distributed rate limits, lightweight coordination, and temporary session-like state.",
      "Choose cache keys and invalidation rules before writing integration code."
    ],
    watch_outs: [
      "A cache stampede can overload the database when a popular key expires.",
      "Do not store critical source-of-truth data in Redis unless durability and recovery are designed."
    ]
  },
  {
    date: "2024-08-26",
    slug: "cache-invalidation-patterns",
    title: "Cache Invalidation Patterns",
    study_category: "Programming",
    tags: %w[study programming cache architecture],
    source_note: "Study/Programing/Cache",
    summary: "Caching is easy to add and hard to keep correct. The useful question is not whether to cache, but what freshness guarantees the user and system actually need.",
    key_ideas: [
      "Read-through, write-through, write-around, and cache-aside patterns move responsibility to different layers.",
      "TTL is a safety mechanism, but it is not a complete invalidation strategy.",
      "Key design should include versioning, tenant boundaries, and parameter normalization."
    ],
    applications: [
      "Use cache-aside for simple service-owned reads where stale data is acceptable for a known window.",
      "Use explicit invalidation when a write must be visible quickly."
    ],
    watch_outs: [
      "Caching authorization-sensitive data can accidentally leak access across users.",
      "Metrics should distinguish cache hit rate, stale reads, and backend fallback latency."
    ]
  },
  {
    date: "2024-09-09",
    slug: "http-backend-contracts",
    title: "HTTP as a Backend Contract",
    study_category: "Programming",
    tags: %w[study programming http api],
    source_note: "Study/Programing/HTTP",
    summary: "HTTP is not just transport. Methods, status codes, headers, caching, content negotiation, and idempotency all communicate service behavior.",
    key_ideas: [
      "GET, POST, PUT, PATCH, and DELETE carry different expectations around safety and idempotency.",
      "Status codes should describe the outcome at the protocol boundary, not internal implementation details.",
      "Headers such as Authorization, Cache-Control, ETag, and Retry-After can encode important behavior."
    ],
    applications: [
      "Design APIs so clients can retry safe operations without causing duplicate side effects.",
      "Use consistent error bodies and correlation IDs to improve debugging across services."
    ],
    watch_outs: [
      "Returning 200 for every outcome makes observability and client behavior worse.",
      "Timeouts and retries should be designed together to avoid traffic amplification."
    ]
  },
  {
    date: "2024-09-23",
    slug: "socket-networking-basics",
    title: "Socket Networking Basics",
    study_category: "Programming",
    tags: %w[study programming network socket],
    source_note: "Study/Programing/Socket",
    summary: "Sockets are the low-level boundary behind many familiar network abstractions. Studying them helps explain why connection lifecycle, buffering, and timeouts matter.",
    key_ideas: [
      "A socket represents one endpoint of a network communication path.",
      "TCP sockets provide ordered byte streams, while UDP sockets send independent datagrams.",
      "Connection establishment, read/write buffering, and shutdown behavior affect application protocols."
    ],
    applications: [
      "Use socket-level thinking when debugging hanging requests, half-open connections, or connection pool exhaustion.",
      "Set explicit connect, read, write, and idle timeouts in client libraries."
    ],
    watch_outs: [
      "A successful connection does not mean the remote service is healthy enough to handle requests.",
      "Ignoring backpressure can turn a slow consumer into memory growth."
    ]
  },
  {
    date: "2024-10-07",
    slug: "tcp-ip-study-notes",
    title: "TCP/IP Study Notes",
    study_category: "Programming",
    tags: %w[study programming network tcp],
    source_note: "Study/Programing/TCP IP",
    summary: "TCP/IP remains essential background knowledge for backend debugging. Many application symptoms are easier to explain when the transport layer is not treated as magic.",
    key_ideas: [
      "IP handles addressing and routing across networks.",
      "TCP adds ordered delivery, retransmission, congestion control, and flow control.",
      "Application latency can be affected by DNS, handshakes, packet loss, congestion, and server processing."
    ],
    applications: [
      "Use packet captures, connection metrics, and load balancer logs when application logs are not enough.",
      "Think about connection reuse before increasing service concurrency."
    ],
    watch_outs: [
      "Retrying after network errors can duplicate writes unless the API is idempotent.",
      "Long-lived connections need health checks, keep-alives, and clear timeout strategy."
    ]
  },
  {
    date: "2024-10-21",
    slug: "tcp-udp-ethernet-notes",
    title: "TCP, UDP, and Ethernet Notes",
    study_category: "Programming",
    tags: %w[study programming network tcp udp ethernet],
    source_note: "Study/Programing/TCP UDP and Ethernet",
    summary: "This note separates three layers that often get compressed into one mental model: Ethernet for local frames, IP for routing, and TCP or UDP for transport behavior.",
    key_ideas: [
      "Ethernet frames move data within a local network segment.",
      "UDP is lightweight and message-oriented, but it does not guarantee delivery or ordering.",
      "TCP is connection-oriented and reliable, but that reliability has handshake and state costs."
    ],
    applications: [
      "Use UDP when the application can tolerate loss or builds its own reliability model.",
      "Use TCP when ordered reliable streams matter more than minimal overhead."
    ],
    watch_outs: [
      "A protocol choice should follow product behavior, not only performance assumptions.",
      "Observability should include packet loss, retransmits, and connection churn for network-sensitive systems."
    ]
  },
  {
    date: "2024-11-04",
    slug: "dns-cname-a-record",
    title: "DNS CNAME and A Record Differences",
    study_category: "Programming",
    tags: %w[study programming dns network],
    source_note: "Study/Programing/DNS에서 CNAME과 A 레코드의 차이",
    summary: "DNS records are operational contracts. Knowing the difference between A records and CNAME records helps when configuring domains, certificates, CDN routing, and service migrations.",
    key_ideas: [
      "An A record maps a name directly to an IPv4 address.",
      "A CNAME record aliases one hostname to another hostname.",
      "DNS TTL controls how quickly clients may observe changes after a record update."
    ],
    applications: [
      "Use CNAME records when delegating a subdomain to another managed service.",
      "Use A records when pointing directly to stable IP addresses."
    ],
    watch_outs: [
      "CNAME records are usually not valid at the zone apex unless the DNS provider offers an alias-like feature.",
      "DNS changes are not instant because resolvers cache records according to TTL."
    ]
  },
  {
    date: "2024-11-18",
    slug: "oauth-backend-notes",
    title: "OAuth Backend Notes",
    study_category: "Programming",
    tags: %w[study programming oauth security],
    source_note: "Study/Programing/OAuth",
    summary: "OAuth is easy to misread as login. The cleaner model is delegated authorization: a client receives limited access to a protected resource through tokens and scopes.",
    key_ideas: [
      "The authorization server issues tokens after validating the user, client, and grant flow.",
      "Access tokens represent permission to call resource servers.",
      "Scopes, audience, expiration, and refresh behavior constrain token usage."
    ],
    applications: [
      "Use authorization code flow with PKCE for browser or mobile clients.",
      "Validate issuer, audience, signature, expiration, and scopes at service boundaries."
    ],
    watch_outs: [
      "Do not treat possession of any JWT as proof that a caller can access every API.",
      "Refresh tokens require stricter storage and revocation handling than short-lived access tokens."
    ]
  },
  {
    date: "2024-12-16",
    slug: "mfa-backend-security",
    title: "MFA from a Backend Security Perspective",
    study_category: "Programming",
    tags: %w[study programming security mfa],
    source_note: "Study/Programing/MFA",
    summary: "Multi-factor authentication reduces account takeover risk, but backend implementation details decide whether it meaningfully improves security.",
    key_ideas: [
      "MFA combines factors such as something the user knows, has, or is.",
      "Enrollment, recovery, device changes, and fallback flows are part of the threat model.",
      "Risk-based prompts can reduce friction while still protecting sensitive actions."
    ],
    applications: [
      "Require stronger verification for account recovery, payout changes, and privileged actions.",
      "Log MFA enrollment and challenge events for security monitoring."
    ],
    watch_outs: [
      "Weak recovery flows can bypass strong MFA.",
      "SMS is better than no MFA but is weaker than authenticator apps or hardware-backed methods."
    ]
  },
  {
    date: "2025-01-06",
    slug: "base64-encoding-boundaries",
    title: "Base64 and Encoding Boundaries",
    study_category: "Programming",
    tags: %w[study programming encoding base64],
    source_note: "Study/Programing/Base64",
    summary: "Base64 is often confused with encryption. It is only an encoding that converts binary data into text-safe characters for transport or storage.",
    key_ideas: [
      "Encoding changes representation, not secrecy.",
      "Base64 increases payload size because binary bytes are represented with a smaller text-safe alphabet.",
      "It is useful for embedding binary data in JSON, URLs, headers, or text-oriented protocols."
    ],
    applications: [
      "Use Base64 when a channel cannot safely transport raw bytes.",
      "Name fields clearly so future readers do not assume encoded means encrypted."
    ],
    watch_outs: [
      "Never use Base64 as a security mechanism.",
      "Be careful with URL-safe variants and padding when interoperating between systems."
    ]
  },
  {
    date: "2025-01-20",
    slug: "checksum-hash-integrity",
    title: "Checksum and Hash for Integrity",
    study_category: "Programming",
    tags: %w[study programming hash checksum security],
    source_note: "Study/Programing/Checksum and Hash",
    summary: "Checksums and cryptographic hashes both summarize data, but they solve different classes of problems. The distinction matters when validating files, messages, or signatures.",
    key_ideas: [
      "Checksums are useful for detecting accidental corruption.",
      "Cryptographic hashes are designed to resist preimage and collision attacks.",
      "Integrity alone does not prove who created the data unless authentication is added."
    ],
    applications: [
      "Use checksums for transfer validation where malicious tampering is not the primary threat.",
      "Use cryptographic hashes with signatures or MACs when trust matters."
    ],
    watch_outs: [
      "A hash published through the same untrusted channel as the file provides weak protection.",
      "Old hash algorithms can become unsafe as collision attacks improve."
    ]
  },
  {
    date: "2025-02-03",
    slug: "rsa-sha256-signatures",
    title: "RSA and SHA-256 Signatures",
    study_category: "Programming",
    tags: %w[study programming security rsa sha256],
    source_note: "Study/Programing/RSA and SHA256",
    summary: "RSA and SHA-256 often appear together in digital signatures. SHA-256 hashes the message; RSA signs or verifies the digest using asymmetric keys.",
    key_ideas: [
      "A cryptographic hash creates a fixed-size digest from arbitrary input.",
      "A digital signature binds a digest to a private key while allowing verification with the public key.",
      "Padding and algorithm parameters are part of the security contract."
    ],
    applications: [
      "Use signatures for artifact verification, webhooks, token validation, and secure message exchange.",
      "Prefer well-maintained libraries and platform primitives over custom crypto code."
    ],
    watch_outs: [
      "Never invent a signature format without understanding canonicalization and replay protection.",
      "Key rotation and trust-store management are as important as the signing algorithm."
    ]
  },
  {
    date: "2025-02-17",
    slug: "tls-for-backend-engineers",
    title: "TLS for Backend Engineers",
    study_category: "Programming",
    tags: %w[study programming tls security],
    source_note: "Study/Programing/TLS",
    summary: "TLS is a core backend reliability and security topic. It protects data in transit, authenticates endpoints through certificates, and affects debugging across proxies and services.",
    key_ideas: [
      "TLS combines key exchange, certificate validation, encryption, and integrity protection.",
      "Certificates bind public keys to identities through a chain of trust.",
      "Modern services often terminate TLS at load balancers, gateways, or sidecars."
    ],
    applications: [
      "Use TLS everywhere traffic crosses trust boundaries.",
      "Document where TLS terminates and which component owns certificate renewal."
    ],
    watch_outs: [
      "Certificate expiration is an operational failure mode, not only a security concern.",
      "Hostname mismatch, missing intermediate certificates, and outdated protocol versions are common causes of incidents."
    ]
  },
  {
    date: "2025-03-03",
    slug: "tls-certificate-spring-boot",
    title: "Using Certificates in Spring Boot",
    study_category: "Programming",
    tags: %w[study programming spring tls certificate],
    source_note: "Study/Programing/Using certificate in spring boot",
    summary: "Certificate handling in Spring Boot requires understanding application configuration and JVM trust material. The key is knowing which side presents a certificate and which side validates it.",
    key_ideas: [
      "A keystore usually holds private keys and certificates presented by the service.",
      "A truststore holds certificates that the service trusts when making outbound TLS calls.",
      "Mutual TLS requires both client and server authentication."
    ],
    applications: [
      "Use explicit profiles and secret management for keystore paths and passwords.",
      "Test certificate chains in environments that resemble production networking."
    ],
    watch_outs: [
      "Do not commit certificates, private keys, or keystore passwords to the repository.",
      "Local success can hide missing intermediate certificates that fail in containerized deployments."
    ]
  },
  {
    date: "2025-03-17",
    slug: "postgresql-redundancy-notes",
    title: "PostgreSQL Redundancy Notes",
    study_category: "Programming",
    tags: %w[study programming postgres database reliability],
    source_note: "Study/Programing/PostgreSQL Redundancy",
    summary: "Redundancy in PostgreSQL is about recovery objectives, replication behavior, failover process, backups, and operational testing.",
    key_ideas: [
      "Streaming replication can keep standby instances close to the primary.",
      "Synchronous and asynchronous replication trade latency for durability guarantees.",
      "Backups and point-in-time recovery solve a different problem from high availability."
    ],
    applications: [
      "Define RPO and RTO before choosing replication and backup strategy.",
      "Test failover and restore procedures regularly, not only during incidents."
    ],
    watch_outs: [
      "A replica can faithfully replicate bad data or destructive writes.",
      "Read replicas can introduce stale-read behavior if application logic assumes immediate consistency."
    ]
  },
  {
    date: "2025-03-31",
    slug: "mongodb-document-modeling-notes",
    title: "MongoDB Document Modeling Notes",
    study_category: "Programming",
    tags: %w[study programming mongodb database],
    source_note: "Study/Programing/MongoDB",
    summary: "MongoDB is most useful when document shape matches access patterns. Schema flexibility is a design responsibility, not permission to skip modeling.",
    key_ideas: [
      "Documents can embed related data that is usually read together.",
      "References can avoid large duplicated documents when relationships change independently.",
      "Indexes should reflect query patterns and cardinality."
    ],
    applications: [
      "Start data modeling from the read and write paths the product actually needs.",
      "Use validation and migrations when document structure becomes part of the contract."
    ],
    watch_outs: [
      "Large unbounded arrays inside a document can become operationally painful.",
      "Flexible schemas can hide data quality problems if ownership is unclear."
    ]
  },
  {
    date: "2025-04-14",
    slug: "database-study-map",
    title: "Database Study Map",
    study_category: "Programming",
    tags: %w[study programming database],
    source_note: "Study/Programing/DB",
    summary: "This note collects the database topics I repeatedly return to as a backend engineer: modeling, transactions, indexing, replication, isolation, backups, and observability.",
    key_ideas: [
      "Data modeling translates product behavior into storage shape.",
      "Indexes speed selected reads but add write cost and maintenance overhead.",
      "Transactions and isolation levels define what concurrent users can observe."
    ],
    applications: [
      "Review query plans and metrics before treating the database as a black box.",
      "Document which tables or collections are source-of-truth for each workflow."
    ],
    watch_outs: [
      "Denormalization can improve reads while increasing consistency work.",
      "A backup that has never been restored is only an assumption."
    ]
  },
  {
    date: "2025-04-28",
    slug: "vector-database-notes",
    title: "Vector Database Notes",
    study_category: "Programming",
    tags: %w[study programming ai vector-database embeddings],
    source_note: "Study/Programing/Vector DB",
    summary: "Vector databases are becoming a common backend component for semantic search and RAG systems. The core idea is to retrieve by similarity over embeddings instead of exact keys.",
    key_ideas: [
      "Embeddings map text, images, or other inputs into numerical vectors.",
      "Similarity search finds vectors near a query vector under a chosen distance metric.",
      "Metadata filtering and chunk identity are as important as vector distance."
    ],
    applications: [
      "Use vector search for semantic retrieval, recommendation, deduplication, and document Q&A.",
      "Store enough metadata to trace every generated answer back to source material."
    ],
    watch_outs: [
      "A high similarity score does not guarantee factual relevance.",
      "Chunking strategy can dominate retrieval quality more than the database choice."
    ]
  },
  {
    date: "2025-05-12",
    slug: "rag-backend-architecture",
    title: "RAG as Backend Architecture",
    study_category: "Programming",
    tags: %w[study programming ai rag architecture],
    source_note: "Study/Programing/RAG",
    summary: "Retrieval augmented generation is not only a prompt trick. A useful RAG system is a backend architecture with ingestion, indexing, retrieval, ranking, prompting, evaluation, and observability.",
    key_ideas: [
      "Ingestion quality determines what the model can retrieve later.",
      "Retrieval should combine semantic relevance with metadata and permission constraints.",
      "Evaluation needs test questions, expected sources, and failure analysis."
    ],
    applications: [
      "Build RAG pipelines as traceable workflows with source IDs and logs.",
      "Treat access control as part of retrieval, not a post-processing step."
    ],
    watch_outs: [
      "RAG does not remove hallucination risk; it changes where the failure can happen.",
      "Prompt changes can hide retrieval problems unless evaluation is repeatable."
    ]
  },
  {
    date: "2025-05-26",
    slug: "langchain-ai-web-service",
    title: "Creating an AI Web Service with LangChain",
    study_category: "Programming",
    tags: %w[study programming ai langchain backend],
    source_note: "Study/Programing/create ai web service with LangChain",
    summary: "LangChain can speed up LLM application experiments, but a production web service still needs normal backend discipline around boundaries, retries, persistence, observability, and security.",
    key_ideas: [
      "Chains and tools help compose model calls with external data or actions.",
      "Prompt templates are part of application behavior and should be versioned.",
      "Tracing is necessary because LLM applications fail in non-deterministic ways."
    ],
    applications: [
      "Use LangChain to prototype retrieval, tool calls, and agent workflows before hardening them.",
      "Wrap model access behind service interfaces so providers can change later."
    ],
    watch_outs: [
      "Do not let experimental chains bypass auth, rate limits, or data validation.",
      "A working demo still needs evaluation and cost controls before production use."
    ]
  },
  {
    date: "2025-06-09",
    slug: "building-genai-app-on-gcp",
    title: "Building a Gen AI App on GCP",
    study_category: "Programming",
    tags: %w[study programming ai gcp cloud],
    source_note: "Study/Programing/Building a Gen AI app on GCP",
    summary: "This note frames a Gen AI app as a cloud system: model access, data flow, identity, storage, deployment, evaluation, and monitoring all need design decisions.",
    key_ideas: [
      "Managed model platforms reduce operational load but still require application-level safeguards.",
      "Grounding and retrieval connect model output to controlled data sources.",
      "Cloud IAM decides which service can access models, data, logs, and secrets."
    ],
    applications: [
      "Start with a thin vertical slice that includes deployment and monitoring from the beginning.",
      "Separate model prompts, retrieval configuration, and product logic so each can evolve."
    ],
    watch_outs: [
      "Provider features change quickly, so keep architecture loosely coupled.",
      "Evaluation should be part of the release loop, not an afterthought."
    ]
  },
  {
    date: "2025-06-23",
    slug: "aws-components-backend-notes",
    title: "AWS Components for Backend Systems",
    study_category: "Programming",
    tags: %w[study programming aws cloud backend],
    source_note: "Study/Programing/AWS components",
    summary: "AWS services are easier to reason about when grouped by backend responsibility: compute, storage, networking, messaging, identity, observability, and deployment.",
    key_ideas: [
      "Compute choices such as Lambda, ECS, EKS, and EC2 trade operational control for management overhead.",
      "S3, RDS, DynamoDB, and ElastiCache serve different data access patterns.",
      "SQS, SNS, EventBridge, and Kinesis support different async communication models."
    ],
    applications: [
      "Pick services from workload requirements instead of popularity.",
      "Write architecture notes that explain why each managed service was chosen."
    ],
    watch_outs: [
      "Managed does not mean maintenance-free; quotas, IAM, cost, and monitoring still matter.",
      "Too many services can increase cognitive load for small teams."
    ]
  },
  {
    date: "2025-07-07",
    slug: "aws-iam-authorization-patterns",
    title: "AWS IAM and Authorization Patterns",
    study_category: "Programming",
    tags: %w[study programming aws iam security],
    source_note: "Study/Programing/AWS IAM and Authorization Patterns",
    summary: "IAM is a design surface for cloud systems. Good policies encode least privilege, clear ownership, and safe operational workflows.",
    key_ideas: [
      "Principals, actions, resources, and conditions form the core shape of an IAM policy.",
      "Roles are safer for workloads than long-lived access keys.",
      "Permission boundaries, service control policies, and resource policies help constrain blast radius."
    ],
    applications: [
      "Use separate roles for build, deploy, runtime, and human break-glass access.",
      "Review IAM changes like application code because they change system behavior."
    ],
    watch_outs: [
      "Wildcard actions and resources are fast during experiments but risky in production.",
      "Unused permissions should be removed before they become permanent."
    ]
  },
  {
    date: "2025-07-21",
    slug: "aws-control-tower-landing-zone",
    title: "AWS Control Tower and Landing Zone Notes",
    study_category: "Programming",
    tags: %w[study programming aws control-tower cloud],
    source_note: "Study/Programing/AWS RI - control tower",
    summary: "A landing zone is the foundation for multi-account cloud operations. Control Tower helps standardize account structure, guardrails, logging, and governance.",
    key_ideas: [
      "Multi-account design separates workloads, environments, security boundaries, and billing visibility.",
      "Guardrails reduce the chance of unsafe account-level configuration.",
      "Centralized logging and audit accounts support incident response and compliance."
    ],
    applications: [
      "Use landing zone design before teams start creating unmanaged cloud accounts.",
      "Keep networking, security, and workload account ownership explicit."
    ],
    watch_outs: [
      "Governance should not block delivery without giving teams a paved path.",
      "Account structure is hard to change after many workloads depend on it."
    ]
  },
  {
    date: "2025-08-04",
    slug: "grpc-service-boundaries",
    title: "gRPC Service Boundaries",
    study_category: "Programming",
    tags: %w[study programming grpc api],
    source_note: "Study/Programing/gRPC",
    summary: "gRPC is useful when service contracts, typed schemas, streaming, and efficient binary transport matter. The tradeoff is operational complexity compared with plain REST.",
    key_ideas: [
      "Protocol Buffers define the service and message contract.",
      "HTTP/2 enables multiplexing and streaming patterns.",
      "Generated clients reduce boilerplate but make schema evolution important."
    ],
    applications: [
      "Use gRPC for internal service-to-service APIs where strong contracts are valuable.",
      "Pair schema changes with compatibility tests and rollout plans."
    ],
    watch_outs: [
      "Debugging gRPC traffic can be less convenient than inspecting JSON over HTTP.",
      "Browser and public API requirements may still make REST or GraphQL a better fit."
    ]
  },
  {
    date: "2025-08-18",
    slug: "neural-network-basics",
    title: "Neural Network Basics",
    study_category: "AI",
    tags: %w[study ai neural-network],
    source_note: "Study/AI/Untitled/인공신경망",
    summary: "This note revisits the basic building blocks of neural networks: parameters, activations, layers, loss functions, and optimization.",
    key_ideas: [
      "A neural network learns parameters that transform inputs into useful outputs.",
      "Activation functions add non-linearity, which lets stacked layers model complex relationships.",
      "Training adjusts weights to minimize a loss function over examples."
    ],
    applications: [
      "Use the simple input-layer-output mental model before jumping into deeper architectures.",
      "Connect model quality discussions to data, loss, optimization, and evaluation."
    ],
    watch_outs: [
      "More layers or parameters do not automatically mean better generalization.",
      "A model can fit training data while failing on real-world distributions."
    ]
  },
  {
    date: "2025-09-01",
    slug: "backpropagation-study-notes",
    title: "Backpropagation Study Notes",
    study_category: "AI",
    tags: %w[study ai backpropagation optimization],
    source_note: "Study/AI/Untitled/BackPropagation",
    summary: "Backpropagation is the mechanism that makes neural network training practical. It computes how much each parameter contributed to the loss by applying the chain rule backward through the model.",
    key_ideas: [
      "Forward pass computes predictions and loss.",
      "Backward pass computes gradients from the loss back to each parameter.",
      "An optimizer uses gradients to update weights."
    ],
    applications: [
      "Use backpropagation intuition to understand why vanishing gradients, exploding gradients, and learning rate matter.",
      "Debug training by watching loss curves, gradient norms, and validation behavior."
    ],
    watch_outs: [
      "Gradients show local direction, not guaranteed global optimality.",
      "Bad scaling or initialization can make training unstable even when the architecture is correct."
    ]
  },
  {
    date: "2025-09-15",
    slug: "cnn-study-notes",
    title: "CNN Study Notes",
    study_category: "AI",
    tags: %w[study ai cnn computer-vision],
    source_note: "Study/AI/Untitled/CNN",
    summary: "Convolutional neural networks are designed around local spatial structure. They are especially useful when nearby features matter, such as in images.",
    key_ideas: [
      "Convolution filters scan across input to detect local patterns.",
      "Pooling can reduce spatial resolution while keeping important signals.",
      "Stacked convolutional layers can learn increasingly abstract visual features."
    ],
    applications: [
      "Use CNN concepts to understand image classifiers, object detection backbones, and visual feature extractors.",
      "Study receptive fields when reasoning about what part of an image influences a prediction."
    ],
    watch_outs: [
      "CNNs can be sensitive to data distribution, augmentation, and preprocessing.",
      "High validation accuracy may hide failures on edge cases or shifted image sources."
    ]
  },
  {
    date: "2025-09-29",
    slug: "rnn-sequence-modeling",
    title: "RNN Sequence Modeling Notes",
    study_category: "AI",
    tags: %w[study ai rnn sequence],
    source_note: "Study/AI/Untitled/RNN",
    summary: "Recurrent neural networks model sequences by carrying state across steps. They are historically important for understanding sequence learning before modern attention-heavy architectures.",
    key_ideas: [
      "An RNN processes one step at a time while updating hidden state.",
      "The hidden state summarizes previous context for later predictions.",
      "Training long sequences can suffer from vanishing or exploding gradients."
    ],
    applications: [
      "Use RNNs as a conceptual bridge to LSTM, GRU, seq2seq, and attention models.",
      "Think about sequence order when modeling text, time series, or event streams."
    ],
    watch_outs: [
      "Long-range dependencies are difficult for simple RNNs.",
      "Batching variable-length sequences requires careful padding and masking."
    ]
  },
  {
    date: "2025-10-13",
    slug: "lstm-gates-study-notes",
    title: "LSTM Gates Study Notes",
    study_category: "AI",
    tags: %w[study ai lstm sequence],
    source_note: "Study/AI/Untitled/LSTM",
    summary: "LSTM networks improve on simple RNNs by introducing gates that control what to remember, forget, and expose at each step.",
    key_ideas: [
      "The cell state provides a path for information to persist across many steps.",
      "Forget, input, and output gates regulate information flow.",
      "LSTMs were designed to reduce the long-term dependency problems of simple RNNs."
    ],
    applications: [
      "Use LSTM concepts when studying speech, text, time series, and older sequence systems.",
      "Compare the gating idea with attention, which handles context in a different way."
    ],
    watch_outs: [
      "LSTMs are still sequential and can be slower to parallelize than transformer-style models.",
      "Good results depend heavily on preprocessing, sequence length, and evaluation setup."
    ]
  },
  {
    date: "2025-10-27",
    slug: "gan-study-notes",
    title: "GAN Study Notes",
    study_category: "AI",
    tags: %w[study ai gan generative-ai],
    source_note: "Study/AI/Untitled/GAN",
    summary: "Generative adversarial networks frame generation as a competition between two models: one creates samples and the other tries to distinguish real from generated data.",
    key_ideas: [
      "The generator learns to produce realistic samples.",
      "The discriminator learns to identify whether samples are real or generated.",
      "Training is a dynamic game rather than a single straightforward optimization problem."
    ],
    applications: [
      "Use GANs as a foundation for understanding image generation history.",
      "Study discriminator feedback as a way to think about learned quality signals."
    ],
    watch_outs: [
      "GAN training can be unstable and sensitive to architecture and hyperparameters.",
      "Mode collapse can make generated outputs look plausible but lack diversity."
    ]
  },
  {
    date: "2025-11-10",
    slug: "autoencoder-study-notes",
    title: "Autoencoder Study Notes",
    study_category: "AI",
    tags: %w[study ai autoencoder representation],
    source_note: "Study/AI/Untitled/Autoencoder",
    summary: "An autoencoder learns to compress input into a latent representation and reconstruct the original input from that representation.",
    key_ideas: [
      "The encoder maps input into a compressed latent space.",
      "The decoder reconstructs input from that latent representation.",
      "The training objective encourages the latent space to preserve useful structure."
    ],
    applications: [
      "Use autoencoders for representation learning, denoising, anomaly detection, and dimensionality reduction.",
      "Study reconstruction error as a signal for unusual inputs."
    ],
    watch_outs: [
      "A powerful decoder can learn reconstruction without creating useful latent structure.",
      "Low reconstruction error does not always mean the representation is semantically meaningful."
    ]
  },
  {
    date: "2025-11-24",
    slug: "variational-autoencoder-study-notes",
    title: "Variational Autoencoder Study Notes",
    study_category: "AI",
    tags: %w[study ai vae generative-ai],
    source_note: "Study/AI/Untitled/Variational Autoencoder",
    summary: "A variational autoencoder turns the autoencoder idea into a probabilistic generative model by learning a distribution over latent variables.",
    key_ideas: [
      "The encoder estimates a latent distribution instead of a single point.",
      "The decoder samples from latent space to reconstruct or generate data.",
      "The loss balances reconstruction quality with regularization of the latent distribution."
    ],
    applications: [
      "Use VAE concepts to understand latent spaces in generative modeling.",
      "Compare VAE tradeoffs with GANs and diffusion models."
    ],
    watch_outs: [
      "Generated samples can be smoother or less sharp than other generative approaches.",
      "The KL term and reconstruction term need careful interpretation during training."
    ]
  },
  {
    date: "2025-12-08",
    slug: "word2vec-embedding-notes",
    title: "Word2Vec and Embedding Notes",
    study_category: "AI",
    tags: %w[study ai word2vec embeddings nlp],
    source_note: "Study/AI/Untitled/Word2Vec",
    summary: "Word2Vec is a useful entry point for understanding embeddings: words become vectors that capture distributional relationships from text.",
    key_ideas: [
      "Embedding models map tokens into dense numerical vectors.",
      "Similar contexts tend to produce vectors that are close in embedding space.",
      "Skip-gram and CBOW are two classic Word2Vec training objectives."
    ],
    applications: [
      "Use embedding intuition when building semantic search or recommendation features.",
      "Think of modern text embeddings as a more powerful continuation of this idea."
    ],
    watch_outs: [
      "Embeddings inherit bias and coverage limitations from training data.",
      "Vector similarity is not the same as factual correctness."
    ]
  },
  {
    date: "2025-12-22",
    slug: "seq2seq-attention-notes",
    title: "Seq2Seq and Attention Notes",
    study_category: "AI",
    tags: %w[study ai seq2seq attention nlp],
    source_note: "Study/AI/Untitled/Seq2seq+Attention",
    summary: "Seq2Seq models helped frame tasks like translation as encoder-decoder learning. Attention improved the model by allowing the decoder to focus on relevant encoder states.",
    key_ideas: [
      "The encoder converts an input sequence into hidden representations.",
      "The decoder generates an output sequence step by step.",
      "Attention gives the decoder a weighted view over source positions."
    ],
    applications: [
      "Use this as a bridge between RNN-based NLP and transformer models.",
      "Study attention weights to understand alignment between input and output tokens."
    ],
    watch_outs: [
      "Attention visualization can be helpful but is not always a complete explanation.",
      "Long sequences still create computational and evaluation challenges."
    ]
  },
  {
    date: "2026-01-05",
    slug: "stochastic-gradient-descent-notes",
    title: "Stochastic Gradient Descent Notes",
    study_category: "AI",
    tags: %w[study ai optimization sgd],
    source_note: "Study/AI/Untitled/Stochastic Gradient Descent",
    summary: "Stochastic gradient descent is the foundation behind many training loops. The core idea is to update parameters using gradient estimates from small batches of data.",
    key_ideas: [
      "Gradient descent moves parameters in the direction that reduces loss.",
      "Stochastic updates use subsets of data, which makes training scalable.",
      "Learning rate controls the size of each update step."
    ],
    applications: [
      "Use SGD intuition to interpret training curves and convergence behavior.",
      "Compare optimizers by how they adapt update direction and step size."
    ],
    watch_outs: [
      "A learning rate that is too high can make training diverge.",
      "A learning rate that is too low can make training appear stuck."
    ]
  },
  {
    date: "2026-01-19",
    slug: "cross-entropy-kl-divergence-notes",
    title: "Cross Entropy and KL Divergence Notes",
    study_category: "AI",
    tags: %w[study ai loss cross-entropy kl-divergence],
    source_note: "Study/AI/Untitled/Cross Entropy and KL Divergence",
    summary: "Cross entropy and KL divergence show up repeatedly in classification and probabilistic modeling. They help compare predicted distributions with target distributions.",
    key_ideas: [
      "Cross entropy measures how well predicted probabilities match the target labels.",
      "KL divergence measures how one probability distribution differs from another.",
      "Softmax is often paired with cross entropy for multi-class classification."
    ],
    applications: [
      "Use cross entropy to reason about confidence, calibration, and classification errors.",
      "Use KL divergence concepts when studying VAEs, distillation, or distribution matching."
    ],
    watch_outs: [
      "High confidence wrong predictions can dominate loss.",
      "Loss values are easier to interpret when compared across the same dataset and setup."
    ]
  },
  {
    date: "2026-02-02",
    slug: "local-llm-rag-meetup-notes",
    title: "Local LLM and RAG Meetup Notes",
    study_category: "Project",
    tags: %w[study project ai rag ollama langchain],
    source_note: "Study/Project/Meet Up presentation for Running LLM model in local",
    summary: "This public version turns a meetup preparation note into a shareable architecture summary for running local LLMs with RAG.",
    key_ideas: [
      "Ollama can make local model experiments easier by managing model download and runtime.",
      "RAG connects a model to external documents through loading, chunking, embedding, retrieval, and prompting.",
      "Chainlit and LangChain can help turn a local experiment into an interactive demo."
    ],
    applications: [
      "Use local LLM demos to explain model limits, retrieval, hallucination, and vector stores to a mixed audience.",
      "Keep a small reproducible repository so the presentation can become a working reference."
    ],
    watch_outs: [
      "Local hardware limits model size, latency, and concurrent usage.",
      "Demo questions should avoid personal data and make source grounding visible."
    ]
  },
  {
    date: "2026-02-16",
    slug: "kaggle-genai-capstone-notes",
    title: "Kaggle Gen AI Capstone Notes",
    study_category: "Project",
    tags: %w[study project ai kaggle gemini],
    source_note: "Study/Project/Kaggle Capstone Project",
    summary: "The Kaggle capstone note is useful as a checklist for building a Gen AI project that demonstrates multiple capabilities instead of a single prompt.",
    key_ideas: [
      "A stronger Gen AI project combines capabilities such as structured output, grounding, retrieval, tool use, and evaluation.",
      "The capstone format pushes the project toward a demonstrable product workflow.",
      "Notebook-based delivery is useful for explaining both implementation and reasoning."
    ],
    applications: [
      "Use the capstone structure to turn an idea into a scoped AI prototype.",
      "Keep capability mapping visible so reviewers can see what the project proves."
    ],
    watch_outs: [
      "A project can use many AI features and still be weak if the user problem is unclear.",
      "Evaluation should describe expected behavior, not only show successful examples."
    ]
  },
  {
    date: "2026-03-02",
    slug: "ms-ai-agents-hackathon-notes",
    title: "MS AI Agents Hackathon Notes",
    study_category: "Project",
    tags: %w[study project ai agents hackathon],
    source_note: "Study/Project/MS AI Agents Hackathon",
    summary: "This note turns the MS AI Agents Hackathon material into a public reflection on what makes an agent project credible.",
    key_ideas: [
      "An agent should have a clear task, tool boundary, memory strategy, and feedback loop.",
      "Tool calls need validation because the model can choose the wrong action.",
      "Agent demos are stronger when they show recovery from errors, not only the happy path."
    ],
    applications: [
      "Use hackathon constraints to quickly test whether an agent workflow is valuable.",
      "Document tool permissions, evaluation prompts, and submission criteria early."
    ],
    watch_outs: [
      "Calling every LLM workflow an agent makes the architecture harder to evaluate.",
      "A convincing demo still needs guardrails before real users can trust it."
    ]
  },
  {
    date: "2026-03-16",
    slug: "partyrock-genai-hackathon-notes",
    title: "PartyRock Generative AI Hackathon Notes",
    study_category: "Project",
    tags: %w[study project ai hackathon aws],
    source_note: "Study/Project/The PartyRock Generative AI Hackathon by AWS",
    summary: "This project note focuses on fast product thinking with managed Gen AI tools: choosing a use case, shaping an interaction, and making the result understandable.",
    key_ideas: [
      "Low-code Gen AI platforms can shorten the path from idea to user feedback.",
      "The value of the app still depends on workflow design and input quality.",
      "A hackathon prototype should clearly show who it helps and how success is measured."
    ],
    applications: [
      "Use managed tools for quick ideation before committing to custom infrastructure.",
      "Turn the final demo into a case study that explains the problem, user flow, and limitations."
    ],
    watch_outs: [
      "Fast prototypes can hide data, privacy, and evaluation issues.",
      "Generated output should not be treated as reliable without review."
    ]
  },
  {
    date: "2026-03-30",
    slug: "aws-genai-hackathon-event-notes",
    title: "AWS Gen AI Hackathon Event Notes",
    study_category: "Project",
    tags: %w[study project ai aws hackathon],
    source_note: "Study/Programing/2024 02 01 aws gen ai hackerton event",
    summary: "This note captures reusable lessons from an AWS Gen AI hackathon: scope the problem, choose managed services carefully, and show the result with a small working flow.",
    key_ideas: [
      "Hackathons reward narrow problem statements with visible user value.",
      "Cloud AI services can speed up prototypes when IAM, data flow, and cost are kept simple.",
      "The best demo path is usually one realistic workflow rather than many unfinished features."
    ],
    applications: [
      "Use the event format to practice architecture decisions under time pressure.",
      "Write down service choices and tradeoffs while the implementation context is fresh."
    ],
    watch_outs: [
      "Event notes often contain screenshots and logistics that should not be published directly.",
      "Prototype credentials, sample data, and account identifiers must stay private."
    ]
  },
  {
    date: "2026-04-13",
    slug: "ai-satellite-project-planning-notes",
    title: "AI and Satellite Project Planning Notes",
    study_category: "Project",
    tags: %w[study project ai satellite geospatial],
    source_note: "Study/Project/AI+Satellite Project",
    summary: "This public version keeps the reusable project-planning angle: how AI, satellite data, and geospatial workflows might fit together without exposing private idea details.",
    key_ideas: [
      "Satellite projects need data sourcing, preprocessing, geospatial indexing, model workflow, and visualization.",
      "AI can assist with classification, summarization, anomaly detection, and decision support.",
      "A useful prototype should start from one measurable decision, not from the full space of satellite data."
    ],
    applications: [
      "Use a small region, a small dataset, and one clear question for the first version.",
      "Document data license, resolution, freshness, and uncertainty before building UI."
    ],
    watch_outs: [
      "Geospatial outputs can look authoritative even when model confidence is weak.",
      "Public writeups should avoid exposing unpublished product strategy."
    ]
  }
]

def yaml_string(value)
  value.to_s.gsub("\\", "\\\\\\").gsub('"', '\"')
end

def clean_source_note(value)
  value.to_s
       .sub(/\AStudy\//, "")
       .gsub("Programing", "Programming")
       .gsub("/Untitled", "")
       .gsub(/\s+/, " ")
end

def practical_reflection(post)
  case post[:study_category]
  when "Programming"
    "For backend engineering, I treat this topic as a design decision rather than an isolated definition. The useful question is how it changes reliability, latency, deployment, debugging, or team ownership in a real service. Writing the note this way helps me connect the concept to production tradeoffs instead of memorizing terminology."
  when "AI"
    "For AI study, I keep the note focused on the mental model first, then connect it back to implementation choices. The goal is not only to know the formula or architecture name, but to understand what signal it learns, where it fails, and how it might affect an applied AI system."
  when "Project"
    "For project notes, I keep the public version centered on reusable engineering lessons: problem framing, architecture choices, demo constraints, and what I would improve next. That makes the note shareable without exposing private brainstorming, raw event logistics, or unfinished product strategy."
  else
    "I keep this note focused on the part that is reusable in future engineering work: the decision it informs, the failure mode it helps explain, and the next question worth testing."
  end
end

def render_post(post)
  tags = post[:tags].map { |tag| "  - #{tag}" }.join("\n")
  key_ideas = post[:key_ideas].map { |item| "- #{item}" }.join("\n")
  applications = post[:applications].map { |item| "- #{item}" }.join("\n")
  watch_outs = post[:watch_outs].map { |item| "- #{item}" }.join("\n")
  source_note = clean_source_note(post[:source_note])
  reflection = practical_reflection(post)

  <<~MARKDOWN
  ---
  layout: post
  title: "#{yaml_string(post[:title])}"
  date: #{post[:date]} 09:00:00 +0100
  category: blog
  tags:
  #{tags}
  study_category: "#{yaml_string(post[:study_category])}"
  origin: notion
  import_batch: notion-batch-2
  source_note: "#{yaml_string(source_note)}"
  ---

  > Refined from a private Notion study note. This public version keeps the reusable technical ideas and removes private scratch content, event logistics, and copied reference material.

  ## What I Wanted to Clarify

  #{post[:summary]}

  ## Key Ideas

  #{key_ideas}

  ## How I Would Use It

  #{applications}

  ## Watch-outs

  #{watch_outs}

  ## Practical Reflection

  #{reflection}

  ## Next Questions

  - What would I measure to know this idea works in production?
  - Where should this concept live in a real backend or AI system design?
  MARKDOWN
end

FileUtils.mkdir_p("_posts")

POSTS.each do |post|
  path = File.join("_posts", "#{post[:date]}-#{post[:slug]}.md")
  File.write(path, render_post(post))
end

puts "Generated #{POSTS.size} refined Notion posts."
puts POSTS.group_by { |post| post[:study_category] }.map { |category, posts| "#{category}: #{posts.size}" }.join(", ")
