# N-Queens

## Problem Statement

The **n-queens** puzzle is the problem of placing `n` queens on an `n x n` chessboard such that no two queens attack each other.

Given an integer `n`, return all distinct solutions to the n-queens puzzle. You may return the answer in any order.

Each solution contains a distinct board configuration of the n-queens' placement, where `'Q'` and `'.'` both indicate a queen and an empty space, respectively.

**Example 1:**
```
Input: n = 4
Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
Explanation: There exist two distinct solutions to the 4-queens puzzle as shown above
```

**Example 2:**
```
Input: n = 1
Output: [["Q"]]
```

**Constraints:**
- `1 <= n <= 9`

## Concept Overview

This problem tests your understanding of backtracking and constraint satisfaction. The key insight is to use backtracking to try placing queens in valid positions, one row at a time, and backtrack when a conflict is detected.

## Solutions

### 1. Best Optimized Solution - Backtracking with Sets

Use backtracking to try placing queens in valid positions, one row at a time, and use sets to efficiently check for conflicts.

```python
def solveNQueens(n):
    result = []
    
    # Use sets to keep track of occupied columns, diagonals, and anti-diagonals
    cols = set()
    diags = set()  # r - c remains constant for a diagonal
    anti_diags = set()  # r + c remains constant for an anti-diagonal
    
    # Initialize the board with empty spaces
    board = [['.' for _ in range(n)] for _ in range(n)]
    
    def backtrack(row):
        # If we've placed queens in all rows, we've found a valid solution
        if row == n:
            # Convert the board to the required format
            solution = [''.join(row) for row in board]
            result.append(solution)
            return
        
        # Try placing a queen in each column of the current row
        for col in range(n):
            # Check if the current position is under attack
            if col in cols or row - col in diags or row + col in anti_diags:
                continue
            
            # Place a queen at the current position
            board[row][col] = 'Q'
            cols.add(col)
            diags.add(row - col)
            anti_diags.add(row + col)
            
            # Recursively place queens in the next row
            backtrack(row + 1)
            
            # Remove the queen from the current position (backtrack)
            board[row][col] = '.'
            cols.remove(col)
            diags.remove(row - col)
            anti_diags.remove(row + col)
    
    backtrack(0)
    return result
```

**Time Complexity:** O(n!) - There are n! possible ways to place n queens on an n x n board, and we check each valid configuration.
**Space Complexity:** O(n) - We use sets to keep track of occupied columns, diagonals, and anti-diagonals, and the recursion stack can go up to n levels deep.

### 2. Alternative Solution - Backtracking with Arrays

Use backtracking to try placing queens in valid positions, one row at a time, and use arrays to check for conflicts.

```python
def solveNQueens(n):
    result = []
    
    # Initialize the board with empty spaces
    board = [['.' for _ in range(n)] for _ in range(n)]
    
    def is_valid(row, col):
        # Check if there's a queen in the same column
        for i in range(row):
            if board[i][col] == 'Q':
                return False
        
        # Check if there's a queen in the upper-left diagonal
        i, j = row - 1, col - 1
        while i >= 0 and j >= 0:
            if board[i][j] == 'Q':
                return False
            i -= 1
            j -= 1
        
        # Check if there's a queen in the upper-right diagonal
        i, j = row - 1, col + 1
        while i >= 0 and j < n:
            if board[i][j] == 'Q':
                return False
            i -= 1
            j += 1
        
        return True
    
    def backtrack(row):
        # If we've placed queens in all rows, we've found a valid solution
        if row == n:
            # Convert the board to the required format
            solution = [''.join(row) for row in board]
            result.append(solution)
            return
        
        # Try placing a queen in each column of the current row
        for col in range(n):
            # Check if the current position is valid
            if is_valid(row, col):
                # Place a queen at the current position
                board[row][col] = 'Q'
                
                # Recursively place queens in the next row
                backtrack(row + 1)
                
                # Remove the queen from the current position (backtrack)
                board[row][col] = '.'
    
    backtrack(0)
    return result
```

