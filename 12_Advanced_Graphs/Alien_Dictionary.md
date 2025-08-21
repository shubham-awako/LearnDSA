# Alien Dictionary

## Problem Statement

There is a new alien language that uses the English alphabet. However, the order among the letters is unknown to you.

You are given a list of strings `words` from the alien language's dictionary, where the strings in `words` are sorted lexicographically by the rules of this new language.

Return a string of the unique letters in the new alien language sorted in lexicographically increasing order by the new language's rules. If there is no solution, return `""`. If there are multiple solutions, return any of them.

**Example 1:**
```
Input: words = ["wrt","wrf","er","ett","rftt"]
Output: "wertf"
```

**Example 2:**
```
Input: words = ["z","x"]
Output: "zx"
```

**Example 3:**
```
Input: words = ["z","x","z"]
Output: ""
Explanation: The order is invalid, so return "".
```

**Constraints:**
- `1 <= words.length <= 100`
- `1 <= words[i].length <= 100`
- `words[i]` consists of only lowercase English letters.

## Concept Overview

This problem asks us to determine the order of letters in an alien language, given a sorted list of words. The key insight is to build a directed graph where each node is a letter, and an edge from letter A to letter B indicates that A comes before B in the alien language. Then, we perform a topological sort on this graph to get the order of letters.

## Solutions

### 1. Best Optimized Solution - Topological Sort with DFS

Use Depth-First Search to perform a topological sort on the graph.

```python
def alienOrder(words):
    # Build the graph
    graph = {}
    in_degree = {}
    
    # Initialize the graph and in-degree
    for word in words:
        for char in word:
            graph[char] = set()
            in_degree[char] = 0
    
    # Build the graph
    for i in range(len(words) - 1):
        word1 = words[i]
        word2 = words[i + 1]
        
        # Check if word2 is a prefix of word1
        if len(word1) > len(word2) and word1[:len(word2)] == word2:
            return ""
        
        # Find the first different character
        for j in range(min(len(word1), len(word2))):
            if word1[j] != word2[j]:
                if word2[j] not in graph[word1[j]]:
                    graph[word1[j]].add(word2[j])
                    in_degree[word2[j]] += 1
                break
    
    # Topological sort using DFS
    visited = {}
    result = []
    
    def dfs(char):
        # If the character is already in the current path, there is a cycle
        if char in visited and visited[char] == 0:
            return False
        
        # If the character has already been processed, skip it
        if char in visited and visited[char] == 1:
            return True
        
        # Mark the character as being visited
        visited[char] = 0
        
        # Visit all neighbors
        for neighbor in graph[char]:
            if not dfs(neighbor):
                return False
        
        # Mark the character as visited
        visited[char] = 1
        
        # Add the character to the result
        result.append(char)
        
        return True
    
    # Perform DFS on all characters
    for char in graph:
        if char not in visited:
            if not dfs(char):
                return ""
    
    # Reverse the result to get the correct order
    return "".join(result[::-1])
```

**Time Complexity:** O(n) - We need to build the graph, which takes O(n) time, where n is the total number of characters in all words, and then perform a topological sort, which takes O(V + E) time, where V is the number of vertices (at most 26) and E is the number of edges (at most 26^2).
**Space Complexity:** O(1) - We need to store the graph and the visited map, which have a constant size (at most 26).

### 2. Alternative Solution - Topological Sort with BFS (Kahn's Algorithm)

Use Breadth-First Search to perform a topological sort on the graph.

```python
from collections import deque

def alienOrder(words):
    # Build the graph
    graph = {}
    in_degree = {}
    
    # Initialize the graph and in-degree
    for word in words:
        for char in word:
            graph[char] = set()
            in_degree[char] = 0
    
    # Build the graph
    for i in range(len(words) - 1):
        word1 = words[i]
        word2 = words[i + 1]
        
        # Check if word2 is a prefix of word1
        if len(word1) > len(word2) and word1[:len(word2)] == word2:
            return ""
        
        # Find the first different character
        for j in range(min(len(word1), len(word2))):
            if word1[j] != word2[j]:
                if word2[j] not in graph[word1[j]]:
                    graph[word1[j]].add(word2[j])
                    in_degree[word2[j]] += 1
                break
    
    # Topological sort using BFS
    queue = deque([char for char in in_degree if in_degree[char] == 0])
    result = []
    
    while queue:
        char = queue.popleft()
        result.append(char)
        
        for neighbor in graph[char]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)
    
    # Check if all characters are included in the result
    if len(result) != len(in_degree):
        return ""
    
    return "".join(result)
```

**Time Complexity:** O(n) - We need to build the graph, which takes O(n) time, where n is the total number of characters in all words, and then perform a topological sort, which takes O(V + E) time, where V is the number of vertices (at most 26) and E is the number of edges (at most 26^2).
**Space Complexity:** O(1) - We need to store the graph, the in-degree map, and the queue, which have a constant size (at most 26).

### 3. Alternative Solution - Topological Sort with DFS and Adjacency Matrix

Use Depth-First Search with an adjacency matrix to perform a topological sort on the graph.

