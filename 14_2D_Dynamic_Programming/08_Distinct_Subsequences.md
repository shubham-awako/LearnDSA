# Distinct Subsequences

## Problem Statement

Given two strings `s` and `t`, return the number of distinct subsequences of `s` which equals `t`.

A string's subsequence is a new string formed from the original string by deleting some (can be none) of the characters without disturbing the remaining characters' relative positions. (i.e., `"ACE"` is a subsequence of `"ABCDE"` while `"AEC"` is not).

The test cases are generated so that the answer fits on a 32-bit signed integer.

**Example 1:**
```
Input: s = "rabbbit", t = "rabbit"
Output: 3
Explanation:
As shown below, there are 3 ways you can get "rabbit" from "rabbbit".
rabbbit
^^^^ ^^
rabbbit
^^ ^^^^
rabbbit
^^^ ^^^
```

**Example 2:**
```
Input: s = "babgbag", t = "bag"
Output: 5
Explanation:
As shown below, there are 5 ways you can get "bag" from "babgbag".
babgbag
^^ ^
babgbag
^^    ^
babgbag
^    ^^
babgbag
  ^  ^^
babgbag
    ^^^
```

**Constraints:**
- `1 <= s.length, t.length <= 1000`
- `s` and `t` consist of lowercase English letters.

## Concept Overview

This problem can be solved using dynamic programming. The key insight is to define a state that represents the number of distinct subsequences of a prefix of s that equal a prefix of t. We can then use this state to build the solution.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def numDistinct(s, t):
    m, n = len(s), len(t)
    
    # Initialize the dp array
    # dp[j] represents the number of distinct subsequences of s[:i] that equal t[:j]
    dp = [0] * (n + 1)
    dp[0] = 1  # Empty string is a subsequence of any string once
    
    # Fill the dp array
    for i in range(1, m + 1):
        for j in range(n, 0, -1):
            if s[i - 1] == t[j - 1]:
                dp[j] += dp[j - 1]
    
    return dp[n]
```

**Time Complexity:** O(m * n) - We iterate through each combination of prefixes of s and t.
**Space Complexity:** O(n) - We use a 1D array to store the number of distinct subsequences.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def numDistinct(s, t):
    m, n = len(s), len(t)
    
    # Initialize the dp array
    # dp[i][j] represents the number of distinct subsequences of s[:i] that equal t[:j]
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Base case: empty string is a subsequence of any string once
    for i in range(m + 1):
        dp[i][0] = 1
    
    # Fill the dp array
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if s[i - 1] == t[j - 1]:
                dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j]
            else:
                dp[i][j] = dp[i - 1][j]
    
    return dp[m][n]
```

**Time Complexity:** O(m * n) - We iterate through each combination of prefixes of s and t.
**Space Complexity:** O(m * n) - We use a 2D array to store the number of distinct subsequences.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def numDistinct(s, t):
    m, n = len(s), len(t)
    memo = {}
    
    def dp(i, j):
        if j == n:
            return 1
        if i == m:
            return 0
        
        if (i, j) in memo:
            return memo[(i, j)]
        
        # Skip the current character in s
        result = dp(i + 1, j)
        
        # Match the current characters in s and t
        if s[i] == t[j]:
            result += dp(i + 1, j + 1)
        
        memo[(i, j)] = result
        return result
    
    return dp(0, 0)
