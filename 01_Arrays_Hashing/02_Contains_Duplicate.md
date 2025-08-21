# Contains Duplicate

## Problem Statement

Given an integer array `nums`, return `true` if any value appears at least twice in the array, and return `false` if every element is distinct.

**Example 1:**
```
Input: nums = [1,2,3,1]
Output: true
```

**Example 2:**
```
Input: nums = [1,2,3,4]
Output: false
```

**Example 3:**
```
Input: nums = [1,1,1,3,3,4,3,2,4,2]
Output: true
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-10^9 <= nums[i] <= 10^9`

## Concept Overview

This problem tests your understanding of detecting duplicates in an array. The key insight is to efficiently track elements we've already seen.

## Solutions

### 1. Brute Force Approach

Check each element against every other element in the array.

```python
def containsDuplicate(nums):
    n = len(nums)
    for i in range(n):
        for j in range(i + 1, n):
            if nums[i] == nums[j]:
                return True
    return False
```

**Time Complexity:** O(n²) - For each element, we check against all other elements.
**Space Complexity:** O(1) - No extra space is used.

### 2. Improved Solution - Sorting

Sort the array first, then check adjacent elements for duplicates.

```python
def containsDuplicate(nums):
    nums.sort()
    for i in range(1, len(nums)):
        if nums[i] == nums[i - 1]:
            return True
    return False
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we sort in-place (though some sorting algorithms may use O(n) space).

### 3. Best Optimized Solution - Hash Set

Use a hash set to track seen elements for O(1) lookups.

```python
def containsDuplicate(nums):
    seen = set()
    for num in nums:
        if num in seen:
            return True
        seen.add(num)
    return False
```

**Time Complexity:** O(n) - We iterate through the array once with O(1) operations per element.
**Space Complexity:** O(n) - In the worst case, we store all elements in the hash set.

## Solution Choice and Explanation

The hash set solution is the best approach for this problem because:

1. **Time Efficiency**: It achieves O(n) time complexity, which is optimal for this problem. We only need to scan the array once.

2. **Space-Time Tradeoff**: While it uses O(n) extra space, the significant improvement in time complexity from O(n²) to O(n) is worth the space cost.

3. **Early Termination**: The solution returns as soon as a duplicate is found, without needing to process the entire array in the best case.

The sorting approach is a reasonable alternative with O(n log n) time complexity, but the hash set solution is strictly better in terms of time complexity. The brute force approach is inefficient for large arrays and should be avoided.

For interviews, the hash set solution demonstrates your understanding of using appropriate data structures to optimize algorithms, which is a key skill for efficient problem-solving.
