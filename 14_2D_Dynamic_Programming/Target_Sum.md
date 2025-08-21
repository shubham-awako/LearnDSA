# Target Sum

## Problem Statement

You are given an integer array `nums` and an integer `target`.

You want to build an expression out of nums by adding one of the symbols '+' and '-' before each integer in nums and then concatenate all the integers.

For example, if `nums = [2, 1]`, you can add a '+' before 2 and a '-' before 1 and concatenate them to build the expression "+2-1".
Return the number of different expressions that you can build, which evaluates to `target`.

**Example 1:**
```
Input: nums = [1,1,1,1,1], target = 3
Output: 5
Explanation: There are 5 ways to assign symbols to make the sum of nums be target 3.
-1 + 1 + 1 + 1 + 1 = 3
+1 - 1 + 1 + 1 + 1 = 3
+1 + 1 - 1 + 1 + 1 = 3
+1 + 1 + 1 - 1 + 1 = 3
+1 + 1 + 1 + 1 - 1 = 3
```

**Example 2:**
```
Input: nums = [1], target = 1
Output: 1
```

**Constraints:**
- `1 <= nums.length <= 20`
- `0 <= nums[i] <= 1000`
- `0 <= sum(nums[i]) <= 1000`
- `-1000 <= target <= 1000`

## Concept Overview

This problem can be transformed into a subset sum problem. The key insight is to recognize that we're essentially partitioning the array into two subsets: one with positive signs and one with negative signs. Let's denote the sum of the positive subset as P and the sum of the negative subset as N. We have:

P + N = sum(nums)
P - N = target

Solving these equations, we get:
P = (sum(nums) + target) / 2

So the problem reduces to finding the number of subsets with a sum equal to (sum(nums) + target) / 2.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def findTargetSumWays(nums, target):
    total_sum = sum(nums)
    
    # If the target is out of range or the sum is odd, return 0
    if abs(target) > total_sum or (total_sum + target) % 2 != 0:
        return 0
    
    # Calculate the target sum for the subset sum problem
    subset_sum = (total_sum + target) // 2
    
    # Initialize the dp array
    dp = [0] * (subset_sum + 1)
    dp[0] = 1  # Base case: there is 1 way to make up sum 0 (by selecting no elements)
    
    # Fill the dp array
    for num in nums:
        for i in range(subset_sum, num - 1, -1):
            dp[i] += dp[i - num]
    
    return dp[subset_sum]
```

**Time Complexity:** O(n * sum) - We iterate through each number and each possible sum from the number to the subset sum.
**Space Complexity:** O(sum) - We use a 1D array to store the number of ways to make up each sum.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def findTargetSumWays(nums, target):
    total_sum = sum(nums)
    
    # If the target is out of range or the sum is odd, return 0
    if abs(target) > total_sum or (total_sum + target) % 2 != 0:
        return 0
    
    # Calculate the target sum for the subset sum problem
    subset_sum = (total_sum + target) // 2
    
    n = len(nums)
    
    # Initialize the dp array
    # dp[i][j] represents the number of ways to make up sum j using the first i elements
    dp = [[0] * (subset_sum + 1) for _ in range(n + 1)]
    
    # Base case: there is 1 way to make up sum 0 (by selecting no elements)
    for i in range(n + 1):
        dp[i][0] = 1
    
    # Fill the dp array
    for i in range(1, n + 1):
        for j in range(subset_sum + 1):
            # If the current number is greater than the current sum,
            # we can't use this number, so the number of ways is the same as without this number
            if nums[i - 1] > j:
                dp[i][j] = dp[i - 1][j]
            else:
                # Otherwise, we can either use this number or not
                dp[i][j] = dp[i - 1][j] + dp[i - 1][j - nums[i - 1]]
    
    return dp[n][subset_sum]
```

**Time Complexity:** O(n * sum) - We have two nested loops, one iterating through the numbers and the other iterating through the possible sums.
**Space Complexity:** O(n * sum) - We use a 2D array to store the number of ways to make up each sum using each subset of numbers.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def findTargetSumWays(nums, target):
    memo = {}
    
    def dp(i, current_sum):
        if i == len(nums):
            return 1 if current_sum == target else 0
        
        if (i, current_sum) in memo:
            return memo[(i, current_sum)]
        
        # Either add the current number or subtract it
        memo[(i, current_sum)] = dp(i + 1, current_sum + nums[i]) + dp(i + 1, current_sum - nums[i])
        return memo[(i, current_sum)]
    
    return dp(0, 0)
