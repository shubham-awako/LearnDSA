# House Robber II

## Problem Statement

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an array `nums` representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

**Example 1:**
```
Input: nums = [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
```

**Example 2:**
```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
```

**Example 3:**
```
Input: nums = [1,2,3]
Output: 3
```

**Constraints:**
- `1 <= nums.length <= 100`
- `0 <= nums[i] <= 1000`

## Concept Overview

This problem is an extension of the House Robber problem, with the added constraint that the houses are arranged in a circle. The key insight is to break the circle by considering two separate cases: either rob houses from 0 to n-2 (excluding the last house) or rob houses from 1 to n-1 (excluding the first house). Then, we can apply the same dynamic programming approach as in the original House Robber problem.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def rob(nums):
    n = len(nums)
    
    # Handle edge cases
    if n == 0:
        return 0
    if n == 1:
        return nums[0]
    if n == 2:
        return max(nums[0], nums[1])
    
    # Case 1: Rob houses from 0 to n-2 (excluding the last house)
    def rob_simple(nums):
        rob_prev = nums[0]
        skip_prev = 0
        
        for i in range(1, len(nums)):
            rob_current = skip_prev + nums[i]
            skip_current = max(rob_prev, skip_prev)
            
            rob_prev = rob_current
            skip_prev = skip_current
        
        return max(rob_prev, skip_prev)
    
    # Return the maximum of the two cases
    return max(rob_simple(nums[:-1]), rob_simple(nums[1:]))
```

**Time Complexity:** O(n) - We iterate through the houses twice, each time from 1 to n-2.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def rob(nums):
    n = len(nums)
    
    # Handle edge cases
    if n == 0:
        return 0
    if n == 1:
        return nums[0]
    if n == 2:
        return max(nums[0], nums[1])
    
    # Case 1: Rob houses from 0 to n-2 (excluding the last house)
    def rob_simple(nums, start, end, memo={}):
        key = (start, end)
        if key in memo:
            return memo[key]
        
        if start > end:
            return 0
        if start == end:
            return nums[start]
        
        # Either rob the current house and skip the next one, or skip the current house
        memo[key] = max(rob_simple(nums, start + 2, end, memo) + nums[start], rob_simple(nums, start + 1, end, memo))
        return memo[key]
    
    # Return the maximum of the two cases
    return max(rob_simple(nums, 0, n - 2, {}), rob_simple(nums, 1, n - 1, {}))
```

**Time Complexity:** O(n) - We compute the result for each house from 0 to n-1 exactly once.
**Space Complexity:** O(n) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def rob(nums):
    n = len(nums)
    
    # Handle edge cases
    if n == 0:
        return 0
    if n == 1:
        return nums[0]
    if n == 2:
        return max(nums[0], nums[1])
    
    # Case 1: Rob houses from 0 to n-2 (excluding the last house)
    def rob_simple(nums):
        n = len(nums)
        dp = [0] * n
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        for i in range(2, n):
            dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
        
        return dp[n - 1]
    
    # Return the maximum of the two cases
    return max(rob_simple(nums[:-1]), rob_simple(nums[1:]))
```

**Time Complexity:** O(n) - We iterate through the houses twice, each time from 2 to n-2.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the other solutions.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of breaking the circle and applying the same approach as in the original House Robber problem.

The key insight of this approach is to break the circle by considering two separate cases: either rob houses from 0 to n-2 (excluding the last house) or rob houses from 1 to n-1 (excluding the first house). Then, we can apply the same dynamic programming approach as in the original House Robber problem.

For example, let's trace through the algorithm for nums = [2, 3, 2]:

1. Case 1: Rob houses from 0 to n-2 (excluding the last house)
   - nums = [2, 3]
   - Initialize:
     - rob_prev = nums[0] = 2
     - skip_prev = 0
   - House 1:
     - rob_current = skip_prev + nums[1] = 0 + 3 = 3
     - skip_current = max(rob_prev, skip_prev) = max(2, 0) = 2
     - rob_prev = rob_current = 3
     - skip_prev = skip_current = 2
   - Return max(rob_prev, skip_prev) = max(3, 2) = 3

2. Case 2: Rob houses from 1 to n-1 (excluding the first house)
   - nums = [3, 2]
   - Initialize:
     - rob_prev = nums[0] = 3
     - skip_prev = 0
   - House 1:
     - rob_current = skip_prev + nums[1] = 0 + 2 = 2
     - skip_current = max(rob_prev, skip_prev) = max(3, 0) = 3
     - rob_prev = rob_current = 2
     - skip_prev = skip_current = 3
   - Return max(rob_prev, skip_prev) = max(2, 3) = 3

3. Return max(3, 3) = 3

For nums = [1, 2, 3, 1]:

1. Case 1: Rob houses from 0 to n-2 (excluding the last house)
   - nums = [1, 2, 3]
   - Initialize:
     - rob_prev = nums[0] = 1
     - skip_prev = 0
   - House 1:
     - rob_current = skip_prev + nums[1] = 0 + 2 = 2
     - skip_current = max(rob_prev, skip_prev) = max(1, 0) = 1
     - rob_prev = rob_current = 2
     - skip_prev = skip_current = 1
   - House 2:
     - rob_current = skip_prev + nums[2] = 1 + 3 = 4
     - skip_current = max(rob_prev, skip_prev) = max(2, 1) = 2
     - rob_prev = rob_current = 4
     - skip_prev = skip_current = 2
   - Return max(rob_prev, skip_prev) = max(4, 2) = 4

2. Case 2: Rob houses from 1 to n-1 (excluding the first house)
   - nums = [2, 3, 1]
   - Initialize:
     - rob_prev = nums[0] = 2
     - skip_prev = 0
   - House 1:
     - rob_current = skip_prev + nums[1] = 0 + 3 = 3
     - skip_current = max(rob_prev, skip_prev) = max(2, 0) = 2
     - rob_prev = rob_current = 3
     - skip_prev = skip_current = 2
   - House 2:
     - rob_current = skip_prev + nums[2] = 2 + 1 = 3
     - skip_current = max(rob_prev, skip_prev) = max(3, 2) = 3
     - rob_prev = rob_current = 3
     - skip_prev = skip_current = 3
   - Return max(rob_prev, skip_prev) = max(3, 3) = 3

3. Return max(4, 3) = 4

The Dynamic Programming with Memoization solution (Solution 2) and the Dynamic Programming with Tabulation solution (Solution 3) are also efficient but use more space. They are useful for understanding the dynamic programming approach to this problem.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Memoization and Tabulation solutions as alternatives if asked for different approaches.
