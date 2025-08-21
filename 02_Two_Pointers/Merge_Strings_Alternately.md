# Merge Strings Alternately

## Problem Statement

You are given two strings `word1` and `word2`. Merge the strings by adding letters in alternating order, starting with `word1`. If a string is longer than the other, append the additional letters onto the end of the merged string.

Return the merged string.

**Example 1:**
```
Input: word1 = "abc", word2 = "pqr"
Output: "apbqcr"
Explanation: The merged string will be merged as so:
word1:  a   b   c
word2:    p   q   r
merged: a p b q c r
```

**Example 2:**
```
Input: word1 = "ab", word2 = "pqrs"
Output: "apbqrs"
Explanation: Notice that as word2 is longer, "rs" is appended to the end.
word1:  a   b 
word2:    p   q   r   s
merged: a p b q   r   s
```

**Example 3:**
```
Input: word1 = "abcd", word2 = "pq"
Output: "apbqcd"
Explanation: Notice that as word1 is longer, "cd" is appended to the end.
word1:  a   b   c   d
word2:    p   q 
merged: a p b q c   d
```

**Constraints:**
- `1 <= word1.length, word2.length <= 100`
- `word1` and `word2` consist of lowercase English letters.

## Concept Overview

This problem tests your ability to merge two strings by alternating their characters. The key insight is to use two pointers to track the current position in each string and handle the case where one string is longer than the other.

## Solutions

### 1. Brute Force Approach - Using Min Length

Merge the strings up to the length of the shorter string, then append the remaining characters from the longer string.

```python
def mergeAlternately(word1, word2):
    result = []
    min_len = min(len(word1), len(word2))
    
    # Merge characters alternately up to the length of the shorter string
    for i in range(min_len):
        result.append(word1[i])
        result.append(word2[i])
    
    # Append remaining characters from the longer string
    result.append(word1[min_len:])
    result.append(word2[min_len:])
    
    return ''.join(result)
```

**Time Complexity:** O(n + m) - Where n and m are the lengths of word1 and word2, respectively.
**Space Complexity:** O(n + m) - For storing the result string.

### 2. Best Optimized Solution - Two Pointers

Use two pointers to track the current position in each string and continue until both strings are exhausted.

```python
def mergeAlternately(word1, word2):
    result = []
    i, j = 0, 0
    
    while i < len(word1) or j < len(word2):
        if i < len(word1):
            result.append(word1[i])
            i += 1
        
        if j < len(word2):
            result.append(word2[j])
            j += 1
    
    return ''.join(result)
```

**Time Complexity:** O(n + m) - Where n and m are the lengths of word1 and word2, respectively.
**Space Complexity:** O(n + m) - For storing the result string.

### 3. Alternative Solution - Using zip_longest

Use Python's `itertools.zip_longest` to pair characters from both strings, filling in missing values with an empty string.

```python
from itertools import zip_longest

def mergeAlternately(word1, word2):
    result = []
    
    for c1, c2 in zip_longest(word1, word2, fillvalue=''):
        result.append(c1)
        result.append(c2)
    
    return ''.join(result)
```

**Time Complexity:** O(n + m) - Where n and m are the lengths of word1 and word2, respectively.
**Space Complexity:** O(n + m) - For storing the result string.

## Solution Choice and Explanation

The two pointers solution (Solution 2) is the best approach for this problem because:

1. **Clarity and Simplicity**: It's straightforward to implement and understand without relying on language-specific features.

2. **Optimal Time Complexity**: It achieves O(n + m) time complexity, which is optimal for this problem.

3. **Explicit Control**: It gives explicit control over how characters are merged, making it easier to modify if additional requirements are added.

The key insight of this approach is to use two pointers to track the current position in each string. We continue merging characters until both strings are exhausted, handling the case where one string is longer than the other.

The brute force approach (Solution 1) is also efficient but requires an additional check to append the remaining characters from the longer string. The `zip_longest` approach (Solution 3) is concise but relies on a Python-specific feature that may not be available in other languages.

In an interview, I would first mention the two pointers approach as the most straightforward and language-agnostic solution. If using Python, I might also mention the `zip_longest` approach as a more concise alternative.
