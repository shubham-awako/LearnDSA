# Missing Number

## Problem Statement

Given an array `nums` containing `n` distinct numbers in the range `[0, n]`, return the only number in the range that is missing from the array.

**Example 1:**
```
Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
```

**Example 2:**
```
Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
```

**Example 3:**
```
Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
```

**Constraints:**
- `n == nums.length`
- `1 <= n <= 10^4`
- `0 <= nums[i] <= n`
- All the numbers of `nums` are unique.

**Follow up:** Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?

## Concept Overview

This problem involves finding the missing number in an array containing n distinct numbers in the range [0, n]. There are several approaches to solve this problem, including using bit manipulation techniques.

## Solutions

### 1. Best Optimized Solution - XOR Operation

Use the XOR operation to find the missing number.

```python
def missingNumber(nums):
    result = len(nums)
    for i in range(len(nums)):
        result ^= i ^ nums[i]
    return result
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Sum Formula

Use the formula for the sum of the first n natural numbers to find the missing number.

```python
def missingNumber(nums):
    n = len(nums)
    expected_sum = n * (n + 1) // 2
    actual_sum = sum(nums)
    return expected_sum - actual_sum
```

**Time Complexity:** O(n) - We iterate through the array once to calculate the sum.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 3. Alternative Solution - Binary Search

Sort the array and use binary search to find the missing number.

```python
def missingNumber(nums):
    nums.sort()
    left, right = 0, len(nums)
    
    while left < right:
        mid = (left + right) // 2
        if nums[mid] > mid:
            right = mid
        else:
            left = mid + 1
    
    return left
```

**Time Complexity:** O(n log n) - Sorting the array takes O(n log n) time.
**Space Complexity:** O(1) - We only use a constant amount of extra space (excluding the space used for sorting).

## Solution Choice and Explanation

The XOR Operation solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity and O(1) space complexity, which is optimal for this problem.

2. **Elegance**: It's a clever application of the XOR operation.

3. **Meets Requirements**: It satisfies the follow-up requirement of using only O(1) extra space complexity and O(n) runtime complexity.

The key insight of this approach is to use the XOR operation, which has the following properties:
- XOR of a number with itself is 0: `a ^ a = 0`
- XOR of a number with 0 is the number itself: `a ^ 0 = a`
- XOR is commutative and associative: `a ^ b = b ^ a` and `(a ^ b) ^ c = a ^ (b ^ c)`

By XORing all numbers in the array and all numbers in the range [0, n], the numbers that appear in both will cancel out (because `a ^ a = 0`), and we'll be left with the missing number.

For example, let's trace through the algorithm for nums = [3,0,1]:

1. Initialize result = len(nums) = 3

2. Iterate through the array:
   - i = 0:
     - result = 3 ^ 0 ^ 3 = 0
   - i = 1:
     - result = 0 ^ 1 ^ 0 = 1
   - i = 2:
     - result = 1 ^ 2 ^ 1 = 2

3. Return result = 2

For nums = [0,1]:

1. Initialize result = len(nums) = 2

2. Iterate through the array:
   - i = 0:
     - result = 2 ^ 0 ^ 0 = 2
   - i = 1:
     - result = 2 ^ 1 ^ 1 = 2

3. Return result = 2

The Sum Formula solution (Solution 2) is also efficient and may be more intuitive for some people. The Binary Search solution (Solution 3) is less efficient due to the sorting step.

In an interview, I would first mention the XOR Operation solution as the most efficient approach for this problem, and then discuss the Sum Formula solution as an alternative if asked for a different approach. I would also mention the Binary Search solution as a baseline for comparison.
