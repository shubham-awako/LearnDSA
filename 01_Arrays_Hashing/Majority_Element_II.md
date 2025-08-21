# Majority Element II

## Problem Statement

Given an integer array `nums` of size `n`, return all elements that appear more than `⌊n/3⌋` times.

**Example 1:**
```
Input: nums = [3,2,3]
Output: [3]
```

**Example 2:**
```
Input: nums = [1]
Output: [1]
```

**Example 3:**
```
Input: nums = [1,2]
Output: [1,2]
```

**Constraints:**
- `1 <= nums.length <= 5 * 10^4`
- `-10^9 <= nums[i] <= 10^9`

**Follow-up:** Could you solve the problem in linear time and in O(1) space?

## Concept Overview

This problem is an extension of the Majority Element problem, where we need to find all elements that appear more than ⌊n/3⌋ times. The key insight is that there can be at most two such elements in any array.

## Solutions

### 1. Brute Force Approach - Counting

Count the occurrences of each element and return those that appear more than ⌊n/3⌋ times.

```python
def majorityElement(nums):
    threshold = len(nums) // 3
    counter = {}
    
    for num in nums:
        counter[num] = counter.get(num, 0) + 1
    
    return [num for num, count in counter.items() if count > threshold]
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - In the worst case, all elements are distinct.

### 2. Improved Solution - Sorting

Sort the array and count consecutive occurrences.

```python
def majorityElement(nums):
    n = len(nums)
    threshold = n // 3
    result = []
    
    if not nums:
        return result
    
    nums.sort()
    
    count = 1
    candidate = nums[0]
    
    for i in range(1, n):
        if nums[i] == candidate:
            count += 1
        else:
            if count > threshold:
                result.append(candidate)
            candidate = nums[i]
            count = 1
    
    # Check the last candidate
    if count > threshold:
        result.append(candidate)
    
    return result
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

### 3. Best Optimized Solution - Boyer-Moore Voting Algorithm

Extend the Boyer-Moore voting algorithm to find up to two majority elements.

```python
def majorityElement(nums):
    if not nums:
        return []
    
    # First pass: find candidates
    count1, count2 = 0, 0
    candidate1, candidate2 = None, None
    
    for num in nums:
        if candidate1 == num:
            count1 += 1
        elif candidate2 == num:
            count2 += 1
        elif count1 == 0:
            candidate1 = num
            count1 = 1
        elif count2 == 0:
            candidate2 = num
            count2 = 1
        else:
            count1 -= 1
            count2 -= 1
    
    # Second pass: count occurrences of candidates
    count1 = count2 = 0
    for num in nums:
        if num == candidate1:
            count1 += 1
        elif num == candidate2:
            count2 += 1
    
    # Check if candidates are majority elements
    result = []
    threshold = len(nums) // 3
    if count1 > threshold:
        result.append(candidate1)
    if count2 > threshold:
        result.append(candidate2)
    
    return result
```

**Time Complexity:** O(n) - We make two passes through the array.
**Space Complexity:** O(1) - We use a constant amount of extra space.

## Solution Choice and Explanation

The Boyer-Moore Voting Algorithm (Solution 3) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity with just two passes through the array.

2. **Optimal Space Complexity**: It uses O(1) extra space, meeting the follow-up challenge.

3. **Elegant Algorithm**: It extends the Boyer-Moore voting algorithm to handle multiple majority elements.

The key insight of this approach is that there can be at most two elements that appear more than ⌊n/3⌋ times in an array. This is because if there were three or more such elements, their total count would exceed n, which is impossible.

The algorithm works in two passes:
1. First pass: Identify up to two potential candidates using a modified Boyer-Moore voting algorithm.
2. Second pass: Count the actual occurrences of these candidates to verify if they are indeed majority elements.

The counting approach (Solution 1) is simple and works in O(n) time but uses O(n) space. The sorting approach (Solution 2) uses O(1) extra space but has a higher time complexity of O(n log n).

In an interview, I would first mention the counting approach for its simplicity, then explain the Boyer-Moore Voting Algorithm as the optimal solution that meets the follow-up challenge of O(1) space complexity.
