# Non-overlapping Intervals

## Problem Statement

Given an array of intervals `intervals` where `intervals[i] = [starti, endi]`, return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

**Example 1:**
```
Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
Output: 1
Explanation: [1,3] can be removed and the rest of the intervals are non-overlapping.
```

**Example 2:**
```
Input: intervals = [[1,2],[1,2],[1,2]]
Output: 2
Explanation: You need to remove two [1,2] to make the rest of the intervals non-overlapping.
```

**Example 3:**
```
Input: intervals = [[1,2],[2,3]]
Output: 0
Explanation: You don't need to remove any of the intervals since they're already non-overlapping.
```

**Constraints:**
- `1 <= intervals.length <= 10^5`
- `intervals[i].length == 2`
- `-5 * 10^4 <= starti < endi <= 5 * 10^4`

## Concept Overview

This problem involves finding the minimum number of intervals to remove to make the rest non-overlapping. The key insight is to sort the intervals by their end times and then greedily select intervals that don't overlap.

## Solutions

### 1. Best Optimized Solution - Greedy Approach

Sort the intervals by their end times and then greedily select intervals that don't overlap.

```python
def eraseOverlapIntervals(intervals):
    if not intervals:
        return 0
    
    # Sort intervals by end time
    intervals.sort(key=lambda x: x[1])
    
    count = 0
    end = intervals[0][1]
    
    # Greedily select intervals that don't overlap
    for i in range(1, len(intervals)):
        if intervals[i][0] < end:
            # Overlapping interval, remove it
            count += 1
        else:
            # Non-overlapping interval, update end
            end = intervals[i][1]
    
    return count
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the greedy selection step takes O(n) time.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Dynamic Programming

Use dynamic programming to find the maximum number of non-overlapping intervals, then subtract from the total number of intervals.

```python
def eraseOverlapIntervals(intervals):
    if not intervals:
        return 0
    
    # Sort intervals by start time
    intervals.sort(key=lambda x: x[0])
    
    n = len(intervals)
    dp = [1] * n  # dp[i] = maximum number of non-overlapping intervals ending with intervals[i]
    
    for i in range(1, n):
        for j in range(i):
            if intervals[j][1] <= intervals[i][0]:
                dp[i] = max(dp[i], dp[j] + 1)
    
    return n - max(dp)
```

**Time Complexity:** O(n^2) - We need to check each pair of intervals.
**Space Complexity:** O(n) - We use an array of size n to store the dp values.

### 3. Alternative Solution - Greedy Approach (Sort by Start Time)

Sort the intervals by their start times and then greedily select intervals that don't overlap.

```python
def eraseOverlapIntervals(intervals):
    if not intervals:
        return 0
    
    # Sort intervals by start time
    intervals.sort(key=lambda x: x[0])
    
    count = 0
    end = intervals[0][1]
    
    # Greedily select intervals that don't overlap
    for i in range(1, len(intervals)):
        if intervals[i][0] < end:
            # Overlapping interval, remove the one with the larger end time
            count += 1
            end = min(end, intervals[i][1])
        else:
            # Non-overlapping interval, update end
            end = intervals[i][1]
    
    return count
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the greedy selection step takes O(n) time.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Greedy Approach (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of selecting non-overlapping intervals.

The key insight of this approach is to sort the intervals by their end times and then greedily select intervals that don't overlap. By sorting the intervals by their end times, we ensure that we always select the interval that ends earliest, which maximizes the number of intervals we can select.

For example, let's trace through the algorithm for intervals = [[1,2],[2,3],[3,4],[1,3]]:

1. Sort intervals by end time:
   - intervals = [[1,2],[2,3],[3,4],[1,3]] -> [[1,2],[2,3],[1,3],[3,4]]

2. Initialize count = 0, end = intervals[0][1] = 2

3. Iterate through the sorted intervals:
   - interval = [2,3]:
     - intervals[1][0] = 2 >= end = 2, so it doesn't overlap
     - Update end = 3
   - interval = [1,3]:
     - intervals[2][0] = 1 < end = 3, so it overlaps
     - Increment count = 1
   - interval = [3,4]:
     - intervals[3][0] = 3 >= end = 3, so it doesn't overlap
     - Update end = 4

4. Return count = 1

For intervals = [[1,2],[1,2],[1,2]]:

1. Sort intervals by end time:
   - intervals = [[1,2],[1,2],[1,2]] (already sorted)

2. Initialize count = 0, end = intervals[0][1] = 2

3. Iterate through the sorted intervals:
   - interval = [1,2]:
     - intervals[1][0] = 1 < end = 2, so it overlaps
     - Increment count = 1
   - interval = [1,2]:
     - intervals[2][0] = 1 < end = 2, so it overlaps
     - Increment count = 2

4. Return count = 2

For intervals = [[1,2],[2,3]]:

1. Sort intervals by end time:
   - intervals = [[1,2],[2,3]] (already sorted)

2. Initialize count = 0, end = intervals[0][1] = 2

3. Iterate through the sorted intervals:
   - interval = [2,3]:
     - intervals[1][0] = 2 >= end = 2, so it doesn't overlap
     - Update end = 3

4. Return count = 0

The Dynamic Programming solution (Solution 2) is less efficient and more complex. The Greedy Approach (Sort by Start Time) solution (Solution 3) is also efficient but may be less intuitive.

In an interview, I would first mention the Greedy Approach (Sort by End Time) solution as the most intuitive approach for this problem, and then discuss the Greedy Approach (Sort by Start Time) and Dynamic Programming solutions as alternatives if asked for different approaches.
