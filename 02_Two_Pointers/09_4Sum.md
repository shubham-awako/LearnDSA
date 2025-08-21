# 4Sum

## Problem Statement

Given an array `nums` of `n` integers, return an array of all the unique quadruplets `[nums[a], nums[b], nums[c], nums[d]]` such that:
- `0 <= a, b, c, d < n`
- `a`, `b`, `c`, and `d` are distinct.
- `nums[a] + nums[b] + nums[c] + nums[d] == target`

You may return the answer in any order.

**Example 1:**
```
Input: nums = [1,0,-1,0,-2,2], target = 0
Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
```

**Example 2:**
```
Input: nums = [2,2,2,2,2], target = 8
Output: [[2,2,2,2]]
```

**Constraints:**
- `1 <= nums.length <= 200`
- `-10^9 <= nums[i] <= 10^9`
- `-10^9 <= target <= 10^9`

## Concept Overview

This problem is an extension of the 3Sum problem, asking us to find quadruplets that sum to a target value. The key insight is to sort the array and use a combination of iteration and the two-pointer technique to efficiently find all valid quadruplets while avoiding duplicates.

## Solutions

### 1. Brute Force Approach

Check all possible quadruplets to find those that sum to the target.

```python
def fourSum(nums, target):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates easily
    nums.sort()
    
    for a in range(n):
        # Skip duplicates for the first element
        if a > 0 and nums[a] == nums[a - 1]:
            continue
            
        for b in range(a + 1, n):
            # Skip duplicates for the second element
            if b > a + 1 and nums[b] == nums[b - 1]:
                continue
                
            for c in range(b + 1, n):
                # Skip duplicates for the third element
                if c > b + 1 and nums[c] == nums[c - 1]:
                    continue
                    
                for d in range(c + 1, n):
                    # Skip duplicates for the fourth element
                    if d > c + 1 and nums[d] == nums[d - 1]:
                        continue
                        
                    if nums[a] + nums[b] + nums[c] + nums[d] == target:
                        result.append([nums[a], nums[b], nums[c], nums[d]])
    
    return result
```

**Time Complexity:** O(n⁴) - We check all possible quadruplets.
**Space Complexity:** O(1) - Excluding the output array.

### 2. Hash Set Approach

Use a hash set to find pairs that sum to a specific value.

```python
def fourSum(nums, target):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates easily
    nums.sort()
    
    for a in range(n):
        # Skip duplicates for the first element
        if a > 0 and nums[a] == nums[a - 1]:
            continue
            
        for b in range(a + 1, n):
            # Skip duplicates for the second element
            if b > a + 1 and nums[b] == nums[b - 1]:
                continue
                
            # Use a hash set to find pairs that sum to (target - nums[a] - nums[b])
            seen = set()
            for d in range(b + 1, n):
                # Calculate the complement needed to make the sum equal to the target
                complement = target - nums[a] - nums[b] - nums[d]
                
                if complement in seen:
                    result.append([nums[a], nums[b], complement, nums[d]])
                    # Skip duplicates for the fourth element
                    while d + 1 < n and nums[d] == nums[d + 1]:
                        d += 1
                
                seen.add(nums[d])
    
    return result
```

**Time Complexity:** O(n³) - We have three nested loops.
**Space Complexity:** O(n) - For the hash set.

### 3. Best Optimized Solution - Two Pointers

Sort the array and use a two-pointer approach to find pairs that sum to a specific value.

```python
def fourSum(nums, target):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates and use two pointers
    nums.sort()
    
    for a in range(n):
        # Skip duplicates for the first element
        if a > 0 and nums[a] == nums[a - 1]:
            continue
        
        for b in range(a + 1, n):
            # Skip duplicates for the second element
            if b > a + 1 and nums[b] == nums[b - 1]:
                continue
            
            # Use two pointers to find pairs that sum to (target - nums[a] - nums[b])
            c, d = b + 1, n - 1
            remaining_target = target - nums[a] - nums[b]
            
            while c < d:
                current_sum = nums[c] + nums[d]
                
                if current_sum == remaining_target:
                    result.append([nums[a], nums[b], nums[c], nums[d]])
                    
                    # Skip duplicates for the third element
                    while c < d and nums[c] == nums[c + 1]:
                        c += 1
                    
                    # Skip duplicates for the fourth element
                    while c < d and nums[d] == nums[d - 1]:
                        d -= 1
                    
                    c += 1
                    d -= 1
                elif current_sum < remaining_target:
                    c += 1
                else:
                    d -= 1
    
    return result
```

