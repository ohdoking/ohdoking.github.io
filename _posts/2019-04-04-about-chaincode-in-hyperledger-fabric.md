---
title: "About Chaincode in HyperLedger Fabric"
layout: post
date: 2019-04-04 20:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- BlockChain
- HyperLedger
- HyperLedger Fabric
- Fabric
- Chaincode
star: true
category: blog
author: Dokeun Oh
description: About Chaincode in HyperLedger Fabric
---
# About Chaincode in HyperLedger Fabric

We will go through a Sample chaincode and understand the following:

* Dependencies
* Struct
* Init Method
* Invoke Method (Get & Set)

## Chaincode

`Chaincode` is a program (smart contract) that is written to read and update the ledger state. All the business logic is inside the chaincode.

In Hyperledger Fabric, chaincode is the ‘smart contract’ that runs on the peers and creates transactions. More broadly, it enables users to create transactions in the Hyperledger Fabric network’s shared ledger and update the world state of the assets.

Chaincode is programmable code, written in Go, and instantiated on a channel. Developers use chaincode to develop business contracts, asset definitions, and collectively-manage decentralized applications. The chaincode manages the ledger state through transactions invoked by applications. Assets are created and updated by a specific chaincode, and cannot be accessed by another chaincode.

`Applications interact with the blockchain ledger through the chaincode.`Therefore, the chaincode needs to be installed on every peer that will endorse a transaction and instantiated on the channel.

## Chaincode Key APIs

An important interface that you can use when writing your chaincode is defined by Hyperledger Fabric —

* ChaincodeStub
* ChaincodeStubInterface

The ChaincodeStub provides functions that allow you to interact with the underlying ledger to query, update, and delete assets.

The key APIs for chaincode include:

* `func (stub *ChaincodeStub) GetState(key string) ([]byte, error)`
> Returns the value of the specified key from the ledger. Note that GetState doesn’t read data from the Write set, which has not been committed to the ledger. In other words, GetState doesn’t consider data modified by PutState that has not been committed. If the key does not exist in the state database, (nil, nil) is returned.

* `func (stub *ChaincodeStub) PutState(key string, value []byte) error`
> Puts the specified key and value into the transaction’s Write set as a data-write proposal. PutState doesn’t affect the ledger until the transaction is validated and successfully committed.

* `func (stub *ChaincodeStub) DelState(key string) error`
> Records the specified key to be deleted in the Write set of the transaction proposal. The key and its value will be deleted from the ledger when the transaction is validated and successfully committed.

## Overview of a Chaincode Program

When creating a chaincode, there are two methods that you will need to implement:

* Init
> Called when a chaincode receives an instantiate or upgrade transaction. This is where you will initialize any application state.
> 
* Invoke
> Called when the invoke transaction is received to process any transaction proposals.

As a developer, one must create both an Init and an Invoke method within your chaincode. The chaincode must be installed using the peer chaincode install command, and instantiated using the peer chaincode instantiate command before the chaincode can be invoked. Then, transactions can be created using the peer chaincode invoke or peer chaincode query commands.

## Chaincode Decomposed — Dependencies 

```
package main
import (
    “github.com/hyperledger/fabric/core/chaincode/shim”
    “github.com/hyperledger/fabric/protos/peer”
)
```
* github.com/hyperledger/fabric/core/chaincode/shim
> contains the definition for the chaincode interface and the chaincode stub, which you will need to interact with the ledger, as we described in the Chaincode Key APIs section

* github.com/hyperledger/fabric/protos/peer
> contains the peer protobuf package.
 
## Chaincode Decomposed — Struct
```
type SampleChaincode struct {

}
```

This might not look like much, but this is the statement that begins the definition of an object/class in Go.

SampleChaincode implements a simple chaincode to manage an asset.



## Reference 
- https://medium.com/swlh/hyperledger-chapter-8-what-is-hyperledger-fabric-chaincode-a74778dff2ae
- 



