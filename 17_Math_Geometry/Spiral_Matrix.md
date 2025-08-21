# Spiral Matrix

## Problem Statement

Given an `m x n` matrix, return all elements of the matrix in spiral order.

**Example 1:**
```
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,3,6,9,8,7,4,5]
```

**Example 2:**
```
Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
Output: [1,2,3,4,8,12,11,10,9,5,6,7]
```

**Constraints:**
- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 10`
- `-100 <= matrix[i][j] <= 100`

## Concept Overview

This problem involves traversing a matrix in a spiral pattern. The key insight is to define the boundaries of the spiral and update them as we traverse the matrix.

## Solutions

### 1. Best Optimized Solution - Boundary Traversal

Define the boundaries of the spiral and update them as we traverse the matrix.

```python
def spiralOrder(matrix):
    if not matrix:
        return []
    
    result = []
    rows, cols = len(matrix), len(matrix[0])
    top, bottom = 0, rows - 1
    left, right = 0, cols - 1
    
    while top <= bottom and left <= right:
        # Traverse right
        for j in range(left, right + 1):
            result.append(matrix[top][j])
        top += 1
        
        # Traverse down
        for i in range(top, bottom + 1):
            result.append(matrix[i][right])
        right -= 1
        
        # Traverse left
        if top <= bottom:
            for j in range(right, left - 1, -1):
                result.append(matrix[bottom][j])
            bottom -= 1
        
        # Traverse up
        if left <= right:
            for i in range(bottom, top - 1, -1):
                result.append(matrix[i][left])
            left += 1
    
    return result
```

**Time Complexity:** O(m * n) - We visit each cell of the matrix once.
**Space Complexity:** O(1) - We only use a constant amount of extra space (excluding the output array).

### 2. Alternative Solution - Direction Array

Use a direction array to traverse the matrix in a spiral pattern.

```python
def spiralOrder(matrix):
    if not matrix:
        return []
    
    rows, cols = len(matrix), len(matrix[0])
    visited = [[False for _ in range(cols)] for _ in range(rows)]
    result = []
    
    # Define the four directions: right, down, left, up
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    direction_idx = 0
    
    row, col = 0, 0
    for _ in range(rows * cols):
        result.append(matrix[row][col])
        visited[row][col] = True
        
        # Calculate the next position
        next_row = row + directions[direction_idx][0]
        next_col = col + directions[direction_idx][1]
        
        # Change direction if the next position is out of bounds or already visited
        if (next_row < 0 or next_row >= rows or 
            next_col < 0 or next_col >= cols or 
            visited[next_row][next_col]):
            direction_idx = (direction_idx + 1) % 4
            next_row = row + directions[direction_idx][0]
            next_col = col + directions[direction_idx][1]
        
        row, col = next_row, next_col
    
    return result
```

**Time Complexity:** O(m * n) - We visit each cell of the matrix once.
**Space Complexity:** O(m * n) - We use a visited array to keep track of visited cells.

### 3. Alternative Solution - Layer by Layer

Traverse the matrix layer by layer, starting from the outermost layer and moving inward.

```python
def spiralOrder(matrix):
    if not matrix:
        return []
    
    result = []
    rows, cols = len(matrix), len(matrix[0])
    
    # Define the number of layers
    layers = (min(rows, cols) + 1) // 2
    
    for layer in range(layers):
        # Traverse right
        for j in range(layer, cols - layer):
            result.append(matrix[layer][j])
        
        # Traverse down
        for i in range(layer + 1, rows - layer):
            result.append(matrix[i][cols - layer - 1])
        
        # Traverse left
        if layer < rows - layer - 1:
            for j in range(cols - layer - 2, layer - 1, -1):
                result.append(matrix[rows - layer - 1][j])
        
        # Traverse up
        if layer < cols - layer - 1:
            for i in range(rows - layer - 2, layer, -1):
                result.append(matrix[i][layer])
    
    return result
```

**Time Complexity:** O(m * n) - We visit each cell of the matrix once.
**Space Complexity:** O(1) - We only use a constant amount of extra space (excluding the output array).

## Solution Choice and Explanation

The Boundary Traversal solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of traversing a matrix in a spiral pattern.

The key insight of this approach is to define the boundaries of the spiral (top, bottom, left, right) and update them as we traverse the matrix. We traverse the matrix in four steps: right, down, left, and up. After each step, we update the corresponding boundary. We continue this process until all elements have been traversed.

For example, let's trace through the algorithm for matrix = [[1,2,3],[4,5,6],[7,8,9]]:

1. Initialize top = 0, bottom = 2, left = 0, right = 2, result = []

2. First iteration:
   - Traverse right: result = [1, 2, 3], top = 1
   - Traverse down: result = [1, 2, 3, 6, 9], right = 1
   - Traverse left: result = [1, 2, 3, 6, 9, 8, 7], bottom = 1
   - Traverse up: result = [1, 2, 3, 6, 9, 8, 7, 4], left = 1

3. Second iteration:
   - Traverse right: result = [1, 2, 3, 6, 9, 8, 7, 4, 5], top = 2
   - Since top > bottom, we break out of the loop

4. Return result = [1, 2, 3, 6, 9, 8, 7, 4, 5]

For matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]:

1. Initialize top = 0, bottom = 2, left = 0, right = 3, result = []

2. First iteration:
   - Traverse right: result = [1, 2, 3, 4], top = 1
   - Traverse down: result = [1, 2, 3, 4, 8, 12], right = 2
   - Traverse left: result = [1, 2, 3, 4, 8, 12, 11, 10], bottom = 1
   - Traverse up: result = [1, 2, 3, 4, 8, 12, 11, 10, 9], left = 1

3. Second iteration:
   - Traverse right: result = [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7], top = 2
   - Since top > bottom, we break out of the loop

4. Return result = [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7]

The Direction Array solution (Solution 2) is also efficient but uses more space due to the visited array. The Layer by Layer solution (Solution 3) is also efficient but may be more complex.

In an interview, I would first mention the Boundary Traversal solution as the most intuitive approach for this problem, and then discuss the Direction Array and Layer by Layer solutions as alternatives if asked for different approaches.
