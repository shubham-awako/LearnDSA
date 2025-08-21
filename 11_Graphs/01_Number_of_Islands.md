# Number of Islands

## Problem Statement

Given an `m x n` 2D binary grid `grid` which represents a map of `'1'`s (land) and `'0'`s (water), return the number of islands.

An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

**Example 1:**
```
Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
Output: 1
```

**Example 2:**
```
Input: grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
Output: 3
```

**Constraints:**
- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 300`
- `grid[i][j]` is `'0'` or `'1'`.

## Concept Overview

This problem tests your understanding of graph traversal algorithms, particularly Depth-First Search (DFS) or Breadth-First Search (BFS). The key insight is to treat the grid as a graph, where each land cell is a vertex and adjacent land cells are connected by edges.

## Solutions

### 1. Best Optimized Solution - DFS

Use Depth-First Search to explore and mark all land cells in an island.

```python
def numIslands(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    count = 0
    
    def dfs(i, j):
        # Check if the current cell is out of bounds or not land
        if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] != '1':
            return
        
        # Mark the current cell as visited
        grid[i][j] = '#'
        
        # Explore all four adjacent cells
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    
    # Iterate through each cell in the grid
    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1':
                # Found a new island, explore it
                dfs(i, j)
                count += 1
    
    return count
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - In the worst case, the recursion stack can go up to m * n levels deep (e.g., for a grid filled with land).

### 2. Alternative Solution - BFS

Use Breadth-First Search to explore and mark all land cells in an island.

```python
from collections import deque

def numIslands(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    count = 0
    
    def bfs(i, j):
        # Use a queue for BFS
        queue = deque([(i, j)])
        grid[i][j] = '#'  # Mark the starting cell as visited
        
        while queue:
            i, j = queue.popleft()
            
            # Explore all four adjacent cells
            for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                ni, nj = i + di, j + dj
                
                # Check if the adjacent cell is valid and land
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == '1':
                    grid[ni][nj] = '#'  # Mark the cell as visited
                    queue.append((ni, nj))
    
    # Iterate through each cell in the grid
    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1':
                # Found a new island, explore it
                bfs(i, j)
                count += 1
    
    return count
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(min(m, n)) - In the worst case, the queue can contain all cells in the shortest dimension of the grid.

### 3. Alternative Solution - Union-Find

Use the Union-Find (Disjoint Set) data structure to group connected land cells.

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
        self.count = 0
    
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
        
        self.count -= 1
    
    def set_count(self, count):
        self.count = count

def numIslands(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    uf = UnionFind(m * n)
    
    # Count the number of land cells
    land_count = 0
    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1':
                land_count += 1
    
    uf.set_count(land_count)
    
    # Union adjacent land cells
    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1':
                # Convert 2D coordinates to 1D index
                idx = i * n + j
                
                # Check right neighbor
                if j + 1 < n and grid[i][j+1] == '1':
                    uf.union(idx, idx + 1)
                
                # Check bottom neighbor
                if i + 1 < m and grid[i+1][j] == '1':
                    uf.union(idx, idx + n)
    
    return uf.count
```

**Time Complexity:** O(m * n * α(m * n)) - We perform Union-Find operations for each cell, where α is the inverse Ackermann function, which is nearly constant.
**Space Complexity:** O(m * n) - We need to store the parent and rank arrays for the Union-Find data structure.

## Solution Choice and Explanation

The DFS solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is typically O(min(m, n)) for a balanced grid.

3. **Intuitiveness**: It naturally maps to the concept of exploring an island by visiting all connected land cells.

The key insight of this approach is to use DFS to explore and mark all land cells in an island. When we encounter a land cell, we start a DFS to explore all connected land cells and mark them as visited. After the DFS completes, we've explored one island, so we increment the count. We continue this process for all unvisited land cells in the grid.

For example, let's trace through the algorithm for the second example:
```
[
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
```

1. Start at (0, 0): grid[0][0] = '1'
   - Start DFS from (0, 0)
   - Mark (0, 0) as visited: grid[0][0] = '#'
   - Explore (1, 0): grid[1][0] = '1'
     - Mark (1, 0) as visited: grid[1][0] = '#'
     - Explore (2, 0): grid[2][0] = '0', skip
     - Explore (0, 0): Already visited, skip
     - Explore (1, 1): grid[1][1] = '1'
       - Mark (1, 1) as visited: grid[1][1] = '#'
       - Explore (2, 1): grid[2][1] = '0', skip
       - Explore (0, 1): grid[0][1] = '1'
         - Mark (0, 1) as visited: grid[0][1] = '#'
         - Explore (1, 1): Already visited, skip
         - Explore (0, 0): Already visited, skip
         - Explore (0, 2): grid[0][2] = '0', skip
       - Explore (1, 2): grid[1][2] = '0', skip
     - Explore (1, -1): Out of bounds, skip
   - Explore (-1, 0): Out of bounds, skip
   - Explore (0, 1): Already visited, skip
   - Explore (0, -1): Out of bounds, skip
   - DFS complete, increment count: count = 1
2. Continue to (0, 1): grid[0][1] = '#', skip
3. Continue to (0, 2): grid[0][2] = '0', skip
4. Continue to (2, 2): grid[2][2] = '1'
   - Start DFS from (2, 2)
   - Mark (2, 2) as visited: grid[2][2] = '#'
   - Explore adjacent cells...
   - DFS complete, increment count: count = 2
5. Continue to (3, 3): grid[3][3] = '1'
   - Start DFS from (3, 3)
   - Mark (3, 3) as visited: grid[3][3] = '#'
   - Explore (4, 3): Out of bounds, skip
   - Explore (2, 3): grid[2][3] = '0', skip
   - Explore (3, 4): grid[3][4] = '1'
     - Mark (3, 4) as visited: grid[3][4] = '#'
     - Explore adjacent cells...
   - Explore (3, 2): grid[3][2] = '0', skip
   - DFS complete, increment count: count = 3
6. Final result: 3 islands

The BFS solution (Solution 2) is also efficient and may be preferred in some cases, especially when the grid is large and the recursion stack might overflow. The Union-Find solution (Solution 3) is more complex but can be useful for dynamic problems where the grid changes over time.

In an interview, I would first mention the DFS solution as the most intuitive approach for this problem, and then discuss the BFS and Union-Find solutions as alternatives if asked for different approaches.
