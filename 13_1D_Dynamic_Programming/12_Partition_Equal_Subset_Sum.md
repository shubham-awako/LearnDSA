# Partition Equal Subset Sum

## Problem Statement

Given a non-empty array `nums` containing only positive integers, find if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

**Example 1:**
```
Input: nums = [1,5,11,5]
Output: true
Explanation: The array can be partitioned as [1, 5, 5] and [11].
```

**Example 2:**
```
Input: nums = [1,2,3,5]
Output: false
Explanation: The array cannot be partitioned into equal sum subsets.
```

**Constraints:**
- `1 <= nums.length <= 200`
- `1 <= nums[i] <= 100`

## Concept Overview

This problem is a variation of the subset sum problem, which is a classic dynamic programming problem. The key insight is to recognize that if the array can be partitioned into two subsets with equal sum, then each subset must have a sum equal to half of the total sum of the array. So, we can reduce this problem to finding a subset of the array with a sum equal to half of the total sum.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def canPartition(nums):
    total_sum = sum(nums)
    
    # If the total sum is odd, we can't partition the array into two equal subsets
    if total_sum % 2 != 0:
        return False
    
    target = total_sum // 2
    n = len(nums)
    
    # dp[j] represents whether it's possible to form a subset with sum j
    dp = [False] * (target + 1)
    dp[0] = True  # Base case: it's always possible to form a subset with sum 0
    
    for i in range(n):
        for j in range(target, nums[i] - 1, -1):
            dp[j] = dp[j] or dp[j - nums[i]]
    
    return dp[target]
```

**Time Complexity:** O(n * target) - We iterate through the array once, and for each element, we update the dp array from target down to the current element.
**Space Complexity:** O(target) - We use the dp array to store whether it's possible to form a subset with a certain sum.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def canPartition(nums):
    total_sum = sum(nums)
    
    # If the total sum is odd, we can't partition the array into two equal subsets
    if total_sum % 2 != 0:
        return False
    
    target = total_sum // 2
    n = len(nums)
    
    # dp[i][j] represents whether it's possible to form a subset with sum j using the first i elements
    dp = [[False] * (target + 1) for _ in range(n + 1)]
    
    # Base case: it's always possible to form a subset with sum 0
    for i in range(n + 1):
        dp[i][0] = True
    
    for i in range(1, n + 1):
        for j in range(1, target + 1):
            if j < nums[i - 1]:
                dp[i][j] = dp[i - 1][j]
            else:
                dp[i][j] = dp[i - 1][j] or dp[i - 1][j - nums[i - 1]]
    
    return dp[n][target]
```

**Time Complexity:** O(n * target) - We have two nested loops, one iterating through the array and the other iterating through the possible sums from 1 to target.
**Space Complexity:** O(n * target) - We use the dp table to store whether it's possible to form a subset with a certain sum using the first i elements.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def canPartition(nums):
    total_sum = sum(nums)
    
    # If the total sum is odd, we can't partition the array into two equal subsets
    if total_sum % 2 != 0:
        return False
    
    target = total_sum // 2
    n = len(nums)
    memo = {}
    
    def dp(i, remaining):
        if remaining == 0:
            return True
        if i == n or remaining < 0:
            return False
        
        if (i, remaining) in memo:
            return memo[(i, remaining)]
        
        # Either include the current element or exclude it
        memo[(i, remaining)] = dp(i + 1, remaining - nums[i]) or dp(i + 1, remaining)
        return memo[(i, remaining)]
    
    return dp(0, target)
```

**Time Complexity:** O(n * target) - We have n * target possible states (i, remaining), and each state takes O(1) time to compute.
**Space Complexity:** O(n * target) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n * target) time complexity, which is optimal for this problem, and the space complexity is O(target), which is better than the O(n * target) space complexity of the tabulation solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding a subset with a certain sum.

The key insight of this approach is to use a 1D array to keep track of whether it's possible to form a subset with a certain sum. For each element in the array, we update the dp array from target down to the current element, checking if it's possible to form a subset with the current sum by either including or excluding the current element.

For example, let's trace through the algorithm for nums = [1, 5, 11, 5]:

1. Calculate total_sum = 1 + 5 + 11 + 5 = 22
2. Check if total_sum is odd: 22 is even, so continue
3. Calculate target = 22 // 2 = 11
4. Initialize dp = [True, False, False, False, False, False, False, False, False, False, False, False]

5. Iterate through the array:
   - i = 0 (nums[0] = 1):
     - j = 11: dp[11] = dp[11] or dp[11 - 1] = False or dp[10] = False
     - j = 10: dp[10] = dp[10] or dp[10 - 1] = False or dp[9] = False
     - ...
     - j = 1: dp[1] = dp[1] or dp[1 - 1] = False or dp[0] = False or True = True
     - dp = [True, True, False, False, False, False, False, False, False, False, False, False]
   - i = 1 (nums[1] = 5):
     - j = 11: dp[11] = dp[11] or dp[11 - 5] = False or dp[6] = False
     - j = 10: dp[10] = dp[10] or dp[10 - 5] = False or dp[5] = False
     - ...
     - j = 6: dp[6] = dp[6] or dp[6 - 5] = False or dp[1] = False or True = True
     - j = 5: dp[5] = dp[5] or dp[5 - 5] = False or dp[0] = False or True = True
     - dp = [True, True, False, False, False, True, True, False, False, False, False, False]
   - i = 2 (nums[2] = 11):
     - j = 11: dp[11] = dp[11] or dp[11 - 11] = False or dp[0] = False or True = True
     - j = 10: dp[10] = dp[10] or dp[10 - 11] = False or dp[-1] = False
     - ...
     - dp = [True, True, False, False, False, True, True, False, False, False, False, True]
   - i = 3 (nums[3] = 5):
     - j = 11: dp[11] = dp[11] or dp[11 - 5] = True or dp[6] = True or True = True
     - j = 10: dp[10] = dp[10] or dp[10 - 5] = False or dp[5] = False or True = True
     - ...
     - j = 5: dp[5] = dp[5] or dp[5 - 5] = True or dp[0] = True or True = True
     - dp = [True, True, False, False, False, True, True, False, False, False, True, True]

6. Return dp[target] = dp[11] = True

For nums = [1, 2, 3, 5]:

1. Calculate total_sum = 1 + 2 + 3 + 5 = 11
2. Check if total_sum is odd: 11 is odd, so return False

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Recursive with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
