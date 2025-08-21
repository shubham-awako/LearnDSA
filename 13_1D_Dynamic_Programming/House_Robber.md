# House Robber

## Problem Statement

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array `nums` representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

**Example 1:**
```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
```

**Example 2:**
```
Input: nums = [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
Total amount you can rob = 2 + 9 + 1 = 12.
```

**Constraints:**
- `1 <= nums.length <= 100`
- `0 <= nums[i] <= 400`

## Concept Overview

This problem is a classic example of dynamic programming. The key insight is to recognize that at each house, we have two options: either rob the current house and skip the next one, or skip the current house and move to the next one. We need to find the maximum amount of money we can rob by making these decisions optimally.

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
    
    # Initialize variables for the first two houses
    rob_prev = nums[0]
    skip_prev = 0
    
    # Calculate the maximum amount for each house from 1 to n-1
    for i in range(1, n):
        # Maximum amount if we rob the current house
        rob_current = skip_prev + nums[i]
        
        # Maximum amount if we skip the current house
        skip_current = max(rob_prev, skip_prev)
        
        # Update variables for the next iteration
        rob_prev = rob_current
        skip_prev = skip_current
    
    # Return the maximum amount
    return max(rob_prev, skip_prev)
```

**Time Complexity:** O(n) - We iterate through the houses from 1 to n-1.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def rob(nums):
    n = len(nums)
    memo = {}
    
    def dp(i):
        # Base cases
        if i < 0:
            return 0
        
        # Check if the result is already computed
        if i in memo:
            return memo[i]
        
        # Compute the result and store it in the memoization dictionary
        memo[i] = max(dp(i - 2) + nums[i], dp(i - 1))
        return memo[i]
    
    return dp(n - 1)
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
    
    # Create a table to store results of subproblems
    dp = [0] * n
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])
    
    # Fill the table in a bottom-up manner
    for i in range(2, n):
        dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
    
    return dp[n - 1]
```

**Time Complexity:** O(n) - We iterate through the houses from 2 to n-1.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the other solutions.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of making decisions at each house.

The key insight of this approach is to recognize that at each house, we have two options: either rob the current house and skip the next one, or skip the current house and move to the next one. We need to find the maximum amount of money we can rob by making these decisions optimally.

For example, let's trace through the algorithm for nums = [1, 2, 3, 1]:

1. Initialize:
   - rob_prev = nums[0] = 1
   - skip_prev = 0

2. Calculate the maximum amount for each house from 1 to n-1:
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
   - House 3:
     - rob_current = skip_prev + nums[3] = 2 + 1 = 3
     - skip_current = max(rob_prev, skip_prev) = max(4, 2) = 4
     - rob_prev = rob_current = 3
     - skip_prev = skip_current = 4

3. Return max(rob_prev, skip_prev) = max(3, 4) = 4

For nums = [2, 7, 9, 3, 1]:

1. Initialize:
   - rob_prev = nums[0] = 2
   - skip_prev = 0

2. Calculate the maximum amount for each house from 1 to n-1:
   - House 1:
     - rob_current = skip_prev + nums[1] = 0 + 7 = 7
     - skip_current = max(rob_prev, skip_prev) = max(2, 0) = 2
     - rob_prev = rob_current = 7
     - skip_prev = skip_current = 2
   - House 2:
     - rob_current = skip_prev + nums[2] = 2 + 9 = 11
     - skip_current = max(rob_prev, skip_prev) = max(7, 2) = 7
     - rob_prev = rob_current = 11
     - skip_prev = skip_current = 7
   - House 3:
     - rob_current = skip_prev + nums[3] = 7 + 3 = 10
     - skip_current = max(rob_prev, skip_prev) = max(11, 7) = 11
     - rob_prev = rob_current = 10
     - skip_prev = skip_current = 11
   - House 4:
     - rob_current = skip_prev + nums[4] = 11 + 1 = 12
     - skip_current = max(rob_prev, skip_prev) = max(10, 11) = 11
     - rob_prev = rob_current = 12
     - skip_prev = skip_current = 11

3. Return max(rob_prev, skip_prev) = max(12, 11) = 12

The Dynamic Programming with Memoization solution (Solution 2) and the Dynamic Programming with Tabulation solution (Solution 3) are also efficient but use more space. They are useful for understanding the dynamic programming approach to this problem.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Memoization and Tabulation solutions as alternatives if asked for different approaches.
