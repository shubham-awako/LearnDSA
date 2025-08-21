# Best Time to Buy And Sell Stock

## Problem Statement

You are given an array `prices` where `prices[i]` is the price of a given stock on the `i`th day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

**Example 1:**
```
Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
```

**Example 2:**
```
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.
```

**Constraints:**
- `1 <= prices.length <= 10^5`
- `0 <= prices[i] <= 10^4`

## Concept Overview

This problem asks us to find the maximum profit that can be achieved by buying and selling a stock once. The key insight is to find the minimum price so far and calculate the maximum profit that can be achieved by selling at the current price.

## Solutions

### 1. Brute Force Approach

Check all possible buy and sell combinations.

```python
def maxProfit(prices):
    n = len(prices)
    max_profit = 0
    
    for i in range(n):
        for j in range(i + 1, n):
            profit = prices[j] - prices[i]
            max_profit = max(max_profit, profit)
    
    return max_profit
```

**Time Complexity:** O(n²) - We check all possible buy and sell combinations.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - One Pass

Keep track of the minimum price so far and update the maximum profit.

```python
def maxProfit(prices):
    if not prices:
        return 0
    
    min_price = float('inf')
    max_profit = 0
    
    for price in prices:
        # Update the minimum price so far
        min_price = min(min_price, price)
        
        # Update the maximum profit
        profit = price - min_price
        max_profit = max(max_profit, profit)
    
    return max_profit
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Dynamic Programming

Use dynamic programming to track the maximum profit at each step.

```python
def maxProfit(prices):
    if not prices:
        return 0
    
    n = len(prices)
    
    # dp[i] represents the maximum profit up to day i
    dp = [0] * n
    
    min_price = prices[0]
    
    for i in range(1, n):
        # Update the minimum price so far
        min_price = min(min_price, prices[i])
        
        # Update the maximum profit
        dp[i] = max(dp[i-1], prices[i] - min_price)
    
    return dp[n-1]
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We use an array of size n to store the maximum profit at each step.

## Solution Choice and Explanation

The one-pass solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the dynamic programming approach.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to keep track of the minimum price seen so far and calculate the profit that can be achieved by selling at the current price. By updating the minimum price and maximum profit as we iterate through the array, we can find the maximum profit in a single pass.

For example, in the array [7,1,5,3,6,4]:
- Day 1: min_price = 7, profit = 0, max_profit = 0
- Day 2: min_price = 1, profit = 0, max_profit = 0
- Day 3: min_price = 1, profit = 4, max_profit = 4
- Day 4: min_price = 1, profit = 2, max_profit = 4
- Day 5: min_price = 1, profit = 5, max_profit = 5
- Day 6: min_price = 1, profit = 3, max_profit = 5

The dynamic programming approach (Solution 3) is also efficient with O(n) time complexity but uses O(n) extra space. The brute force approach (Solution 1) is inefficient with O(n²) time complexity.

In an interview, I would first mention the one-pass approach as the optimal solution that achieves O(n) time complexity with O(1) extra space. I would also explain the insight behind tracking the minimum price and maximum profit.
