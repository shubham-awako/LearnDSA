# Koko Eating Bananas

## Problem Statement

Koko loves to eat bananas. There are `n` piles of bananas, the `i`th pile has `piles[i]` bananas. The guards have gone and will come back in `h` hours.

Koko can decide her bananas-per-hour eating speed of `k`. Each hour, she chooses some pile of bananas and eats `k` bananas from that pile. If the pile has less than `k` bananas, she eats all of them instead and will not eat any more bananas during this hour.

Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

Return the minimum integer `k` such that she can eat all the bananas within `h` hours.

**Example 1:**
```
Input: piles = [3,6,7,11], h = 8
Output: 4
```

**Example 2:**
```
Input: piles = [30,11,23,4,20], h = 5
Output: 30
```

**Example 3:**
```
Input: piles = [30,11,23,4,20], h = 6
Output: 23
```

**Constraints:**
- `1 <= piles.length <= 10^4`
- `piles.length <= h <= 10^9`
- `1 <= piles[i] <= 10^9`

## Concept Overview

This problem is a classic example of binary search on the answer. The key insight is to use binary search to find the minimum eating speed that allows Koko to finish all bananas within h hours.

## Solutions

### 1. Brute Force Approach - Linear Search

Try each possible eating speed from 1 to the maximum pile size.

```python
def minEatingSpeed(piles, h):
    def can_finish(speed):
        # Calculate the total hours needed to eat all bananas at the given speed
        hours = 0
        for pile in piles:
            hours += (pile + speed - 1) // speed  # Ceiling division
        return hours <= h
    
    max_pile = max(piles)
    
    # Try each possible speed
    for speed in range(1, max_pile + 1):
        if can_finish(speed):
            return speed
    
    return max_pile  # This should never happen given the constraints
```

**Time Complexity:** O(n * max(piles)) - For each possible speed, we check all piles.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - Binary Search

Use binary search to find the minimum eating speed.

```python
def minEatingSpeed(piles, h):
    def can_finish(speed):
        # Calculate the total hours needed to eat all bananas at the given speed
        hours = 0
        for pile in piles:
            hours += (pile + speed - 1) // speed  # Ceiling division
        return hours <= h
    
    left, right = 1, max(piles)
    
    while left < right:
        mid = left + (right - left) // 2
        
        if can_finish(mid):
            right = mid  # Try to find a smaller speed
        else:
            left = mid + 1  # Need a larger speed
    
    return left
```

**Time Complexity:** O(n * log(max(piles))) - We perform a binary search on the range [1, max(piles)], and for each speed, we check all piles.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 3. Alternative Solution - Binary Search with Optimization

Optimize the binary search by using a better initial range.

```python
def minEatingSpeed(piles, h):
    def can_finish(speed):
        # Calculate the total hours needed to eat all bananas at the given speed
        hours = 0
        for pile in piles:
            hours += (pile + speed - 1) // speed  # Ceiling division
        return hours <= h
    
    # Calculate the minimum possible speed
    total_bananas = sum(piles)
    min_speed = (total_bananas + h - 1) // h  # Ceiling division
    
    # Calculate the maximum possible speed
    max_speed = max(piles)
    
    left, right = min_speed, max_speed
    
    while left < right:
        mid = left + (right - left) // 2
        
        if can_finish(mid):
            right = mid  # Try to find a smaller speed
        else:
            left = mid + 1  # Need a larger speed
    
    return left
```

**Time Complexity:** O(n * log(max(piles) - min_speed)) - We perform a binary search on a potentially smaller range.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n * log(max(piles))) time complexity, which is efficient for large values of max(piles).

2. **Simplicity**: It's straightforward to implement and understand.

3. **Efficiency**: It efficiently finds the minimum eating speed by narrowing down the search range.

The key insight of this solution is to use binary search to find the minimum eating speed. We define a function `can_finish(speed)` that checks if Koko can finish all bananas within h hours at a given speed. Then, we use binary search to find the minimum speed that satisfies this condition:
- If Koko can finish at speed `mid`, we try to find a smaller speed by setting `right = mid`.
- If Koko cannot finish at speed `mid`, we need a larger speed, so we set `left = mid + 1`.

For example, let's find the minimum eating speed for piles = [3,6,7,11] and h = 8:
1. left = 1, right = 11
2. mid = 6, hours = ceil(3/6) + ceil(6/6) + ceil(7/6) + ceil(11/6) = 1 + 1 + 2 + 2 = 6 <= 8, so right = 6
3. left = 1, right = 6, mid = 3, hours = ceil(3/3) + ceil(6/3) + ceil(7/3) + ceil(11/3) = 1 + 2 + 3 + 4 = 10 > 8, so left = 4
4. left = 4, right = 6, mid = 5, hours = ceil(3/5) + ceil(6/5) + ceil(7/5) + ceil(11/5) = 1 + 2 + 2 + 3 = 8 <= 8, so right = 5
5. left = 4, right = 5, mid = 4, hours = ceil(3/4) + ceil(6/4) + ceil(7/4) + ceil(11/4) = 1 + 2 + 2 + 3 = 8 <= 8, so right = 4
6. left = 4, right = 4, the loop terminates
7. Return left = 4

The alternative solution with optimization (Solution 3) is also efficient and may have a smaller search range, but the optimization may not always be significant. The brute force approach (Solution 1) is inefficient with O(n * max(piles)) time complexity.

In an interview, I would first mention the binary search approach as the most efficient solution for this problem.
