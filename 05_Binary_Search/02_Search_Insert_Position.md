# Search Insert Position

## Problem Statement

Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.

**Example 1:**
```
Input: nums = [1,3,5,6], target = 5
Output: 2
```

**Example 2:**
```
Input: nums = [1,3,5,6], target = 2
Output: 1
```

**Example 3:**
```
Input: nums = [1,3,5,6], target = 7
Output: 4
```

**Constraints:**
- `1 <= nums.length <= 10^4`
- `-10^4 <= nums[i] <= 10^4`
- `nums` contains distinct values sorted in ascending order.
- `-10^4 <= target <= 10^4`

## Concept Overview

This problem is a variation of the standard binary search algorithm. The key insight is to find the position where the target should be inserted, which is equivalent to finding the first element greater than or equal to the target.

## Solutions

### 1. Iterative Binary Search

Use binary search to find the position where the target should be inserted.

```python
def searchInsert(nums, target):
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid  # Target found
        elif nums[mid] < target:
            left = mid + 1  # Search in the right half
        else:
            right = mid - 1  # Search in the left half
    
    # Target not found, return the insertion position
    return left
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Recursive Binary Search

Use recursion to find the position where the target should be inserted.

```python
def searchInsert(nums, target):
    def binary_search(left, right):
        if left > right:
            return left  # Target not found, return the insertion position
        
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid  # Target found
        elif nums[mid] < target:
            return binary_search(mid + 1, right)  # Search in the right half
        else:
            return binary_search(left, mid - 1)  # Search in the left half
    
    return binary_search(0, len(nums) - 1)
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(log n) - The recursion stack can go up to log n levels deep.

### 3. Alternative Solution - Linear Search

Scan the array from left to right to find the position where the target should be inserted.

```python
def searchInsert(nums, target):
    for i in range(len(nums)):
        if nums[i] >= target:
            return i
    
    # Target is greater than all elements in the array
    return len(nums)
```

**Time Complexity:** O(n) - We may need to scan the entire array.
**Space Complexity:** O(1) - We use only a few variables.

**Note:** This solution doesn't satisfy the O(log n) runtime complexity requirement.

### 4. Alternative Solution - Using Python's bisect Module

Use Python's built-in bisect module to find the insertion position.

```python
import bisect

def searchInsert(nums, target):
    return bisect.bisect_left(nums, target)
```

**Time Complexity:** O(log n) - Python's bisect_left function uses binary search.
**Space Complexity:** O(1) - No extra space is used.

## Solution Choice and Explanation

The iterative binary search solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity, which is required by the problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(log n) space used by the recursive approach.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this solution is that when the binary search terminates without finding the target, the `left` pointer points to the position where the target should be inserted. This is because:
- If the target is less than all elements in the array, `left` will be 0.
- If the target is greater than all elements in the array, `left` will be `len(nums)`.
- Otherwise, `left` will point to the first element greater than the target.

For example, let's find the insertion position for 2 in [1,3,5,6]:
1. left = 0, right = 3, mid = 1, nums[mid] = 3
2. 3 > 2, so search in the left half: left = 0, right = 0
3. left = 0, right = 0, mid = 0, nums[mid] = 1
4. 1 < 2, so search in the right half: left = 1, right = -1
5. left > right, so the loop terminates
6. Return left = 1, which is the correct insertion position for 2

The recursive binary search solution (Solution 2) is also efficient but uses O(log n) extra space for the recursion stack. The linear search solution (Solution 3) doesn't satisfy the O(log n) runtime complexity requirement. The bisect module solution (Solution 4) is elegant and efficient, but it's important to understand the underlying algorithm.

In an interview, I would first mention the iterative binary search approach as the most efficient solution for this problem.
