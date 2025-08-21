# Longest Palindromic Substring

## Problem Statement

Given a string `s`, return the longest palindromic substring in `s`.

**Example 1:**
```
Input: s = "babad"
Output: "bab"
Explanation: "aba" is also a valid answer.
```

**Example 2:**
```
Input: s = "cbbd"
Output: "bb"
```

**Constraints:**
- `1 <= s.length <= 1000`
- `s` consist of only digits and English letters.

## Concept Overview

This problem asks us to find the longest substring that is a palindrome. A palindrome is a string that reads the same backward as forward. There are several approaches to solve this problem, including dynamic programming, expanding around centers, and Manacher's algorithm.

## Solutions

### 1. Best Optimized Solution - Expand Around Centers

Use the expand around centers approach to find the longest palindromic substring.

```python
def longestPalindrome(s):
    if not s:
        return ""
    
    n = len(s)
    start = 0
    max_length = 1
    
    # Helper function to expand around center
    def expand_around_center(left, right):
        while left >= 0 and right < n and s[left] == s[right]:
            left -= 1
            right += 1
        return right - left - 1
    
    # Check each position as a potential center
    for i in range(n):
        # Odd length palindrome with center at i
        len1 = expand_around_center(i, i)
        
        # Even length palindrome with center at i and i+1
        len2 = expand_around_center(i, i + 1)
        
        # Update the maximum length and starting position
        length = max(len1, len2)
        if length > max_length:
            max_length = length
            start = i - (length - 1) // 2
    
    return s[start:start + max_length]
```

**Time Complexity:** O(n^2) - We check each position as a potential center and expand around it, which takes O(n) time for each position.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming

Use dynamic programming to find the longest palindromic substring.

```python
def longestPalindrome(s):
    if not s:
        return ""
    
    n = len(s)
    # dp[i][j] will be True if the substring s[i:j+1] is a palindrome
    dp = [[False] * n for _ in range(n)]
    
    start = 0
    max_length = 1
    
    # All substrings of length 1 are palindromes
    for i in range(n):
        dp[i][i] = True
    
    # Check for substrings of length 2
    for i in range(n - 1):
        if s[i] == s[i + 1]:
            dp[i][i + 1] = True
            start = i
            max_length = 2
    
    # Check for substrings of length 3 or more
    for length in range(3, n + 1):
        for i in range(n - length + 1):
            j = i + length - 1
            if s[i] == s[j] and dp[i + 1][j - 1]:
                dp[i][j] = True
                start = i
                max_length = length
    
    return s[start:start + max_length]
```

**Time Complexity:** O(n^2) - We fill in the dp table, which has n^2 entries.
**Space Complexity:** O(n^2) - We use the dp table to store the results of all subproblems.

### 3. Alternative Solution - Manacher's Algorithm

Use Manacher's Algorithm to find the longest palindromic substring.

```python
def longestPalindrome(s):
    if not s:
        return ""
    
    # Preprocess the string to handle even-length palindromes
    t = '#' + '#'.join(s) + '#'
    n = len(t)
    
    # p[i] is the radius of the palindrome centered at i
    p = [0] * n
    
    # Variables to track the center and right boundary of the rightmost palindrome
    center = right = 0
    
    # Variables to track the longest palindrome
    max_radius = 0
    max_center = 0
    
    for i in range(n):
        # If i is within the right boundary, we can use the symmetry property
        if i < right:
            p[i] = min(right - i, p[2 * center - i])
        
        # Expand around center i
        while i + p[i] + 1 < n and i - p[i] - 1 >= 0 and t[i + p[i] + 1] == t[i - p[i] - 1]:
            p[i] += 1
        
        # Update the center and right boundary if needed
        if i + p[i] > right:
            center = i
            right = i + p[i]
        
        # Update the longest palindrome
        if p[i] > max_radius:
            max_radius = p[i]
            max_center = i
    
    # Extract the longest palindromic substring
    start = (max_center - max_radius) // 2
    return s[start:start + max_radius]
```

**Time Complexity:** O(n) - Manacher's Algorithm processes each character exactly once.
**Space Complexity:** O(n) - We use the p array to store the radius of each palindrome.

## Solution Choice and Explanation

The Expand Around Centers solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n^2) time complexity, which is good for this problem, and the space complexity is O(1), which is better than the O(n^2) space complexity of the dynamic programming solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of expanding around the center of a palindrome.

The key insight of this approach is to recognize that a palindrome can be expanded from its center. We consider each position in the string as a potential center and expand around it to find the longest palindrome. We need to handle both odd-length palindromes (with a single character at the center) and even-length palindromes (with two characters at the center).

For example, let's trace through the algorithm for s = "babad":

1. Initialize:
   - start = 0
   - max_length = 1

2. Check each position as a potential center:
   - Position 0 ('b'):
     - Odd length: expand_around_center(0, 0) = 1
     - Even length: expand_around_center(0, 1) = 0
     - length = max(1, 0) = 1
     - No update to max_length
   - Position 1 ('a'):
     - Odd length: expand_around_center(1, 1) = 1
     - Even length: expand_around_center(1, 2) = 0
     - length = max(1, 0) = 1
     - No update to max_length
   - Position 2 ('b'):
     - Odd length: expand_around_center(2, 2) = 3
     - Even length: expand_around_center(2, 3) = 0
     - length = max(3, 0) = 3
     - Update max_length = 3, start = 2 - (3 - 1) // 2 = 1
   - Position 3 ('a'):
     - Odd length: expand_around_center(3, 3) = 1
     - Even length: expand_around_center(3, 4) = 0
     - length = max(1, 0) = 1
     - No update to max_length
   - Position 4 ('d'):
     - Odd length: expand_around_center(4, 4) = 1
     - Even length: expand_around_center(4, 5) = 0
     - length = max(1, 0) = 1
     - No update to max_length

3. Return s[start:start + max_length] = s[1:1 + 3] = "bab"

For s = "cbbd":

1. Initialize:
   - start = 0
   - max_length = 1

2. Check each position as a potential center:
   - Position 0 ('c'):
     - Odd length: expand_around_center(0, 0) = 1
     - Even length: expand_around_center(0, 1) = 0
     - length = max(1, 0) = 1
     - No update to max_length
   - Position 1 ('b'):
     - Odd length: expand_around_center(1, 1) = 1
     - Even length: expand_around_center(1, 2) = 2
     - length = max(1, 2) = 2
     - Update max_length = 2, start = 1 - (2 - 1) // 2 = 1
   - Position 2 ('b'):
     - Odd length: expand_around_center(2, 2) = 1
     - Even length: expand_around_center(2, 3) = 0
     - length = max(1, 0) = 1
     - No update to max_length
   - Position 3 ('d'):
     - Odd length: expand_around_center(3, 3) = 1
     - Even length: expand_around_center(3, 4) = 0
     - length = max(1, 0) = 1
     - No update to max_length

3. Return s[start:start + max_length] = s[1:1 + 2] = "bb"

The Dynamic Programming solution (Solution 2) is also efficient but uses more space. It's useful for understanding the dynamic programming approach to this problem. The Manacher's Algorithm solution (Solution 3) is the most efficient with O(n) time complexity, but it's more complex and harder to understand.

In an interview, I would first mention the Expand Around Centers solution as the most intuitive approach for this problem, and then discuss the Dynamic Programming and Manacher's Algorithm solutions as alternatives if asked for different approaches.
