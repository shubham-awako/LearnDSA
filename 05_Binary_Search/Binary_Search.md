# Binary Search

## Problem Statement

Given an array of integers `nums` which is sorted in ascending order, and an integer `target`, write a function to search `target` in `nums`. If `target` exists, then return its index. Otherwise, return `-1`.

You must write an algorithm with O(log n) runtime complexity.

**Example 1:**
```
Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4
Explanation: 9 exists in nums and its index is 4
```

**Example 2:**
```
Input: nums = [-1,0,3,5,9,12], target = 2
Output: -1
Explanation: 2 does not exist in nums so return -1
```

**Constraints:**
- `1 <= nums.length <= 10^4`
- `-10^4 < nums[i], target < 10^4`
- All the integers in `nums` are unique.
- `nums` is sorted in ascending order.

## Concept Overview

Binary search is a fundamental algorithm for efficiently finding an element in a sorted array. The key insight is to repeatedly divide the search interval in half, eliminating half of the remaining elements at each step.

## Solutions

### 1. Iterative Binary Search

Use a loop to repeatedly narrow down the search range.

```python
def search(nums, target):
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2  # Avoid integer overflow
        
        if nums[mid] == target:
            return mid  # Target found
        elif nums[mid] < target:
            left = mid + 1  # Search in the right half
        else:
            right = mid - 1  # Search in the left half
    
    return -1  # Target not found
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Recursive Binary Search

Use recursion to repeatedly narrow down the search range.

```python
def search(nums, target):
    def binary_search(left, right):
        if left > right:
            return -1  # Target not found
        
        mid = left + (right - left) // 2  # Avoid integer overflow
        
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

### 3. Alternative Solution - Python's Built-in Functions

Use Python's built-in functions to find the target.

```python
def search(nums, target):
    try:
        return nums.index(target)
    except ValueError:
        return -1
```

**Time Complexity:** O(n) - Python's `index` method performs a linear search.
**Space Complexity:** O(1) - No extra space is used.

**Note:** This solution doesn't satisfy the O(log n) runtime complexity requirement.

## Solution Choice and Explanation

The iterative binary search solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity, which is required by the problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(log n) space used by the recursive approach.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of binary search is to repeatedly divide the search interval in half. In each step, we compare the middle element with the target:
- If they are equal, we've found the target.
- If the middle element is less than the target, the target must be in the right half.
- If the middle element is greater than the target, the target must be in the left half.

For example, let's search for 9 in [-1,0,3,5,9,12]:
1. left = 0, right = 5, mid = 2, nums[mid] = 3
2. 3 < 9, so search in the right half: left = 3, right = 5
3. left = 3, right = 5, mid = 4, nums[mid] = 9
4. 9 == 9, so return 4

The recursive binary search solution (Solution 2) is also efficient but uses O(log n) extra space for the recursion stack. The built-in function solution (Solution 3) doesn't satisfy the O(log n) runtime complexity requirement.

In an interview, I would first mention the iterative binary search approach as the most efficient solution for this problem.
