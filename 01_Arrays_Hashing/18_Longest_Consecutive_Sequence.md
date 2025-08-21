# Longest Consecutive Sequence

## Problem Statement

Given an unsorted array of integers `nums`, return the length of the longest consecutive elements sequence.

You must write an algorithm that runs in O(n) time.

**Example 1:**
```
Input: nums = [100,4,200,1,3,2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
```

**Example 2:**
```
Input: nums = [0,3,7,2,5,8,4,6,0,1]
Output: 9
```

**Constraints:**
- `0 <= nums.length <= 10^5`
- `-10^9 <= nums[i] <= 10^9`

## Concept Overview

This problem asks us to find the longest sequence of consecutive integers in an unsorted array. The key insight is to efficiently determine if a number is the start of a sequence and then count the length of that sequence.

## Solutions

### 1. Brute Force Approach - Sorting

Sort the array and count consecutive sequences.

```python
def longestConsecutive(nums):
    if not nums:
        return 0
    
    nums.sort()
    longest_streak = 1
    current_streak = 1
    
    for i in range(1, len(nums)):
        if nums[i] != nums[i-1]:  # Skip duplicates
            if nums[i] == nums[i-1] + 1:
                current_streak += 1
            else:
                longest_streak = max(longest_streak, current_streak)
                current_streak = 1
    
    return max(longest_streak, current_streak)
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

### 2. Improved Solution - HashSet with Sequence Building

Use a hash set to store all numbers, then for each number, check if it's the start of a sequence and count the length.

```python
def longestConsecutive(nums):
    if not nums:
        return 0
    
    num_set = set(nums)
    longest_streak = 0
    
    for num in num_set:
        # Check if this number is the start of a sequence
        if num - 1 not in num_set:
            current_num = num
            current_streak = 1
            
            # Count the length of the sequence
            while current_num + 1 in num_set:
                current_num += 1
                current_streak += 1
            
            longest_streak = max(longest_streak, current_streak)
    
    return longest_streak
```

**Time Complexity:** O(n) - We iterate through the array once to build the set, and then for each number, we check at most once if it's the start of a sequence.
**Space Complexity:** O(n) - We store all numbers in a hash set.

### 3. Best Optimized Solution - HashSet with Bidirectional Search

Use a hash set to store all numbers, then for each number, search in both directions to find the length of the sequence.

```python
def longestConsecutive(nums):
    if not nums:
        return 0
    
    num_set = set(nums)
    longest_streak = 0
    
    for num in nums:
        # Check if this number has been processed as part of a sequence
        if num in num_set:
            # Remove the current number to mark it as processed
            num_set.remove(num)
            
            # Extend the sequence in both directions
            current_streak = 1
            left = num - 1
            right = num + 1
            
            # Extend to the left
            while left in num_set:
                num_set.remove(left)
                current_streak += 1
                left -= 1
            
            # Extend to the right
            while right in num_set:
                num_set.remove(right)
                current_streak += 1
                right += 1
            
            longest_streak = max(longest_streak, current_streak)
    
    return longest_streak
```

**Time Complexity:** O(n) - Each number is processed at most once.
**Space Complexity:** O(n) - We store all numbers in a hash set.

## Solution Choice and Explanation

The HashSet with Sequence Building solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, as required by the problem.

2. **Efficient Sequence Detection**: It only builds sequences starting from the smallest number in each sequence, avoiding redundant work.

3. **Simple Implementation**: It's straightforward to implement and understand.

The key insight of this approach is to only start building sequences from numbers that are the beginning of a sequence (i.e., num - 1 is not in the set). This ensures that we only process each sequence once, starting from its smallest number.

While the Bidirectional Search solution (Solution 3) also has O(n) time complexity, it's more complex and doesn't offer significant advantages over Solution 2. It also modifies the hash set during iteration, which can be error-prone.

The sorting approach (Solution 1) is simple but doesn't meet the O(n) time complexity requirement due to the O(n log n) sorting operation.

In an interview, I would first mention the sorting approach to establish a baseline, then explain the HashSet with Sequence Building approach as the optimal solution that meets the O(n) time complexity requirement.
