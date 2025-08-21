# Search a 2D Matrix

## Problem Statement

You are given an `m x n` integer matrix `matrix` with the following two properties:

1. Each row is sorted in non-decreasing order.
2. The first integer of each row is greater than the last integer of the previous row.

Given an integer `target`, return `true` if `target` is in `matrix` or `false` otherwise.

You must write a solution in O(log(m * n)) time complexity.

**Example 1:**
```
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true
```

**Example 2:**
```
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false
```

**Constraints:**
- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 100`
- `-10^4 <= matrix[i][j], target <= 10^4`

## Concept Overview

This problem combines 2D array traversal with binary search. The key insight is to treat the 2D matrix as a flattened sorted array and apply binary search to efficiently find the target.

## Solutions

### 1. Two Binary Searches

First use binary search to find the row that might contain the target, then use binary search on that row.

```python
def searchMatrix(matrix, target):
    if not matrix or not matrix[0]:
        return False
    
    m, n = len(matrix), len(matrix[0])
    
    # Binary search to find the row
    left, right = 0, m - 1
    while left <= right:
        mid = left + (right - left) // 2
        if matrix[mid][0] <= target <= matrix[mid][n - 1]:
            # Target might be in this row
            row = mid
            break
        elif matrix[mid][0] > target:
            right = mid - 1
        else:
            left = mid + 1
    else:
        # Target is not in the matrix
        return False
    
    # Binary search on the row
    left, right = 0, n - 1
    while left <= right:
        mid = left + (right - left) // 2
        if matrix[row][mid] == target:
            return True
        elif matrix[row][mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return False
```

**Time Complexity:** O(log m + log n) = O(log(m * n)) - We perform two binary searches.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - Single Binary Search

Treat the 2D matrix as a flattened sorted array and apply binary search directly.

```python
def searchMatrix(matrix, target):
    if not matrix or not matrix[0]:
        return False
    
    m, n = len(matrix), len(matrix[0])
    
    # Binary search on the flattened matrix
    left, right = 0, m * n - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        # Convert the 1D index to 2D coordinates
        row, col = mid // n, mid % n
        
        if matrix[row][col] == target:
            return True
        elif matrix[row][col] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return False
```

**Time Complexity:** O(log(m * n)) - We perform a single binary search on the flattened matrix.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Linear Search from Top-Right

Start from the top-right corner and move left or down based on the comparison with the target.

```python
def searchMatrix(matrix, target):
    if not matrix or not matrix[0]:
        return False
    
    m, n = len(matrix), len(matrix[0])
    row, col = 0, n - 1
    
    while row < m and col >= 0:
        if matrix[row][col] == target:
            return True
        elif matrix[row][col] > target:
            col -= 1  # Move left
        else:
            row += 1  # Move down
    
    return False
```

**Time Complexity:** O(m + n) - In the worst case, we traverse m + n elements.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

**Note:** This solution doesn't satisfy the O(log(m * n)) time complexity requirement.

## Solution Choice and Explanation

The single binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log(m * n)) time complexity, which is required by the problem.

2. **Simplicity**: It's more straightforward to implement than the two binary searches approach.

3. **Efficiency**: It performs a single binary search instead of two, potentially reducing the constant factor in the time complexity.

The key insight of this solution is to treat the 2D matrix as a flattened sorted array. Since the matrix has the property that each row is sorted and the first integer of each row is greater than the last integer of the previous row, the flattened array would be sorted. We can then apply binary search directly on this flattened array, using index conversion to map between the 1D index and the 2D coordinates.

For example, let's search for 11 in the matrix [[1,3,5,7],[10,11,16,20],[23,30,34,60]]:
1. m = 3, n = 4, left = 0, right = 11
2. mid = 5, row = 5 // 4 = 1, col = 5 % 4 = 1, matrix[row][col] = 11
3. 11 == 11, so return True

The two binary searches approach (Solution 1) is also efficient but slightly more complex. The linear search approach (Solution 3) doesn't satisfy the O(log(m * n)) time complexity requirement.

In an interview, I would first mention the single binary search approach as the most efficient and straightforward solution for this problem.
