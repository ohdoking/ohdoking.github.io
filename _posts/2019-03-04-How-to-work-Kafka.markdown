---
title: "How to Work with Apache Kafka in Your Spring Boot Application and Docker"
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
description: How to Work with Apache Kafka in Your Spring Boot Application and Docker
---
# How to Work with Apache Kafka in Your Spring Boot Application and Docker

## Step1. Installation and Setup

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
## Step2. Project create 

Let's make 2 projects, Which name are Kafka-consumer project and Kafka-producer like this:

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.ohdoking.kafka</groupId>
    <artifactId>spring-boot-with-kafka</artifactId>
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>

    <modules>
        <module>kafka-consumer</module>
        <module>kafka-producer</module>
    </modules>

</project>
```


## Step3. Publish/read messages from the Kafka topic

Now you can see what it looks like.
Start by creating a simple java class, which we will use for our example. `package.com.ohdoking.models`

```
public class User {

    private String name;
    private int age;

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

## Step4. Configure Kafka through application.yml configuration file

Next, we need to create the configuration file. we need to somehow configure our Kafka producer and consumer to be able to publish and read messages to and from the topic.

we use `application.yml`

Spring Boot allows us to avoid all the boilerplate code we used to write in the past, and provide us with much more intelligent way of configuring our application like this:

### In Kafka-consumer project

```
spring:
   kafka:
     consumer:
        bootstrap-servers: localhost:9092
        group-id: group_id
        auto-offset-reset: earliest
        key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
        value-deserializer: org.apache.kafka.common.serialization.StringDeserializer
```

### In Kafka-producer project

```
spring:
   kafka:
     producer:
        bootstrap-servers: localhost:9092
        key-serializer: org.apache.kafka.common.serialization.StringSerializer
        value-serializer: org.apache.kafka.common.serialization.StringSerializer
```

## Step 5: Create a producer

Creating a provider will write our messages to topic.

```
@Service
public class Producer {

    private static final Logger logger = LoggerFactory.getLogger(Producer.class);
    private static final String TOPIC = "users";

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    public void sendMessage(String message) {
        logger.info(String.format("#### -> Producing message -> %s", message));
        this.kafkaTemplate.send(TOPIC, message);
    }
}
```

## Step 6: Create a consumer

Consumer is the service that will be responsible for reading messages processing them according to the needs of your own business logic. To set it up, enter the following:

```
@Service
public class Consumer {

    private final Logger logger = LoggerFactory.getLogger(Producer.class);

    @KafkaListener(topics = "users", groupId = "group_id")
    public void consume(String message) throws IOException {
        logger.info(String.format("#### -> Consumed message -> %s", message));
    }
}
```

Here, we told our method `void consume(String message)` to subscribe to the user's topic and just emit every message to the application log. in your real application, you can handle messages the way your business requires you to.

## Step 7, Create a REST controller

To fully show how everything that we created works, we need to create a controller with single endpoint. The message will be published to this endpoint, and then handled by our producer. 

Then, our cunsumer will catch and handle it the way we set it up by logging to the console.

```
@RestController
@RequestMapping(value = "/kafka")
public class KafkaController {

    private final Producer producer;

    @Autowired
    KafkaController(Producer producer) {
        this.producer = producer;
    }

    @PostMapping(value = "/publish")
    public void sendMessageToKafkaTopic(@RequestParam("message") String message) {
        this.producer.sendMessage(message);
    }
}
```

## Step 8, Excute docker-compose and test

Now you build maven and execute docker. 

### Build all modules:

```
project> mvn clean package -DskipTests=true
```

### Start infrastructure modules in docker:

```
project> docker-compose up --build
```

Let’s send our message to Kafka using cURL:

```
curl -X POST -F 'message=ohdoking' http://localhost:8083/api/v1/producer/kafka/publish
```

This is result :

![kafka result](https://user-images.githubusercontent.com/4298268/53805361-30c72c80-3f4a-11e9-86e2-bf255f25e8d9.png)

## Interested in more?
You can also find all the code in this article on [GitHub](https://github.com/ohdoking/spring-boot-with-kafka-and-docker).

## Reference 
- https://www.confluent.io/blog/apache-kafka-spring-boot-application
- https://www.baeldung.com/spring-kafka
- https://github.com/igorkosandyak/spring-boot-kafka
