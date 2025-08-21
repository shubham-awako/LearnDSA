# Number of 1 Bits

## Problem Statement

Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).

**Note:**
- Note that in some languages, such as Java, there is no unsigned integer type. In this case, the input will be given as a signed integer type. It should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
- In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 3, the input represents the signed integer `-3`.

**Example 1:**
```
Input: n = 00000000000000000000000000001011
Output: 3
Explanation: The input binary string 00000000000000000000000000001011 has a total of three '1' bits.
```

**Example 2:**
```
Input: n = 00000000000000000000000010000000
Output: 1
Explanation: The input binary string 00000000000000000000000010000000 has a total of one '1' bit.
```

**Example 3:**
```
Input: n = 11111111111111111111111111111101
Output: 31
Explanation: The input binary string 11111111111111111111111111111101 has a total of thirty one '1' bits.
```

**Constraints:**
- The input must be a binary string of length 32.

## Concept Overview

This problem involves counting the number of '1' bits in a binary representation of an integer. There are several approaches to solve this problem, including using bit manipulation techniques.

## Solutions

### 1. Best Optimized Solution - Brian Kernighan's Algorithm

Use Brian Kernighan's algorithm to count the number of '1' bits.

```python
def hammingWeight(n):
    count = 0
    while n:
        n &= (n - 1)
        count += 1
    return count
```

**Time Complexity:** O(k) - Where k is the number of '1' bits in the binary representation of n.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Bit Shifting

Use bit shifting to check each bit of the number.

```python
def hammingWeight(n):
    count = 0
    while n:
        count += n & 1
        n >>= 1
    return count
```

**Time Complexity:** O(log n) - We check each bit of the number, and there are log n bits.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 3. Alternative Solution - Built-in Function

Use the built-in function to count the number of '1' bits.

```python
def hammingWeight(n):
    return bin(n).count('1')
```

**Time Complexity:** O(log n) - The bin function converts the number to a binary string, which takes O(log n) time.
**Space Complexity:** O(log n) - We create a binary string of length log n.

## Solution Choice and Explanation

The Brian Kernighan's Algorithm solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(k) time complexity, where k is the number of '1' bits in the binary representation of n. This is more efficient than the O(log n) time complexity of the other solutions when n has few '1' bits.

2. **Elegance**: It's a clever bit manipulation technique that efficiently counts the number of '1' bits.

3. **Space Efficiency**: It uses O(1) extra space, which is optimal for this problem.

The key insight of this approach is to use the expression `n & (n - 1)` to clear the rightmost '1' bit in n. By repeatedly applying this operation and counting the number of times we need to apply it until n becomes 0, we get the number of '1' bits in n.

For example, let's trace through the algorithm for n = 11 (binary: 1011):

1. Initialize count = 0

2. Iterate while n != 0:
   - n = 11 (binary: 1011)
   - n - 1 = 10 (binary: 1010)
   - n & (n - 1) = 1011 & 1010 = 1010 (binary)
   - n = 10 (binary: 1010)
   - count = 1
   
   - n = 10 (binary: 1010)
   - n - 1 = 9 (binary: 1001)
   - n & (n - 1) = 1010 & 1001 = 1000 (binary)
   - n = 8 (binary: 1000)
   - count = 2
   
   - n = 8 (binary: 1000)
   - n - 1 = 7 (binary: 0111)
   - n & (n - 1) = 1000 & 0111 = 0000 (binary)
   - n = 0
   - count = 3

3. Return count = 3

For n = 128 (binary: 10000000):

1. Initialize count = 0

2. Iterate while n != 0:
   - n = 128 (binary: 10000000)
   - n - 1 = 127 (binary: 01111111)
   - n & (n - 1) = 10000000 & 01111111 = 00000000 (binary)
   - n = 0
   - count = 1

3. Return count = 1

The Bit Shifting solution (Solution 2) is also efficient but may be slower for numbers with many '1' bits. The Built-in Function solution (Solution 3) is the simplest but may not be allowed in an interview setting and uses more space.

In an interview, I would first mention the Brian Kernighan's Algorithm solution as the most efficient approach for this problem, and then discuss the Bit Shifting and Built-in Function solutions as alternatives if asked for different approaches.
