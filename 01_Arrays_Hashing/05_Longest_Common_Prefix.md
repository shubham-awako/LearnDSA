# Longest Common Prefix

## Problem Statement

Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string `""`.

**Example 1:**
```
Input: strs = ["flower","flow","flight"]
Output: "fl"
```

**Example 2:**
```
Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
```

**Constraints:**
- `1 <= strs.length <= 200`
- `0 <= strs[i].length <= 200`
- `strs[i]` consists of only lowercase English letters.

## Concept Overview

The longest common prefix (LCP) is the longest string that is a prefix of all strings in a given set. This problem tests your ability to compare characters across multiple strings efficiently.

## Solutions

### 1. Brute Force Approach - Horizontal Scanning

Compare the first string with each subsequent string, reducing the common prefix as needed.

```python
def longestCommonPrefix(strs):
    if not strs:
        return ""
    
    prefix = strs[0]
    
    for i in range(1, len(strs)):
        while strs[i].find(prefix) != 0:
            prefix = prefix[:-1]
            if not prefix:
                return ""
    
    return prefix
```

**Time Complexity:** O(S) - where S is the sum of all characters in all strings.
**Space Complexity:** O(1) - Constant extra space is used.

### 2. Improved Solution - Vertical Scanning

Compare characters at the same position across all strings.

```python
def longestCommonPrefix(strs):
    if not strs:
        return ""
    
    for i in range(len(strs[0])):
        char = strs[0][i]
        for j in range(1, len(strs)):
            if i >= len(strs[j]) or strs[j][i] != char:
                return strs[0][:i]
    
    return strs[0]
```

**Time Complexity:** O(S) - where S is the sum of all characters in all strings.
**Space Complexity:** O(1) - Constant extra space is used.

### 3. Best Optimized Solution - Divide and Conquer

Divide the array of strings into subproblems, find the common prefix for each subproblem, and then combine the results.

```python
def longestCommonPrefix(strs):
    if not strs:
        return ""
    
    def commonPrefix(left, right):
        min_len = min(len(left), len(right))
        for i in range(min_len):
            if left[i] != right[i]:
                return left[:i]
        return left[:min_len]
    
    def divide(strs, start, end):
        if start == end:
            return strs[start]
        
        mid = (start + end) // 2
        left_prefix = divide(strs, start, mid)
        right_prefix = divide(strs, mid + 1, end)
        
        return commonPrefix(left_prefix, right_prefix)
    
    return divide(strs, 0, len(strs) - 1)
```

**Time Complexity:** O(S) - where S is the sum of all characters in all strings.
**Space Complexity:** O(m log n) - where m is the maximum string length and n is the number of strings.

### 4. Alternative Solution - Binary Search

Use binary search to find the length of the common prefix.

```python
def longestCommonPrefix(strs):
    if not strs:
        return ""
    
    min_len = min(len(s) for s in strs)
    
    def isCommonPrefix(length):
        prefix = strs[0][:length]
        return all(s.startswith(prefix) for s in strs)
    
    low, high = 0, min_len
    
    while low <= high:
        mid = (low + high) // 2
        if isCommonPrefix(mid):
            low = mid + 1
        else:
            high = mid - 1
    
    return strs[0][:high]
```

**Time Complexity:** O(S * log m) - where S is the sum of all characters and m is the minimum string length.
**Space Complexity:** O(1) - Constant extra space is used.

## Solution Choice and Explanation

For this problem, the vertical scanning solution (Solution 2) is the best approach for most practical scenarios because:

1. **Early Termination**: It can stop as soon as a mismatch is found or a string ends, which is efficient for cases where the common prefix is short or non-existent.

2. **Simplicity**: It's straightforward to implement and understand, making it less prone to errors.

3. **Space Efficiency**: It uses O(1) extra space, which is optimal.

4. **Time Efficiency**: While all solutions have a worst-case time complexity of O(S), vertical scanning often performs better in practice due to early termination.

The divide and conquer approach (Solution 3) is theoretically elegant but introduces overhead due to recursion. The binary search approach (Solution 4) has a slightly worse time complexity but might be useful for very long strings with a long common prefix.

In an interview setting, I would implement the vertical scanning solution for its balance of efficiency and simplicity, while mentioning the alternative approaches as optimizations for specific scenarios.
