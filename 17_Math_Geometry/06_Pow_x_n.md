# Pow(x, n)

## Problem Statement

Implement `pow(x, n)`, which calculates `x` raised to the power `n` (i.e., `x^n`).

**Example 1:**
```
Input: x = 2.00000, n = 10
Output: 1024.00000
```

**Example 2:**
```
Input: x = 2.10000, n = 3
Output: 9.26100
```

**Example 3:**
```
Input: x = 2.00000, n = -2
Output: 0.25000
Explanation: 2^(-2) = 1/2^2 = 1/4 = 0.25
```

**Constraints:**
- `-100.0 < x < 100.0`
- `-2^31 <= n <= 2^31 - 1`
- `-10^4 <= x^n <= 10^4`

## Concept Overview

This problem involves calculating the power of a number. The key insight is to use the binary exponentiation algorithm to efficiently compute the power.

## Solutions

### 1. Best Optimized Solution - Binary Exponentiation (Iterative)

Use the binary exponentiation algorithm to efficiently compute the power.

```python
def myPow(x, n):
    if n == 0:
        return 1
    
    if n < 0:
        x = 1 / x
        n = -n
    
    result = 1
    while n > 0:
        if n % 2 == 1:
            result *= x
        x *= x
        n //= 2
    
    return result
```

**Time Complexity:** O(log n) - We divide n by 2 in each iteration.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Binary Exponentiation (Recursive)

Use the binary exponentiation algorithm recursively to compute the power.

```python
def myPow(x, n):
    if n == 0:
        return 1
    
    if n < 0:
        return 1 / myPow(x, -n)
    
    if n % 2 == 0:
        return myPow(x * x, n // 2)
    else:
        return x * myPow(x, n - 1)
```

**Time Complexity:** O(log n) - We divide n by 2 in each recursive call.
**Space Complexity:** O(log n) - The recursion stack can go up to log n levels deep.

### 3. Alternative Solution - Brute Force

Multiply x by itself n times.

```python
def myPow(x, n):
    if n == 0:
        return 1
    
    if n < 0:
        x = 1 / x
        n = -n
    
    result = 1
    for _ in range(n):
        result *= x
    
    return result
```

**Time Complexity:** O(n) - We multiply x by itself n times.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Binary Exponentiation (Iterative) solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(log n) time complexity and O(1) space complexity, which is optimal for this problem.

2. **Robustness**: It handles edge cases like n = 0 and n < 0 correctly.

3. **Simplicity**: It's an iterative solution that avoids the overhead of recursion.

The key insight of this approach is to use the binary exponentiation algorithm, which is based on the fact that any power can be expressed as a sum of powers of 2. For example, x^10 = x^8 * x^2, where 10 = 8 + 2 in binary (1010). This allows us to compute the power in O(log n) time by repeatedly squaring x and multiplying the result by x when the corresponding bit in the binary representation of n is 1.

For example, let's trace through the algorithm for x = 2, n = 10:

1. Initialize result = 1, x = 2, n = 10

2. Iterate while n > 0:
   - n = 10 (binary: 1010), n % 2 = 0, so skip
   - x = x * x = 2 * 2 = 4, n = n // 2 = 5
   - n = 5 (binary: 101), n % 2 = 1, so result = result * x = 1 * 4 = 4
   - x = x * x = 4 * 4 = 16, n = n // 2 = 2
   - n = 2 (binary: 10), n % 2 = 0, so skip
   - x = x * x = 16 * 16 = 256, n = n // 2 = 1
   - n = 1 (binary: 1), n % 2 = 1, so result = result * x = 4 * 256 = 1024
   - x = x * x = 256 * 256 = 65536, n = n // 2 = 0
   - n = 0, so break

3. Return result = 1024

For x = 2, n = -2:

1. Since n < 0, set x = 1 / x = 1 / 2 = 0.5, n = -(-2) = 2

2. Initialize result = 1, x = 0.5, n = 2

3. Iterate while n > 0:
   - n = 2 (binary: 10), n % 2 = 0, so skip
   - x = x * x = 0.5 * 0.5 = 0.25, n = n // 2 = 1
   - n = 1 (binary: 1), n % 2 = 1, so result = result * x = 1 * 0.25 = 0.25
   - x = x * x = 0.25 * 0.25 = 0.0625, n = n // 2 = 0
   - n = 0, so break

4. Return result = 0.25

The Binary Exponentiation (Recursive) solution (Solution 2) is also efficient but uses more space due to the recursion stack. The Brute Force solution (Solution 3) is simple but inefficient for large values of n.

In an interview, I would first mention the Binary Exponentiation (Iterative) solution as the most efficient approach for this problem, and then discuss the Binary Exponentiation (Recursive) solution as an alternative if asked for a different approach. I would also mention the Brute Force solution as a baseline for comparison.
