# Palindrome Partitioning

## Problem Statement

Given a string `s`, partition `s` such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of `s`.

A **palindrome** string is a string that reads the same backward as forward.

**Example 1:**
```
Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]
```

**Example 2:**
```
Input: s = "a"
Output: [["a"]]
```

**Constraints:**
- `1 <= s.length <= 16`
- `s` contains only lowercase English letters.

## Concept Overview

This problem tests your understanding of backtracking and string manipulation. The key insight is to use backtracking to generate all possible partitions of the string, ensuring that each substring is a palindrome.

## Solutions

### 1. Best Optimized Solution - Backtracking with Dynamic Programming

Use backtracking to generate all possible partitions, and use dynamic programming to efficiently check if a substring is a palindrome.

```python
def partition(s):
    n = len(s)
    result = []
    
    # dp[i][j] will be True if s[i:j+1] is a palindrome
    dp = [[False] * n for _ in range(n)]
    
    # All substrings of length 1 are palindromes
    for i in range(n):
        dp[i][i] = True
    
    # Check for palindromes of length 2 or more
    for length in range(2, n + 1):
        for i in range(n - length + 1):
            j = i + length - 1
            if length == 2:
                dp[i][j] = (s[i] == s[j])
            else:
                dp[i][j] = (s[i] == s[j] and dp[i+1][j-1])
    
    def backtrack(start, path):
        # If we've reached the end of the string, we've found a valid partition
        if start == n:
            result.append(path[:])
            return
        
        # Try all possible substrings starting from the current position
        for end in range(start, n):
            # If the substring is a palindrome, add it to the path and continue
            if dp[start][end]:
                path.append(s[start:end+1])
                backtrack(end + 1, path)
                path.pop()
    
    backtrack(0, [])
    return result
```

**Time Complexity:** O(n * 2^n) where n is the length of the string. There are 2^(n-1) possible partitions, and it takes O(n) time to copy each partition.
**Space Complexity:** O(n^2) for the dp array and O(n) for the recursion stack, so O(n^2) overall.

### 2. Alternative Solution - Backtracking with Palindrome Checking

Use backtracking to generate all possible partitions, and check if each substring is a palindrome on the fly.

```python
def partition(s):
    result = []
    
    def is_palindrome(string):
        return string == string[::-1]
    
    def backtrack(start, path):
        # If we've reached the end of the string, we've found a valid partition
        if start == len(s):
            result.append(path[:])
            return
        
        # Try all possible substrings starting from the current position
        for end in range(start, len(s)):
            # If the substring is a palindrome, add it to the path and continue
            if is_palindrome(s[start:end+1]):
                path.append(s[start:end+1])
                backtrack(end + 1, path)
                path.pop()
    
    backtrack(0, [])
    return result
```

**Time Complexity:** O(n * 2^n) where n is the length of the string. There are 2^(n-1) possible partitions, and it takes O(n) time to check if each substring is a palindrome.
**Space Complexity:** O(n) for the recursion stack.

### 3. Alternative Solution - Backtracking with Memoization

Use backtracking to generate all possible partitions, and use memoization to avoid rechecking if a substring is a palindrome.

```python
def partition(s):
    n = len(s)
    result = []
    memo = {}
    
    def is_palindrome(i, j):
        if (i, j) in memo:
            return memo[(i, j)]
        
        if i >= j:
            memo[(i, j)] = True
            return True
        
        if s[i] != s[j]:
            memo[(i, j)] = False
            return False
        
        memo[(i, j)] = is_palindrome(i + 1, j - 1)
        return memo[(i, j)]
    
    def backtrack(start, path):
        # If we've reached the end of the string, we've found a valid partition
        if start == n:
            result.append(path[:])
            return
        
        # Try all possible substrings starting from the current position
        for end in range(start, n):
            # If the substring is a palindrome, add it to the path and continue
            if is_palindrome(start, end):
                path.append(s[start:end+1])
                backtrack(end + 1, path)
                path.pop()
    
    backtrack(0, [])
    return result
```

**Time Complexity:** O(n * 2^n) where n is the length of the string. There are 2^(n-1) possible partitions, and it takes O(n) time to copy each partition.
**Space Complexity:** O(n^2) for the memoization dictionary and O(n) for the recursion stack, so O(n^2) overall.

