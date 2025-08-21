# Coin Change II

## Problem Statement

You are given an integer array `coins` representing coins of different denominations and an integer `amount` representing a total amount of money.

Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return `0`.

You may assume that you have an infinite number of each kind of coin.

The answer is guaranteed to fit into a signed 32-bit integer.

**Example 1:**
```
Input: amount = 5, coins = [1,2,5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1
```

**Example 2:**
```
Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.
```

**Example 3:**
```
Input: amount = 10, coins = [10]
Output: 1
```

**Constraints:**
- `1 <= coins.length <= 300`
- `1 <= coins[i] <= 5000`
- All the values of `coins` are unique.
- `0 <= amount <= 5000`

## Concept Overview

This problem is a variation of the classic "Coin Change" problem, but instead of finding the minimum number of coins needed to make up an amount, we need to find the number of different combinations. The key insight is to use dynamic programming to build up the solution, considering each coin one by one and updating the number of ways to make up each amount.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Space Optimization

Use dynamic programming with space optimization to solve the problem.

```python
def change(amount, coins):
    # Initialize the dp array
    dp = [0] * (amount + 1)
    dp[0] = 1  # Base case: there is 1 way to make up amount 0 (by using no coins)
    
    # Consider each coin one by one
    for coin in coins:
        # Update the dp array for each amount from coin to amount
        for i in range(coin, amount + 1):
            dp[i] += dp[i - coin]
    
    return dp[amount]
```

**Time Complexity:** O(amount * n) - We iterate through each coin and each amount from the coin value to the target amount.
**Space Complexity:** O(amount) - We use a 1D array to store the number of ways to make up each amount.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def change(amount, coins):
    n = len(coins)
    
    # Initialize the dp array
    # dp[i][j] represents the number of ways to make up amount j using the first i coins
    dp = [[0] * (amount + 1) for _ in range(n + 1)]
    
    # Base case: there is 1 way to make up amount 0 (by using no coins)
    for i in range(n + 1):
        dp[i][0] = 1
    
    # Fill the dp array
    for i in range(1, n + 1):
        for j in range(1, amount + 1):
            # If the current coin value is greater than the current amount,
            # we can't use this coin, so the number of ways is the same as without this coin
            if coins[i - 1] > j:
                dp[i][j] = dp[i - 1][j]
            else:
                # Otherwise, we can either use this coin or not
                dp[i][j] = dp[i - 1][j] + dp[i][j - coins[i - 1]]
    
    return dp[n][amount]
```

**Time Complexity:** O(amount * n) - We have two nested loops, one iterating through the coins and the other iterating through the amounts.
**Space Complexity:** O(amount * n) - We use a 2D array to store the number of ways to make up each amount using each subset of coins.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def change(amount, coins):
    memo = {}
    
    def dp(i, remaining):
        if remaining == 0:
            return 1
        if i == len(coins) or remaining < 0:
            return 0
        
        if (i, remaining) in memo:
            return memo[(i, remaining)]
        
        # Either use the current coin or skip it
        memo[(i, remaining)] = dp(i, remaining - coins[i]) + dp(i + 1, remaining)
        return memo[(i, remaining)]
    
    return dp(0, amount)
```

**Time Complexity:** O(amount * n) - We have amount * n possible states (i, remaining), and each state takes O(1) time to compute.
**Space Complexity:** O(amount * n) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Space Optimization solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(amount * n) time complexity, which is optimal for this problem, and the space complexity is O(amount), which is better than the O(amount * n) space complexity of the tabulation solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the number of ways to make up each amount.

The key insight of this approach is to use a 1D array to keep track of the number of ways to make up each amount. For each coin, we update the array for all amounts from the coin value to the target amount. The value dp[i] represents the number of ways to make up amount i using the coins considered so far.

For example, let's trace through the algorithm for amount = 5 and coins = [1, 2, 5]:

1. Initialize dp = [1, 0, 0, 0, 0, 0]

2. Consider each coin:
   - coin = 1:
     - For i = 1: dp[1] += dp[1 - 1] = dp[1] + dp[0] = 0 + 1 = 1
     - For i = 2: dp[2] += dp[2 - 1] = dp[2] + dp[1] = 0 + 1 = 1
     - For i = 3: dp[3] += dp[3 - 1] = dp[3] + dp[2] = 0 + 1 = 1
     - For i = 4: dp[4] += dp[4 - 1] = dp[4] + dp[3] = 0 + 1 = 1
     - For i = 5: dp[5] += dp[5 - 1] = dp[5] + dp[4] = 0 + 1 = 1
     - dp = [1, 1, 1, 1, 1, 1]
   - coin = 2:
     - For i = 2: dp[2] += dp[2 - 2] = dp[2] + dp[0] = 1 + 1 = 2
     - For i = 3: dp[3] += dp[3 - 2] = dp[3] + dp[1] = 1 + 1 = 2
     - For i = 4: dp[4] += dp[4 - 2] = dp[4] + dp[2] = 1 + 2 = 3
     - For i = 5: dp[5] += dp[5 - 2] = dp[5] + dp[3] = 1 + 2 = 3
     - dp = [1, 1, 2, 2, 3, 3]
   - coin = 5:
     - For i = 5: dp[5] += dp[5 - 5] = dp[5] + dp[0] = 3 + 1 = 4
     - dp = [1, 1, 2, 2, 3, 4]

3. Return dp[amount] = dp[5] = 4

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Recursive with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with Space Optimization solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
