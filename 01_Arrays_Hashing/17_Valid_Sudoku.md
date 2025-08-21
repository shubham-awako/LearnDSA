# Valid Sudoku

## Problem Statement

Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

1. Each row must contain the digits 1-9 without repetition.
2. Each column must contain the digits 1-9 without repetition.
3. Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.

**Note:**
- A Sudoku board (partially filled) could be valid but is not necessarily solvable.
- Only the filled cells need to be validated according to the mentioned rules.

**Example 1:**
```
Input: board = 
[["5","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
Output: true
```

**Example 2:**
```
Input: board = 
[["8","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
Output: false
Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
```

**Constraints:**
- `board.length == 9`
- `board[i].length == 9`
- `board[i][j]` is a digit 1-9 or `'.'`.

## Concept Overview

This problem tests your ability to validate a Sudoku board according to the rules of Sudoku. The key insight is to efficiently check for duplicates in rows, columns, and 3x3 sub-boxes.

## Solutions

### 1. Brute Force Approach - Three Separate Passes

Check rows, columns, and sub-boxes in three separate passes.

```python
def isValidSudoku(board):
    # Check rows
    for row in board:
        digits = set()
        for cell in row:
            if cell != '.':
                if cell in digits:
                    return False
                digits.add(cell)
    
    # Check columns
    for col in range(9):
        digits = set()
        for row in range(9):
            cell = board[row][col]
            if cell != '.':
                if cell in digits:
                    return False
                digits.add(cell)
    
    # Check 3x3 sub-boxes
    for box_row in range(0, 9, 3):
        for box_col in range(0, 9, 3):
            digits = set()
            for row in range(box_row, box_row + 3):
                for col in range(box_col, box_col + 3):
                    cell = board[row][col]
                    if cell != '.':
                        if cell in digits:
                            return False
                        digits.add(cell)
    
    return True
```

**Time Complexity:** O(1) - The board size is fixed at 9x9, so the number of operations is constant.
**Space Complexity:** O(1) - We use a fixed amount of extra space.

### 2. Improved Solution - Single Pass with Three Sets

Check rows, columns, and sub-boxes in a single pass using three separate sets.

```python
def isValidSudoku(board):
    # Initialize sets to keep track of numbers in each row, column, and box
    rows = [set() for _ in range(9)]
    cols = [set() for _ in range(9)]
    boxes = [set() for _ in range(9)]
    
    for i in range(9):
        for j in range(9):
            cell = board[i][j]
            if cell == '.':
                continue
            
            # Calculate box index
            box_idx = (i // 3) * 3 + j // 3
            
            # Check if the number is already in the row, column, or box
            if cell in rows[i] or cell in cols[j] or cell in boxes[box_idx]:
                return False
            
            # Add the number to the sets
            rows[i].add(cell)
            cols[j].add(cell)
            boxes[box_idx].add(cell)
    
    return True
```

**Time Complexity:** O(1) - The board size is fixed at 9x9, so the number of operations is constant.
**Space Complexity:** O(1) - We use a fixed amount of extra space.

### 3. Best Optimized Solution - Single Pass with HashSet

Use a single hash set to track all constraints by encoding the position and value.

```python
def isValidSudoku(board):
    seen = set()
    
    for i in range(9):
        for j in range(9):
            cell = board[i][j]
            if cell != '.':
                # Create unique strings for row, column, and box constraints
                row_key = f"{cell} in row {i}"
                col_key = f"{cell} in col {j}"
                box_key = f"{cell} in box {i//3}-{j//3}"
                
                # Check if any constraint is violated
                if row_key in seen or col_key in seen or box_key in seen:
                    return False
                
                # Add the constraints to the set
                seen.add(row_key)
                seen.add(col_key)
                seen.add(box_key)
    
    return True
```

**Time Complexity:** O(1) - The board size is fixed at 9x9, so the number of operations is constant.
**Space Complexity:** O(1) - We use a fixed amount of extra space.

## Solution Choice and Explanation

The single pass with three sets solution (Solution 2) is the best approach for this problem because:

1. **Efficiency**: It processes the board in a single pass, checking all constraints simultaneously.

2. **Clarity**: It clearly separates the three constraints (rows, columns, and boxes), making the code easy to understand and maintain.

3. **Direct Representation**: It directly represents the problem's constraints using separate sets for rows, columns, and boxes.

The single pass with HashSet solution (Solution 3) is also efficient but uses string encoding, which adds overhead and makes the code less intuitive.

The brute force approach (Solution 1) is less efficient as it requires three separate passes through the board.

Since the board size is fixed at 9x9, all solutions have O(1) time and space complexity in the strictest sense. However, the single pass with three sets solution minimizes the constant factors by processing the board only once.

In an interview, I would first clarify the rules of Sudoku and then implement the single pass with three sets solution for its clarity and efficiency.
