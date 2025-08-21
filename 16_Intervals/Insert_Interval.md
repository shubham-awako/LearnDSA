# Insert Interval

## Problem Statement

You are given an array of non-overlapping intervals `intervals` where `intervals[i] = [starti, endi]` represent the start and the end of the `i`th interval and `intervals` is sorted in ascending order by `starti`. You are also given an interval `newInterval = [start, end]` that represents the start and end of another interval.

Insert `newInterval` into `intervals` such that `intervals` is still sorted in ascending order by `starti` and `intervals` still does not have any overlapping intervals (merge overlapping intervals if necessary).

Return `intervals` after the insertion.

**Example 1:**
```
Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
Output: [[1,5],[6,9]]
```

**Example 2:**
```
Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
Output: [[1,2],[3,10],[12,16]]
Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
```

**Constraints:**
- `0 <= intervals.length <= 10^4`
- `intervals[i].length == 2`
- `0 <= starti <= endi <= 10^5`
- `intervals` is sorted by `starti` in ascending order.
- `newInterval.length == 2`
- `0 <= start <= end <= 10^5`

## Concept Overview

This problem involves inserting a new interval into a sorted list of non-overlapping intervals and merging any overlapping intervals. The key insight is to handle three cases: intervals that come before the new interval, intervals that overlap with the new interval, and intervals that come after the new interval.

## Solutions

### 1. Best Optimized Solution - Linear Scan

Use a linear scan to insert the new interval and merge overlapping intervals.

```python
def insert(intervals, newInterval):
    result = []
    i = 0
    n = len(intervals)
    
    # Add all intervals that come before the new interval
    while i < n and intervals[i][1] < newInterval[0]:
        result.append(intervals[i])
        i += 1
    
    # Merge overlapping intervals
    while i < n and intervals[i][0] <= newInterval[1]:
        newInterval[0] = min(newInterval[0], intervals[i][0])
        newInterval[1] = max(newInterval[1], intervals[i][1])
        i += 1
    
    # Add the merged interval
    result.append(newInterval)
    
    # Add all intervals that come after the new interval
    while i < n:
        result.append(intervals[i])
        i += 1
    
    return result
```

**Time Complexity:** O(n) - We iterate through the intervals once.
**Space Complexity:** O(n) - We create a new list to store the result.

### 2. Alternative Solution - Binary Search

Use binary search to find the position to insert the new interval, then merge overlapping intervals.

```python
def insert(intervals, newInterval):
    if not intervals:
        return [newInterval]
    
    # Find the position to insert the new interval
    left, right = 0, len(intervals) - 1
    while left <= right:
        mid = (left + right) // 2
        if intervals[mid][0] < newInterval[0]:
            left = mid + 1
        else:
            right = mid - 1
    
    # Insert the new interval
    intervals.insert(left, newInterval)
    
    # Merge overlapping intervals
    result = [intervals[0]]
    for i in range(1, len(intervals)):
        if result[-1][1] >= intervals[i][0]:
            result[-1][1] = max(result[-1][1], intervals[i][1])
        else:
            result.append(intervals[i])
    
    return result
```

**Time Complexity:** O(n) - Although we use binary search to find the position to insert the new interval, we still need to shift elements to insert it, which takes O(n) time.
**Space Complexity:** O(n) - We create a new list to store the result.

### 3. Alternative Solution - Separate Cases

Handle each case separately: intervals that come before the new interval, intervals that overlap with the new interval, and intervals that come after the new interval.

```python
def insert(intervals, newInterval):
    result = []
    
    # Add all intervals that come before the new interval
    i = 0
    while i < len(intervals) and intervals[i][1] < newInterval[0]:
        result.append(intervals[i])
        i += 1
    
    # Add the merged interval
    merged_interval = newInterval.copy()
    while i < len(intervals) and intervals[i][0] <= newInterval[1]:
        merged_interval[0] = min(merged_interval[0], intervals[i][0])
        merged_interval[1] = max(merged_interval[1], intervals[i][1])
        i += 1
    result.append(merged_interval)
    
    # Add all intervals that come after the new interval
    while i < len(intervals):
        result.append(intervals[i])
        i += 1
    
    return result
```

