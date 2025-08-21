# Min Cost to Connect All Points

## Problem Statement

You are given an array `points` representing integer coordinates of some points on a 2D-plane, where `points[i] = [xi, yi]`.

The cost of connecting two points `[xi, yi]` and `[xj, yj]` is the manhattan distance between them: `|xi - xj| + |yi - yj|`, where `|val|` denotes the absolute value of `val`.

Return the minimum cost to make all points connected. All points are connected if there is exactly one simple path between any two points.

**Example 1:**
```
Input: points = [[0,0],[2,2],[3,10],[5,2],[7,0]]
Output: 20
Explanation: 
We can connect the points as shown above to get the minimum cost of 20.
Notice that there is a unique path between every pair of points.
```

**Example 2:**
```
Input: points = [[3,12],[-2,5],[-4,1]]
Output: 18
```

**Constraints:**
- `1 <= points.length <= 1000`
- `-10^6 <= xi, yi <= 10^6`
- All pairs `(xi, yi)` are distinct.

## Concept Overview

This problem is asking us to find the Minimum Spanning Tree (MST) of a complete graph, where the vertices are the points and the edge weights are the Manhattan distances between the points. The MST is a subset of the edges of a connected, edge-weighted graph that connects all vertices together without any cycles and with the minimum possible total edge weight.

## Solutions

### 1. Best Optimized Solution - Prim's Algorithm

Use Prim's Algorithm to find the MST of the graph.

```python
import heapq

def minCostConnectPoints(points):
    n = len(points)
    if n == 1:
        return 0
    
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(n)]
    for i in range(n):
        for j in range(i + 1, n):
            dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
            graph[i].append((j, dist))
            graph[j].append((i, dist))
    
    # Prim's Algorithm
    mst_cost = 0
    visited = [False] * n
    min_heap = [(0, 0)]  # (cost, vertex)
    
    while min_heap:
        cost, vertex = heapq.heappop(min_heap)
        
        if visited[vertex]:
            continue
        
        visited[vertex] = True
        mst_cost += cost
        
        for neighbor, weight in graph[vertex]:
            if not visited[neighbor]:
                heapq.heappush(min_heap, (weight, neighbor))
    
    return mst_cost
```

**Time Complexity:** O(n^2 * log(n)) - We need to build the graph, which takes O(n^2) time, and then run Prim's Algorithm, which takes O(E * log(V)) time, where E is the number of edges (O(n^2)) and V is the number of vertices (O(n)).
**Space Complexity:** O(n^2) - We need to store the graph as an adjacency list.

### 2. Alternative Solution - Kruskal's Algorithm

Use Kruskal's Algorithm to find the MST of the graph.

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

def minCostConnectPoints(points):
    n = len(points)
    if n == 1:
        return 0
    
    # Build the list of edges
    edges = []
    for i in range(n):
        for j in range(i + 1, n):
            dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
            edges.append((dist, i, j))
    
    # Sort the edges by weight
    edges.sort()
    
    # Kruskal's Algorithm
    uf = UnionFind(n)
    mst_cost = 0
    edges_used = 0
    
    for weight, u, v in edges:
        if uf.union(u, v):
            mst_cost += weight
            edges_used += 1
            
            # Early termination
            if edges_used == n - 1:
                break
    
    return mst_cost
```

**Time Complexity:** O(n^2 * log(n)) - We need to build the list of edges, which takes O(n^2) time, sort the edges, which takes O(n^2 * log(n^2)) = O(n^2 * log(n)) time, and then run Kruskal's Algorithm, which takes O(E * log(V)) time, where E is the number of edges (O(n^2)) and V is the number of vertices (O(n)).
**Space Complexity:** O(n^2) - We need to store the list of edges.

### 3. Alternative Solution - Optimized Prim's Algorithm

Use an optimized version of Prim's Algorithm to find the MST of the graph.

```python
def minCostConnectPoints(points):
    n = len(points)
    if n == 1:
        return 0
    
    # Prim's Algorithm
    mst_cost = 0
    visited = [False] * n
    min_dist = [float('inf')] * n
    min_dist[0] = 0
    
    for _ in range(n):
        # Find the vertex with the minimum distance
        min_vertex = -1
        for i in range(n):
            if not visited[i] and (min_vertex == -1 or min_dist[i] < min_dist[min_vertex]):
                min_vertex = i
        
        # Mark the vertex as visited
        visited[min_vertex] = True
        mst_cost += min_dist[min_vertex]
        
        # Update the distances
        for i in range(n):
            if not visited[i]:
                dist = abs(points[min_vertex][0] - points[i][0]) + abs(points[min_vertex][1] - points[i][1])
                min_dist[i] = min(min_dist[i], dist)
    
    return mst_cost
