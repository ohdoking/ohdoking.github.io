---
title: "Private Data in Hyperledger fabric"
layout: post
date: 2019-04-29 20:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- BlockChain
- DLT
- Private Data
- Gassip
star: true
category: blog
author: Dokeun Oh
description: Private Data in Hyperledger fabric
---
# Private Data in Hyperledger fabric

## What is Private Data?

Private Data that you want to keep private to yourself or to specific organizations, without letting anyone (that you don’t want) know the data that you’re storing or sending

## What is a private data collection?

Private Data collections allow a defined subset of organizations on a channel the ability to endorse, commit, or query private data without having to create a separate channel.

This collection is the combination of two elements:

1. `The actual private data`
> Private data sent peer-to-peer via gossip protocol to only the organizations authorized to see it. This data is stored in a private state database on peers of authorized organizations(sometimes called a "side" database, or "SideDB"), which can be accessed from chaincode on these authorized peers. 
The ordering service is not involved here and does not see the private data.
Note that because gossip distributes the private data peer-to-peer across authorized organizations, It is required to set up anchor peer peers on the channel, and configure CORE_PEER_GOSSIP_EXTERNALENDPOINT on each peer, in order to bootstrap cross-organization communication.

2. `A hash of that data`
> It is endorsed, ordered, and written to. he ledgers of every peer on the channel. The hash serves as evidence of the transaction and is used for state validation and can be used for audit purposes. 

![PrivateDataConcept](https://hyperledger-fabric.readthedocs.io/en/release-1.4/_images/PrivateDataConcept-2.png)

## Transaction flow with private data

When private data collections are referenced in chiancode, the transacation flow is slightly different in order to protect the confidentiality of the private data as transactions are proposed, endorsed, and committed to ledger.

1. The client application submits a proposal request to invoke a chaincode function (reading or writing private data) to endorsing peers which are part of authorized organizations of the collection. The private data, or data used to generate private data in chaincode, is sent in a ``transient`` field of the proposal.

2. The endorsing peers simulate the transaction and store the private data in a ``transient data store`` (a temporary storage local to the peer). They distribute the private data, based on the collection policy, to authorized peers via [gossip](https://hyperledger-fabric.readthedocs.io/en/release-1.4/gossip.html).

3. The endorsing peer sends the proposal response back to the client. The proposal response includes the endorsed read/write set, which includes public data, as well as a hash of any private data keys and values. No private data is sent back to the client. For more information on how endorsement works with private data, click [here](https://hyperledger-fabric.readthedocs.io/en/release-1.4/private-data-arch.html#endorsement).

4. The client application submits the transaction (which includes the proposal response with the private data hashes) to the ordering service. The transactions with the private data hashes get included in blocks as normal. The block with the private data hashes is distributed to all the peers. In this way, all peers on the channel can validate transactions with the hashes of the private data in a consistent way, without knowing the actual private data.

5. At block commit time, authorized peers use the collection policy to determine if they are authorized to have access to the private data. If they do, they will first check their local ``transient data store`` to determine if they have already received the private data at chaincode endorsement time. If not, they will attempt to pull the private data from another authorized peer. Then they will validate the private data against the hashes in the public block and commit the transaction and the block. Upon validation/commit, the private data is moved to their copy of the private state database and private writeset storage. The private data is then deleted from the ``transient data store``.

![private data transaction flow](https://user-images.githubusercontent.com/4298268/56888454-4baeac80-6a74-11e9-998e-4bb211bd4871.png)

## Purging private data

For very sensitive data, even the parties sharing the private data might want - or might be required by government regulations, to periodically "purge" the data on their peers, leaving behind a hash of the data on the blockchain to serve as immutable evidence of the private data. 

private data can be purged if it has been modified for a configurable number of blocks. Purged private data cannot be queried from chaincode, and is not available to other requesting peers. 


## Reference 
- https://hyperledger-fabric.readthedocs.io/en/release-1.4/private-data/private-data.html
- https://medium.com/everis-blockchain/hyperledger-fabric-private-data-tutorial-dcd73dcf1ed5
- https://hyperledger-fabric.readthedocs.io/en/latest/private_data_tutorial.html
- https://miiingo.tistory.com/193





