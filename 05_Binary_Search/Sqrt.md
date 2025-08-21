# Sqrt(x)

## Problem Statement

Given a non-negative integer `x`, return the square root of `x` rounded down to the nearest integer. The returned integer should be non-negative as well.

You must not use any built-in exponent function or operator.

For example, do not use `pow(x, 0.5)` in c++ or `x ** 0.5` in python.

**Example 1:**
```
Input: x = 4
Output: 2
Explanation: The square root of 4 is 2, so we return 2.
```

**Example 2:**
```
Input: x = 8
Output: 2
Explanation: The square root of 8 is 2.82842..., and since we round it down to the nearest integer, 2 is returned.
```

**Constraints:**
- `0 <= x <= 2^31 - 1`

## Concept Overview

This problem asks us to find the integer square root of a number without using built-in functions. The key insight is to use binary search to efficiently find the largest integer whose square is less than or equal to x.

## Solutions

### 1. Brute Force Approach - Linear Search

Iterate from 0 to x and find the largest integer whose square is less than or equal to x.

```python
def mySqrt(x):
    if x == 0:
        return 0
    
    i = 1
    while i * i <= x:
        i += 1
    
    return i - 1
```

**Time Complexity:** O(sqrt(x)) - We iterate up to the square root of x.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - Binary Search

Use binary search to efficiently find the square root.

```python
def mySqrt(x):
    if x == 0:
        return 0
    
    left, right = 1, x
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if mid * mid == x:
            return mid
        elif mid * mid < x:
            left = mid + 1
        else:
            right = mid - 1
    
    # When the loop ends, right is the largest integer whose square is less than or equal to x
    return right
```

**Time Complexity:** O(log x) - The search space is halved in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Newton's Method

Use Newton's method for finding square roots, which converges quadratically.

```python
def mySqrt(x):
    if x == 0:
        return 0
    
    # Start with an initial guess
    guess = x
    
    # Apply Newton's method: x_{n+1} = (x_n + a/x_n) / 2
    while guess * guess > x:
        guess = (guess + x // guess) // 2
    
    return guess
```

**Time Complexity:** O(log x) - Newton's method converges quadratically.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 4. Alternative Solution - Bit Manipulation

Use bit manipulation to find the square root.

```python
def mySqrt(x):
    if x == 0:
        return 0
    
    # Find the highest bit in the square root
    h = 0
    while (1 << h) * (1 << h) <= x:
        h += 1
    h -= 1
    
    # Compute the square root bit by bit
    result = 1 << h
    for i in range(h - 1, -1, -1):
        if (result | (1 << i)) * (result | (1 << i)) <= x:
            result |= (1 << i)
    
    return result
```

**Time Complexity:** O(log x) - We process each bit of the square root.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log x) time complexity, which is efficient for large values of x.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Robustness**: It handles all cases correctly, including edge cases.

The key insight of this solution is to use binary search to efficiently find the largest integer whose square is less than or equal to x. We maintain a search range [left, right] and repeatedly narrow it down:
- If mid * mid == x, we've found the exact square root.
- If mid * mid < x, the square root must be in the range [mid+1, right].
- If mid * mid > x, the square root must be in the range [left, mid-1].

When the loop ends, right is the largest integer whose square is less than or equal to x, which is the integer square root of x.

For example, let's find the square root of 8:
1. left = 1, right = 8, mid = 4, mid * mid = 16 > 8
2. left = 1, right = 3, mid = 2, mid * mid = 4 < 8
3. left = 3, right = 3, mid = 3, mid * mid = 9 > 8
4. left = 3, right = 2 (loop ends)
5. Return right = 2

Newton's method (Solution 3) is also efficient with O(log x) time complexity and is often faster in practice, but it's more complex to understand and implement correctly. The bit manipulation approach (Solution 4) is elegant but more complex and may not be as intuitive.

In an interview, I would first mention the binary search approach as the most straightforward and efficient solution for this problem.
