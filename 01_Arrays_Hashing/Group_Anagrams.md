# Group Anagrams

## Problem Statement

Given an array of strings `strs`, group the anagrams together. You can return the answer in any order.

An **Anagram** is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

**Example 1:**
```
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
```

**Example 2:**
```
Input: strs = [""]
Output: [[""]]
```

**Example 3:**
```
Input: strs = ["a"]
Output: [["a"]]
```

**Constraints:**
- `1 <= strs.length <= 10^4`
- `0 <= strs[i].length <= 100`
- `strs[i]` consists of lowercase English letters.

## Concept Overview

This problem extends the concept of anagrams by requiring us to group together all strings that are anagrams of each other. The key insight is to find a way to identify anagrams efficiently.

## Solutions

### 1. Brute Force Approach - Compare All Pairs

For each string, check if it's an anagram of any existing group. If yes, add it to that group; otherwise, create a new group.

```python
def groupAnagrams(strs):
    result = []
    
    for s in strs:
        found = False
        for group in result:
            if isAnagram(s, group[0]):
                group.append(s)
                found = True
                break
        
        if not found:
            result.append([s])
    
    return result

def isAnagram(s1, s2):
    if len(s1) != len(s2):
        return False
    
    counter = {}
    
    for char in s1:
        counter[char] = counter.get(char, 0) + 1
    
    for char in s2:
        if char not in counter or counter[char] == 0:
            return False
        counter[char] -= 1
    
    return True
```

**Time Complexity:** O(n²k) - where n is the number of strings and k is the maximum length of a string.
**Space Complexity:** O(nk) - for storing the result.

### 2. Improved Solution - Sorting as a Key

Sort each string to create a canonical form for anagrams, then use this sorted string as a key in a hash map.

```python
def groupAnagrams(strs):
    anagram_groups = {}
    
    for s in strs:
        sorted_s = ''.join(sorted(s))
        if sorted_s in anagram_groups:
            anagram_groups[sorted_s].append(s)
        else:
            anagram_groups[sorted_s] = [s]
    
    return list(anagram_groups.values())
```

**Time Complexity:** O(n k log k) - where n is the number of strings and k is the maximum length of a string (sorting each string takes O(k log k)).
**Space Complexity:** O(nk) - for storing the result.

### 3. Best Optimized Solution - Character Count as Key

Use a tuple of character counts as the key for each string, avoiding the need to sort.

```python
def groupAnagrams(strs):
    anagram_groups = {}
    
    for s in strs:
        # Create a count of each character
        count = [0] * 26
        for char in s:
            count[ord(char) - ord('a')] += 1
        
        # Convert count to tuple to use as dictionary key
        count_tuple = tuple(count)
        
        if count_tuple in anagram_groups:
            anagram_groups[count_tuple].append(s)
        else:
            anagram_groups[count_tuple] = [s]
    
    return list(anagram_groups.values())
```

**Time Complexity:** O(nk) - where n is the number of strings and k is the maximum length of a string.
**Space Complexity:** O(nk) - for storing the result.

## Solution Choice and Explanation

The character count solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(nk) time complexity, which is better than the sorting approach's O(n k log k).

2. **Direct Mapping**: It creates a direct mapping from the character frequency pattern to the anagram group, avoiding the overhead of sorting.

3. **Efficient for the Constraints**: Given that the strings consist only of lowercase English letters, the character count array has a fixed size of 26, making it very efficient.

The sorting approach (Solution 2) is a good alternative and is often more intuitive to understand. It's slightly less efficient due to the sorting operation but is still a valid solution.

The brute force approach (Solution 1) is inefficient for large inputs and should be avoided.

In an interview, I would first mention the sorting approach for its simplicity and then optimize to the character count solution for better time complexity. I would also explain that the character count solution works well for the given constraint of lowercase English letters but would need to be adapted for a larger character set.
