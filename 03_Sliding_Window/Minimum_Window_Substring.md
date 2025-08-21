# Minimum Window Substring

## Problem Statement

Given two strings `s` and `t` of lengths `m` and `n` respectively, return the minimum window substring of `s` such that every character in `t` (including duplicates) is included in the window. If there is no such substring, return the empty string `""`.

The testcases will be generated such that the answer is unique.

**Example 1:**
```
Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"
Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
```

**Example 2:**
```
Input: s = "a", t = "a"
Output: "a"
Explanation: The entire string s is the minimum window.
```

**Example 3:**
```
Input: s = "a", t = "aa"
Output: ""
Explanation: Both 'a's from t must be included in the window.
Since the largest window of s only has one 'a', return empty string.
```

**Constraints:**
- `m == s.length`
- `n == t.length`
- `1 <= m, n <= 10^5`
- `s` and `t` consist of uppercase and lowercase English letters.

**Follow up:** Could you find an algorithm that runs in O(m + n) time?

## Concept Overview

This problem asks us to find the minimum window substring of s that contains all characters in t. The key insight is to use a sliding window approach to efficiently find such substrings.

## Solutions

### 1. Brute Force Approach

Check all possible substrings of s and find the minimum length substring that contains all characters in t.

```python
def minWindow(s, t):
    m, n = len(s), len(t)
    
    if n > m:
        return ""
    
    # Count the occurrences of each character in t
    t_count = {}
    for char in t:
        t_count[char] = t_count.get(char, 0) + 1
    
    min_length = float('inf')
    result = ""
    
    # Check all possible substrings
    for i in range(m):
        for j in range(i, m):
            # Count the occurrences of each character in the current substring
            s_count = {}
            for k in range(i, j + 1):
                s_count[s[k]] = s_count.get(s[k], 0) + 1
            
            # Check if the current substring contains all characters in t
            valid = True
            for char, count in t_count.items():
                if char not in s_count or s_count[char] < count:
                    valid = False
                    break
            
            # Update the result if the current substring is valid and shorter
            if valid and j - i + 1 < min_length:
                min_length = j - i + 1
                result = s[i:j+1]
    
    return result
```

**Time Complexity:** O(m²n) - We check all possible substrings of s and count the occurrences of each character.
**Space Complexity:** O(k) - Where k is the size of the character set.

### 2. Best Optimized Solution - Sliding Window

Use a sliding window to efficiently find the minimum window substring.

```python
def minWindow(s, t):
    m, n = len(s), len(t)
    
    if n > m:
        return ""
    
    # Count the occurrences of each character in t
    t_count = {}
    for char in t:
        t_count[char] = t_count.get(char, 0) + 1
    
    # Initialize the window
    window_count = {}
    required = len(t_count)
    formed = 0
    
    min_length = float('inf')
    result = ""
    
    left = 0
    for right in range(m):
        # Add the current character to the window
        char = s[right]
        window_count[char] = window_count.get(char, 0) + 1
        
        # Check if the current character forms a valid count
        if char in t_count and window_count[char] == t_count[char]:
            formed += 1
        
        # Try to minimize the window by moving the left pointer
        while left <= right and formed == required:
            char = s[left]
            
            # Update the result if the current window is smaller
            if right - left + 1 < min_length:
                min_length = right - left + 1
                result = s[left:right+1]
            
            # Remove the leftmost character from the window
            window_count[char] -= 1
            
            # Check if the removal breaks the valid count
            if char in t_count and window_count[char] < t_count[char]:
                formed -= 1
            
            left += 1
    
    return result
```

**Time Complexity:** O(m + n) - We iterate through s and t once.
**Space Complexity:** O(k) - Where k is the size of the character set.

### 3. Alternative Solution - Optimized Sliding Window

Optimize the sliding window approach by only considering characters in t.

```python
def minWindow(s, t):
    m, n = len(s), len(t)
    
    if n > m:
        return ""
    
    # Count the occurrences of each character in t
    t_count = {}
    for char in t:
        t_count[char] = t_count.get(char, 0) + 1
    
    # Initialize the window
    window_count = {}
    required = len(t_count)
    formed = 0
    
    # Filter s to only include characters in t
    filtered_s = []
    for i, char in enumerate(s):
        if char in t_count:
            filtered_s.append((i, char))
    
    min_length = float('inf')
    result = ""
    
    left = 0
    for right in range(len(filtered_s)):
        # Add the current character to the window
        char = filtered_s[right][1]
        window_count[char] = window_count.get(char, 0) + 1
        
        # Check if the current character forms a valid count
        if window_count[char] == t_count[char]:
            formed += 1
        
        # Try to minimize the window by moving the left pointer
        while left <= right and formed == required:
            # Get the current window boundaries in the original string
            start = filtered_s[left][0]
            end = filtered_s[right][0]
            
            # Update the result if the current window is smaller
            if end - start + 1 < min_length:
                min_length = end - start + 1
                result = s[start:end+1]
            
            # Remove the leftmost character from the window
            char = filtered_s[left][1]
            window_count[char] -= 1
            
            # Check if the removal breaks the valid count
            if window_count[char] < t_count[char]:
                formed -= 1
            
            left += 1
    
    return result
```

**Time Complexity:** O(m + n) - We iterate through s and t once.
**Space Complexity:** O(m + k) - We store the filtered s and the character counts.

## Solution Choice and Explanation

The sliding window solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(m + n) time complexity, which is optimal for this problem.

2. **Reasonable Space Complexity**: It uses O(k) space, where k is the size of the character set, which is typically small.

3. **Efficient Window Management**: It efficiently handles the sliding window by expanding and shrinking it based on the current state.

The key insight of this approach is to use a sliding window to find the minimum window substring. We expand the window by adding characters from the right, and when the window contains all characters in t, we shrink it from the left as much as possible while maintaining the condition. This allows us to find the minimum length substring for each valid window.

For example, with s = "ADOBECODEBANC" and t = "ABC":
- We start with left = 0, right = 0, formed = 0, required = 3.
- We expand the window to "A", formed = 1.
- We expand the window to "AD", formed = 1.
- We expand the window to "ADO", formed = 1.
- We expand the window to "ADOB", formed = 2.
- We expand the window to "ADOBE", formed = 2.
- We expand the window to "ADOBEC", formed = 3. Now the window contains all characters in t.
- We shrink the window to "DOBEC", formed = 2. The window no longer contains all characters in t.
- We expand the window to "DOBECODEBA", formed = 2.
- We expand the window to "DOBECODEBAC", formed = 3. Now the window contains all characters in t.
- We shrink the window to "BECODEBAC", formed = 3. The window still contains all characters in t.
- We continue shrinking the window until we reach "BANC", formed = 3. The window still contains all characters in t.
- We shrink the window to "ANC", formed = 2. The window no longer contains all characters in t.
- We've reached the end of the string, so we return the minimum window found: "BANC".

The alternative solution (Solution 3) is also efficient but more complex and uses more space. The brute force approach (Solution 1) is highly inefficient with O(m²n) time complexity.

In an interview, I would first mention the sliding window approach as the optimal solution that achieves O(m + n) time complexity with efficient window management.
