---
title: "About HyperLedger Fabric"
layout: post
date: 2019-03-22 20:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- BlockChain
- HyperLedger
- HyperLedger Fabric
- Fabric
star: true
category: blog
author: Dokeun Oh
description: About HyperLedger Fabric
---
# About HyperLedger Fabric

## What is HyperLedger Fabric?

Fabric is a modular and extensible open-source system for deploying and operating permissioned blockchains and one of the Hyperledger projects hosted by the Linux Foundation.

Fabric is the first truly extensible blockchain system for running distributed applications. it supports modular consensus protocols, which allows the system to be tailored to particular use cases and trust module.

Fabric is also the first blockchain system that runs distributed applications written in standard, gerneral-purpose programming languages, without systemic dependency on a native cryptocurrency. This stands in sharp contrast to existing blockchain platforms that require "smart-contracts" to be written in domain-specific languages or rely on a cryptocurrency.

## Advantages of Hyperledger Fabric architecture 

- Chaincode trust flexibility
- Scalability
- Confidentiality
- Consensus modularity

## System architecture

The blockchain is a distributed system consisting of many nodes that communicate with each other. The blockchain runs programs called chaincode, holds state and ledger data, and executes transactions.

The chaincode is the central element as trasactions are operations invoked on the chaincode. Transactions have to be "endorsed" and only endorsed transactions may be committed and have an effect on the state. There may exist one or more special chaincodes for management functions and parameters, collectively called **system chaincodes**.

### Transactions

#### Type of transactions

* Deploy transactions
⋅⋅- create new chaincode and take a program as parameter

* Invoke transactions
⋅⋅- perform an operation in the context of previously deployed chaincode.
⋅⋅- refers to a chaincode and to one of its provided functions.

### Blockchain datastructures

#### State

The lastest state of the blockchain (or, simply, state) is modeled as a versioned key-value store(KVS), where keys are names and values are arbitrary blobs.
These entries are manipulated by the chaincodes(applications) running on the blockchain through put and get KVS-operations.

State `s` is modeled as an element of a mapping `K -> (V X N)`, where:

- `K` is a set of keys
- `V` is a set of values
- `N` is an infinite ordered set of version numbers. Injective function `next: N -> N` takes an element of N and returns the enxt verions number.

Both `V` and `N` contain a special element ⊥(empty type), which is in case of `N` the lowest element. Initially all keys are mapped to (⊥,⊥). For `s(k)=(v,ver)` we denote `v` by `s(k).value` and `ver` by `s(k).version`.

KVS operations are modeled as follows:

- `put(k,v)` for `k`∈`K` and `v`∈`V`, takes the blockchain state `s` and changes it to `s'` such that `s'(k)=(v,next(s(k).version))` with `s'(k')=s(k')` for all `k'!=k`.
- `get(k)` returns `s(k)`.

State is maintained by peers, but not by orderers and clients.

**State Partitioning**. Keys in the KVS can be recognized from their name to belong to a particular chaincode, in the sense that only transation of a certain chaincode may modify the keys belonging to this chaincode. In principle, any chaincode can read the keys belonging to other chaincodes. Support for cross-chaincode transactions, that modify the state belonging to two or more chaincodes is a post-v1 feature.

#### Ledger

Ledger provides a verifiable history of all successsful state changes (we talk about valid transactions) and unsuccessful attempts to change state (we talk about invalid transactions), occurring during the operation of the system.

Ledger is constructed by the ordering serivce as a totally ordered hashchain of block of (valid or invalid) transactions. The hashchain imposes the total order of blocks in a ledger and each block contains an array of totally ordered transactions. This imposes totl order across all transactions.

Ledger is kept at all peers and optionally, at a subset of orders.
We refer to the Ledger different way depend on each context.

- *OrdererLedger*
- *PeerLedger*

### Nodes

Nodes are the communication entities of the blockchain.
A *node* is only a logical function in the sense that multiple nodes of different types can run on the same physical server.

Three types of nodes.

1. Client or submitting-client
⋅⋅- a client that submits an actual transaction-invocation to the endorsers, and broadcasts transaction-proposals to the ordering service.
2. Peer
⋅⋅- a node that commits transactions and maintains the state and a copy of the ledger. Besides, peers can have a special **endorser** role.
3. Ordering-service-node or orderer
⋅⋅- a node running the communicataion service that implements a delivery guarantee, such as atomic or total order broadcast.

#### Client

