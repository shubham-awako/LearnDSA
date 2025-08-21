# Word Search II

## Problem Statement

Given an `m x n` `board` of characters and a list of strings `words`, return all words on the board.

Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

**Example 1:**
```
Input: board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], words = ["oath","pea","eat","rain"]
Output: ["eat","oath"]
```

**Example 2:**
```
Input: board = [["a","b"],["c","d"]], words = ["abcb"]
Output: []
```

**Constraints:**
- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 12`
- `board[i][j]` is a lowercase English letter.
- `1 <= words.length <= 3 * 10^4`
- `1 <= words[i].length <= 10`
- `words[i]` consists of lowercase English letters.
- All the strings of `words` are unique.

## Concept Overview

This problem combines the concepts of tries and backtracking. The key insight is to build a trie from the list of words and then use backtracking to explore the board, checking if the current path forms a word in the trie.

## Solutions

### 1. Best Optimized Solution - Trie with Backtracking

Build a trie from the list of words and use backtracking to explore the board.

```python
class TrieNode:
    def __init__(self):
        self.children = {}  # Dictionary of child nodes (key: character, value: node)
        self.word = None  # Store the word at the end node for easy retrieval

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.word = word

def findWords(board, words):
    # Build a trie from the list of words
    trie = Trie()
    for word in words:
        trie.insert(word)
    
    m, n = len(board), len(board[0])
    result = []
    
    def backtrack(i, j, node):
        # Check if the current cell is out of bounds or doesn't match any character in the trie
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] not in node.children:
            return
        
        char = board[i][j]
        node = node.children[char]
        
        # If we've found a word, add it to the result and remove it from the trie
        if node.word:
            result.append(node.word)
            node.word = None  # Avoid duplicate words
        
        # Mark the current cell as visited
        board[i][j] = '#'
        
        # Explore all four adjacent cells
        backtrack(i+1, j, node)
        backtrack(i-1, j, node)
        backtrack(i, j+1, node)
        backtrack(i, j-1, node)
        
        # Restore the original value of the cell
        board[i][j] = char
    
    # Try starting from each cell in the board
    for i in range(m):
        for j in range(n):
            backtrack(i, j, trie.root)
    
    return result
```

**Time Complexity:** O(m * n * 4^L) where m and n are the dimensions of the board and L is the maximum length of a word in the words list. For each cell, we potentially explore 4 adjacent cells, and we can go up to L levels deep in the recursion.
**Space Complexity:** O(k) where k is the total number of characters in all words in the words list. This is the space required to build the trie.

### 2. Alternative Solution - Trie with Pruning

Build a trie from the list of words and use backtracking with pruning to explore the board.

```python
class TrieNode:
    def __init__(self):
        self.children = {}  # Dictionary of child nodes (key: character, value: node)
        self.word = None  # Store the word at the end node for easy retrieval
        self.count = 0  # Count of words that have this node in their path

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
            node.count += 1
        node.word = word
    
    def remove(self, word):
        # Remove a word from the trie
        nodes = []
        node = self.root
        for char in word:
            nodes.append(node)
            node = node.children[char]
        
        # Decrement the count of each node in the path
        for i in range(len(word) - 1, -1, -1):
            char = word[i]
            parent = nodes[i]
            child = parent.children[char]
            child.count -= 1
            if child.count == 0:
                del parent.children[char]

def findWords(board, words):
    # Build a trie from the list of words
    trie = Trie()
    for word in words:
        trie.insert(word)
    
    m, n = len(board), len(board[0])
    result = []
    
    def backtrack(i, j, node):
        # Check if the current cell is out of bounds or doesn't match any character in the trie
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] not in node.children:
            return
        
        char = board[i][j]
        node = node.children[char]
        
        # If we've found a word, add it to the result and remove it from the trie
        if node.word:
            result.append(node.word)
            trie.remove(node.word)
            node.word = None  # Avoid duplicate words
        
        # Mark the current cell as visited
        board[i][j] = '#'
        
        # Explore all four adjacent cells
        backtrack(i+1, j, node)
        backtrack(i-1, j, node)
        backtrack(i, j+1, node)
        backtrack(i, j-1, node)
        
        # Restore the original value of the cell
        board[i][j] = char
    
    # Try starting from each cell in the board
    for i in range(m):
        for j in range(n):
            backtrack(i, j, trie.root)
    
    return result
