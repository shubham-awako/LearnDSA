# Sort Colors

## Problem Statement

Given an array `nums` with `n` objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

We will use the integers `0`, `1`, and `2` to represent the color red, white, and blue, respectively.

You must solve this problem without using the library's sort function.

**Example 1:**
```
Input: nums = [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
```

**Example 2:**
```
Input: nums = [2,0,1]
Output: [0,1,2]
```

**Constraints:**
- `n == nums.length`
- `1 <= n <= 300`
- `nums[i]` is either `0`, `1`, or `2`.

**Follow up:** Could you come up with a one-pass algorithm using only constant extra space?

## Concept Overview

This problem is also known as the Dutch National Flag problem, introduced by Edsger W. Dijkstra. The goal is to sort an array containing only three distinct values (0, 1, and 2) in a single pass with constant extra space.

## Solutions

### 1. Brute Force Approach - Counting Sort

Count the occurrences of each color and then overwrite the array.

```python
def sortColors(nums):
    counts = [0, 0, 0]  # Count of 0s, 1s, and 2s
    
    # Count occurrences of each color
    for num in nums:
        counts[num] += 1
    
    # Overwrite the array with the sorted colors
    index = 0
    for color in range(3):
        for _ in range(counts[color]):
            nums[index] = color
            index += 1
    
    return nums
```

**Time Complexity:** O(n) - We iterate through the array twice.
**Space Complexity:** O(1) - We use a fixed-size array for counting.

### 2. Improved Solution - Two-Pass Approach

First pass to move all 0s to the beginning, second pass to move all 1s to the middle.

```python
def sortColors(nums):
    # First pass: move all 0s to the beginning
    j = 0
    for i in range(len(nums)):
        if nums[i] == 0:
            nums[i], nums[j] = nums[j], nums[i]
            j += 1
    
    # Second pass: move all 1s after the 0s
    for i in range(j, len(nums)):
        if nums[i] == 1:
            nums[i], nums[j] = nums[j], nums[i]
            j += 1
    
    return nums
```

**Time Complexity:** O(n) - We iterate through the array twice.
**Space Complexity:** O(1) - We use only a few variables.

### 3. Best Optimized Solution - Dutch National Flag Algorithm

Use three pointers to partition the array in a single pass.

```python
def sortColors(nums):
    # Initialize pointers
    low = 0  # pointer for 0s
    mid = 0  # current element
    high = len(nums) - 1  # pointer for 2s
    
    while mid <= high:
        if nums[mid] == 0:
            # Swap with the low pointer and increment both
            nums[low], nums[mid] = nums[mid], nums[low]
            low += 1
            mid += 1
        elif nums[mid] == 1:
            # Keep 1s in the middle
            mid += 1
        else:  # nums[mid] == 2
            # Swap with the high pointer and decrement high
            nums[mid], nums[high] = nums[high], nums[mid]
            high -= 1
    
    return nums
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We use only a few variables.

## Solution Choice and Explanation

The Dutch National Flag algorithm (Solution 3) is the best solution for this problem because:

1. **One-Pass Algorithm**: It sorts the array in a single pass, meeting the follow-up challenge.

2. **Constant Extra Space**: It uses only a few pointer variables, regardless of the input size.

3. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

4. **In-Place Sorting**: It sorts the array in-place without requiring additional storage.

The algorithm works by maintaining three pointers:
- `low`: Elements before this index are all 0s.
- `mid`: Elements between `low` and `mid` are all 1s.
- `high`: Elements after this index are all 2s.

The key insight is that we process the array from left to right using the `mid` pointer:
- If we encounter a 0, we swap it with the element at the `low` pointer and increment both `low` and `mid`.
- If we encounter a 1, we leave it in place and increment `mid`.
- If we encounter a 2, we swap it with the element at the `high` pointer and decrement `high` (but don't increment `mid` since we need to check the swapped element).

This approach efficiently partitions the array into three sections in a single pass, which is more efficient than the two-pass approach and more elegant than counting sort.

In an interview, I would first mention the counting sort approach to establish a baseline, then explain the Dutch National Flag algorithm as the optimal solution that meets all the requirements.