The client represents the entity that acts on behalf of an end-user. It must connect to a peer for communicating with the blockchain. The client may connect to any peer of its choice. Clients create and thereby invoke transactions.

#### Peer

A peer receives ordered state updates in the form of blocks from the ordering service and maintain the state and the ledger.

Peers can additionally take up a special role of an **endorsing peer**, or an **endorser**. The special function of an *endorsing peer* occurs with respect to a particular chaincode and consists in endorsing a transaction before it is committed.. Every chaincode may specify an *endorsement policy* that may refer to a set of endorsing peers.

#### Ordering service nodes(Orderers)

The orderers form the ordering service which is a communication fabric that provides delivery guarantees.

Ordering service provides a shared *communication channel* to clients and peers, offering a broadcast service for messages containing transactions. TheThe orderers form the ordering service, i.e., a communication fabric that provides delivery guarantees. The channel supports *atomic* delivery of all messages, that is, message communication with total-order delivery and (implementation specific) reliability. This atomic communication guarantee is also called *total-order broadcast*, *atomic broadcast*, or *consensus* in the context of distributed systems.

**Partitioning (ordering service channels)**.

Ordering service may support multiple channels similar to the topics of a publish/subscribe(pub/sub) messaging system.

**Ordering service API**

Peers connect to the channel provided by the ordering service, via the interface provided by the ordering service. The ordering service API consists of 2 basic operations(more generally asynchronous events):

- `broadcast(blob)`
⋅⋅- A client calls this to broadcast an arbitrary message `blob` for dissemination over the channel. This is also called `request(blob)` in the BFT context, when sending a request to a service.
- `deliver(seqno, prevhash, blob)`
⋅⋅- The ordering service calls this on the peer to deliver the message `blob` with the specified non-negative integer sequence number (`seqno`) and hash of the most recently delivered blob (`prevhash`). This is also sometimes called `notify()` in pub-sub systems or `commit()` in BFT systems.

**Ledger and block formation**

The ledger contains all data output by the ordering service.
In a nutshell, it is a sequence of `deliver(seqno, prevhash, blob)` events, which form a hash chain according to the computation of `prevhash` described before.

**Ordering service properties**

The guarantees of the ordering service (or atomic-broadcast channel) stipulate what happens to a broadcasted message and what relations exist among delivered messages. These guarantees are as follows:

1. Safety(consistency guarantees)
⋅⋅- As long as peers are connected for sufficiently long periods of time to the channel(they can disconnect or crash, but will restart and reconnect), they will see an *identical* series of delivered `(seqno, prevhash, blob)` messages. 

2. Liveness(Delivery guarantee)
⋅⋅- Liveness guarantees of the ordering service are specified by a ordering service implementation. The exact guarantees may depend on the network and node falut model.

To summarize, the ordering service ensures the follwoing properties:

* Agreement
⋅⋅- For any two events at correct peer `deliver(seqno, prevhash0, blob0)` and `deliver(seqno, prevhash1, blob1)` with the same `seqno`,`prevhash0`==`prevhash1` and `blob0`==`blob1`.

* Hashchain integrity
⋅⋅- For any two events at correct peers `deliver(seqno-1, prevhash0, blob0)` and `deliver(seqno, prevhash, blob)`, `prevhash = HASH(seqno-1||prevhash0||blob0)`.

* NO skipping
⋅⋅- If an ordering service outputs `deliver(seqno, prevhash, blob)` at a correct peer p, such that `seqno > 0`, then p already delivered an event `deliver(seqno-1, prevhash0, blob0)`.

* No creation
⋅⋅- Any event `deliver(seqno, prevhash, blob)` at a correct peer must be preceded by a `broadcast(blob)` event at some (possibly distinct) peer.

* No duplication(optional, yet desirable)
⋅⋅- For any 2 events `broadcast(blob)` and `broadcast(blob')`, when 2 events `deliver(seqno0, prevhash0, blob)` and `deliver(seqno1, prevhash1, blob1)` occur at correct peers and `blob`==`blob1`, then `seqno0`==`seqno1` and `prevhash0`==`prevhash1`.

* Liverness
⋅⋅- If a correct client invokes an event `broadcast(blob)` then every correct peer "eventually" issues an event `deliver(*, *, blob)`, where `*` denotes an arbitrary value.


## Reference 
- https://hyperledger-fabric.readthedocs.io/en/release-1.4/arch-deep-dive.html
- https://arxiv.org/abs/1801.10228v2