```

**Time Complexity:** O(n^2) - We need to run Prim's Algorithm, which takes O(V^2) time in this implementation, where V is the number of vertices (O(n)).
**Space Complexity:** O(n) - We need to store the visited array and the min_dist array.

## Solution Choice and Explanation

The Optimized Prim's Algorithm solution (Solution 3) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n^2) time complexity, which is optimal for this problem, and the space complexity is O(n).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **No Preprocessing**: It doesn't require building the graph or sorting the edges, which saves time and space.

The key insight of this approach is to use Prim's Algorithm to find the MST of the graph. Prim's Algorithm starts with an arbitrary vertex and grows the MST one vertex at a time, always adding the vertex that is closest to the current MST. The distance between two points is the Manhattan distance, which is `|x1 - x2| + |y1 - y2|`.

For example, let's trace through the algorithm for the first example:
```
points = [[0,0],[2,2],[3,10],[5,2],[7,0]]
```

1. Initialize:
   - mst_cost = 0
   - visited = [False, False, False, False, False]
   - min_dist = [0, inf, inf, inf, inf]

2. Iteration 1:
   - min_vertex = 0 (vertex with minimum distance)
   - visited = [True, False, False, False, False]
   - mst_cost = 0
   - Update min_dist:
     - min_dist[1] = min(inf, |0-2| + |0-2|) = 4
     - min_dist[2] = min(inf, |0-3| + |0-10|) = 13
     - min_dist[3] = min(inf, |0-5| + |0-2|) = 7
     - min_dist[4] = min(inf, |0-7| + |0-0|) = 7
   - min_dist = [0, 4, 13, 7, 7]

3. Iteration 2:
   - min_vertex = 1 (vertex with minimum distance)
   - visited = [True, True, False, False, False]
   - mst_cost = 0 + 4 = 4
   - Update min_dist:
     - min_dist[2] = min(13, |2-3| + |2-10|) = 9
     - min_dist[3] = min(7, |2-5| + |2-2|) = 3
     - min_dist[4] = min(7, |2-7| + |2-0|) = 7
   - min_dist = [0, 4, 9, 3, 7]

4. Iteration 3:
   - min_vertex = 3 (vertex with minimum distance)
   - visited = [True, True, False, True, False]
   - mst_cost = 4 + 3 = 7
   - Update min_dist:
     - min_dist[2] = min(9, |5-3| + |2-10|) = 9
     - min_dist[4] = min(7, |5-7| + |2-0|) = 4
   - min_dist = [0, 4, 9, 3, 4]

5. Iteration 4:
   - min_vertex = 4 (vertex with minimum distance)
   - visited = [True, True, False, True, True]
   - mst_cost = 7 + 4 = 11
   - Update min_dist:
     - min_dist[2] = min(9, |7-3| + |0-10|) = 9
   - min_dist = [0, 4, 9, 3, 4]

6. Iteration 5:
   - min_vertex = 2 (vertex with minimum distance)
   - visited = [True, True, True, True, True]
   - mst_cost = 11 + 9 = 20
   - All vertices are visited, so we're done

7. Final result: 20

The Prim's Algorithm solution (Solution 1) and the Kruskal's Algorithm solution (Solution 2) are also efficient but require building the graph or sorting the edges, which adds to the time and space complexity.

In an interview, I would first mention the Optimized Prim's Algorithm solution as the most efficient approach for this problem, and then discuss the Prim's Algorithm and Kruskal's Algorithm solutions as alternatives if asked for different approaches.
