# Clone Graph

## Problem Statement

Given a reference of a node in a connected undirected graph.

Return a deep copy (clone) of the graph.

Each node in the graph contains a value (`int`) and a list (`List[Node]`) of its neighbors.

```
class Node {
    public int val;
    public List<Node> neighbors;
}
```

Test case format:

For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with `val == 1`, the second node with `val == 2`, and so on. The graph is represented in the test case using an adjacency list.

An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with `val = 1`. You must return the copy of the given node as a reference to the cloned graph.

**Example 1:**
```
Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
Output: [[2,4],[1,3],[2,4],[1,3]]
Explanation: There are 4 nodes in the graph.
1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
```

**Example 2:**
```
Input: adjList = [[]]
Output: [[]]
Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.
```

**Example 3:**
```
Input: adjList = []
Output: []
Explanation: This an empty graph, it does not have any nodes.
```

**Constraints:**
- The number of nodes in the graph is in the range `[0, 100]`.
- `1 <= Node.val <= 100`
- `Node.val` is unique for each node.
- There are no repeated edges and no self-loops in the graph.
- The Graph is connected and all nodes can be visited starting from the given node.

## Concept Overview

This problem tests your understanding of graph traversal and deep copying. The key insight is to use a hash map to keep track of the nodes that have already been cloned to avoid creating duplicate nodes and to handle cycles in the graph.

## Solutions

### 1. Best Optimized Solution - DFS with Hash Map

Use Depth-First Search with a hash map to clone the graph.

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val = 0, neighbors = None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []
"""

def cloneGraph(node):
    if not node:
        return None
    
    # Hash map to store the mapping from original nodes to cloned nodes
    cloned = {}
    
    def dfs(node):
        # If the node has already been cloned, return the cloned node
        if node in cloned:
            return cloned[node]
        
        # Create a new node with the same value
        clone = Node(node.val)
        
        # Add the new node to the hash map
        cloned[node] = clone
        
        # Clone the neighbors
        for neighbor in node.neighbors:
            clone.neighbors.append(dfs(neighbor))
        
        return clone
    
    return dfs(node)
```

**Time Complexity:** O(n + e) - We visit each node and edge once, where n is the number of nodes and e is the number of edges.
**Space Complexity:** O(n) - We store each node in the hash map and the recursion stack can go up to n levels deep.

### 2. Alternative Solution - BFS with Hash Map

Use Breadth-First Search with a hash map to clone the graph.

```python
from collections import deque

"""
# Definition for a Node.
class Node:
    def __init__(self, val = 0, neighbors = None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []
"""

def cloneGraph(node):
    if not node:
        return None
    
    # Hash map to store the mapping from original nodes to cloned nodes
    cloned = {node: Node(node.val)}
    
    # Use a queue for BFS
    queue = deque([node])
    
    while queue:
        curr = queue.popleft()
        
        # Clone the neighbors
        for neighbor in curr.neighbors:
            # If the neighbor has not been cloned yet
            if neighbor not in cloned:
                # Create a new node with the same value
                cloned[neighbor] = Node(neighbor.val)
                # Add the neighbor to the queue
                queue.append(neighbor)
            
            # Add the cloned neighbor to the cloned node's neighbors
            cloned[curr].neighbors.append(cloned[neighbor])
    
    return cloned[node]
```

**Time Complexity:** O(n + e) - We visit each node and edge once, where n is the number of nodes and e is the number of edges.
**Space Complexity:** O(n) - We store each node in the hash map and the queue can contain at most n nodes.

### 3. Alternative Solution - Iterative DFS with Hash Map

Use Iterative Depth-First Search with a hash map to clone the graph.

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val = 0, neighbors = None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []
"""

def cloneGraph(node):
    if not node:
        return None
    
    # Hash map to store the mapping from original nodes to cloned nodes
    cloned = {node: Node(node.val)}
    
    # Use a stack for iterative DFS
    stack = [node]
    
    while stack:
        curr = stack.pop()
        
        # Clone the neighbors
        for neighbor in curr.neighbors:
            # If the neighbor has not been cloned yet
            if neighbor not in cloned:
                # Create a new node with the same value
                cloned[neighbor] = Node(neighbor.val)
                # Add the neighbor to the stack
                stack.append(neighbor)
            
            # Add the cloned neighbor to the cloned node's neighbors
            cloned[curr].neighbors.append(cloned[neighbor])
    
    return cloned[node]
```

**Time Complexity:** O(n + e) - We visit each node and edge once, where n is the number of nodes and e is the number of edges.
**Space Complexity:** O(n) - We store each node in the hash map and the stack can contain at most n nodes.

## Solution Choice and Explanation

The DFS with Hash Map solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(n + e) time complexity, which is optimal for this problem, and the space complexity is O(n).

3. **Intuitiveness**: It naturally maps to the concept of recursively cloning a node and its neighbors.

The key insight of this approach is to use a hash map to keep track of the nodes that have already been cloned to avoid creating duplicate nodes and to handle cycles in the graph. When we encounter a node, we first check if it has already been cloned. If it has, we return the cloned node. Otherwise, we create a new node with the same value, add it to the hash map, and recursively clone its neighbors.

For example, let's trace through the algorithm for the first example:
```
adjList = [[2,4],[1,3],[2,4],[1,3]]
```

1. Start with node 1:
   - Create a new node with value 1: clone_1 = Node(1)
   - Add it to the hash map: cloned = {node_1: clone_1}
   - Clone the neighbors of node 1:
     - Neighbor node 2:
       - Create a new node with value 2: clone_2 = Node(2)
       - Add it to the hash map: cloned = {node_1: clone_1, node_2: clone_2}
       - Clone the neighbors of node 2:
         - Neighbor node 1:
           - Already cloned, return clone_1
         - Neighbor node 3:
           - Create a new node with value 3: clone_3 = Node(3)
           - Add it to the hash map: cloned = {node_1: clone_1, node_2: clone_2, node_3: clone_3}
           - Clone the neighbors of node 3:
             - Neighbor node 2:
               - Already cloned, return clone_2
             - Neighbor node 4:
               - Create a new node with value 4: clone_4 = Node(4)
               - Add it to the hash map: cloned = {node_1: clone_1, node_2: clone_2, node_3: clone_3, node_4: clone_4}
               - Clone the neighbors of node 4:
                 - Neighbor node 1:
                   - Already cloned, return clone_1
                 - Neighbor node 3:
                   - Already cloned, return clone_3
               - Add clone_1 and clone_3 to clone_4.neighbors
             - Add clone_2 and clone_4 to clone_3.neighbors
           - Add clone_1 and clone_3 to clone_2.neighbors
         - Neighbor node 4:
           - Already cloned, return clone_4
       - Add clone_1 and clone_3 to clone_2.neighbors
     - Add clone_2 and clone_4 to clone_1.neighbors
   - Return clone_1

2. Final result: A deep copy of the graph starting from node 1.

The BFS with Hash Map solution (Solution 2) and the Iterative DFS with Hash Map solution (Solution 3) are also efficient and may be preferred in some cases, especially when the graph is large and the recursion stack might overflow.

In an interview, I would first mention the DFS with Hash Map solution as the most intuitive approach for this problem, and then discuss the BFS and Iterative DFS solutions as alternatives if asked for different approaches.
