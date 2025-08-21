# Maximum Subarray

## Problem Statement

Given an integer array `nums`, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

A subarray is a contiguous part of an array.

**Example 1:**
```
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.
```

**Example 2:**
```
Input: nums = [1]
Output: 1
```

**Example 3:**
```
Input: nums = [5,4,-1,7,8]
Output: 23
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-10^4 <= nums[i] <= 10^4`

## Concept Overview

This problem is a classic example of a greedy algorithm, specifically Kadane's algorithm. The key insight is to keep track of the maximum subarray sum ending at each position and update the global maximum as we go.

## Solutions

### 1. Best Optimized Solution - Kadane's Algorithm

Use Kadane's algorithm to find the maximum subarray sum.

```python
def maxSubArray(nums):
    if not nums:
        return 0
    
    max_sum = nums[0]
    current_sum = nums[0]
    
    for i in range(1, len(nums)):
        # Either start a new subarray or continue the previous one
        current_sum = max(nums[i], current_sum + nums[i])
        
        # Update the global maximum
        max_sum = max(max_sum, current_sum)
    
    return max_sum
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Divide and Conquer

Use a divide-and-conquer approach to find the maximum subarray sum.

```python
def maxSubArray(nums):
    def maxSubArrayHelper(nums, left, right):
        if left == right:
            return nums[left]
        
        mid = (left + right) // 2
        
        # Find the maximum subarray sum in the left half
        left_sum = maxSubArrayHelper(nums, left, mid)
        
        # Find the maximum subarray sum in the right half
        right_sum = maxSubArrayHelper(nums, mid + 1, right)
        
        # Find the maximum subarray sum that crosses the middle
        cross_sum = maxCrossingSum(nums, left, mid, right)
        
        # Return the maximum of the three
        return max(left_sum, right_sum, cross_sum)
    
    def maxCrossingSum(nums, left, mid, right):
        # Find the maximum sum starting from the middle and going left
        left_sum = float('-inf')
        current_sum = 0
        for i in range(mid, left - 1, -1):
            current_sum += nums[i]
            left_sum = max(left_sum, current_sum)
        
        # Find the maximum sum starting from the middle + 1 and going right
        right_sum = float('-inf')
        current_sum = 0
        for i in range(mid + 1, right + 1):
            current_sum += nums[i]
            right_sum = max(right_sum, current_sum)
        
        # Return the sum of the two
        return left_sum + right_sum
    
    return maxSubArrayHelper(nums, 0, len(nums) - 1)
```

**Time Complexity:** O(n log n) - We divide the array into halves and solve each half recursively.
**Space Complexity:** O(log n) - The recursion stack can go up to log n levels deep.

### 3. Alternative Solution - Dynamic Programming

Use dynamic programming to find the maximum subarray sum.

```python
def maxSubArray(nums):
    if not nums:
        return 0
    
    n = len(nums)
    # dp[i] represents the maximum subarray sum ending at index i
    dp = [0] * n
    dp[0] = nums[0]
    
    for i in range(1, n):
        # Either start a new subarray or continue the previous one
        dp[i] = max(nums[i], dp[i - 1] + nums[i])
    
    return max(dp)
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We use an array of size n to store the maximum subarray sum ending at each position.

## Solution Choice and Explanation

The Kadane's Algorithm solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the dynamic programming solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the maximum subarray sum.

The key insight of this approach is to keep track of the maximum subarray sum ending at each position and update the global maximum as we go. At each position, we have two choices: either start a new subarray or continue the previous one. We choose the option that gives us the maximum sum.

For example, let's trace through the algorithm for nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]:

1. Initialize max_sum = nums[0] = -2, current_sum = nums[0] = -2
2. For i = 1 (nums[1] = 1):
   - current_sum = max(1, -2 + 1) = max(1, -1) = 1
   - max_sum = max(-2, 1) = 1
3. For i = 2 (nums[2] = -3):
   - current_sum = max(-3, 1 + -3) = max(-3, -2) = -2
   - max_sum = max(1, -2) = 1
4. For i = 3 (nums[3] = 4):
   - current_sum = max(4, -2 + 4) = max(4, 2) = 4
   - max_sum = max(1, 4) = 4
5. For i = 4 (nums[4] = -1):
   - current_sum = max(-1, 4 + -1) = max(-1, 3) = 3
   - max_sum = max(4, 3) = 4
6. For i = 5 (nums[5] = 2):
   - current_sum = max(2, 3 + 2) = max(2, 5) = 5
   - max_sum = max(4, 5) = 5
7. For i = 6 (nums[6] = 1):
   - current_sum = max(1, 5 + 1) = max(1, 6) = 6
   - max_sum = max(5, 6) = 6
8. For i = 7 (nums[7] = -5):
   - current_sum = max(-5, 6 + -5) = max(-5, 1) = 1
   - max_sum = max(6, 1) = 6
9. For i = 8 (nums[8] = 4):
   - current_sum = max(4, 1 + 4) = max(4, 5) = 5
   - max_sum = max(6, 5) = 6
10. Return max_sum = 6

The Divide and Conquer solution (Solution 2) is less efficient but may be useful for parallel processing. The Dynamic Programming solution (Solution 3) is also efficient but uses more space.

In an interview, I would first mention the Kadane's Algorithm solution as the most efficient approach for this problem, and then discuss the Divide and Conquer and Dynamic Programming solutions as alternatives if asked for different approaches.
