# Find Minimum In Rotated Sorted Array

## Problem Statement

Suppose an array of length `n` sorted in ascending order is rotated between `1` and `n` times. For example, the array `nums = [0,1,2,4,5,6,7]` might become:
- `[4,5,6,7,0,1,2]` if it was rotated `4` times.
- `[0,1,2,4,5,6,7]` if it was rotated `7` times.

Notice that rotating an array `[a[0], a[1], a[2], ..., a[n-1]]` 1 time results in the array `[a[n-1], a[0], a[1], a[2], ..., a[n-2]]`.

Given the sorted rotated array `nums` of unique elements, return the minimum element of this array.

You must write an algorithm that runs in O(log n) time.

**Example 1:**
```
Input: nums = [3,4,5,1,2]
Output: 1
Explanation: The original array was [1,2,3,4,5] rotated 3 times.
```

**Example 2:**
```
Input: nums = [4,5,6,7,0,1,2]
Output: 0
Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
```

**Example 3:**
```
Input: nums = [11,13,15,17]
Output: 11
Explanation: The original array was [11,13,15,17] and it was rotated 4 times. 
```

**Constraints:**
- `n == nums.length`
- `1 <= n <= 5000`
- `-5000 <= nums[i] <= 5000`
- All the integers of `nums` are unique.
- `nums` is sorted and rotated between `1` and `n` times.

## Concept Overview

This problem tests your understanding of binary search in a rotated sorted array. The key insight is to use binary search to find the pivot point (the minimum element) by comparing elements with the rightmost element.

## Solutions

### 1. Brute Force Approach - Linear Search

Iterate through the array to find the minimum element.

```python
def findMin(nums):
    return min(nums)
```

**Time Complexity:** O(n) - We iterate through the entire array.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

**Note:** This solution doesn't satisfy the O(log n) time complexity requirement.

### 2. Best Optimized Solution - Binary Search

Use binary search to find the minimum element in the rotated sorted array.

```python
def findMin(nums):
    left, right = 0, len(nums) - 1
    
    while left < right:
        mid = left + (right - left) // 2
        
        # If the middle element is greater than the rightmost element,
        # the minimum element must be in the right half
        if nums[mid] > nums[right]:
            left = mid + 1
        # Otherwise, the minimum element must be in the left half (including mid)
        else:
            right = mid
    
    return nums[left]
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Binary Search with Different Comparison

Use binary search with a different comparison strategy.

```python
def findMin(nums):
    left, right = 0, len(nums) - 1
    
    # If the array is not rotated or is rotated n times
    if nums[left] < nums[right]:
        return nums[left]
    
    while left < right:
        mid = left + (right - left) // 2
        
        # If the middle element is greater than the leftmost element,
        # the minimum element must be in the right half
        if nums[mid] >= nums[0]:
            left = mid + 1
        # Otherwise, the minimum element must be in the left half (including mid)
        else:
            right = mid
    
    return nums[left]
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

**Note:** This solution assumes that the array is rotated at least once. If the array is not rotated, we need to handle it separately.

## Solution Choice and Explanation

The binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity, which is required by the problem.

2. **Robustness**: It handles all cases correctly, including when the array is not rotated or is rotated n times.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this solution is to use binary search to find the minimum element in the rotated sorted array. We compare the middle element with the rightmost element to determine which half of the array contains the minimum element:
- If the middle element is greater than the rightmost element, the minimum element must be in the right half (because the array is rotated).
- Otherwise, the minimum element must be in the left half (including the middle element).

For example, let's find the minimum element in [4,5,6,7,0,1,2]:
1. left = 0, right = 6, mid = 3, nums[mid] = 7, nums[right] = 2
2. 7 > 2, so the minimum element must be in the right half: left = 4, right = 6
3. left = 4, right = 6, mid = 5, nums[mid] = 1, nums[right] = 2
4. 1 < 2, so the minimum element must be in the left half (including mid): left = 4, right = 5
5. left = 4, right = 5, mid = 4, nums[mid] = 0, nums[right] = 1
6. 0 < 1, so the minimum element must be in the left half (including mid): left = 4, right = 4
7. left = 4, right = 4, the loop terminates
8. Return nums[left] = nums[4] = 0

The alternative solution (Solution 3) is also efficient but requires a separate check for when the array is not rotated or is rotated n times. The brute force approach (Solution 1) doesn't satisfy the O(log n) time complexity requirement.

In an interview, I would first mention the binary search approach as the most efficient solution for this problem.
