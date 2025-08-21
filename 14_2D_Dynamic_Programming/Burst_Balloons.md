# Burst Balloons

## Problem Statement

You are given `n` balloons, indexed from `0` to `n - 1`. Each balloon is painted with a number on it represented by an array `nums`. You are asked to burst all the balloons.

If you burst the `ith` balloon, you will get `nums[i - 1] * nums[i] * nums[i + 1]` coins. If `i - 1` or `i + 1` goes out of bounds of the array, then treat it as if there is a balloon with a `1` painted on it.

Return the maximum coins you can collect by bursting the balloons wisely.

**Example 1:**
```
Input: nums = [3,1,5,8]
Output: 167
Explanation:
nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167
```

**Example 2:**
```
Input: nums = [1,5]
Output: 10
```

**Constraints:**
- `n == nums.length`
- `1 <= n <= 500`
- `0 <= nums[i] <= 100`

## Concept Overview

This problem can be solved using dynamic programming. The key insight is to think of the problem in reverse: instead of considering which balloon to burst first, consider which balloon to burst last. This allows us to define a state that represents the maximum coins we can get by bursting all balloons in a range.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def maxCoins(nums):
    # Add 1 at the beginning and end of the array
    nums = [1] + nums + [1]
    n = len(nums)
    
    # Initialize the dp array
    # dp[i][j] represents the maximum coins we can get by bursting all balloons in the range (i, j)
    dp = [[0] * n for _ in range(n)]
    
    # Fill the dp array
    for length in range(2, n):
        for left in range(n - length):
            right = left + length
            
            # Try each balloon as the last one to burst
            for last in range(left + 1, right):
                coins = nums[left] * nums[last] * nums[right]
                dp[left][right] = max(dp[left][right], dp[left][last] + coins + dp[last][right])
    
    return dp[0][n - 1]
```

**Time Complexity:** O(n^3) - We have three nested loops: one for the length of the range, one for the left boundary, and one for the last balloon to burst.
**Space Complexity:** O(n^2) - We use a 2D array to store the maximum coins for each range.

### 2. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def maxCoins(nums):
    # Add 1 at the beginning and end of the array
    nums = [1] + nums + [1]
    n = len(nums)
    memo = {}
    
    def dp(left, right):
        if left + 1 == right:
            return 0
        
        if (left, right) in memo:
            return memo[(left, right)]
        
        result = 0
        # Try each balloon as the last one to burst
        for last in range(left + 1, right):
            coins = nums[left] * nums[last] * nums[right]
            result = max(result, dp(left, last) + coins + dp(last, right))
        
        memo[(left, right)] = result
        return result
    
    return dp(0, n - 1)
```

**Time Complexity:** O(n^3) - We have n^2 possible states (left, right), and for each state, we try n possible values for the last balloon to burst.
**Space Complexity:** O(n^2) - We use the memoization dictionary to store the results of all subproblems.

### 3. Alternative Solution - Divide and Conquer with Memoization

Use a divide-and-conquer approach with memoization to solve the problem.

```python
def maxCoins(nums):
    # Add 1 at the beginning and end of the array
    nums = [1] + nums + [1]
    n = len(nums)
    memo = {}
    
    def divide_and_conquer(left, right):
        if left + 1 == right:
            return 0
        
        if (left, right) in memo:
            return memo[(left, right)]
        
        result = 0
        # Try each balloon as the first one to burst
        for first in range(left + 1, right):
            # Burst the first balloon
            coins = nums[left] * nums[first] * nums[right]
            
            # Recursively solve the left and right subproblems
            left_coins = divide_and_conquer(left, first)
            right_coins = divide_and_conquer(first, right)
            
            # Update the result
            result = max(result, left_coins + coins + right_coins)
        
        memo[(left, right)] = result
        return result
    
    return divide_and_conquer(0, n - 1)
```

**Time Complexity:** O(n^3) - We have n^2 possible states (left, right), and for each state, we try n possible values for the first balloon to burst.
**Space Complexity:** O(n^2) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Tabulation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n^3) time complexity, which is optimal for this problem, and the space complexity is O(n^2).

2. **Simplicity**: It's a straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the maximum coins by considering which balloon to burst last.

The key insight of this approach is to think of the problem in reverse: instead of considering which balloon to burst first, consider which balloon to burst last. This allows us to define a state dp[left][right] that represents the maximum coins we can get by bursting all balloons in the range (left, right).

For each range (left, right), we try each balloon in the range as the last one to burst. When we burst the last balloon, we get coins equal to nums[left] * nums[last] * nums[right], and we also need to add the maximum coins we can get by bursting all balloons in the ranges (left, last) and (last, right).

For example, let's trace through the algorithm for nums = [3, 1, 5, 8]:

1. Add 1 at the beginning and end: nums = [1, 3, 1, 5, 8, 1]
2. Initialize dp = [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]

