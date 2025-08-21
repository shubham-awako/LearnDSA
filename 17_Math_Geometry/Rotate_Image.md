# Rotate Image

## Problem Statement

You are given an `n x n` 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

**Example 1:**
```
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [[7,4,1],[8,5,2],[9,6,3]]
```

**Example 2:**
```
Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
```

**Constraints:**
- `n == matrix.length == matrix[i].length`
- `1 <= n <= 20`
- `-1000 <= matrix[i][j] <= 1000`

## Concept Overview

This problem involves rotating a matrix by 90 degrees clockwise in-place. The key insight is to perform the rotation in layers, starting from the outermost layer and moving inward.

## Solutions

### 1. Best Optimized Solution - Transpose and Reverse

Transpose the matrix (swap rows and columns) and then reverse each row.

```python
def rotate(matrix):
    n = len(matrix)
    
    # Transpose the matrix
    for i in range(n):
        for j in range(i, n):
            matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    
    # Reverse each row
    for i in range(n):
        matrix[i].reverse()
```

**Time Complexity:** O(n^2) - We iterate through all elements of the matrix.
**Space Complexity:** O(1) - We perform the rotation in-place.

### 2. Alternative Solution - Rotate Four Cells at a Time

Rotate the matrix layer by layer, moving four cells at a time.

```python
def rotate(matrix):
    n = len(matrix)
    
    # Iterate through each layer
    for layer in range(n // 2):
        first = layer
        last = n - 1 - layer
        
        # Iterate through each element in the current layer
        for i in range(first, last):
            offset = i - first
            
            # Save the top
            top = matrix[first][i]
            
            # Left -> Top
            matrix[first][i] = matrix[last - offset][first]
            
            # Bottom -> Left
            matrix[last - offset][first] = matrix[last][last - offset]
            
            # Right -> Bottom
            matrix[last][last - offset] = matrix[i][last]
            
            # Top -> Right
            matrix[i][last] = top
```

**Time Complexity:** O(n^2) - We iterate through all elements of the matrix.
**Space Complexity:** O(1) - We perform the rotation in-place.

### 3. Alternative Solution - Rotate by Swapping Corners

Rotate the matrix by swapping the four corners of each layer.

```python
def rotate(matrix):
    n = len(matrix)
    
    # Iterate through each layer
    for layer in range(n // 2):
        # Iterate through each element in the current layer
        for i in range(layer, n - 1 - layer):
            # Save the top-left
            temp = matrix[layer][i]
            
            # Bottom-left -> Top-left
            matrix[layer][i] = matrix[n - 1 - i][layer]
            
            # Bottom-right -> Bottom-left
            matrix[n - 1 - i][layer] = matrix[n - 1 - layer][n - 1 - i]
            
            # Top-right -> Bottom-right
            matrix[n - 1 - layer][n - 1 - i] = matrix[i][n - 1 - layer]
            
            # Top-left -> Top-right
            matrix[i][n - 1 - layer] = temp
```

**Time Complexity:** O(n^2) - We iterate through all elements of the matrix.
**Space Complexity:** O(1) - We perform the rotation in-place.

## Solution Choice and Explanation

The Transpose and Reverse solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n^2) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of rotating a matrix by 90 degrees clockwise.

The key insight of this approach is to first transpose the matrix (swap rows and columns) and then reverse each row. This effectively rotates the matrix by 90 degrees clockwise.

For example, let's trace through the algorithm for matrix = [[1,2,3],[4,5,6],[7,8,9]]:

1. Transpose the matrix:
   - Swap matrix[0][1] and matrix[1][0]: matrix = [[1,4,3],[2,5,6],[7,8,9]]
   - Swap matrix[0][2] and matrix[2][0]: matrix = [[1,4,7],[2,5,6],[3,8,9]]
   - Swap matrix[1][2] and matrix[2][1]: matrix = [[1,4,7],[2,5,8],[3,6,9]]

2. Reverse each row:
   - Reverse row 0: matrix = [[7,4,1],[2,5,8],[3,6,9]]
   - Reverse row 1: matrix = [[7,4,1],[8,5,2],[3,6,9]]
   - Reverse row 2: matrix = [[7,4,1],[8,5,2],[9,6,3]]

The Rotate Four Cells at a Time solution (Solution 2) and the Rotate by Swapping Corners solution (Solution 3) are also efficient but may be more complex and less intuitive.

In an interview, I would first mention the Transpose and Reverse solution as the most intuitive approach for this problem, and then discuss the Rotate Four Cells at a Time and Rotate by Swapping Corners solutions as alternatives if asked for different approaches.

## Mathematical Explanation

To understand why transposing and then reversing each row rotates the matrix by 90 degrees clockwise, let's consider the coordinates of each element.

In the original matrix, an element at position (i, j) has the following coordinates:
- Row: i
- Column: j

After transposing, the element at position (i, j) moves to position (j, i):
- Row: j
- Column: i

After reversing each row, the element at position (j, i) moves to position (j, n - 1 - i):
- Row: j
- Column: n - 1 - i

This is equivalent to rotating the element at position (i, j) by 90 degrees clockwise, which would place it at position (j, n - 1 - i):
- Row: j
- Column: n - 1 - i

For example, in a 3x3 matrix, the element at position (0, 0) would move to position (0, 2) after rotation, which is exactly what we get after transposing (to position (0, 0)) and then reversing the row (to position (0, 2)).