**Time Complexity:** O(n) - We iterate through the intervals once.
**Space Complexity:** O(n) - We create a new list to store the result.

## Solution Choice and Explanation

The Linear Scan solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(n).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of inserting a new interval and merging overlapping intervals.

The key insight of this approach is to handle three cases: intervals that come before the new interval, intervals that overlap with the new interval, and intervals that come after the new interval. We add intervals that come before the new interval directly to the result. We merge overlapping intervals by updating the new interval's start and end points. Finally, we add the merged interval and all intervals that come after it to the result.

For example, let's trace through the algorithm for intervals = [[1,3],[6,9]] and newInterval = [2,5]:

1. Initialize result = [], i = 0, n = 2

2. Add all intervals that come before the new interval:
   - intervals[0] = [1, 3], newInterval = [2, 5]
   - intervals[0][1] = 3 >= newInterval[0] = 2, so break
   - result = []

3. Merge overlapping intervals:
   - intervals[0] = [1, 3], newInterval = [2, 5]
   - intervals[0][0] = 1 <= newInterval[1] = 5, so merge
   - newInterval = [min(2, 1), max(5, 3)] = [1, 5]
   - i = 1
   - intervals[1] = [6, 9], newInterval = [1, 5]
   - intervals[1][0] = 6 > newInterval[1] = 5, so break
   - result = []

4. Add the merged interval:
   - result = [[1, 5]]

5. Add all intervals that come after the new interval:
   - intervals[1] = [6, 9]
   - result = [[1, 5], [6, 9]]

6. Return result = [[1, 5], [6, 9]]

For intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]] and newInterval = [4,8]:

1. Initialize result = [], i = 0, n = 5

2. Add all intervals that come before the new interval:
   - intervals[0] = [1, 2], newInterval = [4, 8]
   - intervals[0][1] = 2 < newInterval[0] = 4, so add to result
   - result = [[1, 2]]
   - i = 1
   - intervals[1] = [3, 5], newInterval = [4, 8]
   - intervals[1][1] = 5 >= newInterval[0] = 4, so break
   - result = [[1, 2]]

3. Merge overlapping intervals:
   - intervals[1] = [3, 5], newInterval = [4, 8]
   - intervals[1][0] = 3 <= newInterval[1] = 8, so merge
   - newInterval = [min(4, 3), max(8, 5)] = [3, 8]
   - i = 2
   - intervals[2] = [6, 7], newInterval = [3, 8]
   - intervals[2][0] = 6 <= newInterval[1] = 8, so merge
   - newInterval = [min(3, 6), max(8, 7)] = [3, 8]
   - i = 3
   - intervals[3] = [8, 10], newInterval = [3, 8]
   - intervals[3][0] = 8 <= newInterval[1] = 8, so merge
   - newInterval = [min(3, 8), max(8, 10)] = [3, 10]
   - i = 4
   - intervals[4] = [12, 16], newInterval = [3, 10]
   - intervals[4][0] = 12 > newInterval[1] = 10, so break
   - result = [[1, 2]]

4. Add the merged interval:
   - result = [[1, 2], [3, 10]]

5. Add all intervals that come after the new interval:
   - intervals[4] = [12, 16]
   - result = [[1, 2], [3, 10], [12, 16]]

6. Return result = [[1, 2], [3, 10], [12, 16]]

The Binary Search solution (Solution 2) is also efficient but may be more complex and less intuitive. The Separate Cases solution (Solution 3) is essentially the same as the Linear Scan solution but separates the cases for clarity.

In an interview, I would first mention the Linear Scan solution as the most intuitive approach for this problem, and then discuss the Binary Search and Separate Cases solutions as alternatives if asked for different approaches.
