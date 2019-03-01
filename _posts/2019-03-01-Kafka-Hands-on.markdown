---
title: "Kafka Hands-on with Docker"
layout: post
date: 2018-03-01 10:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- markdown
- elements
star: true
category: blog
author: Dokeun Oh
description: Kafka Hands-on with Docker
---
# Kafka

Let’s get Apache Kafka running on your workstation with Docker.

Our development cluster will consist of:

- one Kafka broker,
- one Zookeeper instance,
- one schema registry (as we will use Avro later)

We will also configure all three parts to be accessible both from other docker containers and from your host machine.

1. Zookeeper

The most important options to provide to Zookeeper are this instance ID, client port, and the list of all servers in the cluster.
So we should configure 3 things like below. 

* zookeeper.env 

```
ZOOKEEPER_SERVERS=zookeeper-1:4182:5181
ZOOKEEPER_SERVER_ID=1
ZOOKEEPER_CLIENT_PORT=2181

KAFKA_HEAP_OPTS=-Xms32M -Xmx32M -verbose:gc
```

And we configure docker-compose file to use Zookeeper Container.
Confluent's Zookeeper image exports two volumes, data, and log, sepeartely; we will have to mount them to have persitence. Thus the minimal Zookeeper service description will look like this :

* docker-compose.xml

```
zookeeper-1:
    image: confluentinc/cp-zookeeper:5.0.0
    hostname: zookeeper-1
    container_name: zookeeper-1
    ports:
      - "2181:2181"
    env_file:
      - zookeeper.env
    healthcheck:
      test: /bin/sh -c '[ \"imok\" = \"$$(echo ruok | nc -w 1 127.0.0.1 2181)\" ]' || exit 1
      interval: 1m
    volumes:
      - zookeeper-1-data:/var/lib/zookeeper/data/
      - zookeeper-1-log:/var/lib/zookeeper/log/
```

Notice that we are very explicit with hostname, service name, and they shall match what's in the Zookeeper configuration environment.

2. Kafka (broker)

We need specify the broker ID, point it to previously configured Zookeeper, and configure the listeners and advertisers. 
Notice that we configure the broker so we can access it both via kafka-1:9020 from other docker containers and local:29092 from your house machine.

These are the only things you have to configure. however we'll add a few nice things.

All further settings in the following gist are optional and quite opinionated.

```
# This will be our first and only broker
KAFKA_BROKER_ID=1
# Define listeneres for accessing broker both inside Docker and from host machine
KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-1:9092,PLAINTEXT_HOST://localhost:29092
# Zookeeper connection
KAFKA_ZOOKEEPER_CONNECT=zookeeper-1:2181

# In dev, we do not need Confluent metrics
CONFLUENT_SUPPORT_METRICS_ENABLE=false

# As well, we can add some heap pressure
KAFKA_HEAP_OPTS=-Xms256M -Xmx256M -verbose:gc

# In development enviroment, auto-creating topics (and deleting them) could be convenient
KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
KAFKA_DELETE_TOPIC_ENABLE=true

# Eight partitions is more than enough for development
KAFKA_NUM_PARTITIONS=8

# Retain offsets for 31 days - in case you work on your project not that often
KAFKA_OFFSETS_RETENTION_MINUTES=44640

# Since we have just one broker, set replication factors to just one
KAFKA_DEFAULT_REPLICATION_FACTOR=1
KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
KAFKA_MIN_INSYNC_REPLICAS=1

# In development environ, we do not need to many threads
KAFKA_NUM_RECOVERY_THREADS_PER_DATA_DIR=1
KAFKA_NUM_NETWORK_THREADS=3
KAFKA_NUM_IO_THREADS=3

# Configure default log cleanup. You can override these on per-topic basis
KAFKA_LOG_CLEANUP_POLICY=compact

KAFKA_LOG_RETENTION_BYTES=-1
KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS=300000
KAFKA_LOG_RETENTION_HOURS=-1

KAFKA_LOG_ROLL_HOURS=24
KAFKA_LOG_SEGMENT_BYTES=1048576
KAFKA_LOG_SEGMENT_DELETE_DELAY_MS=60000

```

The service description only adds zookeeper-1 dependency and a volume for Kafka logs

```
    kafka-1:
    image: confluentinc/cp-kafka:5.0.0
    hostname: kafka-1
    container_name: kafka-1
    stop_grace_period: 3m
    depends_on:
      - zookeeper-1
    ports:
      - "29092:29092"
    env_file:
      - kafka.env
    volumes:
      - kafka-1-data:/var/lib/kafka/data/
```

3. Schema registry

The Schema registry is the easiest to configure. Here’s the environment:

```
SCHEMA_REGISTRY_HOST_NAME=schema-registry
SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=zookeeper-1:2181
KAFKA_HEAP_OPTS=-Xms32M -Xmx32M -verbose:gc
```

and the service:

```
  schema-registry:
    image: confluentinc/cp-schema-registry:5.0.0
    hostname: schema-registry
    container_name: schema-registry
    depends_on:
      - zookeeper-1
      - kafka-1
    ports:
      - "8081:8081"
    env_file:
      - schema-registry.env
```

4. kafka-console-producer

we can start the whole stack with just `docker-compose up`!

It can take some time to boot the stack and you'll see quite a lot of output. When it's finally up, we can try our new cluster.

In a second terminal, firgure out the broker container ID via `docker ps`, and let's execute a new shell in it, `docker exec -ti <containerId> bash`. Here we will execute the "verifiable productor", that actually waits for the acks from the broker :

```
kafka-verifiable-producer --broker-list kafka-1:9092 --max-messages 1000 --repeating-keys 10 --topic test.test
```

This will produce 1000 messages to topic test.test with 10 repeating keys. you will see the messages produced, their partition and offset, and finally, the resulting throughput.

You can now consume the messages with ```kafka-console-consumer``` or 

```
kafka-verifiable-consumer --broker-list kafka-1:9092 --topic test.test --group-id test-1
```

After consuming all the messages, it will continue polling for new ones, so you can terminate with ```Control+C```

Finally, Let's see how does our topic test.test look like.
Remember, it was automatically created.

Running
```
kafka-topics --zookeeper zookeeper-1:2181 --list

```

will show you the three expected topics:

```
__consumer_offsets
_schemas
test.test
```

and you can investigate the details with the following command: 

```
kafka-topics --zookeeper zookeeper-1:2181 --describe --topic test.test
```

So, now you have a Kafka cluster on your workstation and can try writing producers/consumers/streaming applications in your favorite language.

## Reference 
- https://medium.com/@saabeilin/kafka-hands-on-part-i-development-environment-fc1b70955152
- https://kafka.apache.org/quickstart

