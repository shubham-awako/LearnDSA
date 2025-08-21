# Minimum Size Subarray Sum

## Problem Statement

Given an array of positive integers `nums` and a positive integer `target`, return the minimal length of a subarray whose sum is greater than or equal to `target`. If there is no such subarray, return 0 instead.

**Example 1:**
```
Input: target = 7, nums = [2,3,1,2,4,3]
Output: 2
Explanation: The subarray [4,3] has the minimal length under the problem constraint.
```

**Example 2:**
```
Input: target = 4, nums = [1,4,4]
Output: 1
```

**Example 3:**
```
Input: target = 11, nums = [1,1,1,1,1,1,1,1]
Output: 0
```

**Constraints:**
- `1 <= target <= 10^9`
- `1 <= nums.length <= 10^5`
- `1 <= nums[i] <= 10^5`

**Follow up:** If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log n).

## Concept Overview

This problem asks us to find the minimum length of a subarray whose sum is greater than or equal to a target value. The key insight is to use a sliding window approach to efficiently find such subarrays.

## Solutions

### 1. Brute Force Approach

Check all possible subarrays and find the minimum length that satisfies the condition.

```python
def minSubArrayLen(target, nums):
    n = len(nums)
    min_length = float('inf')
    
    for i in range(n):
        current_sum = 0
        for j in range(i, n):
            current_sum += nums[j]
            if current_sum >= target:
                min_length = min(min_length, j - i + 1)
                break
    
    return min_length if min_length != float('inf') else 0
```

**Time Complexity:** O(n²) - We check all possible subarrays.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - Sliding Window

Use a sliding window to efficiently find subarrays whose sum is greater than or equal to the target.

```python
def minSubArrayLen(target, nums):
    n = len(nums)
    min_length = float('inf')
    left = 0
    current_sum = 0
    
    for right in range(n):
        current_sum += nums[right]
        
        # Shrink the window from the left as long as the sum is >= target
        while current_sum >= target:
            min_length = min(min_length, right - left + 1)
            current_sum -= nums[left]
            left += 1
    
    return min_length if min_length != float('inf') else 0
```

**Time Complexity:** O(n) - We process each element at most twice (once when adding to the window and once when removing from the window).
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Binary Search with Prefix Sums

Use binary search to find the minimum length of a subarray whose sum is greater than or equal to the target.

```python
def minSubArrayLen(target, nums):
    n = len(nums)
    
    # Calculate prefix sums
    prefix_sums = [0] * (n + 1)
    for i in range(n):
        prefix_sums[i + 1] = prefix_sums[i] + nums[i]
    
    # If the sum of all elements is less than the target, return 0
    if prefix_sums[-1] < target:
        return 0
    
    min_length = float('inf')
    
    # For each starting position, binary search for the ending position
    for i in range(n):
        # Binary search for the smallest j such that prefix_sums[j] - prefix_sums[i] >= target
        left, right = i, n
        while left <= right:
            mid = (left + right) // 2
            if prefix_sums[mid] - prefix_sums[i] >= target:
                min_length = min(min_length, mid - i)
                right = mid - 1
            else:
                left = mid + 1
    
    return min_length
```

**Time Complexity:** O(n log n) - For each of the n starting positions, we perform a binary search which takes O(log n) time.
**Space Complexity:** O(n) - We store the prefix sums.

## Solution Choice and Explanation

The sliding window solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the binary search approach.

3. **Efficient Window Management**: It efficiently handles the sliding window by expanding and shrinking it based on the current sum.

The key insight of this approach is to use a sliding window whose sum is at least the target value. We expand the window by adding elements from the right, and when the sum becomes greater than or equal to the target, we shrink the window from the left as much as possible while maintaining the condition. This allows us to find the minimum length subarray for each ending position.

For example, with target = 7 and nums = [2,3,1,2,4,3]:
- We start with left = 0, right = 0, current_sum = 2, min_length = inf.
- We expand the window to [2,3], current_sum = 5, min_length = inf.
- We expand the window to [2,3,1], current_sum = 6, min_length = inf.
- We expand the window to [2,3,1,2], current_sum = 8 >= target, min_length = 4.
- We shrink the window to [3,1,2], current_sum = 6 < target, min_length = 4.
- We expand the window to [3,1,2,4], current_sum = 10 >= target, min_length = 4.
- We shrink the window to [1,2,4], current_sum = 7 >= target, min_length = 3.
- We shrink the window to [2,4], current_sum = 6 < target, min_length = 3.
- We expand the window to [2,4,3], current_sum = 9 >= target, min_length = 3.
- We shrink the window to [4,3], current_sum = 7 >= target, min_length = 2.
- We shrink the window to [3], current_sum = 3 < target, min_length = 2.
- We've reached the end of the array, so we return min_length = 2.

The binary search approach (Solution 3) is also efficient with O(n log n) time complexity and is a good alternative when the sliding window approach is not immediately obvious. The brute force approach (Solution 1) is inefficient with O(n²) time complexity.

In an interview, I would first mention the sliding window approach as the optimal solution that achieves O(n) time complexity with O(1) extra space. I would also mention the binary search approach as a follow-up solution with O(n log n) time complexity.
