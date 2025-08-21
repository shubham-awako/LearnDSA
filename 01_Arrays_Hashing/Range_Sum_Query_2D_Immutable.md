# Range Sum Query 2D - Immutable

## Problem Statement

Given a 2D matrix `matrix`, handle multiple queries of the following type:

- Calculate the sum of the elements of `matrix` inside the rectangle defined by its upper left corner `(row1, col1)` and lower right corner `(row2, col2)`.

Implement the `NumMatrix` class:

- `NumMatrix(int[][] matrix)` Initializes the object with the integer matrix `matrix`.
- `int sumRegion(int row1, int col1, int row2, int col2)` Returns the sum of the elements of `matrix` inside the rectangle defined by its upper left corner `(row1, col1)` and lower right corner `(row2, col2)`.

**Example 1:**
```
Input
["NumMatrix", "sumRegion", "sumRegion", "sumRegion"]
[[[[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]], [2, 1, 4, 3], [1, 1, 2, 2], [1, 2, 2, 4]]
Output
[null, 8, 11, 12]

Explanation
NumMatrix numMatrix = new NumMatrix([[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]);
numMatrix.sumRegion(2, 1, 4, 3); // return 8 (i.e sum of the red rectangle)
numMatrix.sumRegion(1, 1, 2, 2); // return 11 (i.e sum of the green rectangle)
numMatrix.sumRegion(1, 2, 2, 4); // return 12 (i.e sum of the blue rectangle)
```

**Constraints:**
- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 200`
- `-10^5 <= matrix[i][j] <= 10^5`
- `0 <= row1 <= row2 < m`
- `0 <= col1 <= col2 < n`
- At most `10^4` calls will be made to `sumRegion`.

## Concept Overview

This problem tests your ability to efficiently compute the sum of elements in a 2D submatrix. The key insight is to precompute cumulative sums to avoid redundant calculations across multiple queries.

## Solutions

### 1. Brute Force Approach

Calculate the sum by iterating through all elements in the specified rectangle for each query.

```python
class NumMatrix:
    def __init__(self, matrix):
        self.matrix = matrix
        
    def sumRegion(self, row1, col1, row2, col2):
        sum_val = 0
        for i in range(row1, row2 + 1):
            for j in range(col1, col2 + 1):
                sum_val += self.matrix[i][j]
        return sum_val
```

**Time Complexity:** 
- Initialization: O(1)
- Query: O((row2-row1+1) * (col2-col1+1)) - We iterate through all elements in the rectangle.

**Space Complexity:** O(1) - No extra space is used beyond the input matrix.

### 2. Improved Solution - Row-wise Prefix Sums

Precompute row-wise prefix sums to speed up queries.

```python
class NumMatrix:
    def __init__(self, matrix):
        if not matrix or not matrix[0]:
            return
        
        m, n = len(matrix), len(matrix[0])
        self.row_sums = [[0] * (n + 1) for _ in range(m)]
        
        for i in range(m):
            for j in range(n):
                self.row_sums[i][j + 1] = self.row_sums[i][j] + matrix[i][j]
        
    def sumRegion(self, row1, col1, row2, col2):
        sum_val = 0
        for i in range(row1, row2 + 1):
            sum_val += self.row_sums[i][col2 + 1] - self.row_sums[i][col1]
        return sum_val
```

**Time Complexity:** 
- Initialization: O(m * n) - We precompute row-wise prefix sums.
- Query: O(row2 - row1 + 1) - We iterate through the rows in the rectangle.

**Space Complexity:** O(m * n) - We store row-wise prefix sums.

### 3. Best Optimized Solution - 2D Prefix Sums

Precompute 2D prefix sums to achieve constant-time queries.

```python
class NumMatrix:
    def __init__(self, matrix):
        if not matrix or not matrix[0]:
            return
        
        m, n = len(matrix), len(matrix[0])
        # dp[i][j] represents the sum of all elements in the rectangle from (0,0) to (i-1,j-1)
        self.dp = [[0] * (n + 1) for _ in range(m + 1)]
        
        for i in range(m):
            for j in range(n):
                self.dp[i + 1][j + 1] = self.dp[i + 1][j] + self.dp[i][j + 1] - self.dp[i][j] + matrix[i][j]
        
    def sumRegion(self, row1, col1, row2, col2):
        return self.dp[row2 + 1][col2 + 1] - self.dp[row2 + 1][col1] - self.dp[row1][col2 + 1] + self.dp[row1][col1]
```

**Time Complexity:** 
- Initialization: O(m * n) - We precompute 2D prefix sums.
- Query: O(1) - Constant time for each query.

**Space Complexity:** O(m * n) - We store 2D prefix sums.

## Solution Choice and Explanation

The 2D prefix sums solution (Solution 3) is the best approach for this problem because:

1. **Optimal Query Time**: It achieves O(1) time complexity for each query, which is crucial when there are many queries (up to 10^4 as per the constraints).

2. **Reasonable Preprocessing Time**: The O(m * n) preprocessing time is acceptable since it's done only once during initialization.

3. **Space-Time Tradeoff**: While it uses O(m * n) extra space, this is a reasonable tradeoff for the significant improvement in query time.

The key insight of the 2D prefix sums approach is to precompute the sum of all elements in the rectangle from (0,0) to (i,j) for all possible (i,j). Then, to find the sum of a specific rectangle, we can use the inclusion-exclusion principle:

```
sum(row1, col1, row2, col2) = dp[row2+1][col2+1] - dp[row2+1][col1] - dp[row1][col2+1] + dp[row1][col1]
```

This formula works because:
- `dp[row2+1][col2+1]` includes the entire rectangle from (0,0) to (row2,col2)
- We subtract `dp[row2+1][col1]` to remove the rectangle from (0,0) to (row2,col1-1)
- We subtract `dp[row1][col2+1]` to remove the rectangle from (0,0) to (row1-1,col2)
- We add back `dp[row1][col1]` because it was subtracted twice

The row-wise prefix sums solution (Solution 2) is a good intermediate approach but still requires O(row2-row1+1) time for each query, which can be slow for large rectangles.

The brute force approach (Solution 1) is simple but inefficient for multiple queries, especially for large rectangles.

In an interview, I would first mention the brute force approach to establish a baseline, then explain the 2D prefix sums approach as the optimal solution for this problem.