```python
def alienOrder(words):
    # Build the graph
    graph = [[False] * 26 for _ in range(26)]
    in_degree = [0] * 26
    seen = [False] * 26
    
    # Mark the characters that appear in the words
    for word in words:
        for char in word:
            seen[ord(char) - ord('a')] = True
    
    # Build the graph
    for i in range(len(words) - 1):
        word1 = words[i]
        word2 = words[i + 1]
        
        # Check if word2 is a prefix of word1
        if len(word1) > len(word2) and word1[:len(word2)] == word2:
            return ""
        
        # Find the first different character
        for j in range(min(len(word1), len(word2))):
            if word1[j] != word2[j]:
                c1 = ord(word1[j]) - ord('a')
                c2 = ord(word2[j]) - ord('a')
                
                if not graph[c1][c2]:
                    graph[c1][c2] = True
                    in_degree[c2] += 1
                break
    
    # Topological sort using DFS
    visited = [0] * 26  # 0 = not visited, 1 = visiting, 2 = visited
    result = []
    
    def dfs(char):
        # If the character is already in the current path, there is a cycle
        if visited[char] == 1:
            return False
        
        # If the character has already been processed, skip it
        if visited[char] == 2:
            return True
        
        # Mark the character as being visited
        visited[char] = 1
        
        # Visit all neighbors
        for neighbor in range(26):
            if graph[char][neighbor] and not dfs(neighbor):
                return False
        
        # Mark the character as visited
        visited[char] = 2
        
        # Add the character to the result
        result.append(chr(char + ord('a')))
        
        return True
    
    # Perform DFS on all characters
    for char in range(26):
        if seen[char] and visited[char] == 0:
            if not dfs(char):
                return ""
    
    # Reverse the result to get the correct order
    return "".join(result[::-1])
```

**Time Complexity:** O(n) - We need to build the graph, which takes O(n) time, where n is the total number of characters in all words, and then perform a topological sort, which takes O(V^2) time, where V is the number of vertices (at most 26).
**Space Complexity:** O(1) - We need to store the graph, the in-degree array, and the visited array, which have a constant size (at most 26).

## Solution Choice and Explanation

The Topological Sort with BFS (Kahn's Algorithm) solution (Solution 2) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1).

3. **Intuitiveness**: It naturally maps to the concept of finding the order of letters in the alien language.

The key insight of this approach is to build a directed graph where each node is a letter, and an edge from letter A to letter B indicates that A comes before B in the alien language. Then, we perform a topological sort on this graph to get the order of letters. If there is a cycle in the graph, it means the order is invalid, so we return an empty string.

For example, let's trace through the algorithm for the first example:
```
words = ["wrt","wrf","er","ett","rftt"]
```

1. Build the graph:
   - Initialize graph and in_degree:
     - graph = {'w': set(), 'r': set(), 't': set(), 'f': set(), 'e': set()}
     - in_degree = {'w': 0, 'r': 0, 't': 0, 'f': 0, 'e': 0}
   - Compare "wrt" and "wrf":
     - First different character: 't' and 'f'
     - Add edge from 't' to 'f': graph['t'].add('f'), in_degree['f'] += 1
   - Compare "wrf" and "er":
     - First different character: 'w' and 'e'
     - Add edge from 'w' to 'e': graph['w'].add('e'), in_degree['e'] += 1
   - Compare "er" and "ett":
     - First different character: 'r' and 't'
     - Add edge from 'r' to 't': graph['r'].add('t'), in_degree['t'] += 1
   - Compare "ett" and "rftt":
     - First different character: 'e' and 'r'
     - Add edge from 'e' to 'r': graph['e'].add('r'), in_degree['r'] += 1
   - Final graph:
     - graph = {'w': {'e'}, 'r': {'t'}, 't': {'f'}, 'f': set(), 'e': {'r'}}
     - in_degree = {'w': 0, 'r': 1, 't': 1, 'f': 1, 'e': 1}

2. Topological sort using BFS:
   - Initialize queue with characters that have in-degree 0: queue = ['w']
   - Initialize result: result = []
   - BFS:
     - Dequeue 'w':
       - Add 'w' to result: result = ['w']
       - Reduce in-degree of neighbors:
         - in_degree['e'] -= 1, in_degree['e'] = 0
         - Add 'e' to queue: queue = ['e']
     - Dequeue 'e':
       - Add 'e' to result: result = ['w', 'e']
       - Reduce in-degree of neighbors:
         - in_degree['r'] -= 1, in_degree['r'] = 0
         - Add 'r' to queue: queue = ['r']
     - Dequeue 'r':
       - Add 'r' to result: result = ['w', 'e', 'r']
       - Reduce in-degree of neighbors:
         - in_degree['t'] -= 1, in_degree['t'] = 0
         - Add 't' to queue: queue = ['t']
     - Dequeue 't':
       - Add 't' to result: result = ['w', 'e', 'r', 't']
       - Reduce in-degree of neighbors:
         - in_degree['f'] -= 1, in_degree['f'] = 0
         - Add 'f' to queue: queue = ['f']
     - Dequeue 'f':
       - Add 'f' to result: result = ['w', 'e', 'r', 't', 'f']
       - No neighbors, so continue
     - Queue is empty, BFS complete

3. Check if all characters are included in the result:
   - len(result) = 5, len(in_degree) = 5, so all characters are included

4. Final result: "wertf"

The Topological Sort with DFS solution (Solution 1) is also efficient but may be less intuitive for some people. The Topological Sort with DFS and Adjacency Matrix solution (Solution 3) is less efficient for sparse graphs but may be more efficient for dense graphs.

In an interview, I would first mention the Topological Sort with BFS solution as the most intuitive approach for this problem, and then discuss the Topological Sort with DFS and Adjacency Matrix solutions as alternatives if asked for different approaches.