```

**Time Complexity:** O(m * n) - We have m * n possible states (i, j), and each state takes O(1) time to compute.
**Space Complexity:** O(m * n) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(n), which is better than the O(m * n) space complexity of the tabulation solution.

2. **Simplicity**: It's a straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the number of distinct subsequences.

The key insight of this approach is to use a 1D array to keep track of the number of distinct subsequences of a prefix of s that equal a prefix of t. For each position (i, j), we check if the current characters in s and t match. If they do, we can either use the current character in s to match the current character in t, or skip it.

For example, let's trace through the algorithm for s = "rabbbit" and t = "rabbit":

1. Initialize dp = [1, 0, 0, 0, 0, 0, 0]

2. Fill the dp array:
   - i = 1 (s[0] = 'r'):
     - j = 6 (t[5] = 't'): s[0] != t[5], so dp[6] remains 0
     - j = 5 (t[4] = 'i'): s[0] != t[4], so dp[5] remains 0
     - j = 4 (t[3] = 'b'): s[0] != t[3], so dp[4] remains 0
     - j = 3 (t[2] = 'b'): s[0] != t[2], so dp[3] remains 0
     - j = 2 (t[1] = 'a'): s[0] != t[1], so dp[2] remains 0
     - j = 1 (t[0] = 'r'): s[0] == t[0], so dp[1] += dp[0] = 0 + 1 = 1
     - dp = [1, 1, 0, 0, 0, 0, 0]
   - i = 2 (s[1] = 'a'):
     - j = 6 (t[5] = 't'): s[1] != t[5], so dp[6] remains 0
     - j = 5 (t[4] = 'i'): s[1] != t[4], so dp[5] remains 0
     - j = 4 (t[3] = 'b'): s[1] != t[3], so dp[4] remains 0
     - j = 3 (t[2] = 'b'): s[1] != t[2], so dp[3] remains 0
     - j = 2 (t[1] = 'a'): s[1] == t[1], so dp[2] += dp[1] = 0 + 1 = 1
     - j = 1 (t[0] = 'r'): s[1] != t[0], so dp[1] remains 1
     - dp = [1, 1, 1, 0, 0, 0, 0]
   - i = 3 (s[2] = 'b'):
     - j = 6 (t[5] = 't'): s[2] != t[5], so dp[6] remains 0
     - j = 5 (t[4] = 'i'): s[2] != t[4], so dp[5] remains 0
     - j = 4 (t[3] = 'b'): s[2] == t[3], so dp[4] += dp[3] = 0 + 0 = 0
     - j = 3 (t[2] = 'b'): s[2] == t[2], so dp[3] += dp[2] = 0 + 1 = 1
     - j = 2 (t[1] = 'a'): s[2] != t[1], so dp[2] remains 1
     - j = 1 (t[0] = 'r'): s[2] != t[0], so dp[1] remains 1
     - dp = [1, 1, 1, 1, 0, 0, 0]
   - i = 4 (s[3] = 'b'):
     - j = 6 (t[5] = 't'): s[3] != t[5], so dp[6] remains 0
     - j = 5 (t[4] = 'i'): s[3] != t[4], so dp[5] remains 0
     - j = 4 (t[3] = 'b'): s[3] == t[3], so dp[4] += dp[3] = 0 + 1 = 1
     - j = 3 (t[2] = 'b'): s[3] == t[2], so dp[3] += dp[2] = 1 + 1 = 2
     - j = 2 (t[1] = 'a'): s[3] != t[1], so dp[2] remains 1
     - j = 1 (t[0] = 'r'): s[3] != t[0], so dp[1] remains 1
     - dp = [1, 1, 1, 2, 1, 0, 0]
   - i = 5 (s[4] = 'b'):
     - j = 6 (t[5] = 't'): s[4] != t[5], so dp[6] remains 0
     - j = 5 (t[4] = 'i'): s[4] != t[4], so dp[5] remains 0
     - j = 4 (t[3] = 'b'): s[4] == t[3], so dp[4] += dp[3] = 1 + 2 = 3
     - j = 3 (t[2] = 'b'): s[4] == t[2], so dp[3] += dp[2] = 2 + 1 = 3
     - j = 2 (t[1] = 'a'): s[4] != t[1], so dp[2] remains 1
     - j = 1 (t[0] = 'r'): s[4] != t[0], so dp[1] remains 1
     - dp = [1, 1, 1, 3, 3, 0, 0]
   - i = 6 (s[5] = 'i'):
     - j = 6 (t[5] = 't'): s[5] != t[5], so dp[6] remains 0
     - j = 5 (t[4] = 'i'): s[5] == t[4], so dp[5] += dp[4] = 0 + 3 = 3
     - j = 4 (t[3] = 'b'): s[5] != t[3], so dp[4] remains 3
     - j = 3 (t[2] = 'b'): s[5] != t[2], so dp[3] remains 3
     - j = 2 (t[1] = 'a'): s[5] != t[1], so dp[2] remains 1
     - j = 1 (t[0] = 'r'): s[5] != t[0], so dp[1] remains 1
     - dp = [1, 1, 1, 3, 3, 3, 0]
   - i = 7 (s[6] = 't'):
     - j = 6 (t[5] = 't'): s[6] == t[5], so dp[6] += dp[5] = 0 + 3 = 3
     - j = 5 (t[4] = 'i'): s[6] != t[4], so dp[5] remains 3
     - j = 4 (t[3] = 'b'): s[6] != t[3], so dp[4] remains 3
     - j = 3 (t[2] = 'b'): s[6] != t[2], so dp[3] remains 3
     - j = 2 (t[1] = 'a'): s[6] != t[1], so dp[2] remains 1
     - j = 1 (t[0] = 'r'): s[6] != t[0], so dp[1] remains 1
     - dp = [1, 1, 1, 3, 3, 3, 3]

3. Return dp[n] = dp[6] = 3

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Recursive with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