3. Fill the dp array:
   - length = 2:
     - left = 0, right = 2:
       - last = 1: coins = nums[0] * nums[1] * nums[2] = 1 * 3 * 1 = 3
       - dp[0][2] = max(0, dp[0][1] + 3 + dp[1][2]) = max(0, 0 + 3 + 0) = 3
     - left = 1, right = 3:
       - last = 2: coins = nums[1] * nums[2] * nums[3] = 3 * 1 * 5 = 15
       - dp[1][3] = max(0, dp[1][2] + 15 + dp[2][3]) = max(0, 0 + 15 + 0) = 15
     - left = 2, right = 4:
       - last = 3: coins = nums[2] * nums[3] * nums[4] = 1 * 5 * 8 = 40
       - dp[2][4] = max(0, dp[2][3] + 40 + dp[3][4]) = max(0, 0 + 40 + 0) = 40
     - left = 3, right = 5:
       - last = 4: coins = nums[3] * nums[4] * nums[5] = 5 * 8 * 1 = 40
       - dp[3][5] = max(0, dp[3][4] + 40 + dp[4][5]) = max(0, 0 + 40 + 0) = 40
   - length = 3:
     - left = 0, right = 3:
       - last = 1: coins = nums[0] * nums[1] * nums[3] = 1 * 3 * 5 = 15
       - dp[0][3] = max(0, dp[0][1] + 15 + dp[1][3]) = max(0, 0 + 15 + 15) = 30
       - last = 2: coins = nums[0] * nums[2] * nums[3] = 1 * 1 * 5 = 5
       - dp[0][3] = max(30, dp[0][2] + 5 + dp[2][3]) = max(30, 3 + 5 + 0) = 30
     - left = 1, right = 4:
       - last = 2: coins = nums[1] * nums[2] * nums[4] = 3 * 1 * 8 = 24
       - dp[1][4] = max(0, dp[1][2] + 24 + dp[2][4]) = max(0, 0 + 24 + 40) = 64
       - last = 3: coins = nums[1] * nums[3] * nums[4] = 3 * 5 * 8 = 120
       - dp[1][4] = max(64, dp[1][3] + 120 + dp[3][4]) = max(64, 15 + 120 + 0) = 135
     - left = 2, right = 5:
       - last = 3: coins = nums[2] * nums[3] * nums[5] = 1 * 5 * 1 = 5
       - dp[2][5] = max(0, dp[2][3] + 5 + dp[3][5]) = max(0, 0 + 5 + 40) = 45
       - last = 4: coins = nums[2] * nums[4] * nums[5] = 1 * 8 * 1 = 8
       - dp[2][5] = max(45, dp[2][4] + 8 + dp[4][5]) = max(45, 40 + 8 + 0) = 48
   - length = 4:
     - left = 0, right = 4:
       - last = 1: coins = nums[0] * nums[1] * nums[4] = 1 * 3 * 8 = 24
       - dp[0][4] = max(0, dp[0][1] + 24 + dp[1][4]) = max(0, 0 + 24 + 135) = 159
       - last = 2: coins = nums[0] * nums[2] * nums[4] = 1 * 1 * 8 = 8
       - dp[0][4] = max(159, dp[0][2] + 8 + dp[2][4]) = max(159, 3 + 8 + 40) = 159
       - last = 3: coins = nums[0] * nums[3] * nums[4] = 1 * 5 * 8 = 40
       - dp[0][4] = max(159, dp[0][3] + 40 + dp[3][4]) = max(159, 30 + 40 + 0) = 159
     - left = 1, right = 5:
       - last = 2: coins = nums[1] * nums[2] * nums[5] = 3 * 1 * 1 = 3
       - dp[1][5] = max(0, dp[1][2] + 3 + dp[2][5]) = max(0, 0 + 3 + 48) = 51
       - last = 3: coins = nums[1] * nums[3] * nums[5] = 3 * 5 * 1 = 15
       - dp[1][5] = max(51, dp[1][3] + 15 + dp[3][5]) = max(51, 15 + 15 + 40) = 70
       - last = 4: coins = nums[1] * nums[4] * nums[5] = 3 * 8 * 1 = 24
       - dp[1][5] = max(70, dp[1][4] + 24 + dp[4][5]) = max(70, 135 + 24 + 0) = 159
   - length = 5:
     - left = 0, right = 5:
       - last = 1: coins = nums[0] * nums[1] * nums[5] = 1 * 3 * 1 = 3
       - dp[0][5] = max(0, dp[0][1] + 3 + dp[1][5]) = max(0, 0 + 3 + 159) = 162
       - last = 2: coins = nums[0] * nums[2] * nums[5] = 1 * 1 * 1 = 1
       - dp[0][5] = max(162, dp[0][2] + 1 + dp[2][5]) = max(162, 3 + 1 + 48) = 162
       - last = 3: coins = nums[0] * nums[3] * nums[5] = 1 * 5 * 1 = 5
       - dp[0][5] = max(162, dp[0][3] + 5 + dp[3][5]) = max(162, 30 + 5 + 40) = 162
       - last = 4: coins = nums[0] * nums[4] * nums[5] = 1 * 8 * 1 = 8
       - dp[0][5] = max(162, dp[0][4] + 8 + dp[4][5]) = max(162, 159 + 8 + 0) = 167

4. Return dp[0][n - 1] = dp[0][5] = 167

The Recursive with Memoization solution (Solution 2) and the Divide and Conquer with Memoization solution (Solution 3) are also efficient but may be less intuitive for some people.

In an interview, I would first mention the Dynamic Programming with Tabulation solution as the most intuitive approach for this problem, and then discuss the Recursive with Memoization and Divide and Conquer with Memoization solutions as alternatives if asked for different approaches.
