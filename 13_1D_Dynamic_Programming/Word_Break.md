# Word Break

## Problem Statement

Given a string `s` and a dictionary of strings `wordDict`, return `true` if `s` can be segmented into a space-separated sequence of one or more dictionary words.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

**Example 1:**
```
Input: s = "leetcode", wordDict = ["leet","code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".
```

**Example 2:**
```
Input: s = "applepenapple", wordDict = ["apple","pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
Note that you are allowed to reuse a dictionary word.
```

**Example 3:**
```
Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: false
```

**Constraints:**
- `1 <= s.length <= 300`
- `1 <= wordDict.length <= 1000`
- `1 <= wordDict[i].length <= 20`
- `s` and `wordDict[i]` consist of only lowercase English letters.
- All the strings of `wordDict` are unique.

## Concept Overview

This problem is a classic example of dynamic programming. The key insight is to use a boolean array to keep track of whether a substring ending at a certain position can be segmented into dictionary words.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def wordBreak(s, wordDict):
    n = len(s)
    # Convert wordDict to a set for O(1) lookups
    word_set = set(wordDict)
    
    # dp[i] represents whether s[:i] can be segmented into dictionary words
    dp = [False] * (n + 1)
    dp[0] = True  # Empty string can be segmented
    
    for i in range(1, n + 1):
        for j in range(i):
            # If s[:j] can be segmented and s[j:i] is in the dictionary
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break
    
    return dp[n]
```

**Time Complexity:** O(n^2) - We consider all possible substrings of s.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def wordBreak(s, wordDict):
    word_set = set(wordDict)
    memo = {}
    
    def dp(start):
        if start == len(s):
            return True
        
        if start in memo:
            return memo[start]
        
        for end in range(start + 1, len(s) + 1):
            if s[start:end] in word_set and dp(end):
                memo[start] = True
                return True
        
        memo[start] = False
        return False
    
    return dp(0)
```

**Time Complexity:** O(n^2) - We consider all possible substrings of s.
**Space Complexity:** O(n) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - BFS

Use Breadth-First Search to solve the problem.

```python
from collections import deque

def wordBreak(s, wordDict):
    word_set = set(wordDict)
    n = len(s)
    # Use a queue to keep track of the positions we've reached
    queue = deque([0])
    # Use a set to keep track of the positions we've visited
    visited = set()
    
    while queue:
        start = queue.popleft()
        
        if start == n:
            return True
        
        if start in visited:
            continue
        
        visited.add(start)
        
        for end in range(start + 1, n + 1):
            if s[start:end] in word_set:
                queue.append(end)
    
    return False
```

**Time Complexity:** O(n^2) - We consider all possible substrings of s.
**Space Complexity:** O(n) - We use the queue and the visited set to keep track of the positions we've visited.

## Solution Choice and Explanation

The Dynamic Programming with Tabulation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n^2) time complexity, which is optimal for this problem, and the space complexity is O(n).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding whether a string can be segmented into dictionary words.

The key insight of this approach is to use a boolean array to keep track of whether a substring ending at a certain position can be segmented into dictionary words. We can then use this array to determine whether the entire string can be segmented.

For example, let's trace through the algorithm for s = "leetcode" and wordDict = ["leet", "code"]:

1. Initialize:
   - word_set = {"leet", "code"}
   - dp = [True, False, False, False, False, False, False, False, False]

2. Fill the dp array:
   - i = 1:
     - j = 0: dp[0] = True, s[0:1] = "l" not in word_set, so dp[1] remains False
   - i = 2:
     - j = 0: dp[0] = True, s[0:2] = "le" not in word_set, so dp[2] remains False
     - j = 1: dp[1] = False, so skip
   - i = 3:
     - j = 0: dp[0] = True, s[0:3] = "lee" not in word_set, so dp[3] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
   - i = 4:
     - j = 0: dp[0] = True, s[0:4] = "leet" in word_set, so dp[4] = True
     - Break the inner loop
   - i = 5:
     - j = 0: dp[0] = True, s[0:5] = "leetc" not in word_set, so dp[5] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = False, so skip
     - j = 4: dp[4] = True, s[4:5] = "c" not in word_set, so dp[5] remains False
   - i = 6:
     - j = 0: dp[0] = True, s[0:6] = "leetco" not in word_set, so dp[6] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = False, so skip
     - j = 4: dp[4] = True, s[4:6] = "co" not in word_set, so dp[6] remains False
     - j = 5: dp[5] = False, so skip
   - i = 7:
     - j = 0: dp[0] = True, s[0:7] = "leetcod" not in word_set, so dp[7] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = False, so skip
     - j = 4: dp[4] = True, s[4:7] = "cod" not in word_set, so dp[7] remains False
     - j = 5: dp[5] = False, so skip
     - j = 6: dp[6] = False, so skip
   - i = 8:
     - j = 0: dp[0] = True, s[0:8] = "leetcode" not in word_set, so dp[8] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = False, so skip
     - j = 4: dp[4] = True, s[4:8] = "code" in word_set, so dp[8] = True
     - Break the inner loop

