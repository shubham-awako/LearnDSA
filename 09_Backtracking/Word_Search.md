# Word Search

## Problem Statement

Given an `m x n` grid of characters `board` and a string `word`, return `true` if `word` exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

**Example 1:**
```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true
```

**Example 2:**
```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true
```

**Example 3:**
```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false
```

**Constraints:**
- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 6`
- `1 <= word.length <= 15`
- `board` and `word` consists of only lowercase and uppercase English letters.

**Follow up:** Could you use search pruning to make your solution faster with a larger board?

## Concept Overview

This problem tests your understanding of backtracking and depth-first search on a 2D grid. The key insight is to use backtracking to explore all possible paths from each cell in the grid, marking cells as visited to avoid using the same cell multiple times.

## Solutions

### 1. Best Optimized Solution - Backtracking with DFS

Use backtracking with depth-first search to explore all possible paths from each cell in the grid.

```python
def exist(board, word):
    if not board or not board[0]:
        return False
    
    m, n = len(board), len(board[0])
    
    def dfs(i, j, k):
        # If we've matched all characters in the word, return True
        if k == len(word):
            return True
        
        # Check if the current cell is out of bounds or doesn't match the current character
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] != word[k]:
            return False
        
        # Mark the current cell as visited
        temp = board[i][j]
        board[i][j] = '#'
        
        # Explore all four adjacent cells
        found = (dfs(i+1, j, k+1) or
                 dfs(i-1, j, k+1) or
                 dfs(i, j+1, k+1) or
                 dfs(i, j-1, k+1))
        
        # Restore the original value of the cell
        board[i][j] = temp
        
        return found
    
    # Try starting from each cell in the grid
    for i in range(m):
        for j in range(n):
            if dfs(i, j, 0):
                return True
    
    return False
```

**Time Complexity:** O(m * n * 4^L) where m and n are the dimensions of the board and L is the length of the word. For each cell, we potentially explore 4 adjacent cells, and we can go up to L levels deep in the recursion.
**Space Complexity:** O(L) for the recursion stack, where L is the length of the word.

### 2. Alternative Solution - Backtracking with Visited Set

Use a set to keep track of visited cells instead of modifying the board.

```python
def exist(board, word):
    if not board or not board[0]:
        return False
    
    m, n = len(board), len(board[0])
    
    def dfs(i, j, k, visited):
        # If we've matched all characters in the word, return True
        if k == len(word):
            return True
        
        # Check if the current cell is out of bounds, already visited, or doesn't match the current character
        if (i < 0 or i >= m or j < 0 or j >= n or
            (i, j) in visited or board[i][j] != word[k]):
            return False
        
        # Mark the current cell as visited
        visited.add((i, j))
        
        # Explore all four adjacent cells
        found = (dfs(i+1, j, k+1, visited) or
                 dfs(i-1, j, k+1, visited) or
                 dfs(i, j+1, k+1, visited) or
                 dfs(i, j-1, k+1, visited))
        
        # Remove the current cell from the visited set (backtrack)
        visited.remove((i, j))
        
        return found
    
    # Try starting from each cell in the grid
    for i in range(m):
        for j in range(n):
            if dfs(i, j, 0, set()):
                return True
    
    return False
