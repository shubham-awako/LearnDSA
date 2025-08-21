# Interleaving String

## Problem Statement

Given strings `s1`, `s2`, and `s3`, find whether `s3` is formed by an interleaving of `s1` and `s2`.

An interleaving of two strings `s` and `t` is a configuration where `s` and `t` are divided into `n` and `m` substrings respectively, such that:

- `s = s1 + s2 + ... + sn`
- `t = t1 + t2 + ... + tm`
- `|n - m| <= 1`
- The interleaving is `s1 + t1 + s2 + t2 + s3 + t3 + ...` or `t1 + s1 + t2 + s2 + t3 + s3 + ...`

Note: `a + b` is the concatenation of strings `a` and `b`.

**Example 1:**
```
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
Output: true
Explanation: One way to obtain s3 is:
Split s1 into s1 = "aa" + "bc" + "c", and s2 into s2 = "dbbc" + "a".
Interleaving the two splits, we get "aa" + "dbbc" + "bc" + "a" + "c" = "aadbbcbcac".
```

**Example 2:**
```
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
Output: false
Explanation: Notice how it is impossible to interleave s2 with any other string to obtain s3.
```

**Example 3:**
```
Input: s1 = "", s2 = "", s3 = ""
Output: true
```

**Constraints:**
- `0 <= s1.length, s2.length <= 100`
- `0 <= s3.length <= 200`
- `s1`, `s2`, and `s3` consist of lowercase English letters.

## Concept Overview

This problem can be solved using dynamic programming. The key insight is to define a state that represents whether a prefix of s3 can be formed by interleaving prefixes of s1 and s2. We can then use this state to build the solution.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def isInterleave(s1, s2, s3):
    n, m, l = len(s1), len(s2), len(s3)
    
    # If the lengths don't match, s3 can't be an interleaving
    if n + m != l:
        return False
    
    # Initialize the dp array
    # dp[j] represents whether s3[:i+j] can be formed by interleaving s1[:i] and s2[:j]
    dp = [False] * (m + 1)
    dp[0] = True
    
    # Fill the dp array for the first row (i = 0)
    for j in range(1, m + 1):
        dp[j] = dp[j - 1] and s2[j - 1] == s3[j - 1]
    
    # Fill the dp array for the rest of the rows
    for i in range(1, n + 1):
        dp[0] = dp[0] and s1[i - 1] == s3[i - 1]
        for j in range(1, m + 1):
            dp[j] = (dp[j] and s1[i - 1] == s3[i + j - 1]) or (dp[j - 1] and s2[j - 1] == s3[i + j - 1])
    
    return dp[m]
```

**Time Complexity:** O(n * m) - We iterate through each combination of prefixes of s1 and s2.
**Space Complexity:** O(m) - We use a 1D array to store whether s3 can be formed by interleaving prefixes of s1 and s2.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def isInterleave(s1, s2, s3):
    n, m, l = len(s1), len(s2), len(s3)
    
    # If the lengths don't match, s3 can't be an interleaving
    if n + m != l:
        return False
    
    # Initialize the dp array
    # dp[i][j] represents whether s3[:i+j] can be formed by interleaving s1[:i] and s2[:j]
    dp = [[False] * (m + 1) for _ in range(n + 1)]
    dp[0][0] = True
    
    # Fill the dp array for the first row (i = 0)
    for j in range(1, m + 1):
        dp[0][j] = dp[0][j - 1] and s2[j - 1] == s3[j - 1]
    
    # Fill the dp array for the first column (j = 0)
    for i in range(1, n + 1):
        dp[i][0] = dp[i - 1][0] and s1[i - 1] == s3[i - 1]
    
    # Fill the dp array for the rest of the cells
    for i in range(1, n + 1):
        for j in range(1, m + 1):
            dp[i][j] = (dp[i - 1][j] and s1[i - 1] == s3[i + j - 1]) or (dp[i][j - 1] and s2[j - 1] == s3[i + j - 1])
    
    return dp[n][m]
```

**Time Complexity:** O(n * m) - We iterate through each combination of prefixes of s1 and s2.
**Space Complexity:** O(n * m) - We use a 2D array to store whether s3 can be formed by interleaving prefixes of s1 and s2.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def isInterleave(s1, s2, s3):
    n, m, l = len(s1), len(s2), len(s3)
    
    # If the lengths don't match, s3 can't be an interleaving
    if n + m != l:
        return False
    
    memo = {}
    
    def dp(i, j, k):
        if k == l:
            return i == n and j == m
        
        if (i, j) in memo:
            return memo[(i, j)]
        
        result = False
        if i < n and s1[i] == s3[k]:
            result = result or dp(i + 1, j, k + 1)
        if j < m and s2[j] == s3[k]:
            result = result or dp(i, j + 1, k + 1)
        
        memo[(i, j)] = result
        return result
    
    return dp(0, 0, 0)
