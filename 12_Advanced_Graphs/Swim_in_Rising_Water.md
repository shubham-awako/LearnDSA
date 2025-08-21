# Swim in Rising Water

## Problem Statement

You are given an `n x n` integer matrix `grid` where each value `grid[i][j]` represents the elevation at that point `(i, j)`.

The rain starts to fall. At time `t`, the depth of the water everywhere is `t`. You can swim from a square to another 4-directionally adjacent square if and only if the elevation of both squares individually are at most `t`. You can swim infinite distances in zero time. Of course, you must stay within the boundaries of the grid during your swim.

Return the least time until you can reach the bottom right square `(n - 1, n - 1)` if you start at the top left square `(0, 0)`.

**Example 1:**
```
Input: grid = [[0,2],[1,3]]
Output: 3
Explanation:
At time 0, you are at position (0,0).
You cannot go anywhere else because 4-directionally adjacent neighbors have a higher elevation than t = 0.
You cannot reach point (1,1) until time 3.
When the depth of water is 3, we can swim anywhere inside the grid.
```

**Example 2:**
```
Input: grid = [[0,1,2,3,4],[24,23,22,21,5],[12,13,14,15,16],[11,17,18,19,20],[10,9,8,7,6]]
Output: 16
Explanation: The final route is shown.
We need to wait until time 16 so that (0,0) and (4,4) are connected.
```

**Constraints:**
- `n == grid.length`
- `n == grid[i].length`
- `1 <= n <= 50`
- `0 <= grid[i][j] < n^2`
- Each value `grid[i][j]` is unique.

## Concept Overview

This problem can be approached in several ways, but the key insight is to find the minimum maximum elevation along any path from the top-left to the bottom-right. This is a classic problem that can be solved using Dijkstra's algorithm, binary search, or a modified version of Prim's algorithm.

## Solutions

### 1. Best Optimized Solution - Dijkstra's Algorithm

Use Dijkstra's Algorithm to find the path with the minimum maximum elevation.

```python
import heapq

def swimInWater(grid):
    n = len(grid)
    visited = set([(0, 0)])
    min_heap = [(grid[0][0], 0, 0)]  # (max_height, row, col)
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    
    while min_heap:
        max_height, row, col = heapq.heappop(min_heap)
        
        # If we've reached the bottom-right corner, return the maximum height
        if row == n - 1 and col == n - 1:
            return max_height
        
        # Explore all four adjacent cells
        for dr, dc in directions:
            nr, nc = row + dr, col + dc
            
            # Check if the adjacent cell is valid and not visited
            if 0 <= nr < n and 0 <= nc < n and (nr, nc) not in visited:
                visited.add((nr, nc))
                # The maximum height is the maximum of the current maximum height and the height of the adjacent cell
                heapq.heappush(min_heap, (max(max_height, grid[nr][nc]), nr, nc))
    
    return -1  # Should never reach here if the grid is valid
```

**Time Complexity:** O(n^2 * log(n^2)) - We need to run Dijkstra's Algorithm, which takes O(E * log(V)) time, where E is the number of edges (O(n^2)) and V is the number of vertices (O(n^2)).
**Space Complexity:** O(n^2) - We need to store the visited set and the min heap.

### 2. Alternative Solution - Binary Search with BFS

Use binary search to find the minimum time required, and BFS to check if it's possible to reach the bottom-right corner at that time.

```python
from collections import deque

def swimInWater(grid):
    n = len(grid)
    
    def can_reach_bottom_right(t):
        if grid[0][0] > t:
            return False
        
        visited = set([(0, 0)])
        queue = deque([(0, 0)])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        
        while queue:
            row, col = queue.popleft()
            
            if row == n - 1 and col == n - 1:
                return True
            
            for dr, dc in directions:
                nr, nc = row + dr, col + dc
                
                if 0 <= nr < n and 0 <= nc < n and (nr, nc) not in visited and grid[nr][nc] <= t:
                    visited.add((nr, nc))
                    queue.append((nr, nc))
        
        return False
    
    # Binary search for the minimum time
    left, right = grid[0][0], n * n - 1
    
    while left < right:
        mid = (left + right) // 2
        
        if can_reach_bottom_right(mid):
            right = mid
        else:
            left = mid + 1
    
    return left
```

