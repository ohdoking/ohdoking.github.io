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

offset < partition < topic < broker < Kafka cluster

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

## Distribution

The partitions of the log are distributed over the servers in the Kafka cluster with each server handling data and requests for a share of the partitions. Each partition is replicated across a configurable number of servers for fault tolerance. 

Each partition has one server which acts as the "leader" and zero or more servers which act as "followers". The leader handles all read and write requests for the partition while the followers passively replicate the leader. If the leader fails, one of the followers will automatically become the new leader. Each server acts as a leader for some of its partitions and a follower for others so load is well balanced within the cluster.

## Producers

Producers publish data to the topics of their choice. The producer is responsible for choosing which record to assign to which partition within the topic. This can be done in around-roblin fashion simply to balance load or it can be done according to some semantic partition function(say based on some key in the record). More on the use of partitioning in a second.

## Consumers

Consumers label themselves with consumer group name, and each record published topic is delivered to one consumer instance within each subscribing consumer group. Consumer instances cna be ins separate processes or on separate machines.

If all the consumer instance have the same consumer group, then the records will effectively be load balanced over the consumer instances. 

If all the consumer instances have different consumer groups, then each record will be broadcast to all the consumer processes.

![Consumers](https://kafka.apache.org/21/images/consumer-groups.png)

A two server Kafka cluster hosting four patitions(P0 - P3) with two consumer groups. Consumer group A has two consumer instances and group B has four.

More commonly, however, we have found that topics have a small number of consumer group, one for each "logical subscriber". Each group is composed of many consumer instances for scalability and fault tolerance. This is nothing more than publish-subscribe semantics where the subscriber is a cluster of consumers instead of a single process.

The way consumption is implemented in Kafka is by dividing up the partitions in the log over the consumer instances so that each instance is the exclusive consumer of a "fair share" of partitions at any point in time. This process of maintaining meembership in the group is handled by the Kafka protocol dynamically. If new instances join the group they will take over some partitions from other memebers of the group; if an instance dies, its partitions will be distributes to the remaining instances. 

Kafka only provides a total order over records within a partition, not between different partitions in a topic. Perpartition ordering combined with the ability to partition data by key is sufficient for most applications. However, if you require a total order over records this can be achieved with a topic that has only one partition, though this will mean only one consumer process per consumer group.



## Reference 
- https://kafka.apache.org/intro
- https://epicdevs.com/17
- https://soul0.tistory.com/499
- https://medium.com/zaneiru-tech-life-blog/pub-sub-%EB%AA%A8%EB%8D%B8%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-daa3c5c52aa8

