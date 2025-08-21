# Two Sum

## Problem Statement

Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to `target`.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

**Example 1:**
```
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
```

**Example 2:**
```
Input: nums = [3,2,4], target = 6
Output: [1,2]
```

**Example 3:**
```
Input: nums = [3,3], target = 6
Output: [0,1]
```

**Constraints:**
- `2 <= nums.length <= 10^4`
- `-10^9 <= nums[i] <= 10^9`
- `-10^9 <= target <= 10^9`
- Only one valid answer exists.

**Follow-up:** Can you come up with an algorithm that is less than O(n²) time complexity?

## Concept Overview

The Two Sum problem asks us to find two numbers in an array that add up to a specific target value. The key insight is to efficiently find the complement of each number (target - current number) in the array.

## Solutions

### 1. Brute Force Approach

Check every possible pair of numbers in the array.

```python
def twoSum(nums, target):
    n = len(nums)
    for i in range(n):
        for j in range(i + 1, n):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []  # No solution found
```

**Time Complexity:** O(n²) - We check each pair of elements.
**Space Complexity:** O(1) - No extra space is used except for the output.

### 2. Improved Solution - Two-Pass Hash Table

Use a hash table to store each element and its index. Then in a second pass, check if the complement exists in the hash table.

```python
def twoSum(nums, target):
    num_to_index = {}
    for i, num in enumerate(nums):
        num_to_index[num] = i
    
    for i, num in enumerate(nums):
        complement = target - num
        if complement in num_to_index and num_to_index[complement] != i:
            return [i, num_to_index[complement]]
    
    return []  # No solution found
```

**Time Complexity:** O(n) - We iterate through the array twice.
**Space Complexity:** O(n) - We store all elements in a hash table.

### 3. Best Optimized Solution - One-Pass Hash Table

Combine the two passes into one by checking for the complement while building the hash table.

```python
def twoSum(nums, target):
    num_to_index = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in num_to_index:
            return [num_to_index[complement], i]
        num_to_index[num] = i
    
    return []  # No solution found
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We store elements in a hash table.

## Solution Choice and Explanation

The one-pass hash table solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity by using a hash table for O(1) lookups.

2. **Single Pass**: Unlike the two-pass solution, it only needs to iterate through the array once, making it more efficient.

3. **Early Termination**: It returns as soon as a valid pair is found, without processing the entire array in the best case.

4. **Space-Time Tradeoff**: While it uses O(n) extra space, the improvement in time complexity from O(n²) to O(n) is significant and worth the space cost.

The brute force approach is simple but inefficient for large arrays. The two-pass hash table solution is better but still does unnecessary work by building the complete hash table first.

This problem is a classic example of using a hash table to trade space for time, reducing the time complexity from O(n²) to O(n). It's a common interview question that tests understanding of hash tables and efficient lookups.

In an interview, I would first mention the brute force approach to establish a baseline, then immediately pivot to the one-pass hash table solution as the optimal approach.