```

**Time Complexity:** O(m * n * 4^L) where m and n are the dimensions of the board and L is the length of the word. For each cell, we potentially explore 4 adjacent cells, and we can go up to L levels deep in the recursion.
**Space Complexity:** O(L) for the recursion stack and the visited set, where L is the length of the word.

### 3. Alternative Solution - Backtracking with Pruning

Use backtracking with pruning to avoid exploring paths that cannot lead to a valid solution.

```python
def exist(board, word):
    if not board or not board[0]:
        return False
    
    m, n = len(board), len(board[0])
    
    # Check if the board contains all characters in the word
    board_chars = {}
    for i in range(m):
        for j in range(n):
            board_chars[board[i][j]] = board_chars.get(board[i][j], 0) + 1
    
    for char in word:
        if char not in board_chars or board_chars[char] == 0:
            return False
        board_chars[char] -= 1
    
    def dfs(i, j, k):
        # If we've matched all characters in the word, return True
        if k == len(word):
            return True
        
        # Check if the current cell is out of bounds or doesn't match the current character
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] != word[k]:
            return False
        
        # Mark the current cell as visited
        temp = board[i][j]
        board[i][j] = '#'
        
        # Explore all four adjacent cells
        found = (dfs(i+1, j, k+1) or
                 dfs(i-1, j, k+1) or
                 dfs(i, j+1, k+1) or
                 dfs(i, j-1, k+1))
        
        # Restore the original value of the cell
        board[i][j] = temp
        
        return found
    
    # Try starting from each cell in the grid
    for i in range(m):
        for j in range(n):
            if board[i][j] == word[0] and dfs(i, j, 0):
                return True
    
    return False
```

**Time Complexity:** O(m * n * 4^L) where m and n are the dimensions of the board and L is the length of the word. For each cell, we potentially explore 4 adjacent cells, and we can go up to L levels deep in the recursion.
**Space Complexity:** O(L) for the recursion stack, where L is the length of the word.

## Solution Choice and Explanation

The backtracking with DFS solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's straightforward to implement and understand.

2. **Efficiency**: It achieves the optimal time and space complexity for this problem.

3. **In-Place**: It modifies the board in-place to mark visited cells, which is more space-efficient than using a separate visited set.

The key insight of this approach is to use backtracking with depth-first search to explore all possible paths from each cell in the grid. We use a recursive function `dfs(i, j, k)` that:
1. Checks if we've matched all characters in the word, in which case we return True.
2. Checks if the current cell is out of bounds or doesn't match the current character, in which case we return False.
3. Marks the current cell as visited by temporarily changing its value.
4. Explores all four adjacent cells recursively.
5. Restores the original value of the cell (backtracking) before returning.

For example, let's trace through the algorithm for board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]] and word = "ABCCED":
1. Start from each cell in the grid:
   - (0, 0): board[0][0] = "A", word[0] = "A", match
     - Mark (0, 0) as visited: board[0][0] = "#"
     - Try (1, 0): board[1][0] = "S", word[1] = "B", no match
     - Try (0, 1): board[0][1] = "B", word[1] = "B", match
       - Mark (0, 1) as visited: board[0][1] = "#"
       - Try (1, 1): board[1][1] = "F", word[2] = "C", no match
       - Try (0, 2): board[0][2] = "C", word[2] = "C", match
         - Mark (0, 2) as visited: board[0][2] = "#"
         - Try (1, 2): board[1][2] = "C", word[3] = "C", match
           - Mark (1, 2) as visited: board[1][2] = "#"
           - Try (2, 2): board[2][2] = "E", word[4] = "E", match
             - Mark (2, 2) as visited: board[2][2] = "#"
             - Try (2, 3): board[2][3] = "E", word[5] = "D", no match
             - Try (2, 1): board[2][1] = "D", word[5] = "D", match
               - Mark (2, 1) as visited: board[2][1] = "#"
               - We've matched all characters in the word, return True
             - Restore (2, 1): board[2][1] = "D"
           - Restore (2, 2): board[2][2] = "E"
         - Restore (1, 2): board[1][2] = "C"
       - Restore (0, 2): board[0][2] = "C"
     - Restore (0, 1): board[0][1] = "B"
   - Restore (0, 0): board[0][0] = "A"
2. We found a valid path, so return True.

The backtracking with visited set solution (Solution 2) is also efficient but uses more space. The backtracking with pruning solution (Solution 3) adds an optimization to check if the board contains all characters in the word before starting the search, which can be helpful for large boards.

In an interview, I would first mention the backtracking with DFS solution as the most straightforward and efficient approach for this problem, and then mention the pruning optimization if asked for ways to improve the solution for larger boards.
