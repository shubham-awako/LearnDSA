# Counting Bits

## Problem Statement

Given an integer `n`, return an array `ans` of length `n + 1` such that for each `i` (`0 <= i <= n`), `ans[i]` is the number of `1`'s in the binary representation of `i`.

**Example 1:**
```
Input: n = 2
Output: [0,1,1]
Explanation:
0 --> 0
1 --> 1
2 --> 10
```

**Example 2:**
```
Input: n = 5
Output: [0,1,1,2,1,2]
Explanation:
0 --> 0
1 --> 1
2 --> 10
3 --> 11
4 --> 100
5 --> 101
```

**Constraints:**
- `0 <= n <= 10^5`

## Concept Overview

This problem involves counting the number of '1' bits in the binary representation of each number from 0 to n. There are several approaches to solve this problem, including using bit manipulation techniques and dynamic programming.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Bit Manipulation

Use dynamic programming with bit manipulation to count the number of '1' bits.

```python
def countBits(n):
    dp = [0] * (n + 1)
    for i in range(1, n + 1):
        dp[i] = dp[i >> 1] + (i & 1)
    return dp
```

**Time Complexity:** O(n) - We iterate through the numbers from 0 to n once.
**Space Complexity:** O(n) - We use an array of size n + 1 to store the results.

### 2. Alternative Solution - Brian Kernighan's Algorithm

Use Brian Kernighan's algorithm to count the number of '1' bits for each number.

```python
def countBits(n):
    def count_ones(num):
        count = 0
        while num:
            num &= (num - 1)
            count += 1
        return count
    
    return [count_ones(i) for i in range(n + 1)]
```

**Time Complexity:** O(n * log n) - For each number from 0 to n, we perform O(log n) operations in the worst case.
**Space Complexity:** O(n) - We use an array of size n + 1 to store the results.

### 3. Alternative Solution - Dynamic Programming with Last Set Bit

Use dynamic programming with the last set bit to count the number of '1' bits.

```python
def countBits(n):
    dp = [0] * (n + 1)
    for i in range(1, n + 1):
        dp[i] = dp[i & (i - 1)] + 1
    return dp
```

**Time Complexity:** O(n) - We iterate through the numbers from 0 to n once.
**Space Complexity:** O(n) - We use an array of size n + 1 to store the results.

## Solution Choice and Explanation

The Dynamic Programming with Bit Manipulation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Elegance**: It's a clever combination of dynamic programming and bit manipulation.

3. **Simplicity**: It's straightforward to understand and implement.

The key insight of this approach is to use the fact that the number of '1' bits in i is equal to the number of '1' bits in i/2 (i >> 1) plus the least significant bit of i (i & 1). This is because shifting i right by 1 bit removes the least significant bit, and the rest of the bits remain the same.

For example, let's trace through the algorithm for n = 5:

1. Initialize dp = [0, 0, 0, 0, 0, 0]

2. Iterate from i = 1 to n = 5:
   - i = 1:
     - dp[1] = dp[1 >> 1] + (1 & 1) = dp[0] + 1 = 0 + 1 = 1
     - dp = [0, 1, 0, 0, 0, 0]
   - i = 2:
     - dp[2] = dp[2 >> 1] + (2 & 1) = dp[1] + 0 = 1 + 0 = 1
     - dp = [0, 1, 1, 0, 0, 0]
   - i = 3:
     - dp[3] = dp[3 >> 1] + (3 & 1) = dp[1] + 1 = 1 + 1 = 2
     - dp = [0, 1, 1, 2, 0, 0]
   - i = 4:
     - dp[4] = dp[4 >> 1] + (4 & 1) = dp[2] + 0 = 1 + 0 = 1
     - dp = [0, 1, 1, 2, 1, 0]
   - i = 5:
     - dp[5] = dp[5 >> 1] + (5 & 1) = dp[2] + 1 = 1 + 1 = 2
     - dp = [0, 1, 1, 2, 1, 2]

3. Return dp = [0, 1, 1, 2, 1, 2]

The Brian Kernighan's Algorithm solution (Solution 2) is also correct but less efficient, with a time complexity of O(n * log n). The Dynamic Programming with Last Set Bit solution (Solution 3) is also efficient but may be less intuitive.

In an interview, I would first mention the Dynamic Programming with Bit Manipulation solution as the most efficient approach for this problem, and then discuss the Brian Kernighan's Algorithm and Dynamic Programming with Last Set Bit solutions as alternatives if asked for different approaches.

Let's also understand the Dynamic Programming with Last Set Bit solution (Solution 3) in more detail:

The key insight of this approach is to use the fact that `i & (i - 1)` clears the rightmost '1' bit in i. Therefore, the number of '1' bits in i is equal to the number of '1' bits in `i & (i - 1)` plus 1.

For example, let's trace through the algorithm for n = 5:

1. Initialize dp = [0, 0, 0, 0, 0, 0]

2. Iterate from i = 1 to n = 5:
   - i = 1:
     - dp[1] = dp[1 & (1 - 1)] + 1 = dp[0] + 1 = 0 + 1 = 1
     - dp = [0, 1, 0, 0, 0, 0]
   - i = 2:
     - dp[2] = dp[2 & (2 - 1)] + 1 = dp[0] + 1 = 0 + 1 = 1
     - dp = [0, 1, 1, 0, 0, 0]
   - i = 3:
     - dp[3] = dp[3 & (3 - 1)] + 1 = dp[2] + 1 = 1 + 1 = 2
     - dp = [0, 1, 1, 2, 0, 0]
   - i = 4:
     - dp[4] = dp[4 & (4 - 1)] + 1 = dp[0] + 1 = 0 + 1 = 1
     - dp = [0, 1, 1, 2, 1, 0]
   - i = 5:
     - dp[5] = dp[5 & (5 - 1)] + 1 = dp[4] + 1 = 1 + 1 = 2
     - dp = [0, 1, 1, 2, 1, 2]

3. Return dp = [0, 1, 1, 2, 1, 2]

Both the Dynamic Programming with Bit Manipulation and Dynamic Programming with Last Set Bit solutions are efficient and elegant, but the former might be slightly more intuitive for most people.
