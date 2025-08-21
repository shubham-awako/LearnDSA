# Majority Element

## Problem Statement

Given an array `nums` of size `n`, return the majority element.

The majority element is the element that appears more than `⌊n / 2⌋` times. You may assume that the majority element always exists in the array.

**Example 1:**
```
Input: nums = [3,2,3]
Output: 3
```

**Example 2:**
```
Input: nums = [2,2,1,1,1,2,2]
Output: 2
```

**Constraints:**
- `n == nums.length`
- `1 <= n <= 5 * 10^4`
- `-10^9 <= nums[i] <= 10^9`

**Follow-up:** Could you solve the problem in linear time and in O(1) space?

## Concept Overview

The majority element is defined as the element that appears more than ⌊n/2⌋ times in an array of size n. This problem tests your ability to efficiently find such an element, which is guaranteed to exist.

## Solutions

### 1. Brute Force Approach - Count Occurrences

Check each element and count its occurrences in the array.

```python
def majorityElement(nums):
    n = len(nums)
    majority_count = n // 2
    
    for num in nums:
        count = 0
        for x in nums:
            if x == num:
                count += 1
        
        if count > majority_count:
            return num
    
    return -1  # No majority element found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n²) - For each element, we count its occurrences in the array.
**Space Complexity:** O(1) - No extra space is used.

### 2. Improved Solution - Hash Map

Use a hash map to count the occurrences of each element in a single pass.

```python
def majorityElement(nums):
    counts = {}
    n = len(nums)
    majority_count = n // 2
    
    for num in nums:
        counts[num] = counts.get(num, 0) + 1
        if counts[num] > majority_count:
            return num
    
    return -1  # No majority element found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - In the worst case, we store counts for all unique elements.

### 3. Best Optimized Solution - Boyer-Moore Voting Algorithm

Use the Boyer-Moore voting algorithm to find the majority element in a single pass with constant space.

```python
def majorityElement(nums):
    count = 0
    candidate = None
    
    for num in nums:
        if count == 0:
            candidate = num
        
        count += 1 if num == candidate else -1
    
    return candidate
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We only use two variables regardless of input size.

### 4. Alternative Solution - Sorting

Sort the array and return the middle element, which will be the majority element.

```python
def majorityElement(nums):
    nums.sort()
    return nums[len(nums) // 2]
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) or O(n) - Depending on the sorting implementation.

## Solution Choice and Explanation

The Boyer-Moore Voting Algorithm (Solution 3) is the best solution for this problem because:

1. **Optimal Time and Space Complexity**: It achieves O(n) time complexity and O(1) space complexity, meeting the follow-up challenge.

2. **Single Pass**: It only requires one pass through the array, making it efficient.

3. **Elegant Algorithm**: It's based on the observation that if we cancel out each occurrence of an element with all other elements, the majority element will remain.

The hash map solution (Solution 2) is also efficient with O(n) time complexity but uses O(n) space. The sorting solution (Solution 4) is simple but has a higher time complexity of O(n log n).

The Boyer-Moore Voting Algorithm works because the majority element appears more than n/2 times, so even after canceling out all occurrences of other elements, the majority element will have a positive count.

In an interview, I would first mention the hash map approach for its simplicity and then introduce the Boyer-Moore Voting Algorithm as the optimal solution that meets the follow-up challenge of O(1) space complexity.
