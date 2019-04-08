---
title: "Merkle Tree"
layout: post
date: 2019-04-08 20:44
image: /assets/images/markdown.jpg
headerImage: false
tag:
- BlockChain
- DLT
- Merkle Tree
- Hash Tree
- SHA-256
star: true
category: blog
author: Dokeun Oh
description: Merkle Tree
---
# Merkle Tree

## What is Merkle Tree?

Structure named `Merkle tree` or `Hash Tree` is concept which Ralph Merkle make it at 1979. Unlike other tree algorithms, Merkle Tree's purpose is not for quick searches but for `simple and reliable authentication of data`. The top parent node(or root) of Merkle Tree called merkle root, which is hash tree of transactions that saved in block that acts as an element role of blockchain.

Merkle Tree uses [SHA-256 encryption technology](https://www.xorbin.com/tools/sha256-hash-calculator)(hash function) for simple and reliable authentication of data.

## Merkle Tree Structure 

![Merkle Tree Structure](https://en.wikipedia.org/wiki/Merkle_tree#/media/File:Hash_Tree.svg)

The block chain first encrypts each transaction (L1, L2...) with SHA-256 to produce a hash result of 64 characters. Next, each adjacent node is summed and then encrypted again with SHA-256 to produce a hash result. This process is repeated until a single hash is encountered.

In a nutshell, All result values have passed through the hash function of the previous output, so if one of the inputs is different, the final result, the merge root, will be different.

With these characteristics, it is possible to check whether transaction tampering has occurred in a block. Even if the transaction contents are long, the result of the hash function is 64 characters, so the capacity of the block can be drastically reduced.

## Verification method using Merkle tree

Prior to Merkle tree verification, you should know the concept of `Full nodes` and `Light nodes`.

`Full nodes` store and process the entirety of every block. 
`Light nodes` allows nodes to process part of the tree, and they should receives the necessary information from the Full nodes.

Assuming you have only the last value 1e3a hash value and merkle root af3d hash value in the light node as shown in the figure below, how do you check if the transaction 1e3a is true?

![merkle_route_1](http://ohdoking.github.io//assets/images/pimg/merkle_route_1.jpeg)

The method receives the information of black boxes (43bc, 143c, 89fe) from the full node and puts them into the hash function in order and proceed with the calculation. If you know the black square box as shown in the figure below, you can sum the adjacent nodes and get the relative value through the hash. This path is called the `Merkle path`.

![merkle_route_2](http://ohdoking.github.io//assets/images/pimg/merkle_route_2.jpeg)

## Recap

```
* Merkle Tree uses SHA-256 encryption (hash function)
* If you use Merkle tree, you can validate data quickly and reduces tree storage
* Merkle Tree is used to validate transactions on the light node.
```


## Reference 
- https://brownbears.tistory.com/372
- https://medium.com/verifyas/merkle-trees-simple-yet-powerful-4c44dad19539
- https://coincentral.com/merkle-tree-hashing-blockchain/
- 



