# Best Time to Buy and Sell Stock with Cooldown

## Problem Statement

You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.

Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

- After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).
- Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

**Example 1:**
```
Input: prices = [1,2,3,0,2]
Output: 3
Explanation: transactions = [buy, sell, cooldown, buy, sell]
```

**Example 2:**
```
Input: prices = [1]
Output: 0
```

**Constraints:**
- `1 <= prices.length <= 5000`
- `0 <= prices[i] <= 1000`

## Concept Overview

This problem is an extension of the classic "Best Time to Buy and Sell Stock" problem, with the added constraint of a cooldown period after selling. The key insight is to use dynamic programming to keep track of the maximum profit in different states: holding a stock, not holding a stock and able to buy, and not holding a stock and in cooldown.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with State Machine

Use dynamic programming with a state machine approach to solve the problem.

```python
def maxProfit(prices):
    if not prices or len(prices) <= 1:
        return 0
    
    n = len(prices)
    
    # Initialize the state variables
    # hold: maximum profit when holding a stock
    # not_hold: maximum profit when not holding a stock and able to buy
    # cooldown: maximum profit when not holding a stock and in cooldown
    hold = -prices[0]
    not_hold = 0
    cooldown = 0
    
    for i in range(1, n):
        # Update the state variables
        prev_hold = hold
        prev_not_hold = not_hold
        prev_cooldown = cooldown
        
        # If we're holding a stock, we can either continue holding or buy a new one
        hold = max(prev_hold, prev_not_hold - prices[i])
        
        # If we're not holding a stock and able to buy, we can either continue not holding or sell
        not_hold = max(prev_not_hold, prev_cooldown)
        
        # If we're in cooldown, we must have sold a stock on the previous day
        cooldown = prev_hold + prices[i]
    
    # The maximum profit is the maximum of not holding a stock and being in cooldown
    return max(not_hold, cooldown)
```

**Time Complexity:** O(n) - We iterate through the prices array once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def maxProfit(prices):
    if not prices or len(prices) <= 1:
        return 0
    
    n = len(prices)
    
    # Initialize the dp array
    # dp[i][0]: maximum profit on day i when holding a stock
    # dp[i][1]: maximum profit on day i when not holding a stock and able to buy
    # dp[i][2]: maximum profit on day i when not holding a stock and in cooldown
    dp = [[0, 0, 0] for _ in range(n)]
    
    # Base case: day 0
    dp[0][0] = -prices[0]  # Buy a stock
    dp[0][1] = 0           # Do nothing
    dp[0][2] = 0           # No stock to sell yet
    
    for i in range(1, n):
        # If we're holding a stock, we can either continue holding or buy a new one
        dp[i][0] = max(dp[i-1][0], dp[i-1][1] - prices[i])
        
        # If we're not holding a stock and able to buy, we can either continue not holding or come from cooldown
        dp[i][1] = max(dp[i-1][1], dp[i-1][2])
        
        # If we're in cooldown, we must have sold a stock on the previous day
        dp[i][2] = dp[i-1][0] + prices[i]
    
    # The maximum profit is the maximum of not holding a stock and being in cooldown
    return max(dp[n-1][1], dp[n-1][2])
```

**Time Complexity:** O(n) - We iterate through the prices array once.
**Space Complexity:** O(n) - We use a 2D array to store the maximum profit for each day and state.

### 3. Alternative Solution - Dynamic Programming with Memoization

Use recursion with memoization to solve the problem.

```python
def maxProfit(prices):
    if not prices or len(prices) <= 1:
        return 0
    
    n = len(prices)
    memo = {}
    
    def dp(i, holding):
        if i >= n:
            return 0
        
        if (i, holding) in memo:
            return memo[(i, holding)]
        
        # Skip the current day
        skip = dp(i + 1, holding)
        
        if holding:
            # Sell the stock
            sell = dp(i + 2, False) + prices[i]
            memo[(i, holding)] = max(skip, sell)
        else:
            # Buy the stock
            buy = dp(i + 1, True) - prices[i]
            memo[(i, holding)] = max(skip, buy)
        
        return memo[(i, holding)]
    
    return dp(0, False)
```

**Time Complexity:** O(n) - We have 2n possible states (i, holding), and each state takes O(1) time to compute.
**Space Complexity:** O(n) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with State Machine solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1), which is better than the O(n) space complexity of the tabulation solution.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of tracking the maximum profit in different states.

The key insight of this approach is to use three state variables to represent the maximum profit in different states: holding a stock, not holding a stock and able to buy, and not holding a stock and in cooldown. We update these state variables as we iterate through the prices array, and the maximum profit is the maximum of not holding a stock and being in cooldown at the end.

For example, let's trace through the algorithm for prices = [1, 2, 3, 0, 2]:

1. Initialize:
   - hold = -prices[0] = -1
   - not_hold = 0
   - cooldown = 0

2. Iterate through the prices array:
   - i = 1 (prices[1] = 2):
     - prev_hold = hold = -1
     - prev_not_hold = not_hold = 0
     - prev_cooldown = cooldown = 0
     - hold = max(prev_hold, prev_not_hold - prices[i]) = max(-1, 0 - 2) = max(-1, -2) = -1
     - not_hold = max(prev_not_hold, prev_cooldown) = max(0, 0) = 0
     - cooldown = prev_hold + prices[i] = -1 + 2 = 1
   - i = 2 (prices[2] = 3):
     - prev_hold = hold = -1
     - prev_not_hold = not_hold = 0
     - prev_cooldown = cooldown = 1
     - hold = max(prev_hold, prev_not_hold - prices[i]) = max(-1, 0 - 3) = max(-1, -3) = -1
     - not_hold = max(prev_not_hold, prev_cooldown) = max(0, 1) = 1
     - cooldown = prev_hold + prices[i] = -1 + 3 = 2
   - i = 3 (prices[3] = 0):
     - prev_hold = hold = -1
     - prev_not_hold = not_hold = 1
     - prev_cooldown = cooldown = 2
     - hold = max(prev_hold, prev_not_hold - prices[i]) = max(-1, 1 - 0) = max(-1, 1) = 1
     - not_hold = max(prev_not_hold, prev_cooldown) = max(1, 2) = 2
     - cooldown = prev_hold + prices[i] = -1 + 0 = -1
   - i = 4 (prices[4] = 2):
     - prev_hold = hold = 1
     - prev_not_hold = not_hold = 2
     - prev_cooldown = cooldown = -1
     - hold = max(prev_hold, prev_not_hold - prices[i]) = max(1, 2 - 2) = max(1, 0) = 1
     - not_hold = max(prev_not_hold, prev_cooldown) = max(2, -1) = 2
     - cooldown = prev_hold + prices[i] = 1 + 2 = 3

3. Return max(not_hold, cooldown) = max(2, 3) = 3

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but uses more space. The Dynamic Programming with Memoization solution (Solution 3) is also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with State Machine solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Memoization solutions as alternatives if asked for different approaches.
