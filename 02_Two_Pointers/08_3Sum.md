# 3Sum

## Problem Statement

Given an integer array `nums`, return all the triplets `[nums[i], nums[j], nums[k]]` such that `i != j`, `i != k`, and `j != k`, and `nums[i] + nums[j] + nums[k] == 0`.

Notice that the solution set must not contain duplicate triplets.

**Example 1:**
```
Input: nums = [-1,0,1,2,-1,-4]
Output: [[-1,-1,2],[-1,0,1]]
Explanation: 
nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
The distinct triplets are [-1,0,1] and [-1,-1,2].
Notice that the order of the output and the order of the triplets does not matter.
```

**Example 2:**
```
Input: nums = [0,1,1]
Output: []
Explanation: The only possible triplet does not sum up to 0.
```

**Example 3:**
```
Input: nums = [0,0,0]
Output: [[0,0,0]]
Explanation: The only possible triplet sums up to 0.
```

**Constraints:**
- `3 <= nums.length <= 3000`
- `-10^5 <= nums[i] <= 10^5`

## Concept Overview

This problem is an extension of the Two Sum problem, asking us to find triplets that sum to zero. The key insight is to sort the array and use a combination of iteration and two-pointer technique to efficiently find all valid triplets while avoiding duplicates.

## Solutions

### 1. Brute Force Approach

Check all possible triplets to find those that sum to zero.

```python
def threeSum(nums):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates easily
    nums.sort()
    
    for i in range(n):
        # Skip duplicates for the first element
        if i > 0 and nums[i] == nums[i - 1]:
            continue
            
        for j in range(i + 1, n):
            # Skip duplicates for the second element
            if j > i + 1 and nums[j] == nums[j - 1]:
                continue
                
            for k in range(j + 1, n):
                # Skip duplicates for the third element
                if k > j + 1 and nums[k] == nums[k - 1]:
                    continue
                    
                if nums[i] + nums[j] + nums[k] == 0:
                    result.append([nums[i], nums[j], nums[k]])
    
    return result
```

**Time Complexity:** O(n³) - We check all possible triplets.
**Space Complexity:** O(1) - Excluding the output array.

### 2. Hash Set Approach

Use a hash set to find the third element for each pair of elements.

```python
def threeSum(nums):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates easily
    nums.sort()
    
    for i in range(n):
        # Skip duplicates for the first element
        if i > 0 and nums[i] == nums[i - 1]:
            continue
            
        seen = set()
        for j in range(i + 1, n):
            # Calculate the complement needed to make the sum zero
            complement = -nums[i] - nums[j]
            
            if complement in seen:
                result.append([nums[i], complement, nums[j]])
                # Skip duplicates for the third element
                while j + 1 < n and nums[j] == nums[j + 1]:
                    j += 1
            
            seen.add(nums[j])
    
    return result
```

**Time Complexity:** O(n²) - For each element, we process the remaining elements once.
**Space Complexity:** O(n) - For the hash set.

### 3. Best Optimized Solution - Two Pointers

Sort the array and use a two-pointer approach to find pairs that sum to the negative of each element.

```python
def threeSum(nums):
    n = len(nums)
    result = []
    
    # Sort the array to handle duplicates and use two pointers
    nums.sort()
    
    for i in range(n):
        # Skip duplicates for the first element
        if i > 0 and nums[i] == nums[i - 1]:
            continue
        
        # Use two pointers to find pairs that sum to -nums[i]
        left, right = i + 1, n - 1
        target = -nums[i]
        
        while left < right:
            current_sum = nums[left] + nums[right]
            
            if current_sum == target:
                result.append([nums[i], nums[left], nums[right]])
                
                # Skip duplicates for the second element
                while left < right and nums[left] == nums[left + 1]:
                    left += 1
                
                # Skip duplicates for the third element
                while left < right and nums[right] == nums[right - 1]:
                    right -= 1
                
                left += 1
                right -= 1
            elif current_sum < target:
                left += 1
            else:
                right -= 1
    
    return result
```

**Time Complexity:** O(n²) - We process each element once, and for each element, we use two pointers to find pairs in O(n) time.
**Space Complexity:** O(1) - Excluding the output array.

## Solution Choice and Explanation

The two-pointer solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n²) time complexity, which is the best possible for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space (excluding the output array), which is better than the O(n) space used by the hash set approach.

3. **Efficient Handling of Duplicates**: It handles duplicates efficiently by skipping them during the iteration.

The key insight of this approach is to sort the array first, which allows us to:
1. Easily handle duplicates by skipping consecutive equal elements.
2. Use a two-pointer technique to efficiently find pairs that sum to a specific target.

For each element `nums[i]`, we use two pointers to find pairs `(nums[left], nums[right])` such that `nums[left] + nums[right] = -nums[i]`. The two pointers start from opposite ends of the remaining array and move based on the comparison of the current sum with the target:
- If the sum equals the target, we've found a valid triplet.
- If the sum is less than the target, we increment the left pointer to increase the sum.
- If the sum is greater than the target, we decrement the right pointer to decrease the sum.

The brute force approach (Solution 1) is simple but inefficient with O(n³) time complexity. The hash set approach (Solution 2) is better but uses O(n) extra space and is more complex to implement correctly, especially when handling duplicates.

In an interview, I would first mention the two-pointer approach as the optimal solution that achieves O(n²) time complexity with O(1) extra space.
