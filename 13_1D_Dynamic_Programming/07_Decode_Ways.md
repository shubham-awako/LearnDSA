# Decode Ways

## Problem Statement

A message containing letters from `A-Z` can be encoded into numbers using the following mapping:
```
'A' -> "1"
'B' -> "2"
...
'Z' -> "26"
```

To decode an encoded message, all the digits must be grouped then mapped back into letters using the reverse of the mapping above (there may be multiple ways). For example, `"11106"` can be mapped into:
- `"AAJF"` with the grouping `(1 1 10 6)`
- `"KJF"` with the grouping `(11 10 6)`

Note that the grouping `(1 11 06)` is invalid because `"06"` cannot be mapped into `'F'` since `"6"` is different from `"06"`.

Given a string `s` containing only digits, return the number of ways to decode it.

**Example 1:**
```
Input: s = "12"
Output: 2
Explanation: "12" could be decoded as "AB" (1 2) or "L" (12).
```

**Example 2:**
```
Input: s = "226"
Output: 3
Explanation: "226" could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).
```

**Example 3:**
```
Input: s = "06"
Output: 0
Explanation: "06" cannot be mapped to "F" because of the leading zero ("6" is different from "06").
```

**Constraints:**
- `1 <= s.length <= 100`
- `s` contains only digits and may contain leading zeros.

## Concept Overview

This problem is a classic example of dynamic programming. The key insight is to recognize that the number of ways to decode a string up to a certain position depends on the number of ways to decode the string up to the previous one or two positions, depending on whether the last one or two digits form a valid mapping.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def numDecodings(s):
    if not s or s[0] == '0':
        return 0
    
    n = len(s)
    # dp[i] represents the number of ways to decode s[:i]
    # We only need to keep track of the last two values
    prev2 = 1  # Empty string has 1 way to decode
    prev1 = 1  # First character has 1 way to decode if it's not '0'
    
    for i in range(1, n):
        current = 0
        
        # Check if the current digit is valid (not '0')
        if s[i] != '0':
            current += prev1
        
        # Check if the last two digits form a valid mapping (10-26)
        two_digits = int(s[i-1:i+1])
        if 10 <= two_digits <= 26:
            current += prev2
        
        # Update the values for the next iteration
        prev2 = prev1
        prev1 = current
    
    return prev1
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def numDecodings(s):
    memo = {}
    
    def dp(i):
        # Base cases
        if i == len(s):
            return 1
        
        if s[i] == '0':
            return 0
        
        if i in memo:
            return memo[i]
        
        # Decode a single digit
        result = dp(i + 1)
        
        # Decode two digits if possible
        if i + 1 < len(s) and int(s[i:i+2]) <= 26:
            result += dp(i + 2)
        
        memo[i] = result
        return result
    
    return dp(0)
```

**Time Complexity:** O(n) - We compute the result for each position in the string exactly once.
**Space Complexity:** O(n) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def numDecodings(s):
    if not s or s[0] == '0':
        return 0
    
    n = len(s)
    # dp[i] represents the number of ways to decode s[:i]
    dp = [0] * (n + 1)
    dp[0] = 1  # Empty string has 1 way to decode
    dp[1] = 1  # First character has 1 way to decode if it's not '0'
    
    for i in range(2, n + 1):
        # Check if the current digit is valid (not '0')
        if s[i-1] != '0':
            dp[i] += dp[i-1]
        
        # Check if the last two digits form a valid mapping (10-26)
        two_digits = int(s[i-2:i])
        if 10 <= two_digits <= 26:
            dp[i] += dp[i-2]
    
    return dp[n]
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the other solutions.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the number of ways to decode a string.

The key insight of this approach is to recognize that the number of ways to decode a string up to a certain position depends on the number of ways to decode the string up to the previous one or two positions, depending on whether the last one or two digits form a valid mapping.

For example, let's trace through the algorithm for s = "226":

1. Initialize:
   - prev2 = 1 (empty string has 1 way to decode)
   - prev1 = 1 (first character '2' has 1 way to decode)

2. Iterate through the string:
   - i = 1 (character '2'):
     - current = 0
     - s[1] != '0', so current += prev1 = 0 + 1 = 1
     - two_digits = int(s[0:2]) = int("22") = 22
     - 10 <= 22 <= 26, so current += prev2 = 1 + 1 = 2
     - prev2 = prev1 = 1
     - prev1 = current = 2
   - i = 2 (character '6'):
     - current = 0
     - s[2] != '0', so current += prev1 = 0 + 2 = 2
     - two_digits = int(s[1:3]) = int("26") = 26
     - 10 <= 26 <= 26, so current += prev2 = 2 + 1 = 3
     - prev2 = prev1 = 2
     - prev1 = current = 3

3. Return prev1 = 3

For s = "06":

1. Check if the first character is '0':
   - s[0] = '0', so return 0

The Dynamic Programming with Memoization solution (Solution 2) and the Dynamic Programming with Tabulation solution (Solution 3) are also efficient but use more space. They are useful for understanding the dynamic programming approach to this problem.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Memoization and Tabulation solutions as alternatives if asked for different approaches.
