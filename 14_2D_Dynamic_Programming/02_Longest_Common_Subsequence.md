# Longest Common Subsequence

## Problem Statement

Given two strings `text1` and `text2`, return the length of their longest common subsequence. If there is no common subsequence, return `0`.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

For example, `"ace"` is a subsequence of `"abcde"`.

A common subsequence of two strings is a subsequence that is common to both strings.

**Example 1:**
```
Input: text1 = "abcde", text2 = "ace" 
Output: 3  
Explanation: The longest common subsequence is "ace" and its length is 3.
```

**Example 2:**
```
Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: The longest common subsequence is "abc" and its length is 3.
```

**Example 3:**
```
Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: There is no such common subsequence, so the result is 0.
```

**Constraints:**
- `1 <= text1.length, text2.length <= 1000`
- `text1` and `text2` consist of only lowercase English characters.

## Concept Overview

The Longest Common Subsequence (LCS) problem is a classic example of dynamic programming. The key insight is to build a 2D table where each cell (i, j) represents the length of the LCS of the substrings text1[0...i-1] and text2[0...j-1]. We can then use this table to find the length of the LCS of the entire strings.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def longestCommonSubsequence(text1, text2):
    # Ensure text1 is the shorter string for space optimization
    if len(text1) > len(text2):
        text1, text2 = text2, text1
    
    m, n = len(text1), len(text2)
    
    # Initialize a 1D array to represent the current row
    dp = [0] * (m + 1)
    
    # Fill the dp array row by row
    for i in range(1, n + 1):
        prev = 0  # Store the value of dp[j-1] from the previous iteration
        for j in range(1, m + 1):
            temp = dp[j]
            if text2[i - 1] == text1[j - 1]:
                dp[j] = prev + 1
            else:
                dp[j] = max(dp[j], dp[j - 1])
            prev = temp
    
    return dp[m]
```

**Time Complexity:** O(m * n) - We iterate through each cell in the 2D table.
**Space Complexity:** O(min(m, n)) - We only use a 1D array to store the length of the LCS for the current row.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def longestCommonSubsequence(text1, text2):
    m, n = len(text1), len(text2)
    
    # Initialize a 2D array to represent the length of the LCS
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Fill the dp array
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i - 1] == text2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1] + 1
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
    
    return dp[m][n]
```

**Time Complexity:** O(m * n) - We iterate through each cell in the 2D table.
**Space Complexity:** O(m * n) - We use a 2D array to store the length of the LCS for each substring.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def longestCommonSubsequence(text1, text2):
    m, n = len(text1), len(text2)
    memo = {}
    
    def dp(i, j):
        if i == 0 or j == 0:
            return 0
        
        if (i, j) in memo:
            return memo[(i, j)]
        
        if text1[i - 1] == text2[j - 1]:
            memo[(i, j)] = dp(i - 1, j - 1) + 1
        else:
            memo[(i, j)] = max(dp(i - 1, j), dp(i, j - 1))
        
        return memo[(i, j)]
    
    return dp(m, n)
```

**Time Complexity:** O(m * n) - We have m * n possible states (i, j), and each state takes O(1) time to compute.
**Space Complexity:** O(m * n) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Tabulation solution (Solution 2) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(m * n).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the length of the LCS of two strings.

While the Space Optimization solution (Solution 1) has a better space complexity of O(min(m, n)), it's more complex and harder to understand. For educational purposes, the tabulation solution is clearer.

The key insight of this approach is to build a 2D table where each cell (i, j) represents the length of the LCS of the substrings text1[0...i-1] and text2[0...j-1]. We can then use this table to find the length of the LCS of the entire strings.

For example, let's trace through the algorithm for text1 = "abcde" and text2 = "ace":

1. Initialize dp = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]

2. Fill the dp array:
   - i = 1, j = 1: text1[0] = 'a', text2[0] = 'a', they match, so dp[1][1] = dp[0][0] + 1 = 0 + 1 = 1
   - i = 1, j = 2: text1[0] = 'a', text2[1] = 'c', they don't match, so dp[1][2] = max(dp[0][2], dp[1][1]) = max(0, 1) = 1
   - i = 1, j = 3: text1[0] = 'a', text2[2] = 'e', they don't match, so dp[1][3] = max(dp[0][3], dp[1][2]) = max(0, 1) = 1
   - i = 2, j = 1: text1[1] = 'b', text2[0] = 'a', they don't match, so dp[2][1] = max(dp[1][1], dp[2][0]) = max(1, 0) = 1
   - i = 2, j = 2: text1[1] = 'b', text2[1] = 'c', they don't match, so dp[2][2] = max(dp[1][2], dp[2][1]) = max(1, 1) = 1
   - i = 2, j = 3: text1[1] = 'b', text2[2] = 'e', they don't match, so dp[2][3] = max(dp[1][3], dp[2][2]) = max(1, 1) = 1
   - i = 3, j = 1: text1[2] = 'c', text2[0] = 'a', they don't match, so dp[3][1] = max(dp[2][1], dp[3][0]) = max(1, 0) = 1
   - i = 3, j = 2: text1[2] = 'c', text2[1] = 'c', they match, so dp[3][2] = dp[2][1] + 1 = 1 + 1 = 2
   - i = 3, j = 3: text1[2] = 'c', text2[2] = 'e', they don't match, so dp[3][3] = max(dp[2][3], dp[3][2]) = max(1, 2) = 2
   - i = 4, j = 1: text1[3] = 'd', text2[0] = 'a', they don't match, so dp[4][1] = max(dp[3][1], dp[4][0]) = max(1, 0) = 1
   - i = 4, j = 2: text1[3] = 'd', text2[1] = 'c', they don't match, so dp[4][2] = max(dp[3][2], dp[4][1]) = max(2, 1) = 2
   - i = 4, j = 3: text1[3] = 'd', text2[2] = 'e', they don't match, so dp[4][3] = max(dp[3][3], dp[4][2]) = max(2, 2) = 2
   - i = 5, j = 1: text1[4] = 'e', text2[0] = 'a', they don't match, so dp[5][1] = max(dp[4][1], dp[5][0]) = max(1, 0) = 1
   - i = 5, j = 2: text1[4] = 'e', text2[1] = 'c', they don't match, so dp[5][2] = max(dp[4][2], dp[5][1]) = max(2, 1) = 2
   - i = 5, j = 3: text1[4] = 'e', text2[2] = 'e', they match, so dp[5][3] = dp[4][2] + 1 = 2 + 1 = 3

3. Return dp[m][n] = dp[5][3] = 3

The Recursive with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people. The Dynamic Programming with Space Optimization solution (Solution 1) is the most space-efficient but is more complex.

In an interview, I would first mention the Dynamic Programming with Tabulation solution as the most intuitive approach for this problem, and then discuss the Space Optimization and Recursive with Memoization solutions as alternatives if asked for different approaches.
