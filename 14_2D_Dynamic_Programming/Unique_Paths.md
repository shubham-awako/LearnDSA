# Unique Paths

## Problem Statement

A robot is located at the top-left corner of a `m x n` grid (marked 'Start' in the diagram below).

The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

How many possible unique paths are there?

**Example 1:**
```
Input: m = 3, n = 7
Output: 28
```

**Example 2:**
```
Input: m = 3, n = 2
Output: 3
Explanation:
From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
1. Right -> Down -> Down
2. Down -> Down -> Right
3. Down -> Right -> Down
```

**Constraints:**
- `1 <= m, n <= 100`
- It's guaranteed that the answer will be less than or equal to `2 * 10^9`.

## Concept Overview

This problem is a classic example of 2D dynamic programming. The key insight is to recognize that the number of unique paths to reach a cell (i, j) is the sum of the number of unique paths to reach the cell above it (i-1, j) and the cell to the left of it (i, j-1). This is because the robot can only move down or right.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def uniquePaths(m, n):
    # Initialize a 1D array to represent the current row
    dp = [1] * n
    
    # Fill the dp array row by row
    for i in range(1, m):
        for j in range(1, n):
            dp[j] += dp[j - 1]
    
    return dp[n - 1]
```

**Time Complexity:** O(m * n) - We iterate through each cell in the grid.
**Space Complexity:** O(n) - We only use a 1D array to store the number of unique paths for the current row.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def uniquePaths(m, n):
    # Initialize a 2D array to represent the number of unique paths to each cell
    dp = [[1] * n for _ in range(m)]
    
    # Fill the dp array
    for i in range(1, m):
        for j in range(1, n):
            dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
    
    return dp[m - 1][n - 1]
```

**Time Complexity:** O(m * n) - We iterate through each cell in the grid.
**Space Complexity:** O(m * n) - We use a 2D array to store the number of unique paths to each cell.

### 3. Alternative Solution - Mathematical Combination

Use mathematical combination to solve the problem.

```python
import math

def uniquePaths(m, n):
    # The robot needs to move m-1 steps down and n-1 steps right
    # So the total number of steps is (m-1) + (n-1) = m+n-2
    # The number of unique paths is the number of ways to choose m-1 steps down from m+n-2 steps
    # This is equivalent to the combination C(m+n-2, m-1)
    return math.comb(m + n - 2, m - 1)
```

**Time Complexity:** O(min(m, n)) - The time complexity of the math.comb function.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(n), which is better than the O(m * n) space complexity of the tabulation solution.

2. **Simplicity**: It's a straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the number of unique paths to each cell.

The key insight of this approach is to recognize that the number of unique paths to reach a cell (i, j) is the sum of the number of unique paths to reach the cell above it (i-1, j) and the cell to the left of it (i, j-1). This is because the robot can only move down or right. We can optimize the space complexity by using a 1D array to store the number of unique paths for the current row, updating it as we go.

For example, let's trace through the algorithm for m = 3, n = 7:

1. Initialize dp = [1, 1, 1, 1, 1, 1, 1]

2. Iterate through the grid:
   - i = 1, j = 1: dp[1] += dp[0] = 1 + 1 = 2
   - i = 1, j = 2: dp[2] += dp[1] = 1 + 2 = 3
   - i = 1, j = 3: dp[3] += dp[2] = 1 + 3 = 4
   - i = 1, j = 4: dp[4] += dp[3] = 1 + 4 = 5
   - i = 1, j = 5: dp[5] += dp[4] = 1 + 5 = 6
   - i = 1, j = 6: dp[6] += dp[5] = 1 + 6 = 7
   - dp = [1, 2, 3, 4, 5, 6, 7]
   - i = 2, j = 1: dp[1] += dp[0] = 2 + 1 = 3
   - i = 2, j = 2: dp[2] += dp[1] = 3 + 3 = 6
   - i = 2, j = 3: dp[3] += dp[2] = 4 + 6 = 10
   - i = 2, j = 4: dp[4] += dp[3] = 5 + 10 = 15
   - i = 2, j = 5: dp[5] += dp[4] = 6 + 15 = 21
   - i = 2, j = 6: dp[6] += dp[5] = 7 + 21 = 28
   - dp = [1, 3, 6, 10, 15, 21, 28]

3. Return dp[n - 1] = dp[6] = 28

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Mathematical Combination solution (Solution 3) is the most elegant and has the best time and space complexity, but it may be less intuitive for some people and could potentially lead to integer overflow for large inputs.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most intuitive approach for this problem, and then discuss the Mathematical Combination solution as a more elegant alternative if asked for different approaches.
