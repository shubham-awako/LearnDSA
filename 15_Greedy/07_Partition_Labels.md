# Partition Labels

## Problem Statement

You are given a string `s`. We want to partition the string into as many parts as possible so that each letter appears in at most one part.

Note that the partition is done so that after concatenating all the parts in order, the resultant string should be `s`.

Return a list of integers representing the size of these parts.

**Example 1:**
```
Input: s = "ababcbacadefegdehijhklij"
Output: [9,7,8]
Explanation:
The partition is "ababcbaca", "defegde", "hijhklij".
This is a partition so that each letter appears in at most one part.
A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits s into less parts.
```

**Example 2:**
```
Input: s = "eccbbbbdec"
Output: [10]
```

**Constraints:**
- `1 <= s.length <= 500`
- `s` consists of lowercase English letters.

## Concept Overview

This problem can be solved using a greedy approach. The key insight is to find the last occurrence of each character in the string and use that to determine the partitions.

## Solutions

### 1. Best Optimized Solution - Greedy Approach

Use a greedy approach to partition the string.

```python
def partitionLabels(s):
    # Find the last occurrence of each character
    last_occurrence = {char: i for i, char in enumerate(s)}
    
    # Initialize the result and the boundaries of the current partition
    result = []
    start = 0
    end = 0
    
    # Iterate through the string
    for i, char in enumerate(s):
        # Update the end of the current partition
        end = max(end, last_occurrence[char])
        
        # If we've reached the end of the current partition, add its size to the result
        if i == end:
            result.append(end - start + 1)
            start = i + 1
    
    return result
```

**Time Complexity:** O(n) - We iterate through the string once to find the last occurrences and once to determine the partitions.
**Space Complexity:** O(1) - We use a dictionary to store the last occurrences of each character, but since there are at most 26 lowercase English letters, the space complexity is constant.

### 2. Alternative Solution - Two-Pass Approach

Use a two-pass approach to partition the string.

```python
def partitionLabels(s):
    # First pass: Find the last occurrence of each character
    last_occurrence = {}
    for i, char in enumerate(s):
        last_occurrence[char] = i
    
    # Second pass: Determine the partitions
    result = []
    start = 0
    end = 0
    
    for i, char in enumerate(s):
        end = max(end, last_occurrence[char])
        
        if i == end:
            result.append(end - start + 1)
            start = i + 1
    
    return result
```

**Time Complexity:** O(n) - We iterate through the string twice.
**Space Complexity:** O(1) - We use a dictionary to store the last occurrences of each character, but since there are at most 26 lowercase English letters, the space complexity is constant.

### 3. Alternative Solution - Merge Intervals

Use a merge intervals approach to partition the string.

```python
def partitionLabels(s):
    # Find the first and last occurrence of each character
    char_intervals = {}
    for i, char in enumerate(s):
        if char not in char_intervals:
            char_intervals[char] = [i, i]
        else:
            char_intervals[char][1] = i
    
    # Sort the intervals by the start position
    intervals = sorted(char_intervals.values())
    
    # Merge overlapping intervals
    merged = [intervals[0]]
    for interval in intervals[1:]:
        if interval[0] <= merged[-1][1]:
            merged[-1][1] = max(merged[-1][1], interval[1])
        else:
            merged.append(interval)
    
    # Calculate the size of each partition
    return [end - start + 1 for start, end in merged]
```

**Time Complexity:** O(n) - We iterate through the string once to find the intervals, and since there are at most 26 lowercase English letters, the sorting and merging steps take constant time.
**Space Complexity:** O(1) - We use a dictionary to store the intervals of each character, but since there are at most 26 lowercase English letters, the space complexity is constant.

## Solution Choice and Explanation

The Greedy Approach solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of partitioning the string.

The key insight of this approach is to find the last occurrence of each character in the string and use that to determine the partitions. For each character, we update the end of the current partition to be the maximum of the current end and the last occurrence of the character. When we reach the end of the current partition, we add its size to the result and start a new partition.

For example, let's trace through the algorithm for s = "ababcbacadefegdehijhklij":

1. Find the last occurrence of each character:
   - last_occurrence = {'a': 8, 'b': 5, 'c': 7, 'd': 14, 'e': 15, 'f': 11, 'g': 13, 'h': 19, 'i': 22, 'j': 23, 'k': 20, 'l': 21}

