# Longest Increasing Subsequence

## Problem Statement

Given an integer array `nums`, return the length of the longest strictly increasing subsequence.

A subsequence is a sequence that can be derived from an array by deleting some or no elements without changing the order of the remaining elements. For example, `[3,6,2,7]` is a subsequence of the array `[0,3,1,6,2,2,7]`.

**Example 1:**
```
Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
```

**Example 2:**
```
Input: nums = [0,1,0,3,2,3]
Output: 4
```

**Example 3:**
```
Input: nums = [7,7,7,7,7,7,7]
Output: 1
```

**Constraints:**
- `1 <= nums.length <= 2500`
- `-10^4 <= nums[i] <= 10^4`

## Concept Overview

The Longest Increasing Subsequence (LIS) problem is a classic dynamic programming problem. The key insight is to define a state that represents the length of the longest increasing subsequence ending at a particular position, and then use this state to build the solution.

## Solutions

### 1. Best Optimized Solution - Dynamic Programming with Binary Search

Use dynamic programming with binary search to solve the problem.

```python
def lengthOfLIS(nums):
    if not nums:
        return 0
    
    n = len(nums)
    # tails[i] represents the smallest tail of all increasing subsequences of length i+1
    tails = [0] * n
    size = 0
    
    for num in nums:
        # Binary search to find the position to insert the current element
        left, right = 0, size
        while left < right:
            mid = (left + right) // 2
            if tails[mid] < num:
                left = mid + 1
            else:
                right = mid
        
        # Update tails and size
        tails[left] = num
        size = max(size, left + 1)
    
    return size
```

**Time Complexity:** O(n log n) - We iterate through the array once, and for each element, we perform a binary search which takes O(log n) time.
**Space Complexity:** O(n) - We use the tails array to store the smallest tail of all increasing subsequences of each length.

### 2. Alternative Solution - Dynamic Programming with Tabulation

Use dynamic programming with tabulation to solve the problem.

```python
def lengthOfLIS(nums):
    if not nums:
        return 0
    
    n = len(nums)
    # dp[i] represents the length of the longest increasing subsequence ending at index i
    dp = [1] * n
    
    for i in range(1, n):
        for j in range(i):
            if nums[i] > nums[j]:
                dp[i] = max(dp[i], dp[j] + 1)
    
    return max(dp)
```

**Time Complexity:** O(n^2) - We have two nested loops, each iterating through the array.
**Space Complexity:** O(n) - We use the dp array to store the length of the longest increasing subsequence ending at each position.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to solve the problem.

```python
def lengthOfLIS(nums):
    if not nums:
        return 0
    
    n = len(nums)
    memo = {}
    
    def dp(i, prev_idx):
        if i == n:
            return 0
        
        if (i, prev_idx) in memo:
            return memo[(i, prev_idx)]
        
        # Skip the current element
        skip = dp(i + 1, prev_idx)
        
        # Include the current element if it's greater than the previous element
        include = 0
        if prev_idx == -1 or nums[i] > nums[prev_idx]:
            include = 1 + dp(i + 1, i)
        
        # Store the result in the memoization dictionary
        memo[(i, prev_idx)] = max(skip, include)
        return memo[(i, prev_idx)]
    
    return dp(0, -1)
```

**Time Complexity:** O(n^2) - We have n^2 possible states (i, prev_idx), and each state takes O(1) time to compute.
**Space Complexity:** O(n^2) - We use the memoization dictionary to store the results of all subproblems.

## Solution Choice and Explanation

The Dynamic Programming with Binary Search solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log n) time complexity, which is better than the O(n^2) time complexity of the other solutions.

2. **Space Efficiency**: It uses O(n) space, which is the same as the tabulation solution but better than the O(n^2) space complexity of the memoization solution.

3. **Elegance**: It's a more elegant solution that leverages binary search to improve the time complexity.

The key insight of this approach is to maintain an array `tails` where `tails[i]` represents the smallest tail of all increasing subsequences of length i+1. When we encounter a new element, we use binary search to find the position where this element should be inserted in the `tails` array. This allows us to efficiently update the array and keep track of the length of the longest increasing subsequence.

For example, let's trace through the algorithm for nums = [10, 9, 2, 5, 3, 7, 101, 18]:

1. Initialize:
   - tails = [0, 0, 0, 0, 0, 0, 0, 0]
   - size = 0

2. Iterate through the array:
   - num = 10:
     - Binary search: left = 0, right = 0, so left = 0
     - tails[0] = 10
     - size = max(0, 0 + 1) = 1
     - tails = [10, 0, 0, 0, 0, 0, 0, 0]
   - num = 9:
     - Binary search: left = 0, right = 1
       - mid = 0, tails[0] = 10 > 9, so right = 0
     - left = 0
     - tails[0] = 9
     - size = max(1, 0 + 1) = 1
     - tails = [9, 0, 0, 0, 0, 0, 0, 0]
   - num = 2:
     - Binary search: left = 0, right = 1
       - mid = 0, tails[0] = 9 > 2, so right = 0
     - left = 0
     - tails[0] = 2
     - size = max(1, 0 + 1) = 1
     - tails = [2, 0, 0, 0, 0, 0, 0, 0]
   - num = 5:
     - Binary search: left = 0, right = 1
       - mid = 0, tails[0] = 2 < 5, so left = 1
     - left = 1
     - tails[1] = 5
     - size = max(1, 1 + 1) = 2
     - tails = [2, 5, 0, 0, 0, 0, 0, 0]
   - num = 3:
     - Binary search: left = 0, right = 2
       - mid = 1, tails[1] = 5 > 3, so right = 1
       - mid = 0, tails[0] = 2 < 3, so left = 1
     - left = 1
     - tails[1] = 3
     - size = max(2, 1 + 1) = 2
     - tails = [2, 3, 0, 0, 0, 0, 0, 0]
   - num = 7:
     - Binary search: left = 0, right = 2
       - mid = 1, tails[1] = 3 < 7, so left = 2
     - left = 2
     - tails[2] = 7
     - size = max(2, 2 + 1) = 3
     - tails = [2, 3, 7, 0, 0, 0, 0, 0]
   - num = 101:
     - Binary search: left = 0, right = 3
       - mid = 1, tails[1] = 3 < 101, so left = 2
       - mid = 2, tails[2] = 7 < 101, so left = 3
     - left = 3
     - tails[3] = 101
     - size = max(3, 3 + 1) = 4
     - tails = [2, 3, 7, 101, 0, 0, 0, 0]
   - num = 18:
     - Binary search: left = 0, right = 4
       - mid = 2, tails[2] = 7 < 18, so left = 3
       - mid = 3, tails[3] = 101 > 18, so right = 3
     - left = 3
     - tails[3] = 18
     - size = max(4, 3 + 1) = 4
     - tails = [2, 3, 7, 18, 0, 0, 0, 0]

3. Return size = 4

The Dynamic Programming with Tabulation solution (Solution 2) is also efficient but has a higher time complexity. The Recursive with Memoization solution (Solution 3) is less efficient in terms of both time and space.

In an interview, I would first mention the Dynamic Programming with Binary Search solution as the most efficient approach for this problem, and then discuss the Dynamic Programming with Tabulation and Recursive with Memoization solutions as alternatives if asked for different approaches.