```

**Time Complexity:** O(m * n * 4^L) where m and n are the dimensions of the board and L is the maximum length of a word in the words list. For each cell, we potentially explore 4 adjacent cells, and we can go up to L levels deep in the recursion.
**Space Complexity:** O(k) where k is the total number of characters in all words in the words list. This is the space required to build the trie.

### 3. Alternative Solution - Backtracking for Each Word

Use backtracking to search for each word individually.

```python
def findWords(board, words):
    m, n = len(board), len(board[0])
    result = []
    
    def backtrack(i, j, word, index, visited):
        # If we've matched all characters in the word, return True
        if index == len(word):
            return True
        
        # Check if the current cell is out of bounds, already visited, or doesn't match the current character
        if (i < 0 or i >= m or j < 0 or j >= n or
            (i, j) in visited or board[i][j] != word[index]):
            return False
        
        # Mark the current cell as visited
        visited.add((i, j))
        
        # Explore all four adjacent cells
        found = (backtrack(i+1, j, word, index+1, visited) or
                 backtrack(i-1, j, word, index+1, visited) or
                 backtrack(i, j+1, word, index+1, visited) or
                 backtrack(i, j-1, word, index+1, visited))
        
        # Remove the current cell from the visited set (backtrack)
        visited.remove((i, j))
        
        return found
    
    # Try to find each word
    for word in words:
        found = False
        for i in range(m):
            for j in range(n):
                if backtrack(i, j, word, 0, set()):
                    result.append(word)
                    found = True
                    break
            if found:
                break
    
    return result
```

**Time Complexity:** O(w * m * n * 4^L) where w is the number of words, m and n are the dimensions of the board, and L is the maximum length of a word in the words list. For each word, we potentially start from each cell and explore 4 adjacent cells, and we can go up to L levels deep in the recursion.
**Space Complexity:** O(L) for the recursion stack and the visited set, where L is the maximum length of a word in the words list.

## Solution Choice and Explanation

The trie with backtracking solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It efficiently searches for all words in a single pass of the board, rather than searching for each word individually.

2. **Pruning**: It naturally prunes the search space by following only the paths that could potentially lead to a word in the trie.

3. **Space Efficiency**: It uses a trie to store the words, which is memory-efficient for words with common prefixes.

The key insight of this approach is to build a trie from the list of words and then use backtracking to explore the board. For each cell in the board, we start a backtracking search to explore all possible paths, checking if the current path forms a word in the trie.

For example, let's trace through the algorithm for the first example:
1. Build a trie from the words ["oath", "pea", "eat", "rain"]
2. Start backtracking from each cell in the board:
   - Start from (0, 0): board[0][0] = 'o'
     - 'o' is in the trie, so continue
     - Mark (0, 0) as visited
     - Try (1, 0): board[1][0] = 'e'
       - 'e' is not a child of 'o' in the trie, so backtrack
     - Try (0, 1): board[0][1] = 'a'
       - 'a' is a child of 'o' in the trie, so continue
       - Mark (0, 1) as visited
       - Try (1, 1): board[1][1] = 't'
         - 't' is a child of 'a' in the trie, so continue
         - Mark (1, 1) as visited
         - Try (2, 1): board[2][1] = 'h'
           - 'h' is a child of 't' in the trie, so continue
           - Mark (2, 1) as visited
           - This forms the word "oath", so add it to the result
           - Continue exploring...
         - Restore (1, 1)
       - Restore (0, 1)
     - Restore (0, 0)
   - Continue with other cells...

The trie with pruning solution (Solution 2) is an optimization that removes words from the trie as they are found, which can further prune the search space. The backtracking for each word solution (Solution 3) is simpler but less efficient, as it searches for each word individually.

In an interview, I would first mention the trie with backtracking solution as the most efficient approach for this problem, and then discuss the pruning optimization if asked for further optimizations.
