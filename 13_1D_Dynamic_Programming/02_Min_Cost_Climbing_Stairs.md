# Min Cost Climbing Stairs

## Problem Statement

You are given an integer array `cost` where `cost[i]` is the cost of `i`th step on a staircase. Once you pay the cost, you can either climb one or two steps.

You can either start from the step with index 0, or the step with index 1.

Return the minimum cost to reach the top of the floor.

**Example 1:**
```
Input: cost = [10,15,20]
Output: 15
Explanation: You will start at index 1.
- Pay 15 and climb two steps to reach the top.
The total cost is 15.
```

**Example 2:**
```
Input: cost = [1,100,1,1,1,100,1,1,100,1]
Output: 6
Explanation: You will start at index 0.
- Pay 1 and climb two steps to reach index 2.
- Pay 1 and climb two steps to reach index 4.
- Pay 1 and climb two steps to reach index 6.
- Pay 1 and climb one step to reach index 7.
- Pay 1 and climb two steps to reach index 9.
- Pay 1 and climb one step to reach the top.
The total cost is 6.
```

**Constraints:**
- `2 <= cost.length <= 1000`
- `0 <= cost[i] <= 999`

## Concept Overview

This problem is a variation of the classic climbing stairs problem, with the added complexity of costs associated with each step. The key insight is to use dynamic programming to find the minimum cost to reach each step, and then return the minimum cost to reach the top.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def minCostClimbingStairs(cost):
    n = len(cost)
    
    # Initialize variables for the first two steps
    first = cost[0]
    second = cost[1]
    
    # Calculate the minimum cost for each step from 2 to n-1
    for i in range(2, n):
        current = cost[i] + min(first, second)
        first = second
        second = current
    
    # Return the minimum cost to reach the top
    return min(first, second)
```

**Time Complexity:** O(n) - We iterate through the steps from 2 to n-1.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def minCostClimbingStairs(cost):
    n = len(cost)
    memo = {}
    
    def dp(i):
        # Base cases
        if i < 0:
            return 0
        if i == 0 or i == 1:
            return cost[i]
        
        # Check if the result is already computed
        if i in memo:
            return memo[i]
        
        # Compute the result and store it in the memoization dictionary
        memo[i] = cost[i] + min(dp(i - 1), dp(i - 2))
        return memo[i]
    
    # Return the minimum cost to reach the top
    return min(dp(n - 1), dp(n - 2))
```

**Time Complexity:** O(n) - We compute the result for each step from 0 to n-1 exactly once.
**Space Complexity:** O(n) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def minCostClimbingStairs(cost):
    n = len(cost)
    
    # Create a table to store results of subproblems
    dp = [0] * n
    dp[0] = cost[0]
    dp[1] = cost[1]
    
    # Fill the table in a bottom-up manner
    for i in range(2, n):
        dp[i] = cost[i] + min(dp[i - 1], dp[i - 2])
    
    # Return the minimum cost to reach the top
    return min(dp[n - 1], dp[n - 2])
```

**Time Complexity:** O(n) - We iterate through the steps from 2 to n-1.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the other solutions.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the minimum cost to climb the stairs.

The key insight of this approach is to recognize that the minimum cost to reach the `i`th step is the cost of the `i`th step plus the minimum of the costs to reach the `(i-1)`th and `(i-2)`th steps. This is because we can climb either one or two steps at a time.

For example, let's trace through the algorithm for cost = [10, 15, 20]:

1. Initialize:
   - first = cost[0] = 10
   - second = cost[1] = 15

2. Calculate the minimum cost for each step from 2 to n-1:
   - Step 2:
     - current = cost[2] + min(first, second) = 20 + min(10, 15) = 20 + 10 = 30
     - first = second = 15
     - second = current = 30

3. Return min(first, second) = min(15, 30) = 15

For cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]:

1. Initialize:
   - first = cost[0] = 1
   - second = cost[1] = 100

2. Calculate the minimum cost for each step from 2 to n-1:
   - Step 2:
     - current = cost[2] + min(first, second) = 1 + min(1, 100) = 1 + 1 = 2
     - first = second = 100
     - second = current = 2
   - Step 3:
     - current = cost[3] + min(first, second) = 1 + min(100, 2) = 1 + 2 = 3
     - first = second = 2
     - second = current = 3
   - Step 4:
     - current = cost[4] + min(first, second) = 1 + min(2, 3) = 1 + 2 = 3
     - first = second = 3
     - second = current = 3
   - Step 5:
     - current = cost[5] + min(first, second) = 100 + min(3, 3) = 100 + 3 = 103
     - first = second = 3
     - second = current = 103
   - Step 6:
     - current = cost[6] + min(first, second) = 1 + min(3, 103) = 1 + 3 = 4
     - first = second = 103
     - second = current = 4
   - Step 7:
     - current = cost[7] + min(first, second) = 1 + min(103, 4) = 1 + 4 = 5
     - first = second = 4
     - second = current = 5
   - Step 8:
     - current = cost[8] + min(first, second) = 100 + min(4, 5) = 100 + 4 = 104
     - first = second = 5
     - second = current = 104
   - Step 9:
     - current = cost[9] + min(first, second) = 1 + min(5, 104) = 1 + 5 = 6
     - first = second = 104
     - second = current = 6

3. Return min(first, second) = min(104, 6) = 6

The Dynamic Programming with Memoization solution (Solution 2) and the Dynamic Programming with Tabulation solution (Solution 3) are also efficient but use more space. They are useful for understanding the dynamic programming approach to this problem.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Memoization and Tabulation solutions as alternatives if asked for different approaches.
