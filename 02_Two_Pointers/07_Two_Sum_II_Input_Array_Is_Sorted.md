# Two Sum II - Input Array Is Sorted

## Problem Statement

Given a 1-indexed array of integers `numbers` that is already sorted in non-decreasing order, find two numbers such that they add up to a specific `target` number. Let these two numbers be `numbers[index1]` and `numbers[index2]` where `1 <= index1 < index2 <= numbers.length`.

Return the indices of the two numbers, `index1` and `index2`, added by one as an integer array `[index1, index2]` of length 2.

The tests are generated such that there is exactly one solution. You may not use the same element twice.

Your solution must use only constant extra space.

**Example 1:**
```
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
```

**Example 2:**
```
Input: numbers = [2,3,4], target = 6
Output: [1,3]
Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
```

**Example 3:**
```
Input: numbers = [-1,0], target = -1
Output: [1,2]
Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
```

**Constraints:**
- `2 <= numbers.length <= 3 * 10^4`
- `-1000 <= numbers[i] <= 1000`
- `numbers` is sorted in non-decreasing order.
- `-1000 <= target <= 1000`
- The tests are generated such that there is exactly one solution.

## Concept Overview

This problem is a variation of the Two Sum problem, with the additional constraint that the input array is sorted. The key insight is to use a two-pointer approach to efficiently find the pair of numbers that sum to the target.

## Solutions

### 1. Brute Force Approach

Check all possible pairs of numbers to find the one that sums to the target.

```python
def twoSum(numbers, target):
    n = len(numbers)
    
    for i in range(n):
        for j in range(i + 1, n):
            if numbers[i] + numbers[j] == target:
                return [i + 1, j + 1]  # 1-indexed
    
    return []  # No solution found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n²) - We check all possible pairs of numbers.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Binary Search Approach

For each number, use binary search to find its complement (target - number).

```python
def twoSum(numbers, target):
    n = len(numbers)
    
    for i in range(n):
        complement = target - numbers[i]
        
        # Binary search for the complement
        left, right = i + 1, n - 1
        while left <= right:
            mid = (left + right) // 2
            if numbers[mid] == complement:
                return [i + 1, mid + 1]  # 1-indexed
            elif numbers[mid] < complement:
                left = mid + 1
            else:
                right = mid - 1
    
    return []  # No solution found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n log n) - For each of the n numbers, we perform a binary search which takes O(log n) time.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Best Optimized Solution - Two Pointers

Use two pointers starting from opposite ends of the array and move them based on the comparison of the current sum with the target.

```python
def twoSum(numbers, target):
    left, right = 0, len(numbers) - 1
    
    while left < right:
        current_sum = numbers[left] + numbers[right]
        
        if current_sum == target:
            return [left + 1, right + 1]  # 1-indexed
        elif current_sum < target:
            left += 1
        else:
            right -= 1
    
    return []  # No solution found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n) - We process each element at most once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

## Solution Choice and Explanation

The two-pointer solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is better than the O(n²) of the brute force approach and the O(n log n) of the binary search approach.

2. **Optimal Space Complexity**: It uses O(1) extra space, as required by the problem.

3. **Leverages Array Properties**: It takes advantage of the fact that the array is already sorted.

The key insight of this approach is to use two pointers starting from opposite ends of the array. We calculate the sum of the elements at these pointers and compare it with the target:
- If the sum equals the target, we've found our answer.
- If the sum is less than the target, we increment the left pointer to increase the sum.
- If the sum is greater than the target, we decrement the right pointer to decrease the sum.

This approach works because the array is sorted. When we move the left pointer to the right, the sum increases; when we move the right pointer to the left, the sum decreases. This allows us to efficiently navigate the search space and find the pair that sums to the target.

The brute force approach (Solution 1) is simple but inefficient with O(n²) time complexity. The binary search approach (Solution 2) is better but still not optimal with O(n log n) time complexity.

In an interview, I would first mention the two-pointer approach as the optimal solution that leverages the sorted property of the array to achieve O(n) time complexity with O(1) space.
