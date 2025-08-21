# Plus One

## Problem Statement

You are given a large integer represented as an integer array `digits`, where each `digits[i]` is the `i`th digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

Increment the large integer by one and return the resulting array of digits.

**Example 1:**
```
Input: digits = [1,2,3]
Output: [1,2,4]
Explanation: The array represents the integer 123.
Incrementing by one gives 123 + 1 = 124.
Thus, the result should be [1,2,4].
```

**Example 2:**
```
Input: digits = [4,3,2,1]
Output: [4,3,2,2]
Explanation: The array represents the integer 4321.
Incrementing by one gives 4321 + 1 = 4322.
Thus, the result should be [4,3,2,2].
```

**Example 3:**
```
Input: digits = [9]
Output: [1,0]
Explanation: The array represents the integer 9.
Incrementing by one gives 9 + 1 = 10.
Thus, the result should be [1,0].
```

**Constraints:**
- `1 <= digits.length <= 100`
- `0 <= digits[i] <= 9`
- `digits` does not contain any leading 0's.

## Concept Overview

This problem involves incrementing a large integer represented as an array of digits. The key insight is to handle the carry when incrementing a digit results in a value greater than 9.

## Solutions

### 1. Best Optimized Solution - Iterative Approach

Iterate through the array from right to left and handle the carry.

```python
def plusOne(digits):
    n = len(digits)
    
    # Start from the least significant digit
    for i in range(n - 1, -1, -1):
        # Increment the current digit
        digits[i] += 1
        
        # If the digit becomes 10, set it to 0 and carry the 1 to the next digit
        if digits[i] == 10:
            digits[i] = 0
        else:
            # If there's no carry, we can return immediately
            return digits
    
    # If we reach here, it means all digits were 9, so we need to add a leading 1
    return [1] + digits
```

**Time Complexity:** O(n) - In the worst case, we need to iterate through all digits.
**Space Complexity:** O(1) - We only use a constant amount of extra space (excluding the output array).

### 2. Alternative Solution - Recursive Approach

Use recursion to handle the carry.

```python
def plusOne(digits):
    def helper(index):
        # Base case: if we've gone beyond the most significant digit
        if index < 0:
            return [1]
        
        # Increment the current digit
        digits[index] += 1
        
        # If the digit becomes 10, set it to 0 and carry the 1 to the next digit
        if digits[index] == 10:
            digits[index] = 0
            # Recursively handle the carry
            if index > 0:
                return helper(index - 1)
            else:
                return [1] + digits
        
        return digits
    
    return helper(len(digits) - 1)
```

**Time Complexity:** O(n) - In the worst case, we need to recursively process all digits.
**Space Complexity:** O(n) - The recursion stack can go up to n levels deep.

### 3. Alternative Solution - Convert to Integer

Convert the array to an integer, increment it, and then convert it back to an array.

```python
def plusOne(digits):
    # Convert the array to an integer
    num = 0
    for digit in digits:
        num = num * 10 + digit
    
    # Increment the integer
    num += 1
    
    # Convert the integer back to an array
    result = []
    while num > 0:
        result.insert(0, num % 10)
        num //= 10
    
    return result
```

**Time Complexity:** O(n) - We iterate through the array once to convert it to an integer and once to convert it back to an array.
**Space Complexity:** O(n) - We create a new array to store the result.

## Solution Choice and Explanation

The Iterative Approach solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Robustness**: It can handle very large integers that might overflow if converted to an integer.

The key insight of this approach is to iterate through the array from right to left (from the least significant digit to the most significant digit) and handle the carry when incrementing a digit results in a value greater than 9. If a digit becomes 10 after incrementing, we set it to 0 and carry the 1 to the next digit. If there's no carry, we can return immediately. If all digits were 9, we need to add a leading 1.

For example, let's trace through the algorithm for digits = [1,2,3]:

1. Start from the least significant digit: i = 2, digits[2] = 3
2. Increment digits[2]: digits[2] = 3 + 1 = 4
3. Since digits[2] != 10, return digits = [1,2,4]

For digits = [4,3,2,1]:

1. Start from the least significant digit: i = 3, digits[3] = 1
2. Increment digits[3]: digits[3] = 1 + 1 = 2
3. Since digits[3] != 10, return digits = [4,3,2,2]

For digits = [9]:

1. Start from the least significant digit: i = 0, digits[0] = 9
2. Increment digits[0]: digits[0] = 9 + 1 = 10
3. Since digits[0] = 10, set digits[0] = 0
4. Since i = 0, we've processed all digits and still have a carry, so return [1] + digits = [1,0]

For digits = [9,9,9]:

1. Start from the least significant digit: i = 2, digits[2] = 9
2. Increment digits[2]: digits[2] = 9 + 1 = 10
3. Since digits[2] = 10, set digits[2] = 0 and continue
4. i = 1, digits[1] = 9
5. Increment digits[1]: digits[1] = 9 + 1 = 10
6. Since digits[1] = 10, set digits[1] = 0 and continue
7. i = 0, digits[0] = 9
8. Increment digits[0]: digits[0] = 9 + 1 = 10
9. Since digits[0] = 10, set digits[0] = 0
10. Since i = 0, we've processed all digits and still have a carry, so return [1] + digits = [1,0,0,0]

The Recursive Approach solution (Solution 2) is also efficient but uses more space due to the recursion stack. The Convert to Integer solution (Solution 3) is simple but has limitations when dealing with very large integers that might overflow.

In an interview, I would first mention the Iterative Approach solution as the most efficient and robust approach for this problem, and then discuss the Recursive Approach and Convert to Integer solutions as alternatives if asked for different approaches.
