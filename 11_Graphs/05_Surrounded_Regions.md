# Surrounded Regions

## Problem Statement

Given an `m x n` matrix `board` containing `'X'` and `'O'`, capture all regions that are 4-directionally surrounded by `'X'`.

A region is captured by flipping all `'O'`s into `'X'`s in that surrounded region.

**Example 1:**
```
Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
Explanation: Surrounded regions should not be on the border, which means that any 'O' on the border of the board are not flipped to 'X'. Any 'O' that is not on the border and it is not connected to an 'O' on the border will be flipped to 'X'. Two cells are connected if they are adjacent cells connected horizontally or vertically.
```

**Example 2:**
```
Input: board = [["X"]]
Output: [["X"]]
```

**Constraints:**
- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 200`
- `board[i][j]` is `'X'` or `'O'`.

## Concept Overview

This problem tests your understanding of graph traversal, particularly Depth-First Search (DFS) or Breadth-First Search (BFS). The key insight is that any 'O' that is not captured must be connected to a 'O' on the border of the board. So we can start from the border 'O's and mark all connected 'O's as safe, then flip all remaining 'O's to 'X's.

## Solutions

### 1. Best Optimized Solution - DFS from Border

Use Depth-First Search to mark all 'O's connected to the border, then flip all unmarked 'O's to 'X's.

```python
def solve(board):
    if not board or not board[0]:
        return
    
    m, n = len(board), len(board[0])
    
    def dfs(i, j):
        # Check if the current cell is out of bounds or not 'O'
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] != 'O':
            return
        
        # Mark the current cell as visited
        board[i][j] = 'E'  # 'E' for "Escape"
        
        # Explore all four adjacent cells
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    
    # Mark all 'O's connected to the border
    for i in range(m):
        dfs(i, 0)
        dfs(i, n-1)
    for j in range(n):
        dfs(0, j)
        dfs(m-1, j)
    
    # Flip all unmarked 'O's to 'X's and restore marked 'O's
    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O':
                board[i][j] = 'X'
            elif board[i][j] == 'E':
                board[i][j] = 'O'
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - In the worst case, the recursion stack can go up to m * n levels deep (e.g., for a grid filled with 'O's).

### 2. Alternative Solution - BFS from Border

Use Breadth-First Search to mark all 'O's connected to the border, then flip all unmarked 'O's to 'X's.

```python
from collections import deque

def solve(board):
    if not board or not board[0]:
        return
    
    m, n = len(board), len(board[0])
    queue = deque()
    
    # Add all 'O's on the border to the queue
    for i in range(m):
        if board[i][0] == 'O':
            queue.append((i, 0))
            board[i][0] = 'E'
        if board[i][n-1] == 'O':
            queue.append((i, n-1))
            board[i][n-1] = 'E'
    for j in range(n):
        if board[0][j] == 'O':
            queue.append((0, j))
            board[0][j] = 'E'
        if board[m-1][j] == 'O':
            queue.append((m-1, j))
            board[m-1][j] = 'E'
    
    # BFS to mark all 'O's connected to the border
    while queue:
        i, j = queue.popleft()
        
        # Explore all four adjacent cells
        for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            ni, nj = i + di, j + dj
            
            # Check if the adjacent cell is valid and 'O'
            if 0 <= ni < m and 0 <= nj < n and board[ni][nj] == 'O':
                board[ni][nj] = 'E'
                queue.append((ni, nj))
    
    # Flip all unmarked 'O's to 'X's and restore marked 'O's
    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O':
                board[i][j] = 'X'
            elif board[i][j] == 'E':
                board[i][j] = 'O'
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(min(m, n)) - In the worst case, the queue can contain all cells in the shortest dimension of the grid.

### 3. Alternative Solution - Union-Find

Use the Union-Find (Disjoint Set) data structure to group connected 'O's and determine which ones are connected to the border.

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

def solve(board):
    if not board or not board[0]:
        return
    
    m, n = len(board), len(board[0])
    uf = UnionFind(m * n + 1)  # +1 for a dummy node representing the border
    dummy = m * n
    
    # Connect all 'O's on the border to the dummy node
    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O':
                idx = i * n + j
                
                # If on the border, connect to the dummy node
                if i == 0 or i == m-1 or j == 0 or j == n-1:
                    uf.union(idx, dummy)
                
                # Connect to adjacent 'O's
                for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                    ni, nj = i + di, j + dj
                    
                    if 0 <= ni < m and 0 <= nj < n and board[ni][nj] == 'O':
                        uf.union(idx, ni * n + nj)
    
    # Flip all 'O's not connected to the border
    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O' and uf.find(i * n + j) != uf.find(dummy):
                board[i][j] = 'X'
```

**Time Complexity:** O(m * n * α(m * n)) - We perform Union-Find operations for each cell, where α is the inverse Ackermann function, which is nearly constant.
**Space Complexity:** O(m * n) - We need to store the parent and rank arrays for the Union-Find data structure.

## Solution Choice and Explanation

The DFS from Border solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is typically O(min(m, n)) for a balanced grid.

3. **Intuitiveness**: It naturally maps to the concept of identifying 'O's that are connected to the border.

The key insight of this approach is to start from the border 'O's and mark all connected 'O's as safe, then flip all remaining 'O's to 'X's. This is because any 'O' that is not captured must be connected to a 'O' on the border of the board.

For example, let's trace through the algorithm for the first example:
```
[
  ["X","X","X","X"],
  ["X","O","O","X"],
  ["X","X","O","X"],
  ["X","O","X","X"]
]
```

1. Mark all 'O's connected to the border:
   - Start from (3, 1): board[3][1] = 'O'
     - Mark (3, 1) as 'E'
     - Explore adjacent cells...
   - No other 'O's on the border

2. Flip all unmarked 'O's to 'X's and restore marked 'O's:
   - (1, 1): board[1][1] = 'O' -> 'X'
   - (1, 2): board[1][2] = 'O' -> 'X'
   - (2, 2): board[2][2] = 'O' -> 'X'
   - (3, 1): board[3][1] = 'E' -> 'O'

3. Final result:
```
[
  ["X","X","X","X"],
  ["X","X","X","X"],
  ["X","X","X","X"],
  ["X","O","X","X"]
]
```

The BFS from Border solution (Solution 2) is also efficient and may be preferred in some cases, especially when the grid is large and the recursion stack might overflow. The Union-Find solution (Solution 3) is more complex but can be useful for dynamic problems where the grid changes over time.

In an interview, I would first mention the DFS from Border solution as the most intuitive approach for this problem, and then discuss the BFS and Union-Find solutions as alternatives if asked for different approaches.
