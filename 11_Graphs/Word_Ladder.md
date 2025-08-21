# Word Ladder

## Problem Statement

A transformation sequence from word `beginWord` to word `endWord` using a dictionary `wordList` is a sequence of words `beginWord -> s1 -> s2 -> ... -> sk` such that:

- Every adjacent pair of words differs by a single letter.
- Every `si` for `1 <= i <= k` is in `wordList`. Note that `beginWord` does not need to be in `wordList`.
- `sk == endWord`

Given two words, `beginWord` and `endWord`, and a dictionary `wordList`, return the number of words in the shortest transformation sequence from `beginWord` to `endWord`, or `0` if no such sequence exists.

**Example 1:**
```
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
Output: 5
Explanation: One shortest transformation sequence is "hit" -> "hot" -> "dot" -> "dog" -> "cog", which is 5 words long.
```

**Example 2:**
```
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
Output: 0
Explanation: The endWord "cog" is not in wordList, so there is no valid transformation sequence.
```

**Constraints:**
- `1 <= beginWord.length <= 10`
- `endWord.length == beginWord.length`
- `1 <= wordList.length <= 5000`
- `wordList[i].length == beginWord.length`
- `beginWord`, `endWord`, and `wordList[i]` consist of lowercase English letters.
- `beginWord != endWord`
- All the words in `wordList` are unique.

## Concept Overview

This problem tests your understanding of graph traversal, particularly Breadth-First Search (BFS). The key insight is to represent the words as nodes in a graph, where two words are connected by an edge if they differ by exactly one letter. Then, we can use BFS to find the shortest path from `beginWord` to `endWord`.

## Solutions

### 1. Best Optimized Solution - BFS with Word Pattern

Use Breadth-First Search with word patterns to efficiently find the shortest path.

```python
from collections import deque, defaultdict

def ladderLength(beginWord, endWord, wordList):
    # If endWord is not in wordList, return 0
    if endWord not in wordList:
        return 0
    
    # Add beginWord to wordList for convenience
    wordList = set(wordList)
    
    # Create a dictionary of word patterns
    word_patterns = defaultdict(list)
    word_length = len(beginWord)
    
    for word in wordList:
        for i in range(word_length):
            pattern = word[:i] + '*' + word[i+1:]
            word_patterns[pattern].append(word)
    
    # BFS to find the shortest path
    queue = deque([(beginWord, 1)])
    visited = {beginWord}
    
    while queue:
        word, level = queue.popleft()
        
        # Try all possible one-letter transformations
        for i in range(word_length):
            pattern = word[:i] + '*' + word[i+1:]
            
            # Check all words that match the pattern
            for next_word in word_patterns[pattern]:
                if next_word == endWord:
                    return level + 1
                
                if next_word not in visited:
                    visited.add(next_word)
                    queue.append((next_word, level + 1))
            
            # Clear the pattern to avoid revisiting
            word_patterns[pattern] = []
    
    return 0
```

**Time Complexity:** O(N * L^2) - We process each word in the wordList, and for each word, we generate L patterns, each of which takes O(L) time, where N is the number of words and L is the length of each word.
**Space Complexity:** O(N * L) - We store the word patterns and the queue.

### 2. Alternative Solution - Bidirectional BFS

Use Bidirectional BFS to find the shortest path from both ends.

```python
from collections import deque, defaultdict

def ladderLength(beginWord, endWord, wordList):
    # If endWord is not in wordList, return 0
    if endWord not in wordList:
        return 0
    
    # Add beginWord to wordList for convenience
    wordList = set(wordList)
    
    # Create a dictionary of word patterns
    word_patterns = defaultdict(list)
    word_length = len(beginWord)
    
    for word in wordList:
        for i in range(word_length):
            pattern = word[:i] + '*' + word[i+1:]
            word_patterns[pattern].append(word)
    
    # Bidirectional BFS
    begin_queue = deque([beginWord])
    end_queue = deque([endWord])
    begin_visited = {beginWord: 1}
    end_visited = {endWord: 1}
    
    while begin_queue and end_queue:
        # Process the queue with fewer elements
        if len(begin_queue) <= len(end_queue):
            level = bidirectional_bfs(begin_queue, begin_visited, end_visited, word_patterns, word_length)
        else:
            level = bidirectional_bfs(end_queue, end_visited, begin_visited, word_patterns, word_length)
        
        if level:
            return level
    
    return 0

def bidirectional_bfs(queue, visited, other_visited, word_patterns, word_length):
    size = len(queue)
    
    for _ in range(size):
        word = queue.popleft()
        level = visited[word]
        
        # Try all possible one-letter transformations
        for i in range(word_length):
            pattern = word[:i] + '*' + word[i+1:]
            
            # Check all words that match the pattern
            for next_word in word_patterns[pattern]:
                # If the word has been visited from the other end
                if next_word in other_visited:
                    return level + other_visited[next_word]
                
                if next_word not in visited:
                    visited[next_word] = level + 1
                    queue.append(next_word)
    
    return None
```

