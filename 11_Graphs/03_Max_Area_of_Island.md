# Max Area of Island

## Problem Statement

You are given an `m x n` binary matrix `grid`. An island is a group of `1`'s (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

The area of an island is the number of cells with a value `1` in the island.

Return the maximum area of an island in `grid`. If there is no island, return `0`.

**Example 1:**
```
Input: grid = [
  [0,0,1,0,0,0,0,1,0,0,0,0,0],
  [0,0,0,0,0,0,0,1,1,1,0,0,0],
  [0,1,1,0,1,0,0,0,0,0,0,0,0],
  [0,1,0,0,1,1,0,0,1,0,1,0,0],
  [0,1,0,0,1,1,0,0,1,1,1,0,0],
  [0,0,0,0,0,0,0,0,0,0,1,0,0],
  [0,0,0,0,0,0,0,1,1,1,0,0,0],
  [0,0,0,0,0,0,0,1,1,0,0,0,0]
]
Output: 6
Explanation: The answer is not 11, because the island must be connected 4-directionally.
```

**Example 2:**
```
Input: grid = [[0,0,0,0,0,0,0,0]]
Output: 0
```

**Constraints:**
- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 50`
- `grid[i][j]` is either `0` or `1`.

## Concept Overview

This problem is an extension of the "Number of Islands" problem, where instead of counting the number of islands, we need to find the maximum area of an island. The key insight is to use Depth-First Search (DFS) or Breadth-First Search (BFS) to explore each island and keep track of its area.

## Solutions

### 1. Best Optimized Solution - DFS

Use Depth-First Search to explore and calculate the area of each island.

```python
def maxAreaOfIsland(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    max_area = 0
    
    def dfs(i, j):
        # Check if the current cell is out of bounds or not land
        if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] != 1:
            return 0
        
        # Mark the current cell as visited
        grid[i][j] = 0
        
        # Explore all four adjacent cells and count the area
        area = 1 + dfs(i+1, j) + dfs(i-1, j) + dfs(i, j+1) + dfs(i, j-1)
        
        return area
    
    # Iterate through each cell in the grid
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                # Found a new island, explore it and update the maximum area
                max_area = max(max_area, dfs(i, j))
    
    return max_area
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - In the worst case, the recursion stack can go up to m * n levels deep (e.g., for a grid filled with land).

### 2. Alternative Solution - BFS

Use Breadth-First Search to explore and calculate the area of each island.

```python
from collections import deque

def maxAreaOfIsland(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    max_area = 0
    
    def bfs(i, j):
        # Use a queue for BFS
        queue = deque([(i, j)])
        grid[i][j] = 0  # Mark the starting cell as visited
        area = 1
        
        while queue:
            i, j = queue.popleft()
            
            # Explore all four adjacent cells
            for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                ni, nj = i + di, j + dj
                
                # Check if the adjacent cell is valid and land
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                    grid[ni][nj] = 0  # Mark the cell as visited
                    queue.append((ni, nj))
                    area += 1
        
        return area
    
    # Iterate through each cell in the grid
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                # Found a new island, explore it and update the maximum area
                max_area = max(max_area, bfs(i, j))
    
    return max_area
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(min(m, n)) - In the worst case, the queue can contain all cells in the shortest dimension of the grid.

### 3. Alternative Solution - DFS with Visited Set

Use Depth-First Search with a visited set to explore and calculate the area of each island without modifying the original grid.

```python
def maxAreaOfIsland(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    max_area = 0
    visited = set()
    
    def dfs(i, j):
        # Check if the current cell is out of bounds, already visited, or not land
        if i < 0 or i >= m or j < 0 or j >= n or (i, j) in visited or grid[i][j] != 1:
            return 0
        
        # Mark the current cell as visited
        visited.add((i, j))
        
        # Explore all four adjacent cells and count the area
        area = 1 + dfs(i+1, j) + dfs(i-1, j) + dfs(i, j+1) + dfs(i, j-1)
        
        return area
    
    # Iterate through each cell in the grid
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1 and (i, j) not in visited:
                # Found a new island, explore it and update the maximum area
                max_area = max(max_area, dfs(i, j))
    
    return max_area
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - We store each visited cell in the set.

## Solution Choice and Explanation

The DFS solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is typically O(min(m, n)) for a balanced grid.

3. **Intuitiveness**: It naturally maps to the concept of exploring an island and calculating its area.

The key insight of this approach is to use DFS to explore and calculate the area of each island. When we encounter a land cell, we start a DFS to explore all connected land cells and mark them as visited. During the DFS, we count the number of land cells, which gives us the area of the island. We keep track of the maximum area seen so far and return it at the end.

For example, let's trace through the algorithm for a simplified version of the first example:
```
[
  [0,0,1,0],
  [0,0,0,0],
  [0,1,1,0],
  [0,1,0,0]
]
```

1. Start at (0, 0): grid[0][0] = 0, skip
2. Continue to (0, 2): grid[0][2] = 1
   - Start DFS from (0, 2)
   - Mark (0, 2) as visited: grid[0][2] = 0
   - Explore (1, 2): grid[1][2] = 0, area += 0
   - Explore (-1, 2): Out of bounds, area += 0
   - Explore (0, 3): grid[0][3] = 0, area += 0
   - Explore (0, 1): grid[0][1] = 0, area += 0
   - DFS complete, area = 1
   - Update max_area = max(0, 1) = 1
3. Continue to (2, 1): grid[2][1] = 1
   - Start DFS from (2, 1)
   - Mark (2, 1) as visited: grid[2][1] = 0
   - Explore (3, 1): grid[3][1] = 1
     - Mark (3, 1) as visited: grid[3][1] = 0
     - Explore (4, 1): Out of bounds, area += 0
     - Explore (2, 1): Already visited, area += 0
     - Explore (3, 2): grid[3][2] = 0, area += 0
     - Explore (3, 0): grid[3][0] = 0, area += 0
     - DFS complete, area += 1
   - Explore (1, 1): grid[1][1] = 0, area += 0
   - Explore (2, 2): grid[2][2] = 1
     - Mark (2, 2) as visited: grid[2][2] = 0
     - Explore (3, 2): grid[3][2] = 0, area += 0
     - Explore (1, 2): grid[1][2] = 0, area += 0
     - Explore (2, 3): grid[2][3] = 0, area += 0
     - Explore (2, 1): Already visited, area += 0
     - DFS complete, area += 1
   - Explore (2, 0): grid[2][0] = 0, area += 0
   - DFS complete, area = 1 + 1 + 1 = 3
   - Update max_area = max(1, 3) = 3
4. Final result: 3

The BFS solution (Solution 2) is also efficient and may be preferred in some cases, especially when the grid is large and the recursion stack might overflow. The DFS with Visited Set solution (Solution 3) is useful when we need to preserve the original grid.

In an interview, I would first mention the DFS solution as the most intuitive approach for this problem, and then discuss the BFS and DFS with Visited Set solutions as alternatives if asked for different approaches.
