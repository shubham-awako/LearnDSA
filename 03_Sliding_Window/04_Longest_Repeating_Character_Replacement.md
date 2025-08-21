# Longest Repeating Character Replacement

## Problem Statement

You are given a string `s` and an integer `k`. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most `k` times.

Return the length of the longest substring containing the same letter you can get after performing the above operations.

**Example 1:**
```
Input: s = "ABAB", k = 2
Output: 4
Explanation: Replace the two 'A's with two 'B's or vice versa.
```

**Example 2:**
```
Input: s = "AABABBA", k = 1
Output: 4
Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
The substring "BBBB" has the longest repeating letters, which is 4.
```

**Constraints:**
- `1 <= s.length <= 10^5`
- `s` consists of only uppercase English letters.
- `0 <= k <= s.length`

## Concept Overview

This problem asks us to find the length of the longest substring containing the same letter after performing at most `k` character replacements. The key insight is to use a sliding window approach to efficiently track the current substring and its character frequencies.

## Solutions

### 1. Brute Force Approach

Check all possible substrings and count the number of replacements needed.

```python
def characterReplacement(s, k):
    n = len(s)
    max_length = 0
    
    for i in range(n):
        for j in range(i, n):
            # Count the frequency of each character in the substring
            char_count = {}
            for idx in range(i, j + 1):
                char_count[s[idx]] = char_count.get(s[idx], 0) + 1
            
            # Find the most frequent character
            max_freq = max(char_count.values()) if char_count else 0
            
            # Calculate the number of replacements needed
            replacements = (j - i + 1) - max_freq
            
            # If the number of replacements is <= k, update the maximum length
            if replacements <= k:
                max_length = max(max_length, j - i + 1)
    
    return max_length
```

**Time Complexity:** O(n³) - We check all possible substrings, and for each substring, we count the frequency of each character.
**Space Complexity:** O(1) - The character set is fixed (uppercase English letters).

### 2. Best Optimized Solution - Sliding Window

Use a sliding window to track the current substring and its character frequencies.

```python
def characterReplacement(s, k):
    n = len(s)
    char_count = {}
    max_length = 0
    max_freq = 0
    left = 0
    
    for right in range(n):
        # Update the frequency of the current character
        char_count[s[right]] = char_count.get(s[right], 0) + 1
        
        # Update the maximum frequency
        max_freq = max(max_freq, char_count[s[right]])
        
        # If the number of replacements needed is > k, shrink the window
        if (right - left + 1) - max_freq > k:
            char_count[s[left]] -= 1
            left += 1
        
        # Update the maximum length
        max_length = max(max_length, right - left + 1)
    
    return max_length
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(1) - The character set is fixed (uppercase English letters).

### 3. Alternative Solution - Sliding Window with Binary Search

Use binary search to find the maximum length of a valid substring.

```python
def characterReplacement(s, k):
    n = len(s)
    
    def is_valid(length):
        char_count = {}
        max_freq = 0
        
        for i in range(n):
            # Add the current character to the window
            char_count[s[i]] = char_count.get(s[i], 0) + 1
            
            # If the window size exceeds the target length, remove the leftmost character
            if i >= length:
                char_count[s[i - length]] -= 1
            
            # Update the maximum frequency
            max_freq = max(max_freq, char_count[s[i]])
            
            # If the window size is equal to the target length and the number of replacements needed is <= k, return True
            if i >= length - 1 and length - max_freq <= k:
                return True
        
        return False
    
    # Binary search for the maximum valid length
    left, right = 1, n
    result = 0
    
    while left <= right:
        mid = (left + right) // 2
        
        if is_valid(mid):
            result = mid
            left = mid + 1
        else:
            right = mid - 1
    
    return result
```

**Time Complexity:** O(n log n) - We perform a binary search on the length, and for each length, we iterate through the string.
**Space Complexity:** O(1) - The character set is fixed (uppercase English letters).

## Solution Choice and Explanation

The sliding window solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Efficient Window Management**: It efficiently handles the sliding window by maintaining the character frequencies and the maximum frequency.

3. **Single Pass**: It processes the string in a single pass, making it more efficient than the brute force and binary search approaches.

The key insight of this approach is to maintain a sliding window where the number of replacements needed (window size - maximum frequency) is at most `k`. When this condition is violated, we shrink the window from the left.

For example, in the string "AABABBA" with k = 1:
- We start with left = 0, right = 0, char_count = {}, max_freq = 0, max_length = 0.
- For 'A' at position 0: Update char_count = {'A': 1}, max_freq = 1, max_length = 1.
- For 'A' at position 1: Update char_count = {'A': 2}, max_freq = 2, max_length = 2.
- For 'B' at position 2: Update char_count = {'A': 2, 'B': 1}, max_freq = 2, max_length = 3.
- For 'A' at position 3: Update char_count = {'A': 3, 'B': 1}, max_freq = 3, max_length = 4.
- For 'B' at position 4: Update char_count = {'A': 3, 'B': 2}, max_freq = 3, window size = 5, replacements needed = 5 - 3 = 2 > k, so we shrink the window: char_count = {'A': 2, 'B': 2}, left = 1, max_length = 4.
- And so on...

One important optimization in this solution is that we don't need to recalculate the maximum frequency when shrinking the window. This is because the maximum frequency can only increase or stay the same when we add a new character, and we're only interested in the maximum possible substring length.

The brute force approach (Solution 1) is inefficient with O(n³) time complexity. The binary search approach (Solution 3) is more complex and has a higher time complexity of O(n log n).

In an interview, I would first mention the sliding window approach as the optimal solution that achieves O(n) time complexity with efficient window management.
