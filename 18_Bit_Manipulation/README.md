# 18. Bit Manipulation

## Concept Overview

Bit manipulation involves performing operations on individual bits of a binary number. These operations can be used to solve various problems efficiently, often reducing time and space complexity compared to traditional approaches.

### Key Concepts

#### Basic Bit Operations
- **AND (&)**: Returns 1 if both bits are 1, otherwise 0
- **OR (|)**: Returns 1 if at least one bit is 1, otherwise 0
- **XOR (^)**: Returns 1 if exactly one bit is 1, otherwise 0
- **NOT (~)**: Flips all bits (0 becomes 1, 1 becomes 0)
- **Left Shift (<<)**: Shifts bits to the left, filling with 0s
- **Right Shift (>>)**: Shifts bits to the right, filling with the sign bit (arithmetic) or 0s (logical)

#### Common Bit Manipulation Techniques
- **Check if a bit is set**: `(num & (1 << pos)) != 0`
- **Set a bit**: `num |= (1 << pos)`
- **Clear a bit**: `num &= ~(1 << pos)`
- **Toggle a bit**: `num ^= (1 << pos)`
- **Get the value of the rightmost bit**: `num & -num`
- **Remove the rightmost bit**: `num & (num - 1)`
- **Check if a number is a power of 2**: `(num & (num - 1)) == 0`

### Common Patterns
- **Bit Masking**: Using bits to represent a set of boolean flags
- **Bit Counting**: Counting the number of set bits in a binary number
- **Bit Manipulation for Arithmetic**: Performing arithmetic operations using bit manipulation
- **Bit Manipulation for Optimization**: Using bit manipulation to optimize algorithms

### Common Applications
- **Optimizing Space Usage**: Using bits to represent a set of boolean flags
- **Fast Arithmetic Operations**: Performing arithmetic operations using bit manipulation
- **Data Compression**: Using bit manipulation to compress data
- **Error Detection and Correction**: Using bit manipulation to detect and correct errors in data
- **Cryptography**: Using bit manipulation in cryptographic algorithms

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Single Number | Easy | [Solution](./Single_Number.md) |
| 2 | Number of 1 Bits | Easy | [Solution](./Number_of_1_Bits.md) |
| 3 | Counting Bits | Easy | [Solution](./Counting_Bits.md) |
| 4 | Reverse Bits | Easy | [Solution](./Reverse_Bits.md) |
| 5 | Missing Number | Easy | [Solution](./Missing_Number.md) |
| 6 | Sum of Two Integers | Medium | [Solution](./Sum_of_Two_Integers.md) |
| 7 | Reverse Integer | Medium | [Solution](./Reverse_Integer.md) |
