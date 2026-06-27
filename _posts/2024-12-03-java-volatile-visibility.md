---
title: "Java volatile: Visibility, Atomicity, and When to Use It"
layout: post
date: 2024-12-03 09:00
image: /assets/images/markdown.jpg
headerImage: false
star: true
category: blog
blog_category: java-spring
tags:
  - Java
  - Concurrency
  - JVM
study_category: Programming
author: Dokeun Oh
description: A concise guide to what Java volatile guarantees, what it does not guarantee, and when it is a good fit.
---

# Java volatile: Visibility, Atomicity, and When to Use It

`volatile` is one of the simplest Java concurrency keywords, but it is also easy to misuse.

The short version:

- `volatile` guarantees visibility.
- `volatile` creates a happens-before relationship between a write and later reads of the same field.
- `volatile` restricts certain instruction reorderings around that field.
- `volatile` does not make compound operations atomic.

## The Visibility Problem

In a multi-threaded application, each thread may read and write variables through registers, CPU caches, and compiler/JIT optimizations. Without coordination, one thread can update a value while another thread keeps observing an old value.

```java
class Worker {
    private boolean running = true;

    void stop() {
        running = false;
    }

    void run() {
        while (running) {
            doWork();
        }
    }
}
```

The intention is clear: another thread calls `stop()`, then the worker loop exits.

The problem is that `running` is not synchronized. The Java Memory Model does not guarantee that the worker thread will observe the latest value.

## What volatile Guarantees

```java
class Worker {
    private volatile boolean running = true;

    void stop() {
        running = false;
    }

    void run() {
        while (running) {
            doWork();
        }
    }
}
```

With `volatile`, writes to `running` become visible to other threads that read it. More precisely, a write to a volatile field happens-before every subsequent read of that same field.

This makes `volatile` a good fit for simple state flags.

## Visibility vs Atomicity

Visibility means other threads can observe the latest value.

Atomicity means an operation happens as one indivisible step.

`volatile` helps with visibility, but it does not turn a sequence of operations into one atomic operation.

## What volatile Does Not Guarantee

`volatile` does not make a read-modify-write operation atomic.

```java
class Counter {
    private volatile int count = 0;

    void increment() {
        count++;
    }
}
```

`count++` looks like one operation, but it is not. It is roughly:

1. Read `count`.
2. Add one.
3. Write the new value.

Two threads can read the same value and overwrite each other's result. `volatile` does not fix that.

Use `synchronized`, `AtomicInteger`, `LongAdder`, or another concurrency primitive for counters and compound updates.

```java
import java.util.concurrent.atomic.AtomicInteger;

class Counter {
    private final AtomicInteger count = new AtomicInteger();

    void increment() {
        count.incrementAndGet();
    }
}
```

One detail worth knowing: volatile reads and writes of `long` and `double` are atomic. But that still does not make compound logic such as increment, compare-then-set, or check-then-act atomic.

## When volatile Is Appropriate

Use `volatile` when:

- One thread writes a value and other threads read it.
- The value is independent and does not depend on its previous value.
- You need a simple lifecycle flag, readiness flag, or immutable configuration snapshot reference.

Common examples:

```java
private volatile boolean shutdownRequested;
private volatile boolean initialized;
private volatile Config currentConfig;
```

For immutable object references, `volatile` can be useful:

```java
class ConfigHolder {
    private volatile AppConfig config;

    AppConfig getConfig() {
        return config;
    }

    void reload(AppConfig newConfig) {
        this.config = newConfig;
    }
}
```

Readers always see the latest config reference, and the config object itself can remain immutable.

## When volatile Is Not Enough

Do not rely on `volatile` when:

- multiple fields must stay consistent together
- updates depend on the previous value
- a thread must perform check-then-act logic
- only one thread may enter a critical section

Those cases need `synchronized`, `Lock`, atomic classes, or higher-level concurrency utilities.

## Performance Considerations

Volatile reads and writes can be more expensive than ordinary field access because they require memory visibility guarantees. They can also restrict JVM and CPU optimizations around instruction reordering.

That does not mean `volatile` is slow in every case. It means it should be used when the visibility guarantee is actually needed.

## Recap

`volatile` is a visibility tool, not a mutual exclusion tool.

Use it for simple flags and safely published references. Do not use it for counters, check-then-act logic, or multi-field invariants. When an operation must be atomic, use `synchronized`, locks, or atomic classes from `java.util.concurrent`.

## References

- [Java Language Specification, Chapter 17: Threads and Locks](https://docs.oracle.com/javase/specs/jls/se21/html/jls-17.html)
- [AtomicInteger API documentation](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/atomic/AtomicInteger.html)
