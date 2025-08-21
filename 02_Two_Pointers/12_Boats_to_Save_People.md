# Boats to Save People

## Problem Statement

You are given an array `people` where `people[i]` is the weight of the `i`th person, and an infinite number of boats where each boat can carry a maximum weight of `limit`. Each boat carries at most two people at the same time, provided the sum of the weight of those people is at most `limit`.

Return the minimum number of boats to carry every given person.

**Example 1:**
```
Input: people = [1,2], limit = 3
Output: 1
Explanation: 1 boat (1, 2)
```

**Example 2:**
```
Input: people = [3,2,2,1], limit = 3
Output: 3
Explanation: 3 boats (1, 2), (2) and (3)
```

**Example 3:**
```
Input: people = [3,5,3,4], limit = 5
Output: 4
Explanation: 4 boats (3), (3), (4), (5)
```

**Constraints:**
- `1 <= people.length <= 5 * 10^4`
- `1 <= people[i] <= limit <= 3 * 10^4`

## Concept Overview

This problem asks us to find the minimum number of boats needed to carry all people, where each boat can carry at most two people with a weight limit. The key insight is to pair the heaviest person with the lightest person whenever possible.

## Solutions

### 1. Brute Force Approach - Greedy with Sorting

Sort the array and try to pair the heaviest person with the lightest person.

```python
def numRescueBoats(people, limit):
    people.sort()
    boats = 0
    
    left, right = 0, len(people) - 1
    
    while left <= right:
        # Try to pair the heaviest person with the lightest person
        if people[left] + people[right] <= limit:
            left += 1
        
        # The heaviest person goes alone
        right -= 1
        boats += 1
    
    return boats
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

### 2. Best Optimized Solution - Two Pointers

Sort the array and use two pointers to pair people efficiently.

```python
def numRescueBoats(people, limit):
    people.sort()
    boats = 0
    
    left, right = 0, len(people) - 1
    
    while left <= right:
        # Try to pair the heaviest person with the lightest person
        if people[left] + people[right] <= limit:
            left += 1
        
        # The heaviest person goes alone
        right -= 1
        boats += 1
    
    return boats
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(1) - If we use an in-place sorting algorithm.

### 3. Alternative Solution - Counting Sort

Use counting sort for better time complexity when the weight range is small.

```python
def numRescueBoats(people, limit):
    # Count the frequency of each weight
    count = [0] * (limit + 1)
    for p in people:
        count[p] += 1
    
    boats = 0
    left, right = 1, limit
    
    while left <= right:
        while left <= right and count[left] == 0:
            left += 1
        while left <= right and count[right] == 0:
            right -= 1
        
        if left > right:
            break
        
        # Try to pair the heaviest person with the lightest person
        if left + right <= limit:
            count[left] -= 1
        
        count[right] -= 1
        boats += 1
    
    return boats
```

**Time Complexity:** O(n + limit) - Linear in the size of the input and the weight limit.
**Space Complexity:** O(limit) - For the counting array.

## Solution Choice and Explanation

The two-pointer solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n log n) time complexity, which is efficient for the given constraints.

2. **Optimal Space Complexity**: It uses O(1) extra space (excluding the sorting space), which is optimal for this problem.

3. **Greedy Strategy**: It uses a greedy approach to pair the heaviest person with the lightest person whenever possible, which minimizes the number of boats needed.

The key insight of this approach is to sort the array and use two pointers to pair people efficiently. We start with the lightest person (left pointer) and the heaviest person (right pointer). If they can fit in the same boat, we pair them; otherwise, the heaviest person goes alone. This strategy ensures that we always try to maximize the weight carried by each boat.

For example, in the array [3,2,2,1] with a limit of 3:
- After sorting, we have [1,2,2,3].
- We try to pair the heaviest person (3) with the lightest person (1), but their combined weight (4) exceeds the limit, so the heaviest person goes alone. Boats = 1.
- We move to the next heaviest person (2) and try to pair with the lightest person (1). Their combined weight (3) equals the limit, so they go together. Boats = 2.
- We're left with one person of weight 2, who goes alone. Boats = 3.

The counting sort solution (Solution 3) can be more efficient when the weight range is small, but it uses O(limit) extra space, which can be large depending on the constraints.

In an interview, I would first mention the two-pointer approach as the optimal solution that achieves O(n log n) time complexity with O(1) extra space. I would also explain the greedy strategy of pairing the heaviest person with the lightest person whenever possible.
