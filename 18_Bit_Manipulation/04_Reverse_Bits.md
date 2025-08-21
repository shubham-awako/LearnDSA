# Reverse Bits

## Problem Statement

Reverse bits of a given 32 bits unsigned integer.

**Note:**
- Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
- In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 2 above, the input represents the signed integer `-3` and the output represents the signed integer `-1073741825`.

**Example 1:**
```
Input: n = 00000010100101000001111010011100
Output:    00111001011110000010100101000000
Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.
```

**Example 2:**
```
Input: n = 11111111111111111111111111111101
Output:    10111111111111111111111111111111
Explanation: The input binary string 11111111111111111111111111111101 represents the unsigned integer 4294967293, so return 3221225471 which its binary representation is 10111111111111111111111111111111.
```

**Constraints:**
- The input must be a binary string of length 32

## Concept Overview

This problem involves reversing the bits of a 32-bit unsigned integer. There are several approaches to solve this problem, including using bit manipulation techniques.

## Solutions

### 1. Best Optimized Solution - Bit by Bit Reversal

Reverse the bits of the integer bit by bit.

```python
def reverseBits(n):
    result = 0
    for i in range(32):
        result = (result << 1) | (n & 1)
        n >>= 1
    return result
```

**Time Complexity:** O(1) - We perform a fixed number of operations (32).
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Divide and Conquer

Use a divide and conquer approach to reverse the bits.

```python
def reverseBits(n):
    # Swap adjacent bits
    n = ((n & 0xaaaaaaaa) >> 1) | ((n & 0x55555555) << 1)
    # Swap adjacent pairs of bits
    n = ((n & 0xcccccccc) >> 2) | ((n & 0x33333333) << 2)
    # Swap adjacent nibbles
    n = ((n & 0xf0f0f0f0) >> 4) | ((n & 0x0f0f0f0f) << 4)
    # Swap adjacent bytes
    n = ((n & 0xff00ff00) >> 8) | ((n & 0x00ff00ff) << 8)
    # Swap adjacent 16-bit blocks
    n = ((n & 0xffff0000) >> 16) | ((n & 0x0000ffff) << 16)
    return n
```

**Time Complexity:** O(1) - We perform a fixed number of operations.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 3. Alternative Solution - Using Built-in Functions

Use built-in functions to reverse the bits.

```python
def reverseBits(n):
    # Convert to binary string, remove '0b' prefix, pad to 32 bits, reverse, and convert back to integer
    return int(bin(n)[2:].zfill(32)[::-1], 2)
```

**Time Complexity:** O(1) - We perform a fixed number of operations.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Bit by Bit Reversal solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(1) time complexity and O(1) space complexity, which is optimal for this problem.

2. **Simplicity**: It's straightforward to understand and implement.

3. **Generality**: It works for any 32-bit unsigned integer.

The key insight of this approach is to iterate through the 32 bits of the input integer from right to left (least significant bit to most significant bit), and for each bit, shift the result left by 1 and set its least significant bit to the current bit of the input integer.

For example, let's trace through the algorithm for n = 43261596 (binary: 00000010100101000001111010011100):

1. Initialize result = 0

2. Iterate from i = 0 to 31:
   - i = 0:
     - result = (0 << 1) | (43261596 & 1) = 0 | 0 = 0
     - n = 43261596 >> 1 = 21630798
   - i = 1:
     - result = (0 << 1) | (21630798 & 1) = 0 | 0 = 0
     - n = 21630798 >> 1 = 10815399
   - i = 2:
     - result = (0 << 1) | (10815399 & 1) = 0 | 1 = 1
     - n = 10815399 >> 1 = 5407699
   - i = 3:
     - result = (1 << 1) | (5407699 & 1) = 2 | 1 = 3
     - n = 5407699 >> 1 = 2703849
   - ... (continue for all 32 bits)

3. Return result = 964176192

The Divide and Conquer solution (Solution 2) is also efficient but may be less intuitive. The Using Built-in Functions solution (Solution 3) is the simplest but may not be allowed in an interview setting.

In an interview, I would first mention the Bit by Bit Reversal solution as the most intuitive approach for this problem, and then discuss the Divide and Conquer and Using Built-in Functions solutions as alternatives if asked for different approaches.

Let's also understand the Divide and Conquer solution (Solution 2) in more detail:

The key insight of this approach is to swap adjacent groups of bits in a divide-and-conquer manner. We start by swapping adjacent bits, then adjacent pairs of bits, then adjacent nibbles (4 bits), then adjacent bytes (8 bits), and finally adjacent 16-bit blocks.

For example, to swap adjacent bits, we use the following operations:
- Extract the even-indexed bits using the mask 0xaaaaaaaa (binary: 10101010...) and shift them right by 1.
- Extract the odd-indexed bits using the mask 0x55555555 (binary: 01010101...) and shift them left by 1.
- Combine the results using the OR operation.

Similarly, we swap adjacent pairs of bits, nibbles, bytes, and 16-bit blocks using appropriate masks and shifts.

This approach is more efficient than the Bit by Bit Reversal solution in terms of the number of operations (5 operations instead of 32), but it may be less intuitive and harder to implement correctly.
