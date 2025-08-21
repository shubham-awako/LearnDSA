# Reverse Integer

## Problem Statement

Given a signed 32-bit integer `x`, return `x` with its digits reversed. If reversing `x` causes the value to go outside the signed 32-bit integer range `[-2^31, 2^31 - 1]`, then return `0`.

**Assume the environment does not allow you to store 64-bit integers (signed or unsigned).**

**Example 1:**
```
Input: x = 123
Output: 321
```

**Example 2:**
```
Input: x = -123
Output: -321
```

**Example 3:**
```
Input: x = 120
Output: 21
```

**Constraints:**
- `-2^31 <= x <= 2^31 - 1`

## Concept Overview

This problem involves reversing the digits of an integer while handling overflow and negative numbers. The key insight is to build the reversed integer digit by digit and check for overflow at each step.

## Solutions

### 1. Best Optimized Solution - Digit-by-Digit Reversal

Reverse the integer digit by digit while checking for overflow.

```python
def reverse(x):
    # Handle the sign
    sign = 1 if x >= 0 else -1
    x = abs(x)
    
    # Reverse the digits
    reversed_x = 0
    while x > 0:
        # Check for overflow before adding the next digit
        if reversed_x > (2**31 - 1) // 10:
            return 0
        
        digit = x % 10
        reversed_x = reversed_x * 10 + digit
        x //= 10
    
    return sign * reversed_x
```

**Time Complexity:** O(log n) - We process each digit of the integer, and there are log n digits.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Convert to String

Convert the integer to a string, reverse it, and convert it back to an integer.

```python
def reverse(x):
    # Handle the sign
    sign = 1 if x >= 0 else -1
    x = abs(x)
    
    # Convert to string, reverse, and convert back to integer
    reversed_str = str(x)[::-1]
    reversed_x = int(reversed_str)
    
    # Check for overflow
    if reversed_x > 2**31 - 1:
        return 0
    
    return sign * reversed_x
```

**Time Complexity:** O(log n) - We process each digit of the integer, and there are log n digits.
**Space Complexity:** O(log n) - We create a string of length log n.

### 3. Alternative Solution - Mathematical Approach

Use mathematical operations to reverse the integer while checking for overflow.

```python
def reverse(x):
    # Initialize the result
    result = 0
    
    # Handle the sign
    sign = 1 if x >= 0 else -1
    x = abs(x)
    
    # Reverse the digits
    while x > 0:
        # Extract the last digit
        digit = x % 10
        
        # Check for overflow
        if result > (2**31 - 1 - digit) // 10:
            return 0
        
        # Append the digit to the result
        result = result * 10 + digit
        
        # Remove the last digit from x
        x //= 10
    
    return sign * result
```

**Time Complexity:** O(log n) - We process each digit of the integer, and there are log n digits.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Digit-by-Digit Reversal solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(log n) time complexity and O(1) space complexity, which is optimal for this problem.

2. **Simplicity**: It's straightforward to understand and implement.

3. **Robustness**: It handles overflow and negative numbers correctly.

The key insight of this approach is to build the reversed integer digit by digit while checking for overflow at each step. We extract the last digit of the input integer, append it to the reversed integer, and then remove the last digit from the input integer. We repeat this process until the input integer becomes 0.

For example, let's trace through the algorithm for x = 123:

1. Initialize sign = 1 (since x >= 0), x = 123, reversed_x = 0

2. Iterate while x > 0:
   - digit = 123 % 10 = 3
   - reversed_x = 0 * 10 + 3 = 3
   - x = 123 // 10 = 12
   
   - digit = 12 % 10 = 2
   - reversed_x = 3 * 10 + 2 = 32
   - x = 12 // 10 = 1
   
   - digit = 1 % 10 = 1
   - reversed_x = 32 * 10 + 1 = 321
   - x = 1 // 10 = 0
   - Since x = 0, break the loop

3. Return sign * reversed_x = 1 * 321 = 321

For x = -123:

1. Initialize sign = -1 (since x < 0), x = 123, reversed_x = 0

2. Iterate while x > 0:
   - digit = 123 % 10 = 3
   - reversed_x = 0 * 10 + 3 = 3
   - x = 123 // 10 = 12
   
   - digit = 12 % 10 = 2
   - reversed_x = 3 * 10 + 2 = 32
   - x = 12 // 10 = 1
   
   - digit = 1 % 10 = 1
   - reversed_x = 32 * 10 + 1 = 321
   - x = 1 // 10 = 0
   - Since x = 0, break the loop

3. Return sign * reversed_x = -1 * 321 = -321

For x = 120:

1. Initialize sign = 1 (since x >= 0), x = 120, reversed_x = 0

2. Iterate while x > 0:
   - digit = 120 % 10 = 0
   - reversed_x = 0 * 10 + 0 = 0
   - x = 120 // 10 = 12
   
   - digit = 12 % 10 = 2
   - reversed_x = 0 * 10 + 2 = 2
   - x = 12 // 10 = 1
   
   - digit = 1 % 10 = 1
   - reversed_x = 2 * 10 + 1 = 21
   - x = 1 // 10 = 0
   - Since x = 0, break the loop

3. Return sign * reversed_x = 1 * 21 = 21

The Convert to String solution (Solution 2) is also efficient but uses more space and may not be allowed in an interview setting. The Mathematical Approach solution (Solution 3) is similar to the Digit-by-Digit Reversal solution but with a slightly different overflow check.

In an interview, I would first mention the Digit-by-Digit Reversal solution as the most efficient approach for this problem, and then discuss the Convert to String and Mathematical Approach solutions as alternatives if asked for different approaches.

Note: The overflow check in the Digit-by-Digit Reversal solution is crucial. Before appending a new digit to the reversed integer, we check if the current reversed integer is greater than (2^31 - 1) // 10. If it is, then appending any digit would cause an overflow, so we return 0.