```

**Time Complexity:** O(n * sum) - We have n * sum possible states (i, current_sum), and each state takes O(1) time to compute.
**Space Complexity:** O(n * sum) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n * sum) time complexity, which is optimal for this problem, and the space complexity is O(sum), which is better than the O(n * sum) space complexity of the tabulation solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the number of subsets with a certain sum.

The key insight of this approach is to transform the problem into a subset sum problem. We recognize that we're essentially partitioning the array into two subsets: one with positive signs and one with negative signs. Let's denote the sum of the positive subset as P and the sum of the negative subset as N. We have:

P + N = sum(nums)
P - N = target

Solving these equations, we get:
P = (sum(nums) + target) / 2

So the problem reduces to finding the number of subsets with a sum equal to (sum(nums) + target) / 2.

For example, let's trace through the algorithm for nums = [1, 1, 1, 1, 1] and target = 3:

1. Calculate total_sum = 1 + 1 + 1 + 1 + 1 = 5
2. Check if the target is out of range or the sum is odd:
   - abs(target) = 3 <= total_sum = 5, so continue
   - (total_sum + target) % 2 = (5 + 3) % 2 = 8 % 2 = 0, so continue
3. Calculate subset_sum = (total_sum + target) // 2 = (5 + 3) // 2 = 8 // 2 = 4
4. Initialize dp = [1, 0, 0, 0, 0]

5. Fill the dp array:
   - num = 1:
     - For i = 4: dp[4] += dp[4 - 1] = dp[4] + dp[3] = 0 + 0 = 0
     - For i = 3: dp[3] += dp[3 - 1] = dp[3] + dp[2] = 0 + 0 = 0
     - For i = 2: dp[2] += dp[2 - 1] = dp[2] + dp[1] = 0 + 0 = 0
     - For i = 1: dp[1] += dp[1 - 1] = dp[1] + dp[0] = 0 + 1 = 1
     - dp = [1, 1, 0, 0, 0]
   - num = 1:
     - For i = 4: dp[4] += dp[4 - 1] = dp[4] + dp[3] = 0 + 0 = 0
     - For i = 3: dp[3] += dp[3 - 1] = dp[3] + dp[2] = 0 + 0 = 0
     - For i = 2: dp[2] += dp[2 - 1] = dp[2] + dp[1] = 0 + 1 = 1
     - For i = 1: dp[1] += dp[1 - 1] = dp[1] + dp[0] = 1 + 1 = 2
     - dp = [1, 2, 1, 0, 0]
   - num = 1:
     - For i = 4: dp[4] += dp[4 - 1] = dp[4] + dp[3] = 0 + 0 = 0
     - For i = 3: dp[3] += dp[3 - 1] = dp[3] + dp[2] = 0 + 1 = 1
     - For i = 2: dp[2] += dp[2 - 1] = dp[2] + dp[1] = 1 + 2 = 3
     - For i = 1: dp[1] += dp[1 - 1] = dp[1] + dp[0] = 2 + 1 = 3
     - dp = [1, 3, 3, 1, 0]
   - num = 1:
     - For i = 4: dp[4] += dp[4 - 1] = dp[4] + dp[3] = 0 + 1 = 1
     - For i = 3: dp[3] += dp[3 - 1] = dp[3] + dp[2] = 1 + 3 = 4
     - For i = 2: dp[2] += dp[2 - 1] = dp[2] + dp[1] = 3 + 3 = 6
     - For i = 1: dp[1] += dp[1 - 1] = dp[1] + dp[0] = 3 + 1 = 4
     - dp = [1, 4, 6, 4, 1]
   - num = 1:
     - For i = 4: dp[4] += dp[4 - 1] = dp[4] + dp[3] = 1 + 4 = 5
     - For i = 3: dp[3] += dp[3 - 1] = dp[3] + dp[2] = 4 + 6 = 10
     - For i = 2: dp[2] += dp[2 - 1] = dp[2] + dp[1] = 6 + 4 = 10
     - For i = 1: dp[1] += dp[1 - 1] = dp[1] + dp[0] = 4 + 1 = 5
     - dp = [1, 5, 10, 10, 5]

6. Return dp[subset_sum] = dp[4] = 5

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Recursive with Memoization solution (Solution 3) is more intuitive for the original problem but less efficient in terms of space.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
