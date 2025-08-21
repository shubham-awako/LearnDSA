# Climbing Stairs

## Problem Statement

You are climbing a staircase. It takes `n` steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

**Example 1:**
```
Input: n = 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps
```

**Example 2:**
```
Input: n = 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step
```

**Constraints:**
- `1 <= n <= 45`

## Concept Overview

This problem is a classic example of dynamic programming. The key insight is to recognize that the number of ways to reach the top of the staircase is the sum of the number of ways to reach the last step and the number of ways to reach the second-to-last step. This is because the last move can be either 1 step or 2 steps.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def climbStairs(n):
    if n <= 2:
        return n
    
    # Initialize variables for the first two steps
    one_step_before = 2  # Number of ways to reach step 2
    two_steps_before = 1  # Number of ways to reach step 1
    
    # Calculate the number of ways for each step from 3 to n
    for i in range(3, n + 1):
        current = one_step_before + two_steps_before
        two_steps_before = one_step_before
        one_step_before = current
    
    return one_step_before
```

**Time Complexity:** O(n) - We iterate through the steps from 3 to n.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def climbStairs(n):
    # Create a memoization dictionary to store results of subproblems
    memo = {}
    
    def dp(i):
        # Base cases
        if i == 1:
            return 1
        if i == 2:
            return 2
        
        # Check if the result is already computed
        if i in memo:
            return memo[i]
        
        # Compute the result and store it in the memoization dictionary
        memo[i] = dp(i - 1) + dp(i - 2)
        return memo[i]
    
    return dp(n)
```

**Time Complexity:** O(n) - We compute the result for each step from 1 to n exactly once.
**Space Complexity:** O(n) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def climbStairs(n):
    if n <= 2:
        return n
    
    # Create a table to store results of subproblems
    dp = [0] * (n + 1)
    dp[1] = 1
    dp[2] = 2
    
    # Fill the table in a bottom-up manner
    for i in range(3, n + 1):
        dp[i] = dp[i - 1] + dp[i - 2]
    
    return dp[n]
```

**Time Complexity:** O(n) - We iterate through the steps from 3 to n.
**Space Complexity:** O(n) - We use the dp array to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the other solutions.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the number of ways to climb the stairs.

The key insight of this approach is to recognize that the number of ways to reach the top of the staircase is the sum of the number of ways to reach the last step and the number of ways to reach the second-to-last step. This is because the last move can be either 1 step or 2 steps.

For example, let's trace through the algorithm for n = 5:

1. Initialize:
   - one_step_before = 2 (number of ways to reach step 2)
   - two_steps_before = 1 (number of ways to reach step 1)

2. Calculate the number of ways for each step from 3 to 5:
   - Step 3:
     - current = one_step_before + two_steps_before = 2 + 1 = 3
     - two_steps_before = one_step_before = 2
     - one_step_before = current = 3
   - Step 4:
     - current = one_step_before + two_steps_before = 3 + 2 = 5
     - two_steps_before = one_step_before = 3
     - one_step_before = current = 5
   - Step 5:
     - current = one_step_before + two_steps_before = 5 + 3 = 8
     - two_steps_before = one_step_before = 5
     - one_step_before = current = 8

3. Return one_step_before = 8

This approach is essentially computing the Fibonacci sequence, where F(n) = F(n-1) + F(n-2), with F(1) = 1 and F(2) = 2.

The Dynamic Programming with Memoization solution (Solution 2) and the Dynamic Programming with Tabulation solution (Solution 3) are also efficient but use more space. They are useful for understanding the dynamic programming approach to this problem.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Memoization and Tabulation solutions as alternatives if asked for different approaches.