**Time Complexity:** O(n!) - There are n! possible ways to place n queens on an n x n board, and we check each valid configuration.
**Space Complexity:** O(n^2) - We use a 2D array to represent the board, and the recursion stack can go up to n levels deep.

### 3. Alternative Solution - Backtracking with Bit Manipulation

Use backtracking to try placing queens in valid positions, one row at a time, and use bit manipulation to efficiently check for conflicts.

```python
def solveNQueens(n):
    result = []
    
    # Initialize the board with empty spaces
    board = [['.' for _ in range(n)] for _ in range(n)]
    
    def backtrack(row, cols, diags, anti_diags):
        # If we've placed queens in all rows, we've found a valid solution
        if row == n:
            # Convert the board to the required format
            solution = [''.join(row) for row in board]
            result.append(solution)
            return
        
        # Try placing a queen in each column of the current row
        for col in range(n):
            # Check if the current position is under attack
            if (cols & (1 << col)) or (diags & (1 << (row - col + n - 1))) or (anti_diags & (1 << (row + col))):
                continue
            
            # Place a queen at the current position
            board[row][col] = 'Q'
            
            # Recursively place queens in the next row
            backtrack(
                row + 1,
                cols | (1 << col),
                diags | (1 << (row - col + n - 1)),
                anti_diags | (1 << (row + col))
            )
            
            # Remove the queen from the current position (backtrack)
            board[row][col] = '.'
    
    backtrack(0, 0, 0, 0)
    return result
```

**Time Complexity:** O(n!) - There are n! possible ways to place n queens on an n x n board, and we check each valid configuration.
**Space Complexity:** O(n) - We use integers to represent the occupied columns, diagonals, and anti-diagonals, and the recursion stack can go up to n levels deep.

## Solution Choice and Explanation

The backtracking with sets solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It uses sets to efficiently check for conflicts, which avoids the O(n) time complexity of checking each position in the same column and diagonals.

2. **Clarity**: It clearly separates the logic for checking conflicts and the backtracking logic, making the code more readable.

3. **Elegance**: It uses mathematical properties of diagonals to efficiently check for conflicts.

The key insight of this approach is to use backtracking to try placing queens in valid positions, one row at a time, and use sets to efficiently check for conflicts. We use three sets:
1. `cols`: To keep track of occupied columns.
2. `diags`: To keep track of occupied diagonals (where r - c remains constant).
3. `anti_diags`: To keep track of occupied anti-diagonals (where r + c remains constant).

