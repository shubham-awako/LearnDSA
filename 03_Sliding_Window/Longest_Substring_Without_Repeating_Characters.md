# Longest Substring Without Repeating Characters

## Problem Statement

Given a string `s`, find the length of the longest substring without repeating characters.

**Example 1:**
```
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
```

**Example 2:**
```
Input: s = "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
```

**Example 3:**
```
Input: s = "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
```

**Constraints:**
- `0 <= s.length <= 5 * 10^4`
- `s` consists of English letters, digits, symbols and spaces.

## Concept Overview

This problem asks us to find the length of the longest substring without repeating characters. The key insight is to use a sliding window approach to efficiently track the current substring and its characters.

## Solutions

### 1. Brute Force Approach

Check all possible substrings to find the longest one without repeating characters.

```python
def lengthOfLongestSubstring(s):
    n = len(s)
    max_length = 0
    
    for i in range(n):
        for j in range(i, n):
            if len(set(s[i:j+1])) == j - i + 1:
                max_length = max(max_length, j - i + 1)
    
    return max_length
```

**Time Complexity:** O(n³) - We check all possible substrings, and for each substring, we check if it has repeating characters.
**Space Complexity:** O(min(n, m)) - Where m is the size of the character set.

### 2. Improved Solution - Sliding Window with Set

Use a sliding window and a set to track characters in the current window.

```python
def lengthOfLongestSubstring(s):
    n = len(s)
    char_set = set()
    max_length = 0
    left = 0
    
    for right in range(n):
        # If the character is already in the set, remove characters from the left
        while s[right] in char_set:
            char_set.remove(s[left])
            left += 1
        
        # Add the current character to the set
        char_set.add(s[right])
        
        # Update the maximum length
        max_length = max(max_length, right - left + 1)
    
    return max_length
```

**Time Complexity:** O(n) - We process each character at most twice (once when adding to the window and once when removing from the window).
**Space Complexity:** O(min(n, m)) - Where m is the size of the character set.

### 3. Best Optimized Solution - Sliding Window with Map

Use a sliding window and a map to track the last position of each character.

```python
def lengthOfLongestSubstring(s):
    n = len(s)
    char_map = {}
    max_length = 0
    left = 0
    
    for right in range(n):
        # If the character is already in the map and its position is within the current window
        if s[right] in char_map and char_map[s[right]] >= left:
            left = char_map[s[right]] + 1
        
        # Update the position of the character
        char_map[s[right]] = right
        
        # Update the maximum length
        max_length = max(max_length, right - left + 1)
    
    return max_length
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(min(n, m)) - Where m is the size of the character set.

## Solution Choice and Explanation

The sliding window with map solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Efficient Window Management**: It efficiently handles the sliding window by directly jumping to the next valid position when a repeating character is found.

3. **Single Pass**: It processes the string in a single pass, making it more efficient than the sliding window with set approach.

The key insight of this approach is to use a map to store the last position of each character. When we encounter a repeating character, we can directly jump to the position after its last occurrence, rather than removing characters one by one from the left.

For example, in the string "abcabcbb":
- We start with left = 0, right = 0, char_map = {}, max_length = 0.
- For 'a' at position 0: Update char_map = {'a': 0}, max_length = 1.
- For 'b' at position 1: Update char_map = {'a': 0, 'b': 1}, max_length = 2.
- For 'c' at position 2: Update char_map = {'a': 0, 'b': 1, 'c': 2}, max_length = 3.
- For 'a' at position 3: Since 'a' is already in the map at position 0, we update left = 0 + 1 = 1, char_map = {'a': 3, 'b': 1, 'c': 2}, max_length = 3.
- And so on...

The sliding window with set approach (Solution 2) is also efficient with O(n) time complexity but may require more operations when removing characters from the left. The brute force approach (Solution 1) is inefficient with O(n³) time complexity.

In an interview, I would first mention the sliding window with map approach as the optimal solution that achieves O(n) time complexity with efficient window management.
