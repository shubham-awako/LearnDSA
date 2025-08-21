# Set Matrix Zeroes

## Problem Statement

Given an `m x n` integer matrix `matrix`, if an element is 0, set its entire row and column to 0's.

You must do it in place.

**Example 1:**
```
Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
Output: [[1,0,1],[0,0,0],[1,0,1]]
```

**Example 2:**
```
Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
```

**Constraints:**
- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 200`
- `-2^31 <= matrix[i][j] <= 2^31 - 1`

## Concept Overview

This problem involves setting entire rows and columns to zeros if any element in the row or column is zero. The key insight is to use the first row and first column as markers to indicate which rows and columns should be set to zero.

## Solutions

### 1. Best Optimized Solution - Using First Row and Column as Markers

Use the first row and first column as markers to indicate which rows and columns should be set to zero.

```python
def setZeroes(matrix):
    if not matrix:
        return
    
    rows, cols = len(matrix), len(matrix[0])
    first_row_has_zero = False
    first_col_has_zero = False
    
    # Check if the first row has any zeros
    for j in range(cols):
        if matrix[0][j] == 0:
            first_row_has_zero = True
            break
    
    # Check if the first column has any zeros
    for i in range(rows):
        if matrix[i][0] == 0:
            first_col_has_zero = True
            break
    
    # Use the first row and first column as markers
    for i in range(1, rows):
        for j in range(1, cols):
            if matrix[i][j] == 0:
                matrix[i][0] = 0
                matrix[0][j] = 0
    
    # Set rows to zero based on the markers in the first column
    for i in range(1, rows):
        if matrix[i][0] == 0:
            for j in range(1, cols):
                matrix[i][j] = 0
    
    # Set columns to zero based on the markers in the first row
    for j in range(1, cols):
        if matrix[0][j] == 0:
            for i in range(1, rows):
                matrix[i][j] = 0
    
    # Set the first row to zero if needed
    if first_row_has_zero:
        for j in range(cols):
            matrix[0][j] = 0
    
    # Set the first column to zero if needed
    if first_col_has_zero:
        for i in range(rows):
            matrix[i][0] = 0
```

**Time Complexity:** O(m * n) - We iterate through the matrix a constant number of times.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Using Sets

Use sets to keep track of rows and columns that should be set to zero.

```python
def setZeroes(matrix):
    if not matrix:
        return
    
    rows, cols = len(matrix), len(matrix[0])
    zero_rows = set()
    zero_cols = set()
    
    # Find the rows and columns that should be set to zero
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 0:
                zero_rows.add(i)
                zero_cols.add(j)
    
    # Set rows to zero
    for row in zero_rows:
        for j in range(cols):
            matrix[row][j] = 0
    
    # Set columns to zero
    for col in zero_cols:
        for i in range(rows):
            matrix[i][col] = 0
```

**Time Complexity:** O(m * n) - We iterate through the matrix a constant number of times.
**Space Complexity:** O(m + n) - We use sets to store the rows and columns that should be set to zero.

### 3. Alternative Solution - Using a Marker Value

Use a marker value to indicate which cells should be set to zero.

```python
def setZeroes(matrix):
    if not matrix:
        return
    
    rows, cols = len(matrix), len(matrix[0])
    marker = float('inf')  # Use a value that's not in the matrix
    
    # Mark rows and columns that should be set to zero
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 0:
                # Mark the row
                for k in range(cols):
                    if matrix[i][k] != 0:
                        matrix[i][k] = marker
                
                # Mark the column
                for k in range(rows):
                    if matrix[k][j] != 0:
                        matrix[k][j] = marker
    
    # Set marked cells to zero
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == marker:
                matrix[i][j] = 0
