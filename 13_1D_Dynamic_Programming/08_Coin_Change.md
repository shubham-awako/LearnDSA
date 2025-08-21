# Coin Change

## Problem Statement

You are given an integer array `coins` representing coins of different denominations and an integer `amount` representing a total amount of money.

Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return `-1`.

You may assume that you have an infinite number of each kind of coin.

**Example 1:**
```
Input: coins = [1,2,5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1
```

**Example 2:**
```
Input: coins = [2], amount = 3
Output: -1
```

**Example 3:**
```
Input: coins = [1], amount = 0
Output: 0
```

**Constraints:**
- `1 <= coins.length <= 12`
- `1 <= coins[i] <= 2^31 - 1`
- `0 <= amount <= 10^4`

## Concept Overview

This problem is a classic example of dynamic programming, specifically the coin change problem. The key insight is to build a table where each entry represents the minimum number of coins needed to make up a certain amount. We can then use this table to find the minimum number of coins needed to make up the target amount.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def coinChange(coins, amount):
    # Initialize the dp array with a value larger than any possible answer
    dp = [float('inf')] * (amount + 1)
    dp[0] = 0  # Base case: 0 coins needed to make amount 0
    
    # Fill the dp array
    for coin in coins:
        for i in range(coin, amount + 1):
            dp[i] = min(dp[i], dp[i - coin] + 1)
    
    return dp[amount] if dp[amount] != float('inf') else -1
```

**Time Complexity:** O(amount * n) - We iterate through each coin and each amount from the coin value to the target amount.
**Space Complexity:** O(amount) - We use the dp array to store the results of all subproblems.

### 2. Alternative Solution - Dynamic Programming with Memoization

Use dynamic programming with memoization to solve the problem.

```python
def coinChange(coins, amount):
    memo = {}
    
    def dp(remaining):
        # Base cases
        if remaining == 0:
            return 0
        if remaining < 0:
            return -1
        
        # Check if the result is already computed
        if remaining in memo:
            return memo[remaining]
        
        # Compute the result
        min_coins = float('inf')
        for coin in coins:
            result = dp(remaining - coin)
            if result != -1:
                min_coins = min(min_coins, result + 1)
        
        # Store the result in the memoization dictionary
        memo[remaining] = min_coins if min_coins != float('inf') else -1
        return memo[remaining]
    
    return dp(amount)
```

**Time Complexity:** O(amount * n) - We compute the result for each amount from 1 to the target amount, and for each amount, we consider all n coins.
**Space Complexity:** O(amount) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - BFS

Use Breadth-First Search to solve the problem.

```python
from collections import deque

def coinChange(coins, amount):
    if amount == 0:
        return 0
    
    # Use a set to keep track of visited amounts
    visited = set()
    queue = deque([(0, 0)])  # (amount, num_coins)
    
    while queue:
        current_amount, num_coins = queue.popleft()
        
        # Try each coin
        for coin in coins:
            next_amount = current_amount + coin
            
            # If we've reached the target amount, return the number of coins
            if next_amount == amount:
                return num_coins + 1
            
            # If the next amount is less than the target amount and we haven't visited it yet
            if next_amount < amount and next_amount not in visited:
                visited.add(next_amount)
                queue.append((next_amount, num_coins + 1))
    
    return -1
```

**Time Complexity:** O(amount * n) - In the worst case, we visit each amount from 1 to the target amount, and for each amount, we consider all n coins.
**Space Complexity:** O(amount) - We use the visited set and the queue to keep track of the amounts we've visited.

## Solution Choice and Explanation

The Dynamic Programming with Tabulation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(amount * n) time complexity, which is optimal for this problem, and the space complexity is O(amount).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the minimum number of coins needed to make up a certain amount.

The key insight of this approach is to build a table where each entry represents the minimum number of coins needed to make up a certain amount. We can then use this table to find the minimum number of coins needed to make up the target amount.

For example, let's trace through the algorithm for coins = [1, 2, 5] and amount = 11:

1. Initialize:
   - dp = [0, inf, inf, inf, inf, inf, inf, inf, inf, inf, inf, inf]

2. Fill the dp array:
   - For coin = 1:
     - dp[1] = min(dp[1], dp[1-1] + 1) = min(inf, 0 + 1) = 1
     - dp[2] = min(dp[2], dp[2-1] + 1) = min(inf, 1 + 1) = 2
     - ...
     - dp[11] = min(dp[11], dp[11-1] + 1) = min(inf, 10 + 1) = 11
   - For coin = 2:
     - dp[2] = min(dp[2], dp[2-2] + 1) = min(2, 0 + 1) = 1
     - dp[3] = min(dp[3], dp[3-2] + 1) = min(3, 1 + 1) = 2
     - ...
     - dp[11] = min(dp[11], dp[11-2] + 1) = min(11, 9 + 1) = 10
   - For coin = 5:
     - dp[5] = min(dp[5], dp[5-5] + 1) = min(5, 0 + 1) = 1
     - dp[6] = min(dp[6], dp[6-5] + 1) = min(3, 1 + 1) = 2
     - ...
     - dp[11] = min(dp[11], dp[11-5] + 1) = min(10, 6 + 1) = 7
     - dp[11] = min(dp[11], dp[11-5] + 1) = min(7, 2 + 1) = 3

3. Return dp[11] = 3

For coins = [2] and amount = 3:

1. Initialize:
   - dp = [0, inf, inf, inf]

2. Fill the dp array:
   - For coin = 2:
     - dp[2] = min(dp[2], dp[2-2] + 1) = min(inf, 0 + 1) = 1
     - dp[3] = min(dp[3], dp[3-2] + 1) = min(inf, 1 + 1) = 2

3. Wait, that's not right. Let's trace through the algorithm again:

1. Initialize:
   - dp = [0, inf, inf, inf]

2. Fill the dp array:
   - For coin = 2:
     - dp[2] = min(dp[2], dp[2-2] + 1) = min(inf, 0 + 1) = 1
     - dp[3] remains inf because dp[3-2] = dp[1] = inf

3. Return dp[3] = inf, which means -1

The Dynamic Programming with Memoization solution (Solution 2) is also efficient but may be less intuitive for some people. The BFS solution (Solution 3) is elegant but may be less efficient in practice due to the overhead of the queue and set operations.

In an interview, I would first mention the Dynamic Programming with Tabulation solution as the most intuitive approach for this problem, and then discuss the Dynamic Programming with Memoization and BFS solutions as alternatives if asked for different approaches.
