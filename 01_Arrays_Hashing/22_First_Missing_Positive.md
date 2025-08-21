# First Missing Positive

## Problem Statement

Given an unsorted integer array `nums`, return the smallest missing positive integer.

You must implement an algorithm that runs in O(n) time and uses O(1) extra space.

**Example 1:**
```
Input: nums = [1,2,0]
Output: 3
Explanation: The numbers in the range [1,2] are all in the array.
```

**Example 2:**
```
Input: nums = [3,4,-1,1]
Output: 2
Explanation: 1 is in the array but 2 is missing.
```

**Example 3:**
```
Input: nums = [7,8,9,11,12]
Output: 1
Explanation: The smallest positive integer 1 is missing.
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-2^31 <= nums[i] <= 2^31 - 1`

## Concept Overview

This problem asks us to find the smallest positive integer that is not present in the array. The key insight is to use the array itself as a hash table by marking the presence of positive integers.

## Solutions

### 1. Brute Force Approach - Sorting

Sort the array and find the first missing positive integer.

```python
def firstMissingPositive(nums):
    nums.sort()
    
    smallest_positive = 1
    
    for num in nums:
        if num == smallest_positive:
            smallest_positive += 1
        elif num > smallest_positive:
            return smallest_positive
    
    return smallest_positive
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

### 2. Improved Solution - Hash Set

Use a hash set to store all positive integers in the array, then find the first missing positive.

```python
def firstMissingPositive(nums):
    # Create a set of all positive integers in the array
    positive_set = set()
    for num in nums:
        if num > 0:
            positive_set.add(num)
    
    # Find the first missing positive integer
    smallest_positive = 1
    while smallest_positive in positive_set:
        smallest_positive += 1
    
    return smallest_positive
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We store positive integers in a hash set.

### 3. Best Optimized Solution - Array as Hash Table

Use the array itself as a hash table by marking the presence of positive integers.

```python
def firstMissingPositive(nums):
    n = len(nums)
    
    # Step 1: Replace negative numbers, zeros, and numbers larger than n with n+1
    for i in range(n):
        if nums[i] <= 0 or nums[i] > n:
            nums[i] = n + 1
    
    # Step 2: Mark the presence of each number in the range [1, n]
    for i in range(n):
        num = abs(nums[i])
        if num <= n:
            # Mark the presence by making the number at index (num-1) negative
            if nums[num - 1] > 0:
                nums[num - 1] = -nums[num - 1]
    
    # Step 3: Find the first index with a positive value
    for i in range(n):
        if nums[i] > 0:
            return i + 1
    
    # If all numbers in the range [1, n] are present, return n+1
    return n + 1
```

**Time Complexity:** O(n) - We make three passes through the array.
**Space Complexity:** O(1) - We use the array itself as a hash table.

## Solution Choice and Explanation

The array as hash table solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity with just three passes through the array.

2. **Optimal Space Complexity**: It uses O(1) extra space, as required by the problem.

3. **Clever Use of Array**: It repurposes the input array to mark the presence of positive integers.

The key insight of this approach is to use the array indices to represent positive integers and the sign of the values to indicate presence. The algorithm works in three steps:

1. Replace all numbers that are out of range (negative, zero, or greater than n) with a value that won't interfere with our marking (n+1).
2. For each number in the range [1, n], mark its presence by making the value at the corresponding index negative.
3. Find the first index with a positive value, which corresponds to the first missing positive integer.

The sorting approach (Solution 1) is simple but doesn't meet the O(n) time complexity requirement. The hash set approach (Solution 2) meets the time complexity requirement but uses O(n) extra space.

In an interview, I would first mention the constraints (O(n) time and O(1) space), then explain the array as hash table approach as the optimal solution that meets all requirements.
