# Merge Sorted Array

## Problem Statement

You are given two integer arrays `nums1` and `nums2`, sorted in non-decreasing order, and two integers `m` and `n`, representing the number of elements in `nums1` and `nums2` respectively.

Merge `nums1` and `nums2` into a single array sorted in non-decreasing order.

The final sorted array should not be returned by the function, but instead be stored inside the array `nums1`. To accommodate this, `nums1` has a length of `m + n`, where the first `m` elements denote the elements that should be merged, and the last `n` elements are set to 0 and should be ignored. `nums2` has a length of `n`.

**Example 1:**
```
Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
Output: [1,2,2,3,5,6]
Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
```

**Example 2:**
```
Input: nums1 = [1], m = 1, nums2 = [], n = 0
Output: [1]
Explanation: The arrays we are merging are [1] and [].
The result of the merge is [1].
```

**Example 3:**
```
Input: nums1 = [0], m = 0, nums2 = [1], n = 1
Output: [1]
Explanation: The arrays we are merging are [] and [1].
The result of the merge is [1].
Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.
```

**Constraints:**
- `nums1.length == m + n`
- `nums2.length == n`
- `0 <= m, n <= 200`
- `1 <= m + n <= 200`
- `-10^9 <= nums1[i], nums2[j] <= 10^9`

**Follow up:** Can you come up with an algorithm that runs in O(m + n) time?

## Concept Overview

This problem tests your ability to merge two sorted arrays in-place. The key insight is to use a two-pointer approach starting from the end of both arrays to avoid overwriting elements in `nums1` that haven't been processed yet.

## Solutions

### 1. Brute Force Approach - Merge and Sort

Copy the elements from `nums2` into `nums1` and then sort the entire array.

```python
def merge(nums1, m, nums2, n):
    # Copy elements from nums2 to the end of nums1
    for i in range(n):
        nums1[m + i] = nums2[i]
    
    # Sort the entire array
    nums1.sort()
```

**Time Complexity:** O((m+n) log (m+n)) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

### 2. Improved Solution - Using Extra Space

Create a new array to store the merged result, then copy it back to `nums1`.

```python
def merge(nums1, m, nums2, n):
    # Create a copy of the first m elements of nums1
    nums1_copy = nums1[:m]
    
    # Pointers for nums1_copy and nums2
    p1, p2 = 0, 0
    
    # Pointer for nums1
    p = 0
    
    # Compare elements from nums1_copy and nums2 and add the smaller one to nums1
    while p1 < m and p2 < n:
        if nums1_copy[p1] <= nums2[p2]:
            nums1[p] = nums1_copy[p1]
            p1 += 1
        else:
            nums1[p] = nums2[p2]
            p2 += 1
        p += 1
    
    # If there are remaining elements in nums1_copy, add them to nums1
    if p1 < m:
        nums1[p:p + m - p1] = nums1_copy[p1:m]
    
    # If there are remaining elements in nums2, add them to nums1
    if p2 < n:
        nums1[p:p + n - p2] = nums2[p2:n]
```

**Time Complexity:** O(m + n) - We process each element once.
**Space Complexity:** O(m) - We create a copy of the first m elements of nums1.

### 3. Best Optimized Solution - Three Pointers (Start from End)

Use three pointers to merge the arrays from the end, avoiding the need for extra space.

```python
def merge(nums1, m, nums2, n):
    # Pointers for nums1 and nums2
    p1 = m - 1
    p2 = n - 1
    
    # Pointer for the end of nums1
    p = m + n - 1
    
    # Merge from the end
    while p1 >= 0 and p2 >= 0:
        if nums1[p1] > nums2[p2]:
            nums1[p] = nums1[p1]
            p1 -= 1
        else:
            nums1[p] = nums2[p2]
            p2 -= 1
        p -= 1
    
    # If there are remaining elements in nums2, add them to nums1
    # (No need to handle remaining elements in nums1 as they are already in place)
    nums1[:p2 + 1] = nums2[:p2 + 1]
```

**Time Complexity:** O(m + n) - We process each element once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

## Solution Choice and Explanation

The three pointers solution starting from the end (Solution 3) is the best approach for this problem because:

1. **In-Place Modification**: It directly modifies `nums1` without using extra space.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(m) space used by Solution 2.

3. **Optimal Time Complexity**: It achieves O(m + n) time complexity, which is optimal for this problem.

The key insight of this approach is to merge the arrays from the end to avoid overwriting elements in `nums1` that haven't been processed yet. By starting from the end, we can place the largest elements first and work our way backward.

The brute force approach (Solution 1) is simple but has a higher time complexity of O((m+n) log (m+n)). The improved solution (Solution 2) has optimal time complexity but uses O(m) extra space.

In an interview, I would first mention the three pointers approach as the optimal solution that minimizes both time and space complexity. I would also explain the insight of merging from the end to avoid overwriting unprocessed elements.
