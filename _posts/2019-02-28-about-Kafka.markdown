---
title: "Kafka"
layout: post
date: 2018-02-28 10:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- markdown
- elements
star: true
category: blog
author: Dokeun Oh
description: about Apache Kafka
---
# Kafka

Apache Kafka is an open-source stream-processing software platform developed by Linkedin and donated to the Apache Software Foundation, written in Scala and Java. 

![Kafka architecture](https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Overview_of_Apache_Kafka.svg/1920px-Overview_of_Apache_Kafka.svg.png)

## How it works

Kafka works based on the Publish-Subscribe model, they consist of producer, consumer, broker.
“Producer” creates a specific topic message and then delivers “broker” the message.
“Broker“ of Kafka manages messages based on topic. 
When “broker” accumulate message that is received with classifying based on topic, “consumer” that subscribe the topic receive the messages and process them.

![Kafka how it works](https://t1.daumcdn.net/cfile/tistory/270D49435509151E2A)

## Topic and Logs

Let’s first dive into the core abstraction Kafka provides for a stream of records- the topic.

A topic is a category or feed name to which records are published. Topics in Kafka are always multi-subscriber; that is, a topic can have zero, one, or many consumers that subscribe to the data written to it.

For each topic, the Kafka cluster maintains a partitioned log that looks like this: 

![Anatomy of a Topic](https://kafka.apache.org/21/images/log_anatomy.png)

Each partition is an ordered, immutable sequence of records that is continually appended to a structrued commit log. The records in the partitions are each assigned a sequential id number call the offset that uniquely identified each record whine the partition.

The kayak cluster durably persists all published records- whether or not they have been consumed- using a configurable retention period. For example, if the retention policy is set to wo days, then for the two days after a record is published, it is available for consumption, after which it will be discarded to free up space. Kafka’s performance is effectively constant with respect to data size so storing data for a long time is not a problem.

![Anatomy of a Topic2](https://kafka.apache.org/21/images/log_consumer.png)

In fact, the only metadata retained on a per-consumer basic is the offset or position of that consumer in the log. This offset is controlled by consumer: normally a consumer will advance its offset linearly as it reads records, but, in fact, since the position is controlled by the consumer it can consume records in any order it likes. For example a consumer can reset to an older offset to reprocess data from the past or skip ahead to the most recent record and start consuming for “now”

This combination of features means that Kafka consumers are very cheap-they can come and go without much impact on the cluster or on other consumers. For example, you can use our command line tools to “tail” the contents of any topic without changing what is consumed by any existing consumers.

The partitions in the log serve several purpose. First they allow the log to scale beyond a size that will fit on single server. Each individual partition must fit on the serves that host it, but a topic may have many partitions so it can handle an arbitrary amount of data. Second they act as the unit of parallelism-more on that in a bit.

## Reference 
- https://epicdevs.com/17
- https://soul0.tistory.com/499
- https://medium.com/zaneiru-tech-life-blog/pub-sub-%EB%AA%A8%EB%8D%B8%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-daa3c5c52aa8

