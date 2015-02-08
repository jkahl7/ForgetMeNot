// Playground - noun: a place where people can play

import UIKit

class Node : NSObject
{
  var next : Node?
  //var previous : Node?
  var value : Int!
  
  init(addNumber:Int)
  {
    self.value = addNumber
  }
}



class NodeManager : NSObject
{
  var head : Node?
  var tail : Node?
  
  
  func addNode(value:Int) //instantiates a new node
  {
    var newNode = Node(value)
    newNode.value = value
    
    if (self.head == nil)
    {
      self.head = node
      self.tail = node
    } else {
      self.addNodeToHead(node)
    }
  }
  
  
  
  
  
  func addToHead(node:Node)
  {
    node.previous = self.head
    self.head = node
  }
  
  func addToTail(node:Node)
  {
    var nodeToTail:Node = self.head!
    while(nodeToTail != nil)
    {
      nodeToTail = nodeToTail.next
    }
    nodeToTail.next = node
  }
  
}


var node0 = Node(addNumber: 0)
var node1 = Node(addNumber: 1)
var node2 = Node(addNumber: 2)
var node3 = Node(addNumber: 3)
var node4 = Node(addNumber: 4)
var node5 = Node(addNumber: 5)

var nodeManager = NodeManager()

nodeManager.addNode(node0, toHead: true)

nodeManager.addNode(node1, toHead: true)

nodeManager.head

nodeManager.addNode(node2, toHead: true)
nodeManager.addNode(node3, toHead: true)
nodeManager.addNode(node4, toHead: false)
nodeManager.addNode(node5, toHead: true)

nodeManager.head

node0.next
node0.previous
node1.previous
node2.previous