**Time Complexity:** O(n³) - We have two nested loops and a two-pointer approach that takes O(n) time.
**Space Complexity:** O(1) - Excluding the output array.

### 4. Optimized Solution with Early Termination

Add early termination conditions to avoid unnecessary iterations.

```python
def fourSum(nums, target):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates and use two pointers
    nums.sort()
    
    for a in range(n):
        # Skip duplicates for the first element
        if a > 0 and nums[a] == nums[a - 1]:
            continue
        
        # Early termination: if the smallest possible sum is greater than the target, break
        if a + 3 < n and nums[a] + nums[a+1] + nums[a+2] + nums[a+3] > target:
            break
        
        # Early termination: if the largest possible sum is less than the target, skip
        if a < n - 3 and nums[a] + nums[n-3] + nums[n-2] + nums[n-1] < target:
            continue
        
        for b in range(a + 1, n):
            # Skip duplicates for the second element
            if b > a + 1 and nums[b] == nums[b - 1]:
                continue
            
            # Early termination: if the smallest possible sum is greater than the target, break
            if b + 2 < n and nums[a] + nums[b] + nums[b+1] + nums[b+2] > target:
                break
            
            # Early termination: if the largest possible sum is less than the target, skip
            if b < n - 2 and nums[a] + nums[b] + nums[n-2] + nums[n-1] < target:
                continue
            
            # Use two pointers to find pairs that sum to (target - nums[a] - nums[b])
            c, d = b + 1, n - 1
            remaining_target = target - nums[a] - nums[b]
            
            while c < d:
                current_sum = nums[c] + nums[d]
                
                if current_sum == remaining_target:
                    result.append([nums[a], nums[b], nums[c], nums[d]])
                    
                    # Skip duplicates for the third element
                    while c < d and nums[c] == nums[c + 1]:
                        c += 1
                    
                    # Skip duplicates for the fourth element
                    while c < d and nums[d] == nums[d - 1]:
                        d -= 1
                    
                    c += 1
                    d -= 1
                elif current_sum < remaining_target:
                    c += 1
                else:
                    d -= 1
    
    return result
```

**Time Complexity:** O(n³) in the worst case, but often better due to early termination.
**Space Complexity:** O(1) - Excluding the output array.

## Solution Choice and Explanation

The two-pointer solution with early termination (Solution 4) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n³) time complexity in the worst case, which is the best possible for this problem without using additional data structures.

2. **Early Termination**: It adds early termination conditions to avoid unnecessary iterations, which can significantly improve performance for certain inputs.

3. **Optimal Space Complexity**: It uses O(1) extra space (excluding the output array).

4. **Efficient Handling of Duplicates**: It handles duplicates efficiently by skipping them during the iteration.

The key insights of this approach are:
1. Sort the array first to handle duplicates and enable the two-pointer technique.
2. Use two nested loops to fix the first two elements of the quadruplet.
3. Use a two-pointer approach to find the remaining two elements that sum to the target minus the first two elements.
4. Add early termination conditions to avoid unnecessary iterations when the smallest possible sum is greater than the target or the largest possible sum is less than the target.

The brute force approach (Solution 1) is simple but inefficient with O(n⁴) time complexity. The hash set approach (Solution 2) and the basic two-pointer approach (Solution 3) both have O(n³) time complexity, but the two-pointer approach uses less space and is more straightforward to implement.

In an interview, I would first mention the two-pointer approach with early termination as the optimal solution that achieves O(n³) time complexity with O(1) extra space and additional optimizations.
