# Search In Rotated Sorted Array II

## Problem Statement

There is an integer array `nums` sorted in non-decreasing order (not necessarily with distinct values).

Before being passed to your function, `nums` is rotated at an unknown pivot index `k` (`0 <= k < nums.length`) such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (0-indexed). For example, `[0,1,2,4,4,4,5,6,6,7]` might be rotated at pivot index 5 and become `[4,5,6,6,7,0,1,2,4,4]`.

Given the array `nums` after the rotation and an integer `target`, return `true` if `target` is in `nums`, or `false` if it is not in `nums`.

You must decrease the overall operation steps as much as possible.

**Example 1:**
```
Input: nums = [2,5,6,0,0,1,2], target = 0
Output: true
```

**Example 2:**
```
Input: nums = [2,5,6,0,0,1,2], target = 3
Output: false
```

**Constraints:**
- `1 <= nums.length <= 5000`
- `-10^4 <= nums[i] <= 10^4`
- `nums` is guaranteed to be rotated at some pivot.
- `-10^4 <= target <= 10^4`

**Follow up:** This problem is similar to Search in Rotated Sorted Array, but `nums` may contain duplicates. Would this affect the runtime complexity? How and why?

## Concept Overview

This problem is a variation of the "Search in Rotated Sorted Array" problem, but with the added complexity of duplicate elements. The key insight is to use a modified binary search that handles both the rotation and the duplicates.

## Solutions

### 1. Brute Force Approach - Linear Search

Iterate through the array to find the target.

```python
def search(nums, target):
    return target in nums
```

**Time Complexity:** O(n) - We iterate through the entire array.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - Modified Binary Search

Use a modified binary search to handle both the rotation and the duplicates.

```python
def search(nums, target):
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return True
        
        # Handle duplicates
        if nums[left] == nums[mid] == nums[right]:
            left += 1
            right -= 1
            continue
        
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
    
    return False
```

**Time Complexity:** O(log n) in the average case, but O(n) in the worst case when the array contains many duplicates.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Two-Pass Binary Search

First find the pivot index, then perform binary search in the appropriate half of the array.

```python
def search(nums, target):
    # Find the pivot index
    left, right = 0, len(nums) - 1
    while left < right:
        mid = left + (right - left) // 2
        
        # Handle duplicates
        if nums[mid] == nums[right]:
            right -= 1
            continue
        
        if nums[mid] > nums[right]:
            left = mid + 1
        else:
            right = mid
    
    pivot = left
    
    # Perform binary search in the appropriate half
    if nums[pivot] <= target <= nums[len(nums) - 1]:
        # Search in the right half
        left, right = pivot, len(nums) - 1
    else:
        # Search in the left half
        left, right = 0, pivot - 1
    
    # Standard binary search
    while left <= right:
        mid = left + (right - left) // 2
        if nums[mid] == target:
            return True
        elif nums[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return False
```

**Time Complexity:** O(log n) in the average case, but O(n) in the worst case when the array contains many duplicates.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The modified binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity in the average case, which is efficient for most scenarios.

2. **Simplicity**: It's more straightforward to implement than the two-pass approach.

3. **Handling of Duplicates**: It efficiently handles the case where the array contains duplicates by skipping them.

The key insight of this solution is to use a modified binary search that handles both the rotation and the duplicates. When we encounter duplicates at the left, middle, and right positions, we simply skip them by incrementing the left pointer and decrementing the right pointer. Otherwise, we proceed with the standard binary search for rotated sorted arrays.

For example, let's search for 0 in [2,5,6,0,0,1,2]:
1. left = 0, right = 6, mid = 3, nums[mid] = 0
2. nums[mid] = 0 = target, so return True

Let's search for 3 in [2,5,6,0,0,1,2]:
1. left = 0, right = 6, mid = 3, nums[mid] = 0
2. nums[left] <= nums[mid] (2 <= 0 is false), so the right half must be sorted
3. target = 3 is not in the range (nums[mid], nums[right]] = (0, 2], so search in the left half: left = 0, right = 2
4. left = 0, right = 2, mid = 1, nums[mid] = 5
5. nums[left] <= nums[mid] (2 <= 5), so the left half is sorted
6. target = 3 is in the range [nums[left], nums[mid]) = [2, 5), so search in the left half: left = 0, right = 0
7. left = 0, right = 0, mid = 0, nums[mid] = 2
8. nums[mid] = 2 != target = 3, and left > right, so return False

The two-pass binary search approach (Solution 3) is also efficient but more complex. The brute force approach (Solution 1) is simple and may be more efficient in the worst case when the array contains many duplicates.

In an interview, I would first mention the modified binary search approach as the most efficient solution for this problem, but also note that the brute force approach may be more efficient in the worst case when the array contains many duplicates.

**Follow-up Answer:** Yes, the presence of duplicates affects the runtime complexity. In the worst case, when the array contains many duplicates (e.g., [1,1,1,1,1,1,1]), the binary search algorithm may degenerate to O(n) time complexity because we may need to examine all elements to determine which half to search in. This is because duplicates make it impossible to determine which half of the array is sorted based on comparing elements at the left, middle, and right positions.