## Solution Choice and Explanation

The backtracking with dynamic programming solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It precomputes all palindrome substrings, which avoids redundant palindrome checks during backtracking.

2. **Clarity**: It clearly separates the palindrome checking and the backtracking logic, making the code more readable.

3. **Optimization**: It uses dynamic programming to efficiently check if a substring is a palindrome, which is more efficient than checking each substring from scratch.

The key insight of this approach is to use dynamic programming to precompute all palindrome substrings, and then use backtracking to generate all possible partitions. We use a 2D array `dp` where `dp[i][j]` is True if the substring `s[i:j+1]` is a palindrome. We fill this array using the following rules:
1. All substrings of length 1 are palindromes: `dp[i][i] = True`
2. For substrings of length 2: `dp[i][i+1] = (s[i] == s[i+1])`
3. For substrings of length 3 or more: `dp[i][j] = (s[i] == s[j] and dp[i+1][j-1])`

Once we have the dp array, we use backtracking to generate all possible partitions. We use a recursive function `backtrack(start, path)` that:
1. Checks if we've reached the end of the string, in which case we've found a valid partition.
2. Tries all possible substrings starting from the current position.
3. If the substring is a palindrome (as determined by the dp array), adds it to the path and continues recursively.
4. Removes the substring from the path (backtracking) to try other partitions.

For example, let's trace through the algorithm for s = "aab":
1. Fill the dp array:
   - dp[0][0] = True (a is a palindrome)
   - dp[1][1] = True (a is a palindrome)
   - dp[2][2] = True (b is a palindrome)
   - dp[0][1] = True (aa is a palindrome)
   - dp[1][2] = False (ab is not a palindrome)
   - dp[0][2] = False (aab is not a palindrome)
2. Start backtracking with start = 0, path = []
   - Try substring s[0:0+1] = "a"
     - dp[0][0] = True, so it's a palindrome
     - Add "a" to path: path = ["a"]
     - Recursively backtrack with start = 1, path = ["a"]
       - Try substring s[1:1+1] = "a"
         - dp[1][1] = True, so it's a palindrome
         - Add "a" to path: path = ["a", "a"]
         - Recursively backtrack with start = 2, path = ["a", "a"]
           - Try substring s[2:2+1] = "b"
             - dp[2][2] = True, so it's a palindrome
             - Add "b" to path: path = ["a", "a", "b"]
             - Recursively backtrack with start = 3, path = ["a", "a", "b"]
               - start == n, so we've found a valid partition
               - Add path to result: result = [["a", "a", "b"]]
             - Remove "b" from path: path = ["a", "a"]
           - No more substrings to try, backtrack
         - Remove "a" from path: path = ["a"]
       - Try substring s[1:2+1] = "ab"
         - dp[1][2] = False, so it's not a palindrome, skip it
       - No more substrings to try, backtrack
     - Remove "a" from path: path = []
   - Try substring s[0:1+1] = "aa"
     - dp[0][1] = True, so it's a palindrome
     - Add "aa" to path: path = ["aa"]
     - Recursively backtrack with start = 2, path = ["aa"]
       - Try substring s[2:2+1] = "b"
         - dp[2][2] = True, so it's a palindrome
         - Add "b" to path: path = ["aa", "b"]
         - Recursively backtrack with start = 3, path = ["aa", "b"]
           - start == n, so we've found a valid partition
           - Add path to result: result = [["a", "a", "b"], ["aa", "b"]]
         - Remove "b" from path: path = ["aa"]
       - No more substrings to try, backtrack
     - Remove "aa" from path: path = []
   - Try substring s[0:2+1] = "aab"
     - dp[0][2] = False, so it's not a palindrome, skip it
   - No more substrings to try, backtrack
3. Final result: [["a", "a", "b"], ["aa", "b"]]

The backtracking with palindrome checking solution (Solution 2) is simpler but less efficient, as it rechecks palindromes during backtracking. The backtracking with memoization solution (Solution 3) is also efficient but slightly more complex.

In an interview, I would first mention the backtracking with dynamic programming solution as the most efficient approach for this problem, and then mention the simpler backtracking with palindrome checking solution if asked for a more straightforward approach.
