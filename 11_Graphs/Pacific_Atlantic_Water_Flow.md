# Pacific Atlantic Water Flow

## Problem Statement

There is an `m x n` rectangular island that borders both the Pacific Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left and top edges, and the Atlantic Ocean touches the island's right and bottom edges.

The island is partitioned into a grid of square cells. You are given an `m x n` integer matrix `heights` where `heights[r][c]` represents the height above sea level of the cell at coordinate `(r, c)`.

The island receives a lot of rain, and the rain water can flow to neighboring cells directly north, south, east, and west if the neighboring cell's height is less than or equal to the current cell's height. Water can flow from any cell adjacent to an ocean into the ocean.

Return a 2D list of grid coordinates `result` where `result[i] = [ri, ci]` denotes that rain water can flow from cell `(ri, ci)` to both the Pacific and Atlantic oceans.

**Example 1:**
```
Input: heights = [
  [1,2,2,3,5],
  [3,2,3,4,4],
  [2,4,5,3,1],
  [6,7,1,4,5],
  [5,1,1,2,4]
]
Output: [[0,4],[1,3],[1,4],[2,2],[3,0],[3,1],[4,0]]
```

**Example 2:**
```
Input: heights = [
  [2,1],
  [1,2]
]
Output: [[0,0],[0,1],[1,0],[1,1]]
```

**Constraints:**
- `m == heights.length`
- `n == heights[r].length`
- `1 <= m, n <= 200`
- `0 <= heights[r][c] <= 10^5`

## Concept Overview

This problem tests your understanding of graph traversal, particularly Depth-First Search (DFS) or Breadth-First Search (BFS). The key insight is to approach the problem from the oceans' perspective: start from the cells adjacent to each ocean and work inward, marking cells that can be reached from each ocean. Then, find the cells that can be reached from both oceans.

## Solutions

### 1. Best Optimized Solution - DFS from Oceans

Use Depth-First Search to mark cells that can be reached from each ocean, then find the intersection.

```python
def pacificAtlantic(heights):
    if not heights or not heights[0]:
        return []
    
    m, n = len(heights), len(heights[0])
    pacific_reachable = set()
    atlantic_reachable = set()
    
    def dfs(i, j, reachable):
        # Mark the current cell as reachable
        reachable.add((i, j))
        
        # Explore all four adjacent cells
        for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            ni, nj = i + di, j + dj
            
            # Check if the adjacent cell is valid and has not been visited
            if (0 <= ni < m and 0 <= nj < n and
                (ni, nj) not in reachable and
                heights[ni][nj] >= heights[i][j]):
                dfs(ni, nj, reachable)
    
    # DFS from the Pacific Ocean (top and left edges)
    for i in range(m):
        dfs(i, 0, pacific_reachable)
    for j in range(n):
        dfs(0, j, pacific_reachable)
    
    # DFS from the Atlantic Ocean (bottom and right edges)
    for i in range(m):
        dfs(i, n - 1, atlantic_reachable)
    for j in range(n):
        dfs(m - 1, j, atlantic_reachable)
    
    # Find the intersection of the two sets
    return list(pacific_reachable.intersection(atlantic_reachable))
```

**Time Complexity:** O(m * n) - We visit each cell at most twice (once from each ocean).
**Space Complexity:** O(m * n) - We store the reachable cells for each ocean.

### 2. Alternative Solution - BFS from Oceans

Use Breadth-First Search to mark cells that can be reached from each ocean, then find the intersection.

```python
from collections import deque

def pacificAtlantic(heights):
    if not heights or not heights[0]:
        return []
    
    m, n = len(heights), len(heights[0])
    pacific_reachable = set()
    atlantic_reachable = set()
    
    def bfs(queue, reachable):
        while queue:
            i, j = queue.popleft()
            
            # Explore all four adjacent cells
            for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                ni, nj = i + di, j + dj
                
                # Check if the adjacent cell is valid and has not been visited
                if (0 <= ni < m and 0 <= nj < n and
                    (ni, nj) not in reachable and
                    heights[ni][nj] >= heights[i][j]):
                    reachable.add((ni, nj))
                    queue.append((ni, nj))
    
    # BFS from the Pacific Ocean (top and left edges)
    pacific_queue = deque()
    for i in range(m):
        pacific_queue.append((i, 0))
        pacific_reachable.add((i, 0))
    for j in range(1, n):
        pacific_queue.append((0, j))
        pacific_reachable.add((0, j))
    bfs(pacific_queue, pacific_reachable)
    
    # BFS from the Atlantic Ocean (bottom and right edges)
    atlantic_queue = deque()
    for i in range(m):
        atlantic_queue.append((i, n - 1))
        atlantic_reachable.add((i, n - 1))
    for j in range(n - 1):
        atlantic_queue.append((m - 1, j))
        atlantic_reachable.add((m - 1, j))
    bfs(atlantic_queue, atlantic_reachable)
    
    # Find the intersection of the two sets
    return list(pacific_reachable.intersection(atlantic_reachable))
```

**Time Complexity:** O(m * n) - We visit each cell at most twice (once from each ocean).
**Space Complexity:** O(m * n) - We store the reachable cells for each ocean and the queues.

### 3. Alternative Solution - Matrix Marking

