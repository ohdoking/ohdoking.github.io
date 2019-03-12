---
title: "About Garabage Collection"
layout: post
date: 2019-03-12 20:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- Java
- JVM
- Garbage colleciton
star: true
category: blog
author: Dokeun Oh
description: About Garabage Collection
---
# About Garabage Collection

## What is automatic garbage collection ?

Automatic garbage collection is the process of looking at heap memory, identifying which objects are in use and which are not, and deleting the unused object. An unused objet can be relcaimed

In a programming language like C, allocating and deallocating memory is a manual process. In Java, process of deallocating memory is handled automatically by the garbage collector. The basic process cab be described as follows.

## Step

### Step 1 marking.

This is where the garbage collector identifies which pieces of memory are in use and which are not. 

### Step 2 Normal deletion.
### Step 2a Deleting with compacting.

## JVM generations.
* Young generation
    * New object are allocated and aged
    * When it fulls up -> cause minor garbage collection(Stop the world event)
    * Surviving object -> aged and eventually move to the old generation.
* Old or tenured generation.
    * Store long surviving objects 
    *  -> Called Major garbage collection(Stop the world event)
    * Major garbage collections should be minimized(it involves all live objects)
* Permanent generation.
    * Contains metadata required by the jam to describe the classes and methods used in the application
    * Java se library classes and methods
    * Class(no long needed and space may be needed for other class) -> collect full garbage collection.

> Stop the world event : this means that all application threads are stopped until the operation completes. 

## Reference 
- https://www.oracle.com/webfolder/technetwork/tutorials/obe/java/gc01/index.html



