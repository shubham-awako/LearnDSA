# Single Number

## Problem Statement

Given a non-empty array of integers `nums`, every element appears twice except for one. Find that single one.

You must implement a solution with a linear runtime complexity and use only constant extra space.

**Example 1:**
```
Input: nums = [2,2,1]
Output: 1
```

**Example 2:**
```
Input: nums = [4,1,2,1,2]
Output: 4
```

**Example 3:**
```
Input: nums = [1]
Output: 1
```

**Constraints:**
- `1 <= nums.length <= 3 * 10^4`
- `-3 * 10^4 <= nums[i] <= 3 * 10^4`
- Each element in the array appears twice except for one element which appears only once.

## Concept Overview

This problem can be solved using the XOR operation. The key insight is that XOR of a number with itself is 0, and XOR of a number with 0 is the number itself.

## Solutions

### 1. Best Optimized Solution - XOR Operation

Use the XOR operation to find the single number.

```python
def singleNumber(nums):
    result = 0
    for num in nums:
        result ^= num
    return result
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Hash Map

Use a hash map to keep track of the count of each number.

```python
def singleNumber(nums):
    count = {}
    for num in nums:
        count[num] = count.get(num, 0) + 1
    
    for num, freq in count.items():
        if freq == 1:
            return num
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We use a hash map to store the count of each number.

### 3. Alternative Solution - Sorting

Sort the array and compare adjacent elements.

```python
def singleNumber(nums):
    nums.sort()
    
    i = 0
    while i < len(nums) - 1:
        if nums[i] != nums[i + 1]:
            return nums[i]
        i += 2
    
    return nums[-1]
```

**Time Complexity:** O(n log n) - Sorting the array takes O(n log n) time.
**Space Complexity:** O(1) - We only use a constant amount of extra space (excluding the space used for sorting).

## Solution Choice and Explanation

The XOR Operation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity and O(1) space complexity, which is optimal for this problem.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Meets Requirements**: It satisfies the requirement of using only constant extra space.

The key insight of this approach is to use the XOR operation, which has the following properties:
- XOR of a number with itself is 0: `a ^ a = 0`
- XOR of a number with 0 is the number itself: `a ^ 0 = a`
- XOR is commutative and associative: `a ^ b = b ^ a` and `(a ^ b) ^ c = a ^ (b ^ c)`

By XORing all numbers in the array, the numbers that appear twice will cancel out (because `a ^ a = 0`), and we'll be left with the single number.

For example, let's trace through the algorithm for nums = [4,1,2,1,2]:

1. Initialize result = 0

2. Iterate through the array:
   - result = 0 ^ 4 = 4
   - result = 4 ^ 1 = 5
   - result = 5 ^ 2 = 7
   - result = 7 ^ 1 = 6
   - result = 6 ^ 2 = 4

3. Return result = 4

For nums = [2,2,1]:

1. Initialize result = 0

2. Iterate through the array:
   - result = 0 ^ 2 = 2
   - result = 2 ^ 2 = 0
   - result = 0 ^ 1 = 1

3. Return result = 1

The Hash Map solution (Solution 2) is also efficient in terms of time complexity but uses O(n) extra space. The Sorting solution (Solution 3) is less efficient in terms of time complexity and may use extra space for sorting.

In an interview, I would first mention the XOR Operation solution as the most efficient approach for this problem, and then discuss the Hash Map and Sorting solutions as alternatives if asked for different approaches.