3. Return dp[8] = True

For s = "catsandog" and wordDict = ["cats", "dog", "sand", "and", "cat"]:

1. Initialize:
   - word_set = {"cats", "dog", "sand", "and", "cat"}
   - dp = [True, False, False, False, False, False, False, False, False, False]

2. Fill the dp array:
   - i = 1:
     - j = 0: dp[0] = True, s[0:1] = "c" not in word_set, so dp[1] remains False
   - i = 2:
     - j = 0: dp[0] = True, s[0:2] = "ca" not in word_set, so dp[2] remains False
     - j = 1: dp[1] = False, so skip
   - i = 3:
     - j = 0: dp[0] = True, s[0:3] = "cat" in word_set, so dp[3] = True
     - Break the inner loop
   - i = 4:
     - j = 0: dp[0] = True, s[0:4] = "cats" in word_set, so dp[4] = True
     - Break the inner loop
   - i = 5:
     - j = 0: dp[0] = True, s[0:5] = "catsa" not in word_set, so dp[5] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = True, s[3:5] = "sa" not in word_set, so dp[5] remains False
     - j = 4: dp[4] = True, s[4:5] = "a" not in word_set, so dp[5] remains False
   - i = 6:
     - j = 0: dp[0] = True, s[0:6] = "catsan" not in word_set, so dp[6] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = True, s[3:6] = "san" not in word_set, so dp[6] remains False
     - j = 4: dp[4] = True, s[4:6] = "an" not in word_set, so dp[6] remains False
     - j = 5: dp[5] = False, so skip
   - i = 7:
     - j = 0: dp[0] = True, s[0:7] = "catsand" not in word_set, so dp[7] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = True, s[3:7] = "sand" in word_set, so dp[7] = True
     - Break the inner loop
   - i = 8:
     - j = 0: dp[0] = True, s[0:8] = "catsando" not in word_set, so dp[8] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = True, s[3:8] = "sando" not in word_set, so dp[8] remains False
     - j = 4: dp[4] = True, s[4:8] = "ando" not in word_set, so dp[8] remains False
     - j = 5: dp[5] = False, so skip
     - j = 6: dp[6] = False, so skip
     - j = 7: dp[7] = True, s[7:8] = "o" not in word_set, so dp[8] remains False
   - i = 9:
     - j = 0: dp[0] = True, s[0:9] = "catsandog" not in word_set, so dp[9] remains False
     - j = 1: dp[1] = False, so skip
     - j = 2: dp[2] = False, so skip
     - j = 3: dp[3] = True, s[3:9] = "sandog" not in word_set, so dp[9] remains False
     - j = 4: dp[4] = True, s[4:9] = "andog" not in word_set, so dp[9] remains False
     - j = 5: dp[5] = False, so skip
     - j = 6: dp[6] = False, so skip
     - j = 7: dp[7] = True, s[7:9] = "og" not in word_set, so dp[9] remains False
     - j = 8: dp[8] = False, so skip

3. Return dp[9] = False

The Dynamic Programming with Memoization solution (Solution 2) and the BFS solution (Solution 3) are also efficient and may be preferred in some cases, especially when the string is long and the dictionary is small.

In an interview, I would first mention the Dynamic Programming with Tabulation solution as the most intuitive approach for this problem, and then discuss the Dynamic Programming with Memoization and BFS solutions as alternatives if asked for different approaches.
