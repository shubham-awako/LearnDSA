# Contains Duplicate II

## Problem Statement

Given an integer array `nums` and an integer `k`, return `true` if there are two distinct indices `i` and `j` in the array such that `nums[i] == nums[j]` and `abs(i - j) <= k`.

**Example 1:**
```
Input: nums = [1,2,3,1], k = 3
Output: true
```

**Example 2:**
```
Input: nums = [1,0,1,1], k = 1
Output: true
```

**Example 3:**
```
Input: nums = [1,2,3,1,2,3], k = 2
Output: false
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-10^9 <= nums[i] <= 10^9`
- `0 <= k <= 10^5`

## Concept Overview

This problem asks us to find if there are two duplicate elements within a distance of `k` from each other. The key insight is to use a sliding window of size `k+1` and check for duplicates within this window.

## Solutions

### 1. Brute Force Approach

Check all pairs of elements within distance `k`.

```python
def containsNearbyDuplicate(nums, k):
    n = len(nums)
    
    for i in range(n):
        for j in range(i + 1, min(i + k + 1, n)):
            if nums[i] == nums[j]:
                return True
    
    return False
```

**Time Complexity:** O(n * k) - For each element, we check up to k elements ahead.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Improved Solution - Hash Map

Use a hash map to store the most recent index of each element.

```python
def containsNearbyDuplicate(nums, k):
    index_map = {}
    
    for i, num in enumerate(nums):
        # If the number is already in the map and the distance is <= k
        if num in index_map and i - index_map[num] <= k:
            return True
        
        # Update the index of the number
        index_map[num] = i
    
    return False
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - In the worst case, all elements are distinct.

### 3. Best Optimized Solution - Sliding Window with Hash Set

Use a sliding window of size `k+1` and a hash set to check for duplicates.

```python
def containsNearbyDuplicate(nums, k):
    window = set()
    
    for i, num in enumerate(nums):
        # If the window size exceeds k, remove the leftmost element
        if i > k:
            window.remove(nums[i - k - 1])
        
        # If the current number is already in the window, return True
        if num in window:
            return True
        
        # Add the current number to the window
        window.add(num)
    
    return False
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(min(n, k+1)) - The size of the window is at most k+1.

## Solution Choice and Explanation

The sliding window with hash set solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(min(n, k+1)) space, which is better than the O(n) space used by the hash map approach when k is small.

3. **Direct Implementation of the Problem**: It directly implements the concept of checking for duplicates within a window of size k+1.

The key insight of this approach is to maintain a sliding window of size k+1 using a hash set. For each element, we:
1. Remove the element that's now outside the window (if the window size exceeds k).
2. Check if the current element is already in the window (which would mean a duplicate within distance k).
3. Add the current element to the window.

This approach efficiently checks for duplicates within the required distance without having to compare each element with all elements within distance k.

The hash map approach (Solution 2) is also efficient with O(n) time complexity but may use more space when k is small. The brute force approach (Solution 1) is inefficient with O(n * k) time complexity.

In an interview, I would first mention the sliding window with hash set approach as the optimal solution that achieves O(n) time complexity with O(min(n, k+1)) space.
