# Rotate Array

## Problem Statement

Given an integer array `nums`, rotate the array to the right by `k` steps, where `k` is non-negative.

**Example 1:**
```
Input: nums = [1,2,3,4,5,6,7], k = 3
Output: [5,6,7,1,2,3,4]
Explanation:
rotate 1 steps to the right: [7,1,2,3,4,5,6]
rotate 2 steps to the right: [6,7,1,2,3,4,5]
rotate 3 steps to the right: [5,6,7,1,2,3,4]
```

**Example 2:**
```
Input: nums = [-1,-100,3,99], k = 2
Output: [3,99,-1,-100]
Explanation:
rotate 1 steps to the right: [99,-1,-100,3]
rotate 2 steps to the right: [3,99,-1,-100]
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-2^31 <= nums[i] <= 2^31 - 1`
- `0 <= k <= 10^5`

**Follow up:**
- Try to come up with as many solutions as you can. There are at least three different ways to solve this problem.
- Could you do it in-place with O(1) extra space?

## Concept Overview

This problem tests your ability to rotate an array by a given number of steps. The key insight is to use array reversal or cyclic replacements to achieve the rotation efficiently.

## Solutions

### 1. Brute Force Approach - Using Extra Array

Create a new array with the rotated elements, then copy it back to the original array.

```python
def rotate(nums, k):
    n = len(nums)
    k = k % n  # Handle case where k > n
    
    # Create a new array with the rotated elements
    rotated = [0] * n
    for i in range(n):
        rotated[(i + k) % n] = nums[i]
    
    # Copy the rotated array back to the original array
    for i in range(n):
        nums[i] = rotated[i]
```

**Time Complexity:** O(n) - We process each element once.
**Space Complexity:** O(n) - We create a new array of the same size.

### 2. Improved Solution - Cyclic Replacements

Perform cyclic replacements to rotate the array in-place.

```python
def rotate(nums, k):
    n = len(nums)
    k = k % n  # Handle case where k > n
    
    count = 0  # Count of elements rotated
    start = 0  # Starting index for the current cycle
    
    while count < n:
        current = start
        prev = nums[start]
        
        while True:
            next_idx = (current + k) % n
            temp = nums[next_idx]
            nums[next_idx] = prev
            prev = temp
            current = next_idx
            count += 1
            
            if current == start:
                break
        
        start += 1
```

**Time Complexity:** O(n) - We process each element once.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Best Optimized Solution - Reverse Array

Reverse the entire array, then reverse the first k elements and the remaining elements separately.

```python
def rotate(nums, k):
    n = len(nums)
    k = k % n  # Handle case where k > n
    
    # Reverse the entire array
    reverse(nums, 0, n - 1)
    
    # Reverse the first k elements
    reverse(nums, 0, k - 1)
    
    # Reverse the remaining elements
    reverse(nums, k, n - 1)

def reverse(nums, start, end):
    while start < end:
        nums[start], nums[end] = nums[end], nums[start]
        start += 1
        end -= 1
```

**Time Complexity:** O(n) - We process each element a constant number of times.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 4. Alternative Solution - Slicing (Python-specific)

Use Python's slicing to rotate the array.

```python
def rotate(nums, k):
    n = len(nums)
    k = k % n  # Handle case where k > n
    
    # Rotate the array using slicing
    nums[:] = nums[n-k:] + nums[:n-k]
```

**Time Complexity:** O(n) - Slicing creates a new list under the hood.
**Space Complexity:** O(n) - Slicing creates a new list under the hood.

## Solution Choice and Explanation

The reverse array solution (Solution 3) is the best approach for this problem because:

1. **In-Place Modification**: It directly modifies the array without using extra space.

2. **Optimal Space Complexity**: It uses O(1) extra space, as required by the follow-up question.

3. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

4. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use array reversal to achieve rotation. The process is as follows:
1. Reverse the entire array: [1,2,3,4,5,6,7] -> [7,6,5,4,3,2,1]
2. Reverse the first k elements: [7,6,5,4,3,2,1] -> [5,6,7,4,3,2,1]
3. Reverse the remaining elements: [5,6,7,4,3,2,1] -> [5,6,7,1,2,3,4]

The cyclic replacements solution (Solution 2) is also in-place and has O(1) space complexity, but it's more complex to implement and understand. The brute force approach (Solution 1) and the slicing approach (Solution 4) both use O(n) extra space, which doesn't meet the follow-up challenge.

In an interview, I would first mention the reverse array approach as the optimal solution that achieves O(n) time complexity with O(1) extra space. I would also mention the other approaches to demonstrate my understanding of different techniques.
