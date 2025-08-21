# Concatenation of Array

## Problem Statement

Given an integer array `nums` of length `n`, you want to create an array `ans` of length `2n` where `ans[i] == nums[i]` and `ans[i + n] == nums[i]` for `0 <= i < n` (0-indexed).

Specifically, `ans` is the concatenation of two `nums` arrays.

Return the array `ans`.

**Example 1:**
```
Input: nums = [1,2,1]
Output: [1,2,1,1,2,1]
Explanation: The array ans is formed as follows:
- ans = [nums[0],nums[1],nums[2],nums[0],nums[1],nums[2]]
- ans = [1,2,1,1,2,1]
```

**Example 2:**
```
Input: nums = [1,3,2,1]
Output: [1,3,2,1,1,3,2,1]
Explanation: The array ans is formed as follows:
- ans = [nums[0],nums[1],nums[2],nums[3],nums[0],nums[1],nums[2],nums[3]]
- ans = [1,3,2,1,1,3,2,1]
```

**Constraints:**
- `n == nums.length`
- `1 <= n <= 1000`
- `1 <= nums[i] <= 1000`

## Concept Overview

This problem tests basic array manipulation and understanding of array concatenation. The task is to duplicate an array and append it to itself.

## Solutions

### 1. Brute Force Approach

The most straightforward approach is to create a new array of size `2n` and manually copy elements from the original array twice.

```python
def getConcatenation(nums):
    n = len(nums)
    ans = [0] * (2 * n)
    
    for i in range(n):
        ans[i] = nums[i]
        ans[i + n] = nums[i]
    
    return ans
```

**Time Complexity:** O(n) - We iterate through the original array once.
**Space Complexity:** O(n) - We create a new array of size 2n.

### 2. Improved Solution

Python provides a simpler way to concatenate arrays using the `+` operator or multiplication.

```python
def getConcatenation(nums):
    return nums + nums
```

**Time Complexity:** O(n) - Under the hood, Python still needs to create a new array and copy elements.
**Space Complexity:** O(n) - We create a new array of size 2n.

### 3. Best Optimized Solution

The most Pythonic and readable solution is to use the multiplication operator:

```python
def getConcatenation(nums):
    return nums * 2
```

**Time Complexity:** O(n) - Python needs to create a new array and copy elements.
**Space Complexity:** O(n) - We create a new array of size 2n.

## Solution Choice and Explanation

For this problem, the best solution is to use Python's built-in array multiplication (`nums * 2`). This approach is:

1. Most readable and concise
2. Leverages Python's optimized implementation for array duplication
3. Has the same time and space complexity as other approaches

While all three approaches have the same asymptotic complexity, the third solution is preferred for its simplicity and readability. In Python, using built-in operations like `+` or `*` for arrays is generally more efficient than manual element-by-element copying, as these operations are optimized at a lower level.

This problem is straightforward and doesn't require complex algorithmic techniques, making it a good introduction to array manipulation.
