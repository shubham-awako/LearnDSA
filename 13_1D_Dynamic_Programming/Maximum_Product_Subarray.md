# Maximum Product Subarray

## Problem Statement

Given an integer array `nums`, find a contiguous non-empty subarray within the array that has the largest product, and return the product.

The test cases are generated so that the answer will fit in a 32-bit integer.

A subarray is a contiguous subsequence of the array.

**Example 1:**
```
Input: nums = [2,3,-2,4]
Output: 6
Explanation: [2,3] has the largest product 6.
```

**Example 2:**
```
Input: nums = [-2,0,-1]
Output: 0
Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
```

**Constraints:**
- `1 <= nums.length <= 2 * 10^4`
- `-10 <= nums[i] <= 10`
- The product of any prefix or suffix of `nums` is guaranteed to fit in a 32-bit integer.

## Concept Overview

This problem is a variation of the maximum subarray problem, but with a twist: we need to find the maximum product instead of the maximum sum. The key insight is to keep track of both the maximum and minimum product ending at each position, because a negative number can turn a minimum product into a maximum product.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def maxProduct(nums):
    if not nums:
        return 0
    
    n = len(nums)
    max_so_far = nums[0]
    min_so_far = nums[0]
    result = max_so_far
    
    for i in range(1, n):
        # Keep track of both max and min because a negative number can turn a min into a max
        curr = nums[i]
        temp_max = max(curr, max_so_far * curr, min_so_far * curr)
        min_so_far = min(curr, max_so_far * curr, min_so_far * curr)
        max_so_far = temp_max
        
        # Update the result
        result = max(result, max_so_far)
    
    return result
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def maxProduct(nums):
    if not nums:
        return 0
    
    n = len(nums)
    # dp[i][0] represents the maximum product ending at position i
    # dp[i][1] represents the minimum product ending at position i
    dp = [[0, 0] for _ in range(n)]
    dp[0][0] = nums[0]
    dp[0][1] = nums[0]
    result = nums[0]
    
    for i in range(1, n):
        # Keep track of both max and min because a negative number can turn a min into a max
        dp[i][0] = max(nums[i], dp[i-1][0] * nums[i], dp[i-1][1] * nums[i])
        dp[i][1] = min(nums[i], dp[i-1][0] * nums[i], dp[i-1][1] * nums[i])
        
        # Update the result
        result = max(result, dp[i][0])
    
    return result
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

### 3. Alternative Solution - Brute Force

Use brute force to solve the problem.

```python
def maxProduct(nums):
    if not nums:
        return 0
    
    n = len(nums)
    result = float('-inf')
    
    for i in range(n):
        product = 1
        for j in range(i, n):
            product *= nums[j]
            result = max(result, product)
    
    return result
```

**Time Complexity:** O(n^2) - We consider all possible subarrays.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the tabulation solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the maximum product subarray.

The key insight of this approach is to keep track of both the maximum and minimum product ending at each position, because a negative number can turn a minimum product into a maximum product. For example, if we have a very negative minimum product and we encounter another negative number, multiplying them will give us a large positive product.

For example, let's trace through the algorithm for nums = [2, 3, -2, 4]:

1. Initialize:
   - max_so_far = nums[0] = 2
   - min_so_far = nums[0] = 2
   - result = max_so_far = 2

2. Iterate through the array:
   - i = 1 (nums[1] = 3):
     - curr = 3
     - temp_max = max(3, 2 * 3, 2 * 3) = max(3, 6, 6) = 6
     - min_so_far = min(3, 2 * 3, 2 * 3) = min(3, 6, 6) = 3
     - max_so_far = temp_max = 6
     - result = max(2, 6) = 6
   - i = 2 (nums[2] = -2):
     - curr = -2
     - temp_max = max(-2, 6 * -2, 3 * -2) = max(-2, -12, -6) = -2
     - min_so_far = min(-2, 6 * -2, 3 * -2) = min(-2, -12, -6) = -12
     - max_so_far = temp_max = -2
     - result = max(6, -2) = 6
   - i = 3 (nums[3] = 4):
     - curr = 4
     - temp_max = max(4, -2 * 4, -12 * 4) = max(4, -8, -48) = 4
     - min_so_far = min(4, -2 * 4, -12 * 4) = min(4, -8, -48) = -48
     - max_so_far = temp_max = 4
     - result = max(6, 4) = 6

3. Return result = 6

For nums = [-2, 0, -1]:

1. Initialize:
   - max_so_far = nums[0] = -2
   - min_so_far = nums[0] = -2
   - result = max_so_far = -2

2. Iterate through the array:
   - i = 1 (nums[1] = 0):
     - curr = 0
     - temp_max = max(0, -2 * 0, -2 * 0) = max(0, 0, 0) = 0
     - min_so_far = min(0, -2 * 0, -2 * 0) = min(0, 0, 0) = 0
     - max_so_far = temp_max = 0
     - result = max(-2, 0) = 0
   - i = 2 (nums[2] = -1):
     - curr = -1
     - temp_max = max(-1, 0 * -1, 0 * -1) = max(-1, 0, 0) = 0
     - min_so_far = min(-1, 0 * -1, 0 * -1) = min(-1, 0, 0) = -1
     - max_so_far = temp_max = 0
     - result = max(0, 0) = 0

3. Return result = 0

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Brute Force solution (Solution 3) is the simplest but least efficient.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Brute Force solutions as alternatives if asked for different approaches.