**Time Complexity:** O(N * L^2) - We process each word in the wordList, and for each word, we generate L patterns, each of which takes O(L) time, where N is the number of words and L is the length of each word.
**Space Complexity:** O(N * L) - We store the word patterns and the queues.

### 3. Alternative Solution - BFS with Direct Comparison

Use Breadth-First Search with direct comparison to find the shortest path.

```python
from collections import deque

def ladderLength(beginWord, endWord, wordList):
    # If endWord is not in wordList, return 0
    if endWord not in wordList:
        return 0
    
    # Add beginWord to wordList for convenience
    wordList = set(wordList)
    
    # BFS to find the shortest path
    queue = deque([(beginWord, 1)])
    visited = {beginWord}
    
    while queue:
        word, level = queue.popleft()
        
        # Try all possible one-letter transformations
        for i in range(len(word)):
            for c in 'abcdefghijklmnopqrstuvwxyz':
                next_word = word[:i] + c + word[i+1:]
                
                if next_word == endWord:
                    return level + 1
                
                if next_word in wordList and next_word not in visited:
                    visited.add(next_word)
                    queue.append((next_word, level + 1))
    
    return 0
```

**Time Complexity:** O(N * L * 26) - We process each word in the wordList, and for each word, we try 26 different characters at each of the L positions, where N is the number of words and L is the length of each word.
**Space Complexity:** O(N) - We store the visited set and the queue.

## Solution Choice and Explanation

The BFS with Word Pattern solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(N * L^2) time complexity, which is optimal for this problem, and the space complexity is O(N * L).

2. **Intuitiveness**: It naturally maps to the concept of finding the shortest path in a graph, where words are nodes and edges connect words that differ by one letter.

3. **Optimization**: It uses word patterns to efficiently find all words that differ by one letter, which is faster than trying all 26 letters at each position.

The key insight of this approach is to use BFS to find the shortest path from `beginWord` to `endWord`. We represent the words as nodes in a graph, where two words are connected by an edge if they differ by exactly one letter. To efficiently find all words that differ by one letter, we use word patterns, where a pattern is a word with one letter replaced by a wildcard character (`*`).

For example, let's trace through the algorithm for the first example:
```
beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
```

1. Create word patterns:
   - "hit": "*it", "h*t", "hi*"
   - "hot": "*ot", "h*t", "ho*"
   - "dot": "*ot", "d*t", "do*"
   - "dog": "*og", "d*g", "do*"
   - "lot": "*ot", "l*t", "lo*"
   - "log": "*og", "l*g", "lo*"
   - "cog": "*og", "c*g", "co*"

2. BFS:
   - Start with "hit" at level 1:
     - Pattern "*it": No matches
     - Pattern "h*t": Matches "hot"
       - Add "hot" to the queue at level 2
     - Pattern "hi*": No matches
   - Process "hot" at level 2:
     - Pattern "*ot": Matches "dot", "lot"
       - Add "dot" and "lot" to the queue at level 3
     - Pattern "h*t": Already processed
     - Pattern "ho*": No matches
   - Process "dot" at level 3:
     - Pattern "*ot": Already processed
     - Pattern "d*t": No matches
     - Pattern "do*": Matches "dog"
       - Add "dog" to the queue at level 4
   - Process "lot" at level 3:
     - Pattern "*ot": Already processed
     - Pattern "l*t": No matches
     - Pattern "lo*": Matches "log"
       - Add "log" to the queue at level 4
   - Process "dog" at level 4:
     - Pattern "*og": Matches "log", "cog"
       - "cog" is the endWord, return level + 1 = 5
     - Pattern "d*g": No matches
     - Pattern "do*": Already processed

3. Final result: 5

The Bidirectional BFS solution (Solution 2) is also efficient and may be preferred in some cases, as it can reduce the search space by exploring from both ends. The BFS with Direct Comparison solution (Solution 3) is simpler but less efficient, as it tries all 26 letters at each position.

In an interview, I would first mention the BFS with Word Pattern solution as the most efficient approach for this problem, and then discuss the Bidirectional BFS and BFS with Direct Comparison solutions as alternatives if asked for different approaches.
