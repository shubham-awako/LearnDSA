# Valid Anagram

## Problem Statement

Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`, and `false` otherwise.

An **Anagram** is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

**Example 1:**
```
Input: s = "anagram", t = "nagaram"
Output: true
```

**Example 2:**
```
Input: s = "rat", t = "car"
Output: false
```

**Constraints:**
- `1 <= s.length, t.length <= 5 * 10^4`
- `s` and `t` consist of lowercase English letters.

**Follow-up:** What if the inputs contain Unicode characters? How would you adapt your solution to such a case?

## Concept Overview

An anagram is a word formed by rearranging the letters of another word, using all the original letters exactly once. To determine if two strings are anagrams, we need to check if they have the same characters with the same frequencies.

## Solutions

### 1. Brute Force Approach - Sorting

Sort both strings and compare them. If they are anagrams, the sorted strings will be identical.

```python
def isAnagram(s, t):
    if len(s) != len(t):
        return False
    
    return sorted(s) == sorted(t)
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(n) - Space required for sorting.

### 2. Improved Solution - Character Count with Dictionary

Count the frequency of each character in both strings and compare the counts.

```python
def isAnagram(s, t):
    if len(s) != len(t):
        return False
    
    char_count_s = {}
    char_count_t = {}
    
    for char in s:
        char_count_s[char] = char_count_s.get(char, 0) + 1
    
    for char in t:
        char_count_t[char] = char_count_t.get(char, 0) + 1
    
    return char_count_s == char_count_t
```

**Time Complexity:** O(n) - We iterate through each string once.
**Space Complexity:** O(k) - Where k is the size of the character set (26 for lowercase English letters).

### 3. Best Optimized Solution - Single Dictionary

Use a single dictionary to count characters in the first string and decrement counts for the second string.

```python
def isAnagram(s, t):
    if len(s) != len(t):
        return False
    
    char_count = {}
    
    # Count characters in s
    for char in s:
        char_count[char] = char_count.get(char, 0) + 1
    
    # Decrement counts for characters in t
    for char in t:
        if char not in char_count or char_count[char] == 0:
            return False
        char_count[char] -= 1
    
    return True
```

**Time Complexity:** O(n) - We iterate through each string once.
**Space Complexity:** O(k) - Where k is the size of the character set (26 for lowercase English letters).

### 4. Alternative Solution for Unicode Characters

For Unicode characters, we can use the Counter class from the collections module:

```python
from collections import Counter

def isAnagram(s, t):
    return Counter(s) == Counter(t)
```

**Time Complexity:** O(n) - Counter creation is linear.
**Space Complexity:** O(k) - Where k is the number of unique characters.

## Solution Choice and Explanation

For this problem, the best solution is the single dictionary approach (Solution 3) because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Early Termination**: It can return false as soon as an inconsistency is found, without processing the entire strings.

3. **Space Efficiency**: It uses only one dictionary instead of two, reducing the constant factor in space complexity.

4. **Handles the Constraints Well**: For the given constraint of lowercase English letters, a single dictionary is very efficient.

For the follow-up question about Unicode characters, the Counter solution is elegant and handles all character types without modification. It's slightly less efficient than the optimized single dictionary approach due to the overhead of the Counter class, but it's more readable and handles the general case well.

In an interview setting, I would first implement the single dictionary solution for its efficiency, and then mention the Counter approach as a clean alternative, especially when dealing with Unicode characters.
