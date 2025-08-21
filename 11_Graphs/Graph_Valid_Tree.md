# Graph Valid Tree

## Problem Statement

You have a graph of `n` nodes labeled from `0` to `n - 1`. You are given an integer `n` and a list of `edges` where `edges[i] = [ai, bi]` indicates that there is an undirected edge between nodes `ai` and `bi` in the graph.

Return `true` if the edges of the given graph make up a valid tree, and `false` otherwise.

**Example 1:**
```
Input: n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]
Output: true
```

**Example 2:**
```
Input: n = 5, edges = [[0,1],[1,2],[2,3],[1,3],[1,4]]
Output: false
```

**Constraints:**
- `1 <= n <= 2000`
- `0 <= edges.length <= 5000`
- `edges[i].length == 2`
- `0 <= ai, bi < n`
- `ai != bi`
- There are no self-loops or repeated edges.

## Concept Overview

This problem tests your understanding of graph theory, particularly the properties of a tree. A graph is a valid tree if and only if it is connected and has no cycles. In other words, a tree is a connected acyclic graph.

## Solutions

### 1. Best Optimized Solution - Union-Find

Use the Union-Find (Disjoint Set) data structure to check if the graph is a valid tree.

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])  # Path compression
        return self.parent[x]
    
    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)
        
        if root_x == root_y:
            return False
        
        # Union by rank
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1
        
        return True

def validTree(n, edges):
    # A tree with n nodes must have exactly n-1 edges
    if len(edges) != n - 1:
        return False
    
    uf = UnionFind(n)
    
    # Check for cycles
    for u, v in edges:
        if not uf.union(u, v):
            return False
    
    return True
```

**Time Complexity:** O(E * α(n)) - We perform Union-Find operations for each edge, where α is the inverse Ackermann function, which is nearly constant.
**Space Complexity:** O(n) - We need to store the parent and rank arrays for the Union-Find data structure.

### 2. Alternative Solution - DFS

Use Depth-First Search to check if the graph is connected and has no cycles.

```python
def validTree(n, edges):
    # A tree with n nodes must have exactly n-1 edges
    if len(edges) != n - 1:
        return False
    
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)
    
    # Check if the graph is connected
    visited = set()
    
    def dfs(node):
        visited.add(node)
        
        for neighbor in graph[node]:
            if neighbor not in visited:
                dfs(neighbor)
    
    dfs(0)
    
    return len(visited) == n
```

**Time Complexity:** O(n + e) - We visit each vertex and edge once, where n is the number of nodes and e is the number of edges.
**Space Complexity:** O(n + e) - We store the graph as an adjacency list and the visited set.

### 3. Alternative Solution - BFS

Use Breadth-First Search to check if the graph is connected and has no cycles.

```python
from collections import deque

def validTree(n, edges):
    # A tree with n nodes must have exactly n-1 edges
    if len(edges) != n - 1:
        return False
    
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)
    
    # Check if the graph is connected
    visited = {0}
    queue = deque([0])
    
    while queue:
        node = queue.popleft()
        
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
    
    return len(visited) == n
```

**Time Complexity:** O(n + e) - We visit each vertex and edge once, where n is the number of nodes and e is the number of edges.
**Space Complexity:** O(n + e) - We store the graph as an adjacency list, the visited set, and the queue.

## Solution Choice and Explanation

The Union-Find solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(E * α(n)) time complexity, which is nearly linear and optimal for this problem.

2. **Simplicity**: It's the most straightforward and elegant solution for checking if a graph is a valid tree.

3. **Intuitiveness**: It naturally maps to the concept of checking if a graph is connected and has no cycles.

The key insight of this approach is to use the Union-Find data structure to check if the graph is a valid tree. A graph is a valid tree if and only if it is connected and has no cycles. We can check these properties using Union-Find:

1. A tree with n nodes must have exactly n-1 edges. If the number of edges is not n-1, the graph is not a valid tree.
2. We use Union-Find to check if the graph has a cycle. If we encounter an edge that connects two nodes that are already in the same set, we've found a cycle, and the graph is not a valid tree.
3. If the graph has exactly n-1 edges and no cycles, it must be connected (because a disconnected graph with no cycles would have fewer than n-1 edges).

For example, let's trace through the algorithm for the first example:
```
n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]
```

1. Check if the number of edges is n-1:
   - Number of edges = 4
   - n-1 = 4
   - The condition is satisfied

2. Initialize the Union-Find data structure:
   - parent = [0, 1, 2, 3, 4]
   - rank = [0, 0, 0, 0, 0]

3. Process the edges:
   - Edge [0, 1]:
     - find(0) = 0, find(1) = 1
     - Union 0 and 1: parent = [0, 0, 2, 3, 4], rank = [1, 0, 0, 0, 0]
   - Edge [0, 2]:
     - find(0) = 0, find(2) = 2
     - Union 0 and 2: parent = [0, 0, 0, 3, 4], rank = [1, 0, 0, 0, 0]
   - Edge [0, 3]:
     - find(0) = 0, find(3) = 3
     - Union 0 and 3: parent = [0, 0, 0, 0, 4], rank = [1, 0, 0, 0, 0]
   - Edge [1, 4]:
     - find(1) = 0, find(4) = 4
     - Union 0 and 4: parent = [0, 0, 0, 0, 0], rank = [1, 0, 0, 0, 0]

4. No cycles detected, and the graph has exactly n-1 edges, so it's a valid tree.

5. Final result: true

For the second example:
```
n = 5, edges = [[0,1],[1,2],[2,3],[1,3],[1,4]]
```

1. Check if the number of edges is n-1:
   - Number of edges = 5
   - n-1 = 4
   - The condition is not satisfied, so the graph is not a valid tree.

2. Final result: false

The DFS solution (Solution 2) and the BFS solution (Solution 3) are also efficient and may be preferred in some cases, especially when the graph is already represented as an adjacency list.

In an interview, I would first mention the Union-Find solution as the most efficient approach for this problem, and then discuss the DFS and BFS solutions as alternatives if asked for different approaches.
