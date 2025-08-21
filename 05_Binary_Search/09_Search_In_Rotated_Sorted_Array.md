# Search In Rotated Sorted Array

## Problem Statement

There is an integer array `nums` sorted in ascending order (with distinct values).

Prior to being passed to your function, `nums` is possibly rotated at an unknown pivot index `k` (`1 <= k < nums.length`) such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (0-indexed). For example, `[0,1,2,4,5,6,7]` might be rotated at pivot index 3 and become `[4,5,6,7,0,1,2]`.

Given the array `nums` after the possible rotation and an integer `target`, return the index of `target` if it is in `nums`, or `-1` if it is not in `nums`.

You must write an algorithm with O(log n) runtime complexity.

**Example 1:**
```
Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4
```

**Example 2:**
```
Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1
```

**Example 3:**
```
Input: nums = [1], target = 0
Output: -1
```

**Constraints:**
- `1 <= nums.length <= 5000`
- `-10^4 <= nums[i] <= 10^4`
- All values of `nums` are unique.
- `nums` is an ascending array that is possibly rotated.
- `-10^4 <= target <= 10^4`

## Concept Overview

This problem tests your understanding of binary search in a rotated sorted array. The key insight is to use binary search to find the target, but with a modified condition to handle the rotation.

## Solutions

### 1. Brute Force Approach - Linear Search

Iterate through the array to find the target.

```python
def search(nums, target):
    for i in range(len(nums)):
        if nums[i] == target:
            return i
    return -1
```

**Time Complexity:** O(n) - We iterate through the entire array.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

**Note:** This solution doesn't satisfy the O(log n) time complexity requirement.

### 2. Two-Pass Binary Search

First find the pivot index, then perform binary search in the appropriate half of the array.

```python
def search(nums, target):
    # Find the pivot index
    left, right = 0, len(nums) - 1
    while left < right:
        mid = left + (right - left) // 2
        if nums[mid] > nums[right]:
            left = mid + 1
        else:
            right = mid
    
    pivot = left
    
    # Perform binary search in the appropriate half
    if pivot == 0 or target < nums[0]:
        # Search in the right half
        left, right = pivot, len(nums) - 1
    else:
        # Search in the left half
        left, right = 0, pivot - 1
    
    # Standard binary search
    while left <= right:
        mid = left + (right - left) // 2
        if nums[mid] == target:
            return mid
        elif nums[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1
```

**Time Complexity:** O(log n) - We perform two binary searches, each taking O(log n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Best Optimized Solution - One-Pass Binary Search

Use a modified binary search to find the target in a single pass.

```python
def search(nums, target):
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid
        
        # Check if the left half is sorted
        if nums[left] <= nums[mid]:
            # Check if the target is in the left half
            if nums[left] <= target < nums[mid]:
                right = mid - 1
            else:
                left = mid + 1
        # The right half must be sorted
        else:
            # Check if the target is in the right half
            if nums[mid] < target <= nums[right]:
                left = mid + 1
            else:
                right = mid - 1
    
    return -1
```

**Time Complexity:** O(log n) - We perform a single binary search.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 4. Alternative Solution - Find Pivot First

Find the pivot index first, then adjust the indices during binary search.

```python
def search(nums, target):
    n = len(nums)
    
    # Find the pivot index
    left, right = 0, n - 1
    while left < right:
        mid = left + (right - left) // 2
        if nums[mid] > nums[right]:
            left = mid + 1
        else:
            right = mid
    
    pivot = left
    
    # Perform binary search with adjusted indices
    left, right = 0, n - 1
    while left <= right:
        mid = left + (right - left) // 2
        # Adjust the mid index
        real_mid = (mid + pivot) % n
        
        if nums[real_mid] == target:
            return real_mid
        elif nums[real_mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1
```

**Time Complexity:** O(log n) - We perform two binary searches, each taking O(log n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The one-pass binary search solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity, which is required by the problem.

2. **Efficiency**: It performs a single binary search, which is more efficient than the two-pass approach.

3. **Simplicity**: It's more straightforward to implement than the approach with adjusted indices.

The key insight of this solution is to use a modified binary search that handles the rotation. In each step, we determine which half of the array is sorted (at least one half must be sorted), and then check if the target is in that sorted half:
- If the left half is sorted (nums[left] <= nums[mid]), we check if the target is in the left half. If it is, we search in the left half; otherwise, we search in the right half.
- If the right half is sorted (nums[mid] < nums[right]), we check if the target is in the right half. If it is, we search in the right half; otherwise, we search in the left half.

For example, let's search for 0 in [4,5,6,7,0,1,2]:
1. left = 0, right = 6, mid = 3, nums[mid] = 7
2. nums[left] <= nums[mid] (4 <= 7), so the left half is sorted
3. target = 0 is not in the range [nums[left], nums[mid]) = [4, 7), so search in the right half: left = 4, right = 6
4. left = 4, right = 6, mid = 5, nums[mid] = 1
5. nums[left] > nums[mid] (0 > 1 is false), so the right half is sorted
6. target = 0 is not in the range (nums[mid], nums[right]] = (1, 2], so search in the left half: left = 4, right = 4
7. left = 4, right = 4, mid = 4, nums[mid] = 0
8. nums[mid] = 0 = target, so return mid = 4

The two-pass binary search approach (Solution 2) is also efficient but performs two binary searches. The approach with adjusted indices (Solution 4) is more complex and may be error-prone. The brute force approach (Solution 1) doesn't satisfy the O(log n) time complexity requirement.

In an interview, I would first mention the one-pass binary search approach as the most efficient solution for this problem.
