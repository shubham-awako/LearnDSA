# Network Delay Time

## Problem Statement

You are given a network of `n` nodes, labeled from `1` to `n`. You are also given `times`, a list of travel times as directed edges `times[i] = (ui, vi, wi)`, where `ui` is the source node, `vi` is the target node, and `wi` is the time it takes for a signal to travel from source to target.

We will send a signal from a given node `k`. Return the minimum time it takes for all the `n` nodes to receive the signal. If it is impossible for all the `n` nodes to receive the signal, return `-1`.

**Example 1:**
```
Input: times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
Output: 2
```

**Example 2:**
```
Input: times = [[1,2,1]], n = 2, k = 1
Output: 1
```

**Example 3:**
```
Input: times = [[1,2,1]], n = 2, k = 2
Output: -1
```

**Constraints:**
- `1 <= k <= n <= 100`
- `1 <= times.length <= 6000`
- `times[i].length == 3`
- `1 <= ui, vi <= n`
- `ui != vi`
- `0 <= wi <= 100`
- All the pairs `(ui, vi)` are unique (i.e., no multiple edges).

## Concept Overview

This problem is asking us to find the time it takes for a signal to reach all nodes in a network, starting from a given node. This is equivalent to finding the longest shortest path from the source node to any other node in the graph. We can use Dijkstra's algorithm to find the shortest paths from the source node to all other nodes, and then return the maximum of these shortest paths.

## Solutions

### 1. Best Optimized Solution - Dijkstra's Algorithm

Use Dijkstra's Algorithm to find the shortest paths from the source node to all other nodes.

```python
import heapq

def networkDelayTime(times, n, k):
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(n + 1)]
    for u, v, w in times:
        graph[u].append((v, w))
    
    # Dijkstra's Algorithm
    dist = [float('inf')] * (n + 1)
    dist[k] = 0
    min_heap = [(0, k)]  # (distance, node)
    
    while min_heap:
        d, node = heapq.heappop(min_heap)
        
        if d > dist[node]:
            continue
        
        for neighbor, weight in graph[node]:
            if d + weight < dist[neighbor]:
                dist[neighbor] = d + weight
                heapq.heappush(min_heap, (dist[neighbor], neighbor))
    
    # Find the maximum distance
    max_dist = max(dist[1:])
    
    return max_dist if max_dist < float('inf') else -1
```

**Time Complexity:** O(E * log(V)) - We need to run Dijkstra's Algorithm, which takes O(E * log(V)) time, where E is the number of edges and V is the number of vertices.
**Space Complexity:** O(V + E) - We need to store the graph as an adjacency list and the distance array.

### 2. Alternative Solution - Bellman-Ford Algorithm

Use the Bellman-Ford Algorithm to find the shortest paths from the source node to all other nodes.

```python
def networkDelayTime(times, n, k):
    # Initialize distances
    dist = [float('inf')] * (n + 1)
    dist[k] = 0
    
    # Relax all edges n-1 times
    for _ in range(n - 1):
        for u, v, w in times:
            if dist[u] != float('inf') and dist[u] + w < dist[v]:
                dist[v] = dist[u] + w
    
    # Find the maximum distance
    max_dist = max(dist[1:])
    
    return max_dist if max_dist < float('inf') else -1
```

**Time Complexity:** O(V * E) - We need to run the Bellman-Ford Algorithm, which takes O(V * E) time, where V is the number of vertices and E is the number of edges.
**Space Complexity:** O(V) - We need to store the distance array.

### 3. Alternative Solution - Floyd-Warshall Algorithm

Use the Floyd-Warshall Algorithm to find the shortest paths between all pairs of nodes.

```python
def networkDelayTime(times, n, k):
    # Initialize distances
    dist = [[float('inf')] * (n + 1) for _ in range(n + 1)]
    for i in range(1, n + 1):
        dist[i][i] = 0
    
    # Set the distances for the edges
    for u, v, w in times:
        dist[u][v] = w
    
    # Floyd-Warshall Algorithm
    for p in range(1, n + 1):
        for i in range(1, n + 1):
            for j in range(1, n + 1):
                dist[i][j] = min(dist[i][j], dist[i][p] + dist[p][j])
    
    # Find the maximum distance from the source node to any other node
    max_dist = max(dist[k][1:])
    
    return max_dist if max_dist < float('inf') else -1
```

**Time Complexity:** O(V^3) - We need to run the Floyd-Warshall Algorithm, which takes O(V^3) time, where V is the number of vertices.
**Space Complexity:** O(V^2) - We need to store the distance matrix.

## Solution Choice and Explanation

The Dijkstra's Algorithm solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(E * log(V)) time complexity, which is better than the O(V * E) time complexity of the Bellman-Ford Algorithm and the O(V^3) time complexity of the Floyd-Warshall Algorithm.

2. **Optimality**: Dijkstra's Algorithm is optimal for finding the shortest paths from a single source in a graph with non-negative edge weights.

3. **Simplicity**: It's a well-known and widely-used algorithm for solving the single-source shortest path problem.

The key insight of this approach is to use Dijkstra's Algorithm to find the shortest paths from the source node to all other nodes. Dijkstra's Algorithm is a greedy algorithm that maintains a priority queue of nodes, sorted by their distance from the source. In each iteration, it selects the node with the smallest distance, explores its neighbors, and updates their distances if a shorter path is found.

For example, let's trace through the algorithm for the first example:
```
times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
```

1. Build the adjacency list representation of the graph:
   - graph[1] = []
   - graph[2] = [(1, 1), (3, 1)]
   - graph[3] = [(4, 1)]
   - graph[4] = []

2. Initialize distances:
   - dist = [inf, inf, 0, inf, inf]

3. Initialize the min heap:
   - min_heap = [(0, 2)]

4. Dijkstra's Algorithm:
   - Pop (0, 2) from the min heap:
     - Explore neighbors of node 2:
       - Neighbor 1: dist[1] = min(inf, 0 + 1) = 1
         - Push (1, 1) to the min heap
       - Neighbor 3: dist[3] = min(inf, 0 + 1) = 1
         - Push (1, 3) to the min heap
     - min_heap = [(1, 1), (1, 3)]
   - Pop (1, 1) from the min heap:
     - Explore neighbors of node 1:
       - No neighbors
     - min_heap = [(1, 3)]
   - Pop (1, 3) from the min heap:
     - Explore neighbors of node 3:
       - Neighbor 4: dist[4] = min(inf, 1 + 1) = 2
         - Push (2, 4) to the min heap
     - min_heap = [(2, 4)]
   - Pop (2, 4) from the min heap:
     - Explore neighbors of node 4:
       - No neighbors
     - min_heap = []

5. Find the maximum distance:
   - dist = [inf, 1, 0, 1, 2]
   - max_dist = max(1, 0, 1, 2) = 2

6. Final result: 2

The Bellman-Ford Algorithm solution (Solution 2) is also correct but less efficient, especially for sparse graphs. The Floyd-Warshall Algorithm solution (Solution 3) is overkill for this problem, as we only need the shortest paths from a single source, not between all pairs of nodes.

In an interview, I would first mention the Dijkstra's Algorithm solution as the most efficient approach for this problem, and then discuss the Bellman-Ford and Floyd-Warshall solutions as alternatives if asked for different approaches.
