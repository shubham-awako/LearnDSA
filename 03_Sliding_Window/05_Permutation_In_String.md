# Permutation In String

## Problem Statement

Given two strings `s1` and `s2`, return `true` if `s2` contains a permutation of `s1`, or `false` otherwise.

In other words, return `true` if one of `s1`'s permutations is the substring of `s2`.

**Example 1:**
```
Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").
```

**Example 2:**
```
Input: s1 = "ab", s2 = "eidboaoo"
Output: false
```

**Constraints:**
- `1 <= s1.length, s2.length <= 10^4`
- `s1` and `s2` consist of lowercase English letters.

## Concept Overview

This problem asks us to check if a string contains a permutation of another string. The key insight is to use a sliding window approach to efficiently check if a substring of `s2` has the same character frequencies as `s1`.

## Solutions

### 1. Brute Force Approach

Generate all permutations of `s1` and check if any of them is a substring of `s2`.

```python
from itertools import permutations

def checkInclusion(s1, s2):
    n1, n2 = len(s1), len(s2)
    
    if n1 > n2:
        return False
    
    # Generate all permutations of s1
    perms = [''.join(p) for p in permutations(s1)]
    
    # Check if any permutation is a substring of s2
    for perm in perms:
        if perm in s2:
            return True
    
    return False
```

**Time Complexity:** O(n1! * n2) - We generate n1! permutations of s1 and check each one against s2.
**Space Complexity:** O(n1! * n1) - We store all permutations of s1.

### 2. Improved Solution - Character Count

Count the occurrences of each character in `s1` and check if any substring of `s2` with length `len(s1)` has the same character counts.

```python
def checkInclusion(s1, s2):
    n1, n2 = len(s1), len(s2)
    
    if n1 > n2:
        return False
    
    # Count the occurrences of each character in s1
    s1_count = {}
    for char in s1:
        s1_count[char] = s1_count.get(char, 0) + 1
    
    # Check each substring of s2 with length n1
    for i in range(n2 - n1 + 1):
        s2_count = {}
        for j in range(i, i + n1):
            s2_count[s2[j]] = s2_count.get(s2[j], 0) + 1
        
        # Check if the character counts match
        if s1_count == s2_count:
            return True
    
    return False
```

**Time Complexity:** O(n1 + (n2 - n1) * n1) - We count the characters in s1 once and then check each substring of s2 with length n1.
**Space Complexity:** O(1) - The character set is fixed (lowercase English letters).

### 3. Best Optimized Solution - Sliding Window

Use a sliding window to efficiently track the character frequencies in the current window.

```python
def checkInclusion(s1, s2):
    n1, n2 = len(s1), len(s2)
    
    if n1 > n2:
        return False
    
    # Count the occurrences of each character in s1
    s1_count = [0] * 26
    for char in s1:
        s1_count[ord(char) - ord('a')] += 1
    
    # Initialize the window
    window_count = [0] * 26
    for i in range(n1):
        window_count[ord(s2[i]) - ord('a')] += 1
    
    # Check if the initial window is a permutation of s1
    if s1_count == window_count:
        return True
    
    # Slide the window
    for i in range(n1, n2):
        # Add the new character to the window
        window_count[ord(s2[i]) - ord('a')] += 1
        
        # Remove the leftmost character from the window
        window_count[ord(s2[i - n1]) - ord('a')] -= 1
        
        # Check if the current window is a permutation of s1
        if s1_count == window_count:
            return True
    
    return False
```

**Time Complexity:** O(n1 + n2) - We count the characters in s1 once and then slide the window through s2.
**Space Complexity:** O(1) - The character set is fixed (lowercase English letters).

### 4. Alternative Solution - Sliding Window with Optimization

Use a sliding window with a counter to track the number of matching characters.

```python
def checkInclusion(s1, s2):
    n1, n2 = len(s1), len(s2)
    
    if n1 > n2:
        return False
    
    # Count the occurrences of each character in s1
    s1_count = [0] * 26
    for char in s1:
        s1_count[ord(char) - ord('a')] += 1
    
    # Initialize the window
    window_count = [0] * 26
    matches = 0
    
    for i in range(n1):
        idx = ord(s2[i]) - ord('a')
        window_count[idx] += 1
        if window_count[idx] == s1_count[idx]:
            matches += 1
        elif window_count[idx] == s1_count[idx] + 1:
            matches -= 1
    
    # Check if the initial window is a permutation of s1
    if matches == 26:
        return True
    
    # Slide the window
    for i in range(n1, n2):
        # Add the new character to the window
        idx_in = ord(s2[i]) - ord('a')
        window_count[idx_in] += 1
        if window_count[idx_in] == s1_count[idx_in]:
            matches += 1
        elif window_count[idx_in] == s1_count[idx_in] + 1:
            matches -= 1
        
        # Remove the leftmost character from the window
        idx_out = ord(s2[i - n1]) - ord('a')
        window_count[idx_out] -= 1
        if window_count[idx_out] == s1_count[idx_out]:
            matches += 1
        elif window_count[idx_out] == s1_count[idx_out] - 1:
            matches -= 1
        
        # Check if the current window is a permutation of s1
        if matches == 26:
            return True
    
    return False
```

**Time Complexity:** O(n1 + n2) - We count the characters in s1 once and then slide the window through s2.
**Space Complexity:** O(1) - The character set is fixed (lowercase English letters).

## Solution Choice and Explanation

The sliding window solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n1 + n2) time complexity, which is optimal for this problem.

2. **Efficient Window Management**: It efficiently handles the sliding window by maintaining the character frequencies in the current window.

3. **Simple Implementation**: It's straightforward to implement and understand.

The key insight of this approach is to use a sliding window of size `len(s1)` and check if the character frequencies in the window match those in `s1`. We can efficiently update the window by adding the new character and removing the leftmost character as we slide the window.

For example, with s1 = "ab" and s2 = "eidbaooo":
- We start with the window "ei", which doesn't match the character frequencies of "ab".
- We slide the window to "id", which doesn't match.
- We slide the window to "db", which doesn't match.
- We slide the window to "ba", which matches the character frequencies of "ab" (it's a permutation).
- We return true.

The alternative solution with optimization (Solution 4) is also efficient but more complex and prone to errors. The character count solution (Solution 2) is less efficient with O(n1 + (n2 - n1) * n1) time complexity. The brute force approach (Solution 1) is highly inefficient with O(n1! * n2) time complexity.

In an interview, I would first mention the sliding window approach as the optimal solution that achieves O(n1 + n2) time complexity with efficient window management.
