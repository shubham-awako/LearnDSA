# Regular Expression Matching

## Problem Statement

Given an input string `s` and a pattern `p`, implement regular expression matching with support for `'.'` and `'*'` where:

- `'.'` Matches any single character.
- `'*'` Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

**Example 1:**
```
Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
```

**Example 2:**
```
Input: s = "aa", p = "a*"
Output: true
Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
```

**Example 3:**
```
Input: s = "ab", p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".
```

**Constraints:**
- `1 <= s.length <= 20`
- `1 <= p.length <= 30`
- `s` contains only lowercase English letters.
- `p` contains only lowercase English letters, `'.'`, and `'*'`.
- It is guaranteed for each appearance of the character `'*'`, there will be a previous valid character to match.

## Concept Overview

This problem can be solved using dynamic programming. The key insight is to define a state that represents whether a prefix of the input string matches a prefix of the pattern. We can then use this state to build the solution.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def isMatch(s, p):
    m, n = len(s), len(p)
    
    # Initialize the dp array
    # dp[i][j] represents whether s[:i] matches p[:j]
    dp = [[False] * (n + 1) for _ in range(m + 1)]
    
    # Base case: empty pattern matches empty string
    dp[0][0] = True
    
    # Handle patterns like a*, a*b*, etc.
    for j in range(1, n + 1):
        if p[j - 1] == '*':
            dp[0][j] = dp[0][j - 2]
    
    # Fill the dp array
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if p[j - 1] == '*':
                # Zero occurrence of the preceding element
                dp[i][j] = dp[i][j - 2]
                
                # One or more occurrences of the preceding element
                if p[j - 2] == '.' or p[j - 2] == s[i - 1]:
                    dp[i][j] = dp[i][j] or dp[i - 1][j]
            elif p[j - 1] == '.' or p[j - 1] == s[i - 1]:
                dp[i][j] = dp[i - 1][j - 1]
    
    return dp[m][n]
```

**Time Complexity:** O(m * n) - We iterate through each combination of prefixes of s and p.
**Space Complexity:** O(m * n) - We use a 2D array to store whether each prefix of s matches each prefix of p.

### 2. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def isMatch(s, p):
    memo = {}
    
    def dp(i, j):
        if (i, j) in memo:
            return memo[(i, j)]
        
        # Base case: empty pattern matches empty string
        if j == len(p):
            return i == len(s)
        
        # Check if the current characters match
        first_match = i < len(s) and (p[j] == s[i] or p[j] == '.')
        
        # Handle the '*' pattern
        if j + 1 < len(p) and p[j + 1] == '*':
            # Zero occurrence of the preceding element
            result = dp(i, j + 2)
            
            # One or more occurrences of the preceding element
            if first_match:
                result = result or dp(i + 1, j)
        else:
            # Regular character or '.' pattern
            result = first_match and dp(i + 1, j + 1)
        
        memo[(i, j)] = result
        return result
    
    return dp(0, 0)
```

**Time Complexity:** O(m * n) - We have m * n possible states (i, j), and each state takes O(1) time to compute.
**Space Complexity:** O(m * n) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - Bottom-up Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def isMatch(s, p):
    m, n = len(s), len(p)
    
    # Initialize the dp array
    # dp[j] represents whether s[:i] matches p[:j]
    dp = [False] * (n + 1)
    dp[0] = True
    
    # Handle patterns like a*, a*b*, etc.
    for j in range(1, n + 1):
        if p[j - 1] == '*':
            dp[j] = dp[j - 2]
    
    # Fill the dp array
    for i in range(1, m + 1):
        prev = dp[0]
        dp[0] = False
        
        for j in range(1, n + 1):
            temp = dp[j]
            
            if p[j - 1] == '*':
                # Zero occurrence of the preceding element
                dp[j] = dp[j - 2]
                
                # One or more occurrences of the preceding element
                if p[j - 2] == '.' or p[j - 2] == s[i - 1]:
                    dp[j] = dp[j] or dp[j]
            elif p[j - 1] == '.' or p[j - 1] == s[i - 1]:
                dp[j] = prev
            else:
                dp[j] = False
            
            prev = temp
    
    return dp[n]
