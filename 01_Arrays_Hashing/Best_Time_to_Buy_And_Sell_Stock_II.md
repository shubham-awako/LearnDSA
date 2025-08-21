# Best Time to Buy And Sell Stock II

## Problem Statement

You are given an integer array `prices` where `prices[i]` is the price of a given stock on the `i`th day.

On each day, you may decide to buy and/or sell the stock. You can only hold at most one share of the stock at any time. However, you can buy it then immediately sell it on the same day.

Find and return the maximum profit you can achieve.

**Example 1:**
```
Input: prices = [7,1,5,3,6,4]
Output: 7
Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
Total profit is 4 + 3 = 7.
```

**Example 2:**
```
Input: prices = [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
Total profit is 4.
```

**Example 3:**
```
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: There is no way to make a positive profit, so we never buy the stock to achieve the maximum profit of 0.
```

**Constraints:**
- `1 <= prices.length <= 3 * 10^4`
- `0 <= prices[i] <= 10^4`

## Concept Overview

This problem asks us to find the maximum profit that can be achieved by buying and selling a stock multiple times. The key insight is to identify all profitable transactions and accumulate them.

## Solutions

### 1. Brute Force Approach - Recursive

Try all possible combinations of buying and selling the stock.

```python
def maxProfit(prices):
    def dfs(index, holding):
        if index == len(prices):
            return 0
        
        # Skip this day
        profit = dfs(index + 1, holding)
        
        if holding:
            # Sell the stock
            profit = max(profit, prices[index] + dfs(index + 1, False))
        else:
            # Buy the stock
            profit = max(profit, -prices[index] + dfs(index + 1, True))
        
        return profit
    
    return dfs(0, False)
```

**Time Complexity:** O(2^n) - We have two choices (buy/skip or sell/skip) for each day.
**Space Complexity:** O(n) - The recursion stack can go up to n levels deep.

### 2. Improved Solution - Dynamic Programming

Use dynamic programming to avoid redundant calculations in the recursive approach.

```python
def maxProfit(prices):
    n = len(prices)
    # dp[i][j] represents the maximum profit on day i with holding state j
    # j = 0 means not holding a stock, j = 1 means holding a stock
    dp = [[-float('inf')] * 2 for _ in range(n + 1)]
    dp[0][0] = 0  # Base case: no profit on day 0 with no stock
    
    for i in range(1, n + 1):
        # Not holding a stock
        dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i-1])
        
        # Holding a stock
        dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i-1])
    
    return dp[n][0]  # Maximum profit on the last day with no stock
```

**Time Complexity:** O(n) - We fill in a 2D DP table of size n x 2.
**Space Complexity:** O(n) - We use a 2D DP table.

### 3. Best Optimized Solution - Greedy Approach

Accumulate all positive price differences between consecutive days.

```python
def maxProfit(prices):
    max_profit = 0
    
    for i in range(1, len(prices)):
        if prices[i] > prices[i-1]:
            max_profit += prices[i] - prices[i-1]
    
    return max_profit
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We use only a single variable to track the profit.

## Solution Choice and Explanation

The greedy approach (Solution 3) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity with a single pass through the array.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the DP approach.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of the greedy approach is that we can maximize profit by capturing all positive price differences between consecutive days. This is equivalent to buying on every day followed by a price increase and selling on the day of the price increase.

For example, in the sequence [1, 2, 3, 4, 5], the greedy approach would accumulate profits (2-1) + (3-2) + (4-3) + (5-4) = 4, which is the same as buying at price 1 and selling at price 5.

The dynamic programming approach (Solution 2) is also correct but uses more space and is more complex. The recursive approach (Solution 1) is inefficient due to redundant calculations.

In an interview, I would first explain the greedy approach and its intuition, as it's the most efficient solution for this problem.
