# Find The Duplicate Number

## Problem Statement

Given an array of integers `nums` containing `n + 1` integers where each integer is in the range `[1, n]` inclusive.

There is only one repeated number in `nums`, return this repeated number.

You must solve the problem without modifying the array `nums` and uses only constant extra space.

**Example 1:**
```
Input: nums = [1,3,4,2,2]
Output: 2
```

**Example 2:**
```
Input: nums = [3,1,3,4,2]
Output: 3
```

**Constraints:**
- `1 <= n <= 10^5`
- `nums.length == n + 1`
- `1 <= nums[i] <= n`
- All the integers in `nums` appear only once except for precisely one integer which appears two or more times.

**Follow up:**
- How can we prove that at least one duplicate number must exist in `nums`?
- Can you solve the problem in linear runtime complexity?

## Concept Overview

This problem can be approached in several ways, but the most efficient solution involves treating the array as a linked list with a cycle. The key insight is to use Floyd's Cycle-Finding Algorithm (also known as the "tortoise and hare" algorithm) to detect the duplicate number.

## Solutions

### 1. Sorting Approach

Sort the array and find the duplicate by comparing adjacent elements.

```python
def findDuplicate(nums):
    nums.sort()
    
    for i in range(1, len(nums)):
        if nums[i] == nums[i - 1]:
            return nums[i]
    
    return -1  # No duplicate found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

**Note:** This solution modifies the array, which doesn't satisfy the problem constraint.

### 2. Hash Set Approach

Use a hash set to keep track of seen numbers.

```python
def findDuplicate(nums):
    seen = set()
    
    for num in nums:
        if num in seen:
            return num
        seen.add(num)
    
    return -1  # No duplicate found (won't reach here given the problem constraints)
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We store all numbers in the hash set.

**Note:** This solution uses O(n) extra space, which doesn't satisfy the problem constraint.

### 3. Best Optimized Solution - Floyd's Cycle-Finding Algorithm

Treat the array as a linked list where `nums[i]` represents the next index to visit, and use Floyd's Cycle-Finding Algorithm to find the duplicate.

```python
def findDuplicate(nums):
    # Phase 1: Find the intersection point of the two runners
    slow = nums[0]
    fast = nums[0]
    
    while True:
        slow = nums[slow]
        fast = nums[nums[fast]]
        if slow == fast:
            break
    
    # Phase 2: Find the entrance to the cycle
    slow = nums[0]
    while slow != fast:
        slow = nums[slow]
        fast = nums[fast]
    
    return slow
```

**Time Complexity:** O(n) - We iterate through the array at most twice.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 4. Alternative Solution - Binary Search

Use binary search to find the duplicate number.

```python
def findDuplicate(nums):
    left, right = 1, len(nums) - 1
    
    while left < right:
        mid = left + (right - left) // 2
        count = sum(1 for num in nums if num <= mid)
        
        if count > mid:
            right = mid
        else:
            left = mid + 1
    
    return left
```

**Time Complexity:** O(n log n) - We perform a binary search, and for each value, we count the numbers in the array.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The Floyd's Cycle-Finding Algorithm (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which satisfies the follow-up challenge.

2. **Optimal Space Complexity**: It uses O(1) extra space, which satisfies the problem constraint.

3. **No Modification**: It doesn't modify the array, which satisfies the problem constraint.

The key insight of this approach is to treat the array as a linked list where `nums[i]` represents the next index to visit. Since there's a duplicate number, there must be a cycle in this linked list. We can use Floyd's Cycle-Finding Algorithm to detect the cycle and find the duplicate number.

For example, let's find the duplicate in [1,3,4,2,2]:
1. Treat the array as a linked list: 0 -> 1 -> 3 -> 2 -> 4 -> 2 -> ...
2. There's a cycle: 2 -> 4 -> 2 -> ...
3. The entrance to the cycle is 2, which is the duplicate number.

The binary search approach (Solution 4) is also efficient and uses O(1) extra space, but it has a higher time complexity of O(n log n). The sorting approach (Solution 1) modifies the array, which doesn't satisfy the problem constraint. The hash set approach (Solution 2) uses O(n) extra space, which doesn't satisfy the problem constraint.

In an interview, I would first mention the Floyd's Cycle-Finding Algorithm as the most efficient solution that satisfies all the problem constraints.

**Follow-up Answers:**
1. We can prove that at least one duplicate number must exist in `nums` using the pigeonhole principle. There are n+1 integers in the array, but only n distinct possible values (1 to n). Therefore, by the pigeonhole principle, at least one value must appear more than once.
2. Yes, we can solve the problem in linear runtime complexity using Floyd's Cycle-Finding Algorithm, as shown in Solution 3.