```

**Time Complexity:** O(m * n) - We iterate through each combination of prefixes of s and p.
**Space Complexity:** O(n) - We use a 1D array to store whether the current prefix of s matches each prefix of p.

## Solution Choice and Explanation

The Dynamic Programming with Tabulation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(m * n) time complexity, which is optimal for this problem, and the space complexity is O(m * n).

2. **Simplicity**: It's a straightforward and elegant solution that captures the essence of the problem.

3. **Intuitiveness**: It naturally maps to the concept of determining whether a prefix of the input string matches a prefix of the pattern.

The key insight of this approach is to use a 2D array to keep track of whether a prefix of the input string matches a prefix of the pattern. For each position (i, j), we check if the current characters match and update the dp array accordingly. We need to handle three cases:
1. Regular character or '.' pattern: If the current characters match, dp[i][j] = dp[i-1][j-1].
2. '*' pattern with zero occurrence: dp[i][j] = dp[i][j-2].
3. '*' pattern with one or more occurrences: If the preceding character matches the current character in s, dp[i][j] = dp[i-1][j].

For example, let's trace through the algorithm for s = "aa" and p = "a*":

1. Initialize dp = [[True, False, False], [False, False, False], [False, False, False]]

2. Handle patterns like a*, a*b*, etc.:
   - j = 1: p[0] = 'a', not '*', so dp[0][1] remains False
   - j = 2: p[1] = '*', so dp[0][2] = dp[0][0] = True
   - dp = [[True, False, True], [False, False, False], [False, False, False]]

3. Fill the dp array:
   - i = 1, j = 1: p[0] = 'a', s[0] = 'a', so dp[1][1] = dp[0][0] = True
   - i = 1, j = 2: p[1] = '*', so dp[1][2] = dp[1][0] = False. Also, p[0] = 'a' = s[0], so dp[1][2] = dp[1][2] or dp[0][2] = False or True = True
   - dp = [[True, False, True], [False, True, True], [False, False, False]]
   - i = 2, j = 1: p[0] = 'a', s[1] = 'a', so dp[2][1] = dp[1][0] = False
   - i = 2, j = 2: p[1] = '*', so dp[2][2] = dp[2][0] = False. Also, p[0] = 'a' = s[1], so dp[2][2] = dp[2][2] or dp[1][2] = False or True = True
   - dp = [[True, False, True], [False, True, True], [False, False, True]]

4. Return dp[m][n] = dp[2][2] = True

Let's trace through another example: s = "ab" and p = ".*":

1. Initialize dp = [[True, False, False], [False, False, False], [False, False, False]]

2. Handle patterns like a*, a*b*, etc.:
   - j = 1: p[0] = '.', not '*', so dp[0][1] remains False
   - j = 2: p[1] = '*', so dp[0][2] = dp[0][0] = True
   - dp = [[True, False, True], [False, False, False], [False, False, False]]

3. Fill the dp array:
   - i = 1, j = 1: p[0] = '.', so dp[1][1] = dp[0][0] = True
   - i = 1, j = 2: p[1] = '*', so dp[1][2] = dp[1][0] = False. Also, p[0] = '.', so dp[1][2] = dp[1][2] or dp[0][2] = False or True = True
   - dp = [[True, False, True], [False, True, True], [False, False, False]]
   - i = 2, j = 1: p[0] = '.', so dp[2][1] = dp[1][0] = False
   - i = 2, j = 2: p[1] = '*', so dp[2][2] = dp[2][0] = False. Also, p[0] = '.', so dp[2][2] = dp[2][2] or dp[1][2] = False or True = True
   - dp = [[True, False, True], [False, True, True], [False, False, True]]

4. Return dp[m][n] = dp[2][2] = True

The Recursive with Memoization solution (Solution 2) is also efficient and may be more intuitive for some people. The Bottom-up Dynamic Programming with Space Optimization solution (Solution 3) is efficient in terms of space but may be more complex to understand.

In an interview, I would first mention the Dynamic Programming with Tabulation solution as the most intuitive approach for this problem, and then discuss the Recursive with Memoization and Bottom-up Dynamic Programming with Space Optimization solutions as alternatives if asked for different approaches.
