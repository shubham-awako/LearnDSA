# Find in Mountain Array

## Problem Statement

(This problem is an interactive problem.)

You may recall that an array `arr` is a mountain array if and only if:
- `arr.length >= 3`
- There exists some `i` with `0 < i < arr.length - 1` such that:
  - `arr[0] < arr[1] < ... < arr[i - 1] < arr[i]`
  - `arr[i] > arr[i + 1] > ... > arr[arr.length - 1]`

Given a mountain array `mountainArr`, return the minimum index such that `mountainArr.get(index) == target`. If such an index doesn't exist, return `-1`.

You can't access the mountain array directly. You may only access the array using a `MountainArray` interface:
- `MountainArray.get(k)` returns the element of the array at index `k` (0-indexed).
- `MountainArray.length()` returns the length of the array.

Submissions making more than `100` calls to `MountainArray.get` will be judged Wrong Answer. Also, any solutions that attempt to circumvent the judge will result in disqualification.

**Example 1:**
```
Input: array = [1,2,3,4,5,3,1], target = 3
Output: 2
Explanation: 3 exists in the array, at index=2 and index=5. Return the minimum index, which is 2.
```

**Example 2:**
```
Input: array = [0,1,2,4,2,1], target = 3
Output: -1
Explanation: 3 does not exist in the array, so we return -1.
```

**Constraints:**
- `3 <= mountain_arr.length() <= 10^4`
- `0 <= target <= 10^9`
- `0 <= mountain_arr.get(index) <= 10^9`

## Concept Overview

This problem combines binary search with the concept of a mountain array. The key insight is to first find the peak of the mountain, then perform binary search on both the increasing and decreasing parts of the array.

## Solutions

### 1. Best Optimized Solution - Binary Search

Use binary search to find the peak of the mountain, then perform binary search on both the increasing and decreasing parts of the array.

```python
# """
# This is MountainArray's API interface.
# You should not implement it, or speculate about its implementation
# """
# class MountainArray:
#     def get(self, index: int) -> int:
#         pass
#     def length(self) -> int:
#         pass

def findInMountainArray(target, mountain_arr):
    n = mountain_arr.length()
    
    # Find the peak of the mountain
    left, right = 0, n - 1
    while left < right:
        mid = left + (right - left) // 2
        if mountain_arr.get(mid) < mountain_arr.get(mid + 1):
            left = mid + 1
        else:
            right = mid
    
    peak = left
    
    # Search in the increasing part of the array
    left, right = 0, peak
    while left <= right:
        mid = left + (right - left) // 2
        mid_val = mountain_arr.get(mid)
        
        if mid_val == target:
            return mid
        elif mid_val < target:
            left = mid + 1
        else:
            right = mid - 1
    
    # Search in the decreasing part of the array
    left, right = peak, n - 1
    while left <= right:
        mid = left + (right - left) // 2
        mid_val = mountain_arr.get(mid)
        
        if mid_val == target:
            return mid
        elif mid_val > target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1
```

**Time Complexity:** O(log n) - We perform three binary searches, each taking O(log n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Alternative Solution - Binary Search with Caching

Use binary search with caching to reduce the number of calls to `MountainArray.get`.

```python
def findInMountainArray(target, mountain_arr):
    n = mountain_arr.length()
    cache = {}
    
    def get_cached(index):
        if index not in cache:
            cache[index] = mountain_arr.get(index)
        return cache[index]
    
    # Find the peak of the mountain
    left, right = 0, n - 1
    while left < right:
        mid = left + (right - left) // 2
        if get_cached(mid) < get_cached(mid + 1):
            left = mid + 1
        else:
            right = mid
    
    peak = left
    
    # Search in the increasing part of the array
    left, right = 0, peak
    while left <= right:
        mid = left + (right - left) // 2
        mid_val = get_cached(mid)
        
        if mid_val == target:
            return mid
        elif mid_val < target:
            left = mid + 1
        else:
            right = mid - 1
    
    # Search in the decreasing part of the array
    left, right = peak, n - 1
    while left <= right:
        mid = left + (right - left) // 2
        mid_val = get_cached(mid)
        
        if mid_val == target:
            return mid
        elif mid_val > target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1
```

**Time Complexity:** O(log n) - We perform three binary searches, each taking O(log n) time.
**Space Complexity:** O(log n) - We cache the values of the array elements accessed during the binary searches.

### 3. Alternative Solution - Combined Binary Search

Combine the binary searches to reduce the number of calls to `MountainArray.get`.

```python
def findInMountainArray(target, mountain_arr):
    n = mountain_arr.length()
    
    # Find the peak of the mountain
    left, right = 0, n - 1
    while left < right:
        mid = left + (right - left) // 2
        if mountain_arr.get(mid) < mountain_arr.get(mid + 1):
            left = mid + 1
        else:
            right = mid
    
    peak = left
    
    # Binary search function
    def binary_search(left, right, is_increasing):
        while left <= right:
            mid = left + (right - left) // 2
            mid_val = mountain_arr.get(mid)
            
            if mid_val == target:
                return mid
            
            if is_increasing:
                if mid_val < target:
                    left = mid + 1
                else:
                    right = mid - 1
            else:
                if mid_val > target:
                    left = mid + 1
                else:
                    right = mid - 1
        
        return -1
    
    # Search in the increasing part of the array
    result = binary_search(0, peak, True)
    if result != -1:
        return result
    
    # Search in the decreasing part of the array
    return binary_search(peak, n - 1, False)
```

**Time Complexity:** O(log n) - We perform three binary searches, each taking O(log n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The best optimized solution (Solution 1) is the most straightforward approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity, which is efficient for the given constraints.

2. **Minimal API Calls**: It makes at most 3 * log n calls to `MountainArray.get`, which is well within the limit of 100 calls for the given constraints.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this solution is to divide the problem into three parts:
1. Find the peak of the mountain using binary search.
2. Search for the target in the increasing part of the array (from the start to the peak) using binary search.
3. If the target is not found in the increasing part, search for it in the decreasing part of the array (from the peak to the end) using binary search.

For example, let's find the target 3 in the mountain array [1,2,3,4,5,3,1]:
1. Find the peak: peak = 4 (index where the value is 5)
2. Search in the increasing part [1,2,3,4,5]: found 3 at index 2
3. Return 2

The alternative solution with caching (Solution 2) is also efficient and may reduce the number of calls to `MountainArray.get`, but it uses extra space for the cache. The combined binary search solution (Solution 3) is more concise but may be slightly less readable.

In an interview, I would first mention the basic binary search approach as the most straightforward solution for this problem, and then discuss potential optimizations like caching if needed.
