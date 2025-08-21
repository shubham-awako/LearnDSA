# Subarray Sum Equals K

## Problem Statement

Given an array of integers `nums` and an integer `k`, return the total number of subarrays whose sum equals to `k`.

A subarray is a contiguous non-empty sequence of elements within an array.

**Example 1:**
```
Input: nums = [1,1,1], k = 2
Output: 2
```

**Example 2:**
```
Input: nums = [1,2,3], k = 3
Output: 2
```

**Constraints:**
- `1 <= nums.length <= 2 * 10^4`
- `-1000 <= nums[i] <= 1000`
- `-10^7 <= k <= 10^7`

## Concept Overview

This problem asks us to find the number of contiguous subarrays with a sum equal to a given value. The key insight is to use prefix sums and a hash map to efficiently count subarrays.

## Solutions

### 1. Brute Force Approach

Calculate the sum of all possible subarrays and count those with sum equal to k.

```python
def subarraySum(nums, k):
    count = 0
    n = len(nums)
    
    for i in range(n):
        current_sum = 0
        for j in range(i, n):
            current_sum += nums[j]
            if current_sum == k:
                count += 1
    
    return count
```

**Time Complexity:** O(n²) - We check all possible subarrays.
**Space Complexity:** O(1) - We use only a few variables.

### 2. Improved Solution - Prefix Sum Array

Precompute prefix sums to calculate subarray sums more efficiently.

```python
def subarraySum(nums, k):
    count = 0
    n = len(nums)
    
    # Calculate prefix sums
    prefix_sum = [0] * (n + 1)
    for i in range(n):
        prefix_sum[i + 1] = prefix_sum[i] + nums[i]
    
    # Count subarrays with sum equal to k
    for i in range(n):
        for j in range(i, n):
            # Sum of subarray nums[i:j+1] is prefix_sum[j+1] - prefix_sum[i]
            if prefix_sum[j + 1] - prefix_sum[i] == k:
                count += 1
    
    return count
```

**Time Complexity:** O(n²) - We still check all possible subarrays, but calculate sums in O(1) time.
**Space Complexity:** O(n) - We store the prefix sum array.

### 3. Best Optimized Solution - Hash Map with Prefix Sum

Use a hash map to store the frequency of prefix sums and find subarrays with sum k in a single pass.

```python
def subarraySum(nums, k):
    count = 0
    current_sum = 0
    prefix_sum_count = {0: 1}  # Empty subarray has sum 0
    
    for num in nums:
        current_sum += num
        
        # If (current_sum - k) exists in the map, it means there are subarrays ending at the current position with sum k
        if current_sum - k in prefix_sum_count:
            count += prefix_sum_count[current_sum - k]
        
        # Update the frequency of the current prefix sum
        prefix_sum_count[current_sum] = prefix_sum_count.get(current_sum, 0) + 1
    
    return count
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - In the worst case, all prefix sums are distinct.

## Solution Choice and Explanation

The hash map with prefix sum solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity with a single pass through the array.

2. **Efficient Subarray Counting**: It uses a hash map to quickly find the number of subarrays with the desired sum.

3. **Handles Negative Numbers**: It correctly handles arrays with negative numbers, where a simple sliding window approach would fail.

The key insight of this approach is to use a hash map to store the frequency of prefix sums. For each position, we check if there's a prefix sum such that (current_sum - prefix_sum = k), which indicates a subarray with sum k ending at the current position.

For example, if the current prefix sum is 10 and k is 7, we check if there's a previous prefix sum of 3 (10 - 7). If there is, it means there's a subarray with sum 7 ending at the current position.

The brute force approach (Solution 1) and the prefix sum array approach (Solution 2) both have O(n²) time complexity, which is inefficient for large arrays.

In an interview, I would first mention the brute force approach to establish a baseline, then explain the hash map with prefix sum approach as the optimal solution for this problem.