```

**Time Complexity:** O(n * m) - We have n * m possible states (i, j), and each state takes O(1) time to compute.
**Space Complexity:** O(n * m) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n * m) time complexity, which is optimal for this problem, and the space complexity is O(m), which is better than the O(n * m) space complexity of the tabulation solution.

2. **Simplicity**: It's a straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of determining whether s3 can be formed by interleaving s1 and s2.

The key insight of this approach is to use a 1D array to keep track of whether a prefix of s3 can be formed by interleaving prefixes of s1 and s2. For each position (i, j), we check if we can form s3[:i+j] by either using s1[i-1] or s2[j-1] as the last character.

For example, let's trace through the algorithm for s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac":

1. Check if the lengths match: len(s1) + len(s2) = 5 + 5 = 10 = len(s3), so continue
2. Initialize dp = [True, False, False, False, False, False]

3. Fill the dp array for the first row (i = 0):
   - j = 1: dp[1] = dp[0] and s2[0] == s3[0] = True and 'd' == 'a' = False
   - j = 2: dp[2] = dp[1] and s2[1] == s3[1] = False and 'b' == 'a' = False
   - j = 3: dp[3] = dp[2] and s2[2] == s3[2] = False and 'b' == 'd' = False
   - j = 4: dp[4] = dp[3] and s2[3] == s3[3] = False and 'c' == 'b' = False
   - j = 5: dp[5] = dp[4] and s2[4] == s3[4] = False and 'a' == 'b' = False
   - dp = [True, False, False, False, False, False]

4. Fill the dp array for the rest of the rows:
   - i = 1:
     - dp[0] = dp[0] and s1[0] == s3[0] = True and 'a' == 'a' = True
     - j = 1: dp[1] = (dp[1] and s1[0] == s3[1]) or (dp[0] and s2[0] == s3[1]) = (False and 'a' == 'a') or (True and 'd' == 'a') = False or False = False
     - j = 2: dp[2] = (dp[2] and s1[0] == s3[2]) or (dp[1] and s2[1] == s3[2]) = (False and 'a' == 'd') or (False and 'b' == 'd') = False or False = False
     - ...
     - dp = [True, False, False, False, False, False]
   - i = 2:
     - dp[0] = dp[0] and s1[1] == s3[1] = True and 'a' == 'a' = True
     - j = 1: dp[1] = (dp[1] and s1[1] == s3[2]) or (dp[0] and s2[0] == s3[2]) = (False and 'a' == 'd') or (True and 'd' == 'd') = False or True = True
     - j = 2: dp[2] = (dp[2] and s1[1] == s3[3]) or (dp[1] and s2[1] == s3[3]) = (False and 'a' == 'b') or (True and 'b' == 'b') = False or True = True
     - ...
     - dp = [True, True, True, ...]

Let's continue with a more detailed trace for a simpler example: s1 = "ab", s2 = "cd", s3 = "acbd":

1. Check if the lengths match: len(s1) + len(s2) = 2 + 2 = 4 = len(s3), so continue
2. Initialize dp = [True, False, False]

3. Fill the dp array for the first row (i = 0):
   - j = 1: dp[1] = dp[0] and s2[0] == s3[0] = True and 'c' == 'a' = False
   - j = 2: dp[2] = dp[1] and s2[1] == s3[1] = False and 'd' == 'c' = False
   - dp = [True, False, False]

4. Fill the dp array for the rest of the rows:
   - i = 1:
     - dp[0] = dp[0] and s1[0] == s3[0] = True and 'a' == 'a' = True
     - j = 1: dp[1] = (dp[1] and s1[0] == s3[1]) or (dp[0] and s2[0] == s3[1]) = (False and 'a' == 'c') or (True and 'c' == 'c') = False or True = True
     - j = 2: dp[2] = (dp[2] and s1[0] == s3[2]) or (dp[1] and s2[1] == s3[2]) = (False and 'a' == 'b') or (True and 'd' == 'b') = False or False = False
     - dp = [True, True, False]
   - i = 2:
     - dp[0] = dp[0] and s1[1] == s3[1] = True and 'b' == 'c' = False
     - j = 1: dp[1] = (dp[1] and s1[1] == s3[2]) or (dp[0] and s2[0] == s3[2]) = (True and 'b' == 'b') or (False and 'c' == 'b') = True or False = True
     - j = 2: dp[2] = (dp[2] and s1[1] == s3[3]) or (dp[1] and s2[1] == s3[3]) = (False and 'b' == 'd') or (True and 'd' == 'd') = False or True = True
     - dp = [False, True, True]

5. Return dp[m] = dp[2] = True

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Recursive with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