Use two matrices to mark cells that can be reached from each ocean, then find the intersection.

```python
def pacificAtlantic(heights):
    if not heights or not heights[0]:
        return []
    
    m, n = len(heights), len(heights[0])
    pacific = [[False] * n for _ in range(m)]
    atlantic = [[False] * n for _ in range(m)]
    
    def dfs(i, j, reachable):
        # Mark the current cell as reachable
        reachable[i][j] = True
        
        # Explore all four adjacent cells
        for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            ni, nj = i + di, j + dj
            
            # Check if the adjacent cell is valid and has not been visited
            if (0 <= ni < m and 0 <= nj < n and
                not reachable[ni][nj] and
                heights[ni][nj] >= heights[i][j]):
                dfs(ni, nj, reachable)
    
    # DFS from the Pacific Ocean (top and left edges)
    for i in range(m):
        dfs(i, 0, pacific)
    for j in range(n):
        dfs(0, j, pacific)
    
    # DFS from the Atlantic Ocean (bottom and right edges)
    for i in range(m):
        dfs(i, n - 1, atlantic)
    for j in range(n):
        dfs(m - 1, j, atlantic)
    
    # Find the intersection of the two matrices
    result = []
    for i in range(m):
        for j in range(n):
            if pacific[i][j] and atlantic[i][j]:
                result.append([i, j])
    
    return result
```

**Time Complexity:** O(m * n) - We visit each cell at most twice (once from each ocean).
**Space Complexity:** O(m * n) - We store the reachable cells for each ocean in two matrices.

## Solution Choice and Explanation

The DFS from Oceans solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(m * n).

3. **Intuitiveness**: It naturally maps to the concept of water flowing from the oceans inward.

The key insight of this approach is to think of the problem from the oceans' perspective: instead of trying to determine if water can flow from each cell to both oceans, we start from the cells adjacent to each ocean and work inward, marking cells that can be reached from each ocean. Then, we find the intersection of these two sets to get the cells that can be reached from both oceans.

For example, let's trace through the algorithm for a simplified version of the first example:
```
[
  [1,2,3],
  [8,9,4],
  [7,6,5]
]
```

1. DFS from the Pacific Ocean (top and left edges):
   - Start from (0, 0): heights[0][0] = 1
     - Mark (0, 0) as Pacific-reachable
     - Explore (1, 0): heights[1][0] = 8 >= heights[0][0] = 1, so mark (1, 0) as Pacific-reachable
       - Explore (2, 0): heights[2][0] = 7 < heights[1][0] = 8, so mark (2, 0) as Pacific-reachable
         - Explore (2, 1): heights[2][1] = 6 < heights[2][0] = 7, so mark (2, 1) as Pacific-reachable
           - Explore (1, 1): heights[1][1] = 9 >= heights[2][1] = 6, so mark (1, 1) as Pacific-reachable
             - Explore (0, 1): heights[0][1] = 2 < heights[1][1] = 9, so mark (0, 1) as Pacific-reachable
               - Explore (0, 2): heights[0][2] = 3 >= heights[0][1] = 2, so mark (0, 2) as Pacific-reachable
                 - Explore (1, 2): heights[1][2] = 4 >= heights[0][2] = 3, so mark (1, 2) as Pacific-reachable
                   - Explore (2, 2): heights[2][2] = 5 >= heights[1][2] = 4, so mark (2, 2) as Pacific-reachable
   - Pacific-reachable = {(0, 0), (1, 0), (2, 0), (2, 1), (1, 1), (0, 1), (0, 2), (1, 2), (2, 2)}

2. DFS from the Atlantic Ocean (bottom and right edges):
   - Start from (2, 2): heights[2][2] = 5
     - Mark (2, 2) as Atlantic-reachable
     - Explore (1, 2): heights[1][2] = 4 < heights[2][2] = 5, so mark (1, 2) as Atlantic-reachable
       - Explore (0, 2): heights[0][2] = 3 < heights[1][2] = 4, so mark (0, 2) as Atlantic-reachable
     - Explore (2, 1): heights[2][1] = 6 >= heights[2][2] = 5, so mark (2, 1) as Atlantic-reachable
       - Explore (1, 1): heights[1][1] = 9 >= heights[2][1] = 6, so mark (1, 1) as Atlantic-reachable
         - Explore (0, 1): heights[0][1] = 2 < heights[1][1] = 9, so mark (0, 1) as Atlantic-reachable
   - Atlantic-reachable = {(2, 2), (1, 2), (0, 2), (2, 1), (1, 1), (0, 1)}

3. Intersection of Pacific-reachable and Atlantic-reachable:
   - {(0, 1), (0, 2), (1, 1), (1, 2), (2, 1), (2, 2)}

4. Final result: [[0, 1], [0, 2], [1, 1], [1, 2], [2, 1], [2, 2]]

The BFS from Oceans solution (Solution 2) is also efficient and may be preferred in some cases, especially when the grid is large and the recursion stack might overflow. The Matrix Marking solution (Solution 3) is similar to Solution 1 but uses matrices instead of sets to mark reachable cells.

In an interview, I would first mention the DFS from Oceans solution as the most intuitive approach for this problem, and then discuss the BFS and Matrix Marking solutions as alternatives if asked for different approaches.
