# Median of Two Sorted Arrays

## Problem Statement

Given two sorted arrays `nums1` and `nums2` of size `m` and `n` respectively, return the median of the two sorted arrays.

The overall run time complexity should be O(log (m+n)).

**Example 1:**
```
Input: nums1 = [1,3], nums2 = [2]
Output: 2.00000
Explanation: merged array = [1,2,3] and median is 2.
```

**Example 2:**
```
Input: nums1 = [1,2], nums2 = [3,4]
Output: 2.50000
Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
```

**Constraints:**
- `nums1.length == m`
- `nums2.length == n`
- `0 <= m <= 1000`
- `0 <= n <= 1000`
- `1 <= m + n <= 2000`
- `-10^6 <= nums1[i], nums2[i] <= 10^6`

## Concept Overview

This problem tests your understanding of binary search and finding the median of a sorted array. The key insight is to use binary search to find the correct partition of the two arrays such that the left half and right half have equal number of elements, and all elements in the left half are smaller than all elements in the right half.

## Solutions

### 1. Brute Force Approach - Merge and Find Median

Merge the two sorted arrays and find the median of the merged array.

```python
def findMedianSortedArrays(nums1, nums2):
    # Merge the two sorted arrays
    merged = []
    i, j = 0, 0
    
    while i < len(nums1) and j < len(nums2):
        if nums1[i] < nums2[j]:
            merged.append(nums1[i])
            i += 1
        else:
            merged.append(nums2[j])
            j += 1
    
    # Add remaining elements
    merged.extend(nums1[i:])
    merged.extend(nums2[j:])
    
    # Find the median
    n = len(merged)
    if n % 2 == 1:
        return merged[n // 2]
    else:
        return (merged[n // 2 - 1] + merged[n // 2]) / 2
```

**Time Complexity:** O(m + n) - We iterate through both arrays once.
**Space Complexity:** O(m + n) - We create a merged array.

### 2. Improved Solution - Without Merging

Find the median without explicitly merging the arrays.

```python
def findMedianSortedArrays(nums1, nums2):
    # Ensure nums1 is the smaller array
    if len(nums1) > len(nums2):
        nums1, nums2 = nums2, nums1
    
    m, n = len(nums1), len(nums2)
    total = m + n
    half = (total + 1) // 2  # Number of elements in the left half
    
    # Binary search on the smaller array
    left, right = 0, m
    
    while left <= right:
        # Number of elements to take from nums1
        i = (left + right) // 2
        # Number of elements to take from nums2
        j = half - i
        
        # Check if the partition is valid
        if i > 0 and j < n and nums1[i - 1] > nums2[j]:
            # Take fewer elements from nums1
            right = i - 1
        elif j > 0 and i < m and nums2[j - 1] > nums1[i]:
            # Take more elements from nums1
            left = i + 1
        else:
            # Valid partition found
            
            # Find the maximum of the left half
            if i == 0:
                max_left = nums2[j - 1]
            elif j == 0:
                max_left = nums1[i - 1]
            else:
                max_left = max(nums1[i - 1], nums2[j - 1])
            
            # If the total number of elements is odd, the median is the maximum of the left half
            if total % 2 == 1:
                return max_left
            
            # Find the minimum of the right half
            if i == m:
                min_right = nums2[j]
            elif j == n:
                min_right = nums1[i]
            else:
                min_right = min(nums1[i], nums2[j])
            
            # If the total number of elements is even, the median is the average of max_left and min_right
            return (max_left + min_right) / 2
```

**Time Complexity:** O(log(min(m, n))) - We perform binary search on the smaller array.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Best Optimized Solution - Binary Search

Use binary search to find the correct partition of the two arrays.

```python
def findMedianSortedArrays(nums1, nums2):
    # Ensure nums1 is the smaller array
    if len(nums1) > len(nums2):
        nums1, nums2 = nums2, nums1
    
    m, n = len(nums1), len(nums2)
    
    # Binary search on the smaller array
    left, right = 0, m
    
    while left <= right:
        # Partition nums1
        i = (left + right) // 2
        # Partition nums2
        j = (m + n + 1) // 2 - i
        
        # Check if the partition is valid
        max_left_nums1 = float('-inf') if i == 0 else nums1[i - 1]
        min_right_nums1 = float('inf') if i == m else nums1[i]
        max_left_nums2 = float('-inf') if j == 0 else nums2[j - 1]
        min_right_nums2 = float('inf') if j == n else nums2[j]
        
        if max_left_nums1 <= min_right_nums2 and max_left_nums2 <= min_right_nums1:
            # Valid partition found
            
            # If the total number of elements is odd
            if (m + n) % 2 == 1:
                return max(max_left_nums1, max_left_nums2)
            
            # If the total number of elements is even
            return (max(max_left_nums1, max_left_nums2) + min(min_right_nums1, min_right_nums2)) / 2
        
        elif max_left_nums1 > min_right_nums2:
            # Take fewer elements from nums1
            right = i - 1
        else:
            # Take more elements from nums1
            left = i + 1
```

**Time Complexity:** O(log(min(m, n))) - We perform binary search on the smaller array.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The binary search solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log(min(m, n))) time complexity, which is better than the O(m + n) time complexity of the brute force approach and satisfies the O(log(m + n)) requirement.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(m + n) space used by the brute force approach.

3. **Efficiency**: It efficiently finds the median without explicitly merging the arrays.

The key insight of this solution is to use binary search to find the correct partition of the two arrays such that:
1. The left half and right half have equal number of elements (or the left half has one more element if the total number is odd).
2. All elements in the left half are smaller than all elements in the right half.

Once we find such a partition, the median is either the maximum of the left half (if the total number of elements is odd) or the average of the maximum of the left half and the minimum of the right half (if the total number of elements is even).

For example, let's find the median of nums1 = [1, 3] and nums2 = [2]:
1. m = 2, n = 1, total = 3 (odd)
2. left = 0, right = 2
3. i = 1, j = 1
4. max_left_nums1 = 1, min_right_nums1 = 3
5. max_left_nums2 = float('-inf') (since j = 0), min_right_nums2 = 2
6. max_left_nums1 <= min_right_nums2 (1 <= 2) and max_left_nums2 <= min_right_nums1 (-inf <= 3), so the partition is valid
7. Since the total number of elements is odd, the median is max(max_left_nums1, max_left_nums2) = max(1, -inf) = 1
8. But wait, that's not right. The median should be 2. Let me double-check the calculation...

I made an error in the calculation. Let me correct it:
1. m = 2, n = 1, total = 3 (odd)
2. left = 0, right = 2
3. i = 1, j = (3 + 1) // 2 - 1 = 1
4. max_left_nums1 = 1, min_right_nums1 = 3
5. max_left_nums2 = 2 (since j = 1), min_right_nums2 = float('inf') (since j = n)
6. max_left_nums1 <= min_right_nums2 (1 <= inf) and max_left_nums2 <= min_right_nums1 (2 <= 3), so the partition is valid
7. Since the total number of elements is odd, the median is max(max_left_nums1, max_left_nums2) = max(1, 2) = 2

The improved solution (Solution 2) is also efficient but slightly more complex. The brute force approach (Solution 1) is simple but doesn't meet the O(log(m + n)) time complexity requirement.

In an interview, I would first mention the binary search approach as the most efficient solution for this problem.