```

**Time Complexity:** O(m * n * (m + n)) - For each zero in the matrix, we iterate through its row and column.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Using First Row and Column as Markers solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **In-Place**: It satisfies the requirement of modifying the matrix in-place.

3. **Elegance**: It cleverly uses the first row and first column as markers, avoiding the need for additional data structures.

The key insight of this approach is to use the first row and first column as markers to indicate which rows and columns should be set to zero. We first check if the first row and first column have any zeros, and then use them as markers for the rest of the matrix. Finally, we set the first row and first column to zero if needed.

For example, let's trace through the algorithm for matrix = [[1,1,1],[1,0,1],[1,1,1]]:

1. Initialize first_row_has_zero = False, first_col_has_zero = False

2. Check if the first row has any zeros:
   - first_row_has_zero = False

3. Check if the first column has any zeros:
   - first_col_has_zero = False

4. Use the first row and first column as markers:
   - matrix[1][1] = 0, so set matrix[1][0] = 0 and matrix[0][1] = 0
   - matrix = [[1,0,1],[0,0,1],[1,1,1]]

5. Set rows to zero based on the markers in the first column:
   - matrix[1][0] = 0, so set matrix[1][1:] = 0
   - matrix = [[1,0,1],[0,0,0],[1,1,1]]

6. Set columns to zero based on the markers in the first row:
   - matrix[0][1] = 0, so set matrix[1:][1] = 0
   - matrix = [[1,0,1],[0,0,0],[1,0,1]]

7. Set the first row to zero if needed:
   - first_row_has_zero = False, so no change

8. Set the first column to zero if needed:
   - first_col_has_zero = False, so no change

9. Final matrix = [[1,0,1],[0,0,0],[1,0,1]]

For matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]:

1. Initialize first_row_has_zero = False, first_col_has_zero = False

2. Check if the first row has any zeros:
   - matrix[0][0] = 0, so first_row_has_zero = True

3. Check if the first column has any zeros:
   - matrix[0][0] = 0, so first_col_has_zero = True

4. Use the first row and first column as markers:
   - matrix[0][3] = 0, so set matrix[0][3] = 0 (already 0)
   - matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]

5. Set rows to zero based on the markers in the first column:
   - No change

6. Set columns to zero based on the markers in the first row:
   - No change

7. Set the first row to zero if needed:
   - first_row_has_zero = True, so set matrix[0][:] = 0
   - matrix = [[0,0,0,0],[3,4,5,2],[1,3,1,5]]

8. Set the first column to zero if needed:
   - first_col_has_zero = True, so set matrix[:][0] = 0
   - matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

9. Final matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

Wait, that's not right. Let me trace through the algorithm again for matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]:

1. Initialize first_row_has_zero = False, first_col_has_zero = False

2. Check if the first row has any zeros:
   - matrix[0][0] = 0 and matrix[0][3] = 0, so first_row_has_zero = True

3. Check if the first column has any zeros:
   - matrix[0][0] = 0, so first_col_has_zero = True

4. Use the first row and first column as markers:
   - matrix[0][0] = 0 and matrix[0][3] = 0 (already marked)
   - matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]

5. Set rows to zero based on the markers in the first column:
   - No change (no zeros in the first column except the first row)

6. Set columns to zero based on the markers in the first row:
   - No change (no zeros in the first row except the first and last columns)

7. Set the first row to zero if needed:
   - first_row_has_zero = True, so set matrix[0][:] = 0
   - matrix = [[0,0,0,0],[3,4,5,2],[1,3,1,5]]

8. Set the first column to zero if needed:
   - first_col_has_zero = True, so set matrix[:][0] = 0
   - matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

9. Final matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

But this is still not right. Let me trace through the algorithm one more time with more careful attention to detail:

1. Initialize first_row_has_zero = False, first_col_has_zero = False

2. Check if the first row has any zeros:
   - matrix[0][0] = 0 and matrix[0][3] = 0, so first_row_has_zero = True

3. Check if the first column has any zeros:
   - matrix[0][0] = 0, so first_col_has_zero = True

4. Use the first row and first column as markers:
   - For each zero in the matrix (excluding the first row and first column), mark the corresponding row and column
   - No zeros in the matrix (excluding the first row and first column), so no change
   - matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]

5. Set rows to zero based on the markers in the first column:
   - No change (no zeros in the first column except the first row)

6. Set columns to zero based on the markers in the first row:
   - No change (no zeros in the first row except the first and last columns)

7. Set the first row to zero if needed:
   - first_row_has_zero = True, so set matrix[0][:] = 0
   - matrix = [[0,0,0,0],[3,4,5,2],[1,3,1,5]]

8. Set the first column to zero if needed:
   - first_col_has_zero = True, so set matrix[:][0] = 0
   - matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

9. Final matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

Wait, this still doesn't match the expected output. Let me trace through the algorithm one more time with the correct implementation:

For matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]:

1. Initialize first_row_has_zero = False, first_col_has_zero = False

2. Check if the first row has any zeros:
   - matrix[0][0] = 0 and matrix[0][3] = 0, so first_row_has_zero = True

3. Check if the first column has any zeros:
   - matrix[0][0] = 0, so first_col_has_zero = True

4. Use the first row and first column as markers:
   - For each zero in the matrix (excluding the first row and first column), mark the corresponding row and column
   - No zeros in the matrix (excluding the first row and first column), so no change
   - matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]

5. Set rows to zero based on the markers in the first column:
   - No change (no zeros in the first column except the first row)

6. Set columns to zero based on the markers in the first row:
   - No change (no zeros in the first row except the first and last columns)

7. Set the first row to zero if needed:
   - first_row_has_zero = True, so set matrix[0][:] = 0
   - matrix = [[0,0,0,0],[3,4,5,2],[1,3,1,5]]

8. Set the first column to zero if needed:
   - first_col_has_zero = True, so set matrix[:][0] = 0
   - matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

9. Final matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

The issue is that I'm not accounting for the zeros in the original matrix correctly. Let me trace through the algorithm one more time with the correct implementation:

For matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]:

1. Check if the first row has any zeros:
   - matrix[0][0] = 0 and matrix[0][3] = 0, so first_row_has_zero = True

2. Check if the first column has any zeros:
   - matrix[0][0] = 0, so first_col_has_zero = True

3. Use the first row and first column as markers:
   - For each zero in the matrix (excluding the first row and first column), mark the corresponding row and column
   - No zeros in the matrix (excluding the first row and first column), so no change

4. Set rows to zero based on the markers in the first column:
   - No zeros in the first column (excluding the first row), so no change

5. Set columns to zero based on the markers in the first row:
   - No zeros in the first row (excluding the first column), so no change

6. Set the first row to zero if needed:
   - first_row_has_zero = True, so set the first row to zero
   - matrix = [[0,0,0,0],[3,4,5,2],[1,3,1,5]]

7. Set the first column to zero if needed:
   - first_col_has_zero = True, so set the first column to zero
   - matrix = [[0,0,0,0],[0,4,5,2],[0,3,1,5]]

But the expected output is [[0,0,0,0],[0,4,5,0],[0,3,1,0]]. The issue is that I'm not accounting for the zero at matrix[0][3] correctly. Let me trace through the algorithm one more time with the correct implementation:

For matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]:

1. Check if the first row has any zeros:
   - matrix[0][0] = 0 and matrix[0][3] = 0, so first_row_has_zero = True

2. Check if the first column has any zeros:
   - matrix[0][0] = 0, so first_col_has_zero = True

3. Use the first row and first column as markers:
   - For each zero in the matrix (excluding the first row and first column), mark the corresponding row and column
   - No zeros in the matrix (excluding the first row and first column), so no change

4. Set rows to zero based on the markers in the first column:
   - No zeros in the first column (excluding the first row), so no change

5. Set columns to zero based on the markers in the first row:
   - matrix[0][3] = 0, so set the fourth column to zero
   - matrix = [[0,1,2,0],[3,4,5,0],[1,3,1,0]]

6. Set the first row to zero if needed:
   - first_row_has_zero = True, so set the first row to zero
   - matrix = [[0,0,0,0],[3,4,5,0],[1,3,1,0]]

7. Set the first column to zero if needed:
   - first_col_has_zero = True, so set the first column to zero
   - matrix = [[0,0,0,0],[0,4,5,0],[0,3,1,0]]

The final matrix is [[0,0,0,0],[0,4,5,0],[0,3,1,0]], which matches the expected output.

The Using Sets solution (Solution 2) is also efficient but uses more space. The Using a Marker Value solution (Solution 3) is less efficient and may not work if the marker value is present in the matrix.

In an interview, I would first mention the Using First Row and Column as Markers solution as the most space-efficient approach for this problem, and then discuss the Using Sets solution as an alternative if asked for a different approach.
