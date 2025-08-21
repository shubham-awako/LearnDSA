# Redundant Connection

## Problem Statement

In this problem, a tree is an undirected graph that is connected and has no cycles.

You are given a graph that started as a tree with n nodes labeled from 1 to n, with one additional edge added. The added edge has two different vertices chosen from 1 to n, and was not an edge that already existed. The graph is represented as an array `edges` of length `n` where `edges[i] = [ai, bi]` indicates that there is an edge between nodes `ai` and `bi` in the graph.

Return an edge that can be removed so that the resulting graph is a tree. If there are multiple answers, return the edge that occurs last in the input.

**Example 1:**
```
Input: edges = [[1,2],[1,3],[2,3]]
Output: [2,3]
```

**Example 2:**
```
Input: edges = [[1,2],[2,3],[3,4],[1,4],[1,5]]
Output: [1,4]
```

**Constraints:**
- `n == edges.length`
- `3 <= n <= 1000`
- `edges[i].length == 2`
- `1 <= ai < bi <= n`
- `ai != bi`
- There are no repeated edges.
- The given graph is connected.

## Concept Overview

This problem tests your understanding of graph theory, particularly cycle detection in an undirected graph. The key insight is to use the Union-Find (Disjoint Set) data structure to detect cycles in the graph. When we encounter an edge that connects two nodes that are already in the same set, we've found a cycle, and that edge is the redundant connection.

## Solutions

### 1. Best Optimized Solution - Union-Find

Use the Union-Find (Disjoint Set) data structure to detect cycles in the graph.

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n + 1))
        self.rank = [0] * (n + 1)
    
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

def findRedundantConnection(edges):
    n = len(edges)
    uf = UnionFind(n)
    
    for u, v in edges:
        if not uf.union(u, v):
            return [u, v]
    
    return []
```

**Time Complexity:** O(n * α(n)) - We perform Union-Find operations for each edge, where α is the inverse Ackermann function, which is nearly constant.
**Space Complexity:** O(n) - We need to store the parent and rank arrays for the Union-Find data structure.

### 2. Alternative Solution - DFS Cycle Detection

Use Depth-First Search to detect cycles in the graph.

```python
def findRedundantConnection(edges):
    n = len(edges)
    graph = [[] for _ in range(n + 1)]
    
    def dfs(u, v, visited):
        if u == v:
            return True
        
        visited.add(u)
        
        for neighbor in graph[u]:
            if neighbor not in visited:
                if dfs(neighbor, v, visited):
                    return True
        
        return False
    
    for u, v in edges:
        # Check if adding this edge would create a cycle
        if dfs(u, v, set()):
            return [u, v]
        
        # Add the edge to the graph
        graph[u].append(v)
        graph[v].append(u)
    
    return []
```

**Time Complexity:** O(n^2) - In the worst case, we need to perform a DFS for each edge, and each DFS takes O(n) time.
**Space Complexity:** O(n) - We need to store the graph as an adjacency list and the visited set.

### 3. Alternative Solution - BFS Cycle Detection

Use Breadth-First Search to detect cycles in the graph.

```python
from collections import deque

def findRedundantConnection(edges):
    n = len(edges)
    graph = [[] for _ in range(n + 1)]
    
    def bfs(u, v):
        visited = set([u])
        queue = deque([u])
        
        while queue:
            node = queue.popleft()
            
            if node == v:
                return True
            
            for neighbor in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append(neighbor)
        
        return False
    
    for u, v in edges:
        # Check if adding this edge would create a cycle
        if bfs(u, v):
            return [u, v]
        
        # Add the edge to the graph
        graph[u].append(v)
        graph[v].append(u)
    
    return []
```

**Time Complexity:** O(n^2) - In the worst case, we need to perform a BFS for each edge, and each BFS takes O(n) time.
**Space Complexity:** O(n) - We need to store the graph as an adjacency list, the visited set, and the queue.

## Solution Choice and Explanation

The Union-Find solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n * α(n)) time complexity, which is nearly linear and much better than the O(n^2) time complexity of the DFS and BFS solutions.

2. **Simplicity**: It's the most straightforward and elegant solution for detecting cycles in an undirected graph.

3. **Intuitiveness**: It naturally maps to the concept of detecting cycles in a graph by checking if two nodes are already in the same set.

The key insight of this approach is to use the Union-Find data structure to detect cycles in the graph. When we encounter an edge that connects two nodes that are already in the same set, we've found a cycle, and that edge is the redundant connection.

For example, let's trace through the algorithm for the first example:
```
edges = [[1,2],[1,3],[2,3]]
```

1. Initialize the Union-Find data structure:
   - parent = [0, 1, 2, 3]
   - rank = [0, 0, 0, 0]

2. Process the edges:
   - Edge [1, 2]:
     - find(1) = 1, find(2) = 2
     - Union 1 and 2: parent = [0, 1, 1, 3], rank = [0, 1, 0, 0]
   - Edge [1, 3]:
     - find(1) = 1, find(3) = 3
     - Union 1 and 3: parent = [0, 1, 1, 1], rank = [0, 1, 0, 0]
   - Edge [2, 3]:
     - find(2) = 1, find(3) = 1
     - 2 and 3 are already in the same set, so this edge creates a cycle
     - Return [2, 3]

3. Final result: [2, 3]

The DFS Cycle Detection solution (Solution 2) and the BFS Cycle Detection solution (Solution 3) are less efficient for this problem, as they require O(n^2) time in the worst case.

In an interview, I would first mention the Union-Find solution as the most efficient approach for this problem, and then discuss the DFS and BFS solutions as alternatives if asked for different approaches.
