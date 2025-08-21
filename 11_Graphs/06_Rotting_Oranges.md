# Rotting Oranges

## Problem Statement

You are given an `m x n` grid where each cell can have one of three values:
- `0` representing an empty cell,
- `1` representing a fresh orange, or
- `2` representing a rotten orange.

Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.

Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return `-1`.

**Example 1:**
```
Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
Output: 4
```

**Example 2:**
```
Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
Output: -1
Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.
```

**Example 3:**
```
Input: grid = [[0,2]]
Output: 0
Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.
```

**Constraints:**
- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 10`
- `grid[i][j]` is `0`, `1`, or `2`.

## Concept Overview

This problem tests your understanding of Breadth-First Search (BFS) in a grid. The key insight is to use BFS to simulate the rotting process, starting from all initially rotten oranges and keeping track of the time it takes for each orange to rot.

## Solutions

### 1. Best Optimized Solution - BFS

Use Breadth-First Search to simulate the rotting process, starting from all initially rotten oranges.

```python
from collections import deque

def orangesRotting(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    queue = deque()
    fresh_count = 0
    
    # Count fresh oranges and add rotten oranges to the queue
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                fresh_count += 1
            elif grid[i][j] == 2:
                queue.append((i, j, 0))  # (row, col, time)
    
    # If there are no fresh oranges, return 0
    if fresh_count == 0:
        return 0
    
    # BFS to simulate the rotting process
    max_time = 0
    while queue:
        i, j, time = queue.popleft()
        max_time = max(max_time, time)
        
        # Explore all four adjacent cells
        for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            ni, nj = i + di, j + dj
            
            # Check if the adjacent cell is valid and has a fresh orange
            if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                grid[ni][nj] = 2  # Mark the orange as rotten
                fresh_count -= 1
                queue.append((ni, nj, time + 1))
    
    # If there are still fresh oranges, return -1
    if fresh_count > 0:
        return -1
    
    return max_time
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - In the worst case, the queue can contain all cells in the grid.

### 2. Alternative Solution - BFS with Level Tracking

Use Breadth-First Search with level tracking to simulate the rotting process.

```python
from collections import deque

def orangesRotting(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    queue = deque()
    fresh_count = 0
    
    # Count fresh oranges and add rotten oranges to the queue
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                fresh_count += 1
            elif grid[i][j] == 2:
                queue.append((i, j))
    
    # If there are no fresh oranges, return 0
    if fresh_count == 0:
        return 0
    
    # BFS to simulate the rotting process
    minutes = 0
    while queue and fresh_count > 0:
        size = len(queue)
        
        # Process all oranges at the current level
        for _ in range(size):
            i, j = queue.popleft()
            
            # Explore all four adjacent cells
            for di, dj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                ni, nj = i + di, j + dj
                
                # Check if the adjacent cell is valid and has a fresh orange
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                    grid[ni][nj] = 2  # Mark the orange as rotten
                    fresh_count -= 1
                    queue.append((ni, nj))
        
        minutes += 1
    
    # If there are still fresh oranges, return -1
    if fresh_count > 0:
        return -1
    
    return minutes
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - In the worst case, the queue can contain all cells in the grid.

### 3. Alternative Solution - In-place BFS

Use Breadth-First Search with in-place marking to simulate the rotting process.

```python
from collections import deque

def orangesRotting(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    fresh_count = 0
    rotten = []
    
    # Count fresh oranges and identify rotten oranges
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                fresh_count += 1
            elif grid[i][j] == 2:
                rotten.append((i, j))
    
    # If there are no fresh oranges, return 0
    if fresh_count == 0:
        return 0
    
    # BFS to simulate the rotting process
    minutes = 0
    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    
    while rotten and fresh_count > 0:
        new_rotten = []
        
        for i, j in rotten:
            for di, dj in directions:
                ni, nj = i + di, j + dj
                
                # Check if the adjacent cell is valid and has a fresh orange
                if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                    grid[ni][nj] = 2  # Mark the orange as rotten
                    fresh_count -= 1
                    new_rotten.append((ni, nj))
        
        rotten = new_rotten
        if rotten:
            minutes += 1
    
    # If there are still fresh oranges, return -1
    if fresh_count > 0:
        return -1
    
    return minutes
```

**Time Complexity:** O(m * n) - We visit each cell at most once.
**Space Complexity:** O(m * n) - In the worst case, the lists can contain all cells in the grid.

## Solution Choice and Explanation

The BFS solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(m * n).

3. **Intuitiveness**: It naturally maps to the concept of simulating the rotting process, where oranges rot in layers (or levels) over time.

The key insight of this approach is to use BFS to simulate the rotting process, starting from all initially rotten oranges and keeping track of the time it takes for each orange to rot. We also need to count the number of fresh oranges at the beginning and decrement this count as oranges rot. If there are still fresh oranges after the BFS, it means some oranges can never rot, so we return -1.

For example, let's trace through the algorithm for the first example:
```
[
  [2,1,1],
  [1,1,0],
  [0,1,1]
]
```

1. Count fresh oranges and add rotten oranges to the queue:
   - Fresh count = 6
   - Queue = [(0, 0, 0)]  # (row, col, time)

2. BFS to simulate the rotting process:
   - Dequeue (0, 0, 0):
     - Explore (1, 0): grid[1][0] = 1, mark as rotten, fresh count = 5, enqueue (1, 0, 1)
     - Explore (0, 1): grid[0][1] = 1, mark as rotten, fresh count = 4, enqueue (0, 1, 1)
   - Dequeue (1, 0, 1):
     - Explore (2, 0): grid[2][0] = 0, skip
     - Explore (1, 1): grid[1][1] = 1, mark as rotten, fresh count = 3, enqueue (1, 1, 2)
   - Dequeue (0, 1, 1):
     - Explore (0, 2): grid[0][2] = 1, mark as rotten, fresh count = 2, enqueue (0, 2, 2)
   - Dequeue (1, 1, 2):
     - Explore (2, 1): grid[2][1] = 1, mark as rotten, fresh count = 1, enqueue (2, 1, 3)
   - Dequeue (0, 2, 2):
     - No valid adjacent fresh oranges
   - Dequeue (2, 1, 3):
     - Explore (2, 2): grid[2][2] = 1, mark as rotten, fresh count = 0, enqueue (2, 2, 4)
   - Dequeue (2, 2, 4):
     - No valid adjacent fresh oranges
   - Max time = 4

3. Final result: 4

The BFS with Level Tracking solution (Solution 2) is also efficient and may be preferred in some cases, as it more explicitly tracks the minutes. The In-place BFS solution (Solution 3) is similar but uses lists instead of a queue.

In an interview, I would first mention the BFS solution as the most intuitive approach for this problem, and then discuss the BFS with Level Tracking and In-place BFS solutions as alternatives if asked for different approaches.
