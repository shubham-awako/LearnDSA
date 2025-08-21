# Edit Distance

## Problem Statement

Given two strings `word1` and `word2`, return the minimum number of operations required to convert `word1` to `word2`.

You have the following three operations permitted on a word:
- Insert a character
- Delete a character
- Replace a character

**Example 1:**
```
Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation: 
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')
```

**Example 2:**
```
Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation: 
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')
```

**Constraints:**
- `0 <= word1.length, word2.length <= 500`
- `word1` and `word2` consist of lowercase English letters.

## Concept Overview

This problem is a classic example of dynamic programming, specifically the Levenshtein distance problem. The key insight is to define a state that represents the minimum number of operations required to convert a prefix of word1 to a prefix of word2. We can then use this state to build the solution.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def minDistance(word1, word2):
    m, n = len(word1), len(word2)
    
    # If one of the strings is empty, the distance is the length of the other string
    if m == 0:
        return n
    if n == 0:
        return m
    
    # Initialize the dp array
    # dp[j] represents the minimum number of operations to convert word1[:i] to word2[:j]
    dp = list(range(n + 1))
    
    # Fill the dp array
    for i in range(1, m + 1):
        prev = dp[0]
        dp[0] = i
        
        for j in range(1, n + 1):
            temp = dp[j]
            
            if word1[i - 1] == word2[j - 1]:
                dp[j] = prev
            else:
                dp[j] = 1 + min(prev, dp[j], dp[j - 1])
            
            prev = temp
    
    return dp[n]
```

**Time Complexity:** O(m * n) - We iterate through each combination of prefixes of word1 and word2.
**Space Complexity:** O(n) - We use a 1D array to store the minimum number of operations.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def minDistance(word1, word2):
    m, n = len(word1), len(word2)
    
    # Initialize the dp array
    # dp[i][j] represents the minimum number of operations to convert word1[:i] to word2[:j]
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Base cases: converting to an empty string
    for i in range(m + 1):
        dp[i][0] = i
    for j in range(n + 1):
        dp[0][j] = j
    
    # Fill the dp array
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if word1[i - 1] == word2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1]
            else:
                dp[i][j] = 1 + min(dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1])
    
    return dp[m][n]
```

**Time Complexity:** O(m * n) - We iterate through each combination of prefixes of word1 and word2.
**Space Complexity:** O(m * n) - We use a 2D array to store the minimum number of operations.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def minDistance(word1, word2):
    m, n = len(word1), len(word2)
    memo = {}
    
    def dp(i, j):
        if i == 0:
            return j
        if j == 0:
            return i
        
        if (i, j) in memo:
            return memo[(i, j)]
        
        if word1[i - 1] == word2[j - 1]:
            memo[(i, j)] = dp(i - 1, j - 1)
        else:
            memo[(i, j)] = 1 + min(dp(i - 1, j - 1), dp(i - 1, j), dp(i, j - 1))
        
        return memo[(i, j)]
    
    return dp(m, n)
```

**Time Complexity:** O(m * n) - We have m * n possible states (i, j), and each state takes O(1) time to compute.
**Space Complexity:** O(m * n) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(n), which is better than the O(m * n) space complexity of the tabulation solution.

2. **Simplicity**: It's a straightforward solution that captures the essence of the problem.

3. **Intuitiveness**: It naturally maps to the concept of finding the minimum number of operations to convert one string to another.

The key insight of this approach is to use a 1D array to keep track of the minimum number of operations required to convert a prefix of word1 to a prefix of word2. For each position (i, j), we have three possible operations:
1. Replace: If the current characters are different, we can replace the character in word1 with the character in word2.
2. Delete: We can delete the current character in word1.
3. Insert: We can insert the current character of word2 into word1.

For example, let's trace through the algorithm for word1 = "horse" and word2 = "ros":

1. Initialize dp = [0, 1, 2, 3]

2. Fill the dp array:
   - i = 1 (word1[0] = 'h'):
     - prev = dp[0] = 0
     - dp[0] = 1
     - j = 1 (word2[0] = 'r'): word1[0] != word2[0], so dp[1] = 1 + min(prev, dp[1], dp[0]) = 1 + min(0, 1, 1) = 1
     - j = 2 (word2[1] = 'o'): word1[0] != word2[1], so dp[2] = 1 + min(dp[1], dp[2], dp[1]) = 1 + min(1, 2, 1) = 2
     - j = 3 (word2[2] = 's'): word1[0] != word2[2], so dp[3] = 1 + min(dp[2], dp[3], dp[2]) = 1 + min(2, 3, 2) = 3
     - dp = [1, 1, 2, 3]
   - i = 2 (word1[1] = 'o'):
     - prev = dp[0] = 1
     - dp[0] = 2
     - j = 1 (word2[0] = 'r'): word1[1] != word2[0], so dp[1] = 1 + min(prev, dp[1], dp[0]) = 1 + min(1, 1, 2) = 2
     - j = 2 (word2[1] = 'o'): word1[1] == word2[1], so dp[2] = prev = 1
     - j = 3 (word2[2] = 's'): word1[1] != word2[2], so dp[3] = 1 + min(dp[2], dp[3], dp[2]) = 1 + min(1, 3, 1) = 2
     - dp = [2, 2, 1, 2]
   - i = 3 (word1[2] = 'r'):
     - prev = dp[0] = 2
     - dp[0] = 3
     - j = 1 (word2[0] = 'r'): word1[2] == word2[0], so dp[1] = prev = 2
     - j = 2 (word2[1] = 'o'): word1[2] != word2[1], so dp[2] = 1 + min(dp[1], dp[2], dp[1]) = 1 + min(2, 1, 2) = 2
     - j = 3 (word2[2] = 's'): word1[2] != word2[2], so dp[3] = 1 + min(dp[2], dp[3], dp[2]) = 1 + min(2, 2, 2) = 3
     - dp = [3, 2, 2, 3]
   - i = 4 (word1[3] = 's'):
     - prev = dp[0] = 3
     - dp[0] = 4
     - j = 1 (word2[0] = 'r'): word1[3] != word2[0], so dp[1] = 1 + min(prev, dp[1], dp[0]) = 1 + min(3, 2, 4) = 3
     - j = 2 (word2[1] = 'o'): word1[3] != word2[1], so dp[2] = 1 + min(dp[1], dp[2], dp[1]) = 1 + min(3, 2, 3) = 3
     - j = 3 (word2[2] = 's'): word1[3] == word2[2], so dp[3] = prev = 2
     - dp = [4, 3, 3, 2]
   - i = 5 (word1[4] = 'e'):
     - prev = dp[0] = 4
     - dp[0] = 5
     - j = 1 (word2[0] = 'r'): word1[4] != word2[0], so dp[1] = 1 + min(prev, dp[1], dp[0]) = 1 + min(4, 3, 5) = 4
     - j = 2 (word2[1] = 'o'): word1[4] != word2[1], so dp[2] = 1 + min(dp[1], dp[2], dp[1]) = 1 + min(4, 3, 4) = 4
     - j = 3 (word2[2] = 's'): word1[4] != word2[2], so dp[3] = 1 + min(dp[2], dp[3], dp[2]) = 1 + min(4, 2, 4) = 3
     - dp = [5, 4, 4, 3]

3. Return dp[n] = dp[3] = 3

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Recursive with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
