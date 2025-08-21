# Split Array Largest Sum

## Problem Statement

Given an integer array `nums` and an integer `k`, split the array into `k` non-empty subarrays such that the largest sum of any subarray is minimized.

Return the minimized largest sum of the split.

A subarray is a contiguous part of the array.

**Example 1:**
```
Input: nums = [7,2,5,10,8], k = 2
Output: 18
Explanation: There are four ways to split nums into two subarrays.
The best way is to split it into [7,2,5] and [10,8], where the largest sum among the two subarrays is only 18.
```

**Example 2:**
```
Input: nums = [1,2,3,4,5], k = 2
Output: 9
Explanation: There are four ways to split nums into two subarrays.
The best way is to split it into [1,2,3] and [4,5], where the largest sum among the two subarrays is only 9.
```

**Constraints:**
- `1 <= nums.length <= 1000`
- `0 <= nums[i] <= 10^6`
- `1 <= k <= min(50, nums.length)`

## Concept Overview

This problem is a classic example of binary search on the answer. The key insight is to use binary search to find the minimum possible value of the largest subarray sum, and check if it's possible to split the array into k subarrays with that constraint.

## Solutions

### 1. Brute Force Approach - Dynamic Programming

Use dynamic programming to find the minimum largest subarray sum.

```python
def splitArray(nums, k):
    n = len(nums)
    
    # dp[i][j] = minimum largest subarray sum when splitting nums[0:i] into j subarrays
    dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
    dp[0][0] = 0
    
    # Precompute prefix sums
    prefix_sum = [0] * (n + 1)
    for i in range(n):
        prefix_sum[i + 1] = prefix_sum[i] + nums[i]
    
    for i in range(1, n + 1):
        for j in range(1, min(i, k) + 1):
            for l in range(j - 1, i):
                # Split nums[0:i] into nums[0:l] and nums[l:i]
                # dp[l][j-1] = minimum largest subarray sum when splitting nums[0:l] into j-1 subarrays
                # prefix_sum[i] - prefix_sum[l] = sum of nums[l:i]
                dp[i][j] = min(dp[i][j], max(dp[l][j - 1], prefix_sum[i] - prefix_sum[l]))
    
    return dp[n][k]
```

**Time Complexity:** O(n² * k) - We have n * k states, and for each state, we consider up to n possible values of l.
**Space Complexity:** O(n * k) - For storing the dp array.

### 2. Best Optimized Solution - Binary Search

Use binary search to find the minimum possible value of the largest subarray sum.

```python
def splitArray(nums, k):
    def can_split(max_sum):
        # Check if it's possible to split the array into k subarrays
        # such that the largest subarray sum is at most max_sum
        count = 1
        current_sum = 0
        
        for num in nums:
            if current_sum + num > max_sum:
                count += 1
                current_sum = num
            else:
                current_sum += num
            
            if count > k:
                return False
        
        return True
    
    # The minimum possible value of the largest subarray sum is the maximum element
    # The maximum possible value is the sum of all elements
    left = max(nums)
    right = sum(nums)
    
    while left < right:
        mid = left + (right - left) // 2
        
        if can_split(mid):
            right = mid  # Try to find a smaller max_sum
        else:
            left = mid + 1  # Need a larger max_sum
    
    return left
```

**Time Complexity:** O(n * log(sum(nums))) - We perform a binary search on the range [max(nums), sum(nums)], and for each value, we check if it's possible to split the array in O(n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Greedy Approach with Binary Search

Use a greedy approach to check if it's possible to split the array into k subarrays with a given maximum sum.

```python
def splitArray(nums, k):
    def min_subarrays(max_sum):
        # Return the minimum number of subarrays needed
        # such that each subarray has sum at most max_sum
        count = 1
        current_sum = 0
        
        for num in nums:
            if current_sum + num > max_sum:
                count += 1
                current_sum = num
            else:
                current_sum += num
        
        return count
    
    # The minimum possible value of the largest subarray sum is the maximum element
    # The maximum possible value is the sum of all elements
    left = max(nums)
    right = sum(nums)
    
    while left < right:
        mid = left + (right - left) // 2
        
        if min_subarrays(mid) <= k:
            right = mid  # Try to find a smaller max_sum
        else:
            left = mid + 1  # Need a larger max_sum
    
    return left
```

**Time Complexity:** O(n * log(sum(nums))) - We perform a binary search on the range [max(nums), sum(nums)], and for each value, we check if it's possible to split the array in O(n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n * log(sum(nums))) time complexity, which is efficient for the given constraints.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n * k) space used by the dynamic programming approach.

3. **Simplicity**: It's more straightforward to implement than the dynamic programming approach.

The key insight of this solution is to use binary search to find the minimum possible value of the largest subarray sum. We define a function `can_split(max_sum)` that checks if it's possible to split the array into k subarrays such that the largest subarray sum is at most `max_sum`. Then, we use binary search to find the minimum value of `max_sum` that satisfies this condition:
- If we can split the array with `max_sum`, we try to find a smaller `max_sum` by setting `right = mid`.
- If we cannot split the array with `max_sum`, we need a larger `max_sum`, so we set `left = mid + 1`.

For example, let's find the minimum largest subarray sum for nums = [7,2,5,10,8] and k = 2:
1. left = 10 (max element), right = 32 (sum of all elements)
2. mid = 21, can_split(21) = true (split into [7,2,5] and [10,8]), so right = 21
3. left = 10, right = 21, mid = 15, can_split(15) = false (cannot split into 2 subarrays with max sum 15), so left = 16
4. left = 16, right = 21, mid = 18, can_split(18) = true (split into [7,2,5] and [10,8]), so right = 18
5. left = 16, right = 18, mid = 17, can_split(17) = false (cannot split into 2 subarrays with max sum 17), so left = 18
6. left = 18, right = 18, the loop terminates
7. Return left = 18

The dynamic programming approach (Solution 1) is also correct but has a higher time and space complexity. The greedy approach with binary search (Solution 3) is essentially the same as Solution 2 but with a slightly different implementation.

In an interview, I would first mention the binary search approach as the most efficient solution for this problem.
