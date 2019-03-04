---
title: "How to Work with Apache Kafka in Your Spring Boot Application"
layout: post
date: 2018-03-04 20:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- markdown
- elements
star: true
category: blog
author: Dokeun Oh
description: How to Work with Apache Kafka in Your Spring Boot Application
---
# How to Work with Apache Kafka in Your Spring Boot Application

## Installation and Setup

After set up Kafka with docker.
What you set Kafka environment with docker can be found [here](http://ohdoking.github.io//Kafka-Hands-on/),
We also need to add the `spring-kafka` depenency to our `pom.xml`

```
<dependency>
    <groupId>org.springframework.kafka</groupId>
    <artifactId>spring-kafka</artifactId>
    <version>2.2.2.RELEASE</version>
</dependency>
```

## Configuring Topics



## Reference 
- https://www.confluent.io/blog/apache-kafka-spring-boot-application
- https://www.baeldung.com/spring-kafka