2. Initialize result = [], start = 0, end = 0

3. Iterate through the string:
   - i = 0, char = 'a':
     - end = max(0, 8) = 8
     - i != end, so continue
   - i = 1, char = 'b':
     - end = max(8, 5) = 8
     - i != end, so continue
   - i = 2, char = 'a':
     - end = max(8, 8) = 8
     - i != end, so continue
   - i = 3, char = 'b':
     - end = max(8, 5) = 8
     - i != end, so continue
   - i = 4, char = 'c':
     - end = max(8, 7) = 8
     - i != end, so continue
   - i = 5, char = 'b':
     - end = max(8, 5) = 8
     - i != end, so continue
   - i = 6, char = 'a':
     - end = max(8, 8) = 8
     - i != end, so continue
   - i = 7, char = 'c':
     - end = max(8, 7) = 8
     - i != end, so continue
   - i = 8, char = 'a':
     - end = max(8, 8) = 8
     - i == end, so result = [9], start = 9
   - i = 9, char = 'd':
     - end = max(0, 14) = 14
     - i != end, so continue
   - i = 10, char = 'e':
     - end = max(14, 15) = 15
     - i != end, so continue
   - i = 11, char = 'f':
     - end = max(15, 11) = 15
     - i != end, so continue
   - i = 12, char = 'e':
     - end = max(15, 15) = 15
     - i != end, so continue
   - i = 13, char = 'g':
     - end = max(15, 13) = 15
     - i != end, so continue
   - i = 14, char = 'd':
     - end = max(15, 14) = 15
     - i != end, so continue
   - i = 15, char = 'e':
     - end = max(15, 15) = 15
     - i == end, so result = [9, 7], start = 16
   - i = 16, char = 'h':
     - end = max(0, 19) = 19
     - i != end, so continue
   - i = 17, char = 'i':
     - end = max(19, 22) = 22
     - i != end, so continue
   - i = 18, char = 'j':
     - end = max(22, 23) = 23
     - i != end, so continue
   - i = 19, char = 'h':
     - end = max(23, 19) = 23
     - i != end, so continue
   - i = 20, char = 'k':
     - end = max(23, 20) = 23
     - i != end, so continue
   - i = 21, char = 'l':
     - end = max(23, 21) = 23
     - i != end, so continue
   - i = 22, char = 'i':
     - end = max(23, 22) = 23
     - i != end, so continue
   - i = 23, char = 'j':
     - end = max(23, 23) = 23
     - i == end, so result = [9, 7, 8], start = 24

4. Return result = [9, 7, 8]

For s = "eccbbbbdec":

1. Find the last occurrence of each character:
   - last_occurrence = {'e': 9, 'c': 8, 'b': 6, 'd': 7}

2. Initialize result = [], start = 0, end = 0

3. Iterate through the string:
   - i = 0, char = 'e':
     - end = max(0, 9) = 9
     - i != end, so continue
   - i = 1, char = 'c':
     - end = max(9, 8) = 9
     - i != end, so continue
   - i = 2, char = 'c':
     - end = max(9, 8) = 9
     - i != end, so continue
   - i = 3, char = 'b':
     - end = max(9, 6) = 9
     - i != end, so continue
   - i = 4, char = 'b':
     - end = max(9, 6) = 9
     - i != end, so continue
   - i = 5, char = 'b':
     - end = max(9, 6) = 9
     - i != end, so continue
   - i = 6, char = 'b':
     - end = max(9, 6) = 9
     - i != end, so continue
   - i = 7, char = 'd':
     - end = max(9, 7) = 9
     - i != end, so continue
   - i = 8, char = 'e':
     - end = max(9, 9) = 9
     - i != end, so continue
   - i = 9, char = 'c':
     - end = max(9, 8) = 9
     - i == end, so result = [10], start = 10

4. Return result = [10]

The Two-Pass Approach solution (Solution 2) is essentially the same as the Greedy Approach solution but separates the two passes for clarity. The Merge Intervals solution (Solution 3) is less efficient and more complex but may be a good starting point for understanding the problem.

In an interview, I would first mention the Greedy Approach solution as the most efficient approach for this problem, and then discuss the Two-Pass Approach and Merge Intervals solutions as alternatives if asked for different approaches.