**Time Complexity:** O(n^2 * log(n^2)) - We perform a binary search over the possible times, which takes O(log(n^2)) iterations, and in each iteration, we run a BFS, which takes O(n^2) time.
**Space Complexity:** O(n^2) - We need to store the visited set and the queue.

### 3. Alternative Solution - Union-Find

Use the Union-Find data structure to connect cells as the water level rises.

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
            return
        
        # Union by rank
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1

def swimInWater(grid):
    n = len(grid)
    
    # Create a list of cells sorted by height
    cells = []
    for i in range(n):
        for j in range(n):
            cells.append((grid[i][j], i, j))
    
    cells.sort()
    
    # Union-Find
    uf = UnionFind(n * n)
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    
    for height, row, col in cells:
        # Connect the current cell to its adjacent cells if they have already been processed
        for dr, dc in directions:
            nr, nc = row + dr, col + dc
            
            if 0 <= nr < n and 0 <= nc < n and grid[nr][nc] <= height:
                uf.union(row * n + col, nr * n + nc)
        
        # Check if the top-left and bottom-right corners are connected
        if uf.find(0) == uf.find(n * n - 1):
            return height
    
    return -1  # Should never reach here if the grid is valid
```

**Time Complexity:** O(n^2 * log(n^2)) - We need to sort the cells, which takes O(n^2 * log(n^2)) time, and then perform Union-Find operations, which take O(n^2 * α(n^2)) time, where α is the inverse Ackermann function, which is nearly constant.
**Space Complexity:** O(n^2) - We need to store the cells and the Union-Find data structure.

## Solution Choice and Explanation

The Dijkstra's Algorithm solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n^2 * log(n^2)) time complexity, which is optimal for this problem, and the space complexity is O(n^2).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the path with the minimum maximum elevation.

The key insight of this approach is to use Dijkstra's Algorithm to find the path with the minimum maximum elevation. In Dijkstra's Algorithm, we maintain a priority queue of cells, sorted by the maximum elevation encountered so far. In each iteration, we select the cell with the smallest maximum elevation, explore its neighbors, and update their maximum elevations if a better path is found.

For example, let's trace through the algorithm for the first example:
```
grid = [[0,2],[1,3]]
```

1. Initialize:
   - visited = {(0, 0)}
   - min_heap = [(0, 0, 0)]  # (max_height, row, col)

2. Dijkstra's Algorithm:
   - Pop (0, 0, 0) from the min heap:
     - Explore neighbors of (0, 0):
       - Neighbor (0, 1): max_height = max(0, 2) = 2
         - Push (2, 0, 1) to the min heap
       - Neighbor (1, 0): max_height = max(0, 1) = 1
         - Push (1, 1, 0) to the min heap
     - min_heap = [(1, 1, 0), (2, 0, 1)]
   - Pop (1, 1, 0) from the min heap:
     - Explore neighbors of (1, 0):
       - Neighbor (1, 1): max_height = max(1, 3) = 3
         - Push (3, 1, 1) to the min heap
     - min_heap = [(2, 0, 1), (3, 1, 1)]
   - Pop (2, 0, 1) from the min heap:
     - Explore neighbors of (0, 1):
       - Neighbor (1, 1): max_height = max(2, 3) = 3
         - Already visited with a better path, so skip
     - min_heap = [(3, 1, 1)]
   - Pop (3, 1, 1) from the min heap:
     - (1, 1) is the bottom-right corner, so return max_height = 3

3. Final result: 3

The Binary Search with BFS solution (Solution 2) is also efficient and may be preferred in some cases, especially when the grid is large and the range of heights is small. The Union-Find solution (Solution 3) is elegant but may be less intuitive.

In an interview, I would first mention the Dijkstra's Algorithm solution as the most intuitive approach for this problem, and then discuss the Binary Search with BFS and Union-Find solutions as alternatives if asked for different approaches.