For example, let's trace through the algorithm for n = 4:
1. Start with an empty board and empty sets: cols = {}, diags = {}, anti_diags = {}
2. Try placing a queen in each column of row 0:
   - Try (0, 0): cols = {0}, diags = {0}, anti_diags = {0}
     - Recursively place queens in row 1:
       - Try (1, 0): Conflict in column 0, skip
       - Try (1, 1): Conflict in anti-diagonal 2, skip
       - Try (1, 2): cols = {0, 2}, diags = {0, -1}, anti_diags = {0, 3}
         - Recursively place queens in row 2:
           - Try (2, 0): Conflict in column 0, skip
           - Try (2, 1): cols = {0, 2, 1}, diags = {0, -1, 1}, anti_diags = {0, 3, 3}
             - Recursively place queens in row 3:
               - Try (3, 0): Conflict in column 0, skip
               - Try (3, 1): Conflict in column 1, skip
               - Try (3, 2): Conflict in column 2, skip
               - Try (3, 3): cols = {0, 2, 1, 3}, diags = {0, -1, 1, 0}, anti_diags = {0, 3, 3, 6}
                 - row == n, so we've found a valid solution: [".Q..", "...Q", "Q...", "..Q."]
               - Remove (3, 3): cols = {0, 2, 1}, diags = {0, -1, 1}, anti_diags = {0, 3, 3}
             - Remove (2, 1): cols = {0, 2}, diags = {0, -1}, anti_diags = {0, 3}
           - Try (2, 3): cols = {0, 2, 3}, diags = {0, -1, -1}, anti_diags = {0, 3, 5}
             - Recursively place queens in row 3:
               - Try (3, 0): Conflict in column 0, skip
               - Try (3, 1): cols = {0, 2, 3, 1}, diags = {0, -1, -1, 2}, anti_diags = {0, 3, 5, 4}
                 - row == n, so we've found a valid solution: [".Q..", "...Q", "..Q.", "Q..."]
               - Remove (3, 1): cols = {0, 2, 3}, diags = {0, -1, -1}, anti_diags = {0, 3, 5}
             - Try (3, 2): Conflict in column 2, skip
             - Try (3, 3): Conflict in column 3, skip
           - Remove (2, 3): cols = {0, 2}, diags = {0, -1}, anti_diags = {0, 3}
         - Remove (1, 2): cols = {0}, diags = {0}, anti_diags = {0}
       - Try (1, 3): cols = {0, 3}, diags = {0, -2}, anti_diags = {0, 4}
         - Recursively place queens in row 2:
           - Try (2, 0): Conflict in column 0, skip
           - Try (2, 1): cols = {0, 3, 1}, diags = {0, -2, 1}, anti_diags = {0, 4, 3}
             - Recursively place queens in row 3:
               - Try (3, 0): Conflict in column 0, skip
               - Try (3, 1): Conflict in column 1, skip
               - Try (3, 2): cols = {0, 3, 1, 2}, diags = {0, -2, 1, 1}, anti_diags = {0, 4, 3, 5}
                 - row == n, so we've found a valid solution: [".Q..", "...Q", ".Q..", "..Q."]
               - Remove (3, 2): cols = {0, 3, 1}, diags = {0, -2, 1}, anti_diags = {0, 4, 3}
             - Try (3, 3): Conflict in column 3, skip
           - Remove (2, 1): cols = {0, 3}, diags = {0, -2}, anti_diags = {0, 4}
         - Remove (1, 3): cols = {0}, diags = {0}, anti_diags = {0}
     - Remove (0, 0): cols = {}, diags = {}, anti_diags = {}
   - Try (0, 1): cols = {1}, diags = {-1}, anti_diags = {1}
     - Recursively place queens in row 1:
       - Try (1, 0): Conflict in diagonal -1, skip
       - Try (1, 1): Conflict in column 1, skip
       - Try (1, 2): Conflict in anti-diagonal 3, skip
       - Try (1, 3): cols = {1, 3}, diags = {-1, -2}, anti_diags = {1, 4}
         - Recursively place queens in row 2:
           - Try (2, 0): cols = {1, 3, 0}, diags = {-1, -2, 2}, anti_diags = {1, 4, 2}
             - Recursively place queens in row 3:
               - Try (3, 0): Conflict in column 0, skip
               - Try (3, 1): Conflict in column 1, skip
               - Try (3, 2): cols = {1, 3, 0, 2}, diags = {-1, -2, 2, 1}, anti_diags = {1, 4, 2, 5}
                 - row == n, so we've found a valid solution: ["..Q.", "Q...", "...Q", ".Q.."]
               - Remove (3, 2): cols = {1, 3, 0}, diags = {-1, -2, 2}, anti_diags = {1, 4, 2}
             - Try (3, 3): Conflict in column 3, skip
           - Remove (2, 0): cols = {1, 3}, diags = {-1, -2}, anti_diags = {1, 4}
         - Remove (1, 3): cols = {1}, diags = {-1}, anti_diags = {1}
     - Remove (0, 1): cols = {}, diags = {}, anti_diags = {}
   - Try (0, 2): cols = {2}, diags = {-2}, anti_diags = {2}
     - Recursively place queens in row 1:
       - Try (1, 0): cols = {2, 0}, diags = {-2, 1}, anti_diags = {2, 1}
         - Recursively place queens in row 2:
           - Try (2, 0): Conflict in column 0, skip
           - Try (2, 1): Conflict in diagonal 1, skip
           - Try (2, 2): Conflict in column 2, skip
           - Try (2, 3): cols = {2, 0, 3}, diags = {-2, 1, -1}, anti_diags = {2, 1, 5}
             - Recursively place queens in row 3:
               - Try (3, 0): Conflict in column 0, skip
               - Try (3, 1): cols = {2, 0, 3, 1}, diags = {-2, 1, -1, 2}, anti_diags = {2, 1, 5, 4}
                 - row == n, so we've found a valid solution: ["..Q.", "Q...", "...Q", ".Q.."]
               - Remove (3, 1): cols = {2, 0, 3}, diags = {-2, 1, -1}, anti_diags = {2, 1, 5}
             - Try (3, 2): Conflict in column 2, skip
             - Try (3, 3): Conflict in column 3, skip
           - Remove (2, 3): cols = {2, 0}, diags = {-2, 1}, anti_diags = {2, 1}
         - Remove (1, 0): cols = {2}, diags = {-2}, anti_diags = {2}
       - Try (1, 1): Conflict in anti-diagonal 3, skip
       - Try (1, 2): Conflict in column 2, skip
       - Try (1, 3): cols = {2, 3}, diags = {-2, -2}, anti_diags = {2, 4}
         - Recursively place queens in row 2:
           - Try (2, 0): Conflict in diagonal -2, skip
           - Try (2, 1): cols = {2, 3, 1}, diags = {-2, -2, 1}, anti_diags = {2, 4, 3}
             - Recursively place queens in row 3:
               - Try (3, 0): cols = {2, 3, 1, 0}, diags = {-2, -2, 1, 3}, anti_diags = {2, 4, 3, 3}
                 - row == n, so we've found a valid solution: ["..Q.", "...Q", ".Q..", "Q..."]
               - Remove (3, 0): cols = {2, 3, 1}, diags = {-2, -2, 1}, anti_diags = {2, 4, 3}
             - Try (3, 1): Conflict in column 1, skip
             - Try (3, 2): Conflict in column 2, skip
             - Try (3, 3): Conflict in column 3, skip
           - Remove (2, 1): cols = {2, 3}, diags = {-2, -2}, anti_diags = {2, 4}
         - Remove (1, 3): cols = {2}, diags = {-2}, anti_diags = {2}
     - Remove (0, 2): cols = {}, diags = {}, anti_diags = {}
   - Try (0, 3): cols = {3}, diags = {-3}, anti_diags = {3}
     - Recursively place queens in row 1:
       - Try (1, 0): Conflict in diagonal -3, skip
       - Try (1, 1): cols = {3, 1}, diags = {-3, 0}, anti_diags = {3, 2}
         - Recursively place queens in row 2:
           - Try (2, 0): Conflict in diagonal 0, skip
           - Try (2, 1): Conflict in column 1, skip
           - Try (2, 2): Conflict in anti-diagonal 4, skip
           - Try (2, 3): Conflict in column 3, skip
         - Remove (1, 1): cols = {3}, diags = {-3}, anti_diags = {3}
       - Try (1, 2): Conflict in anti-diagonal 3, skip
       - Try (1, 3): Conflict in column 3, skip
     - Remove (0, 3): cols = {}, diags = {}, anti_diags = {}
3. Final result: [[".Q..", "...Q", "Q...", "..Q."], ["..Q.", "Q...", "...Q", ".Q.."]]

The backtracking with arrays solution (Solution 2) is simpler but less efficient, as it takes O(n) time to check for conflicts in each position. The backtracking with bit manipulation solution (Solution 3) is also efficient but less readable.

In an interview, I would first mention the backtracking with sets solution as the most efficient and readable approach for this problem, and then mention the bit manipulation optimization if asked for further optimizations.
