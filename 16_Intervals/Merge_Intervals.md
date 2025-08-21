# Merge Intervals

## Problem Statement

Given an array of `intervals` where `intervals[i] = [starti, endi]`, merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

**Example 1:**
```
Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
```

**Example 2:**
```
Input: intervals = [[1,4],[4,5]]
Output: [[1,5]]
Explanation: Intervals [1,4] and [4,5] are considered overlapping.
```

**Constraints:**
- `1 <= intervals.length <= 10^4`
- `intervals[i].length == 2`
- `0 <= starti <= endi <= 10^4`

## Concept Overview

This problem involves merging overlapping intervals in a given array. The key insight is to sort the intervals by their start times and then merge overlapping intervals by updating the end time of the current interval if needed.

## Solutions

### 1. Best Optimized Solution - Sort and Merge

Sort the intervals by their start times and then merge overlapping intervals.

```python
def merge(intervals):
    # Sort intervals by start time
    intervals.sort(key=lambda x: x[0])
    
    merged = []
    for interval in intervals:
        # If the merged list is empty or the current interval does not overlap with the previous one
        if not merged or merged[-1][1] < interval[0]:
            merged.append(interval)
        else:
            # Otherwise, there is an overlap, so we merge the current and previous intervals
            merged[-1][1] = max(merged[-1][1], interval[1])
    
    return merged
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the merging step takes O(n) time.
**Space Complexity:** O(n) - We create a new list to store the merged intervals.

### 2. Alternative Solution - Line Sweep

Use a line sweep algorithm to merge overlapping intervals.

```python
def merge(intervals):
    # Create events for interval start and end
    events = []
    for start, end in intervals:
        events.append((start, 1))  # 1 for start event
        events.append((end, -1))   # -1 for end event
    
    # Sort events by time, and if times are equal, sort by event type (end before start)
    events.sort(key=lambda x: (x[0], x[1]))
    
    merged = []
    count = 0
    start = 0
    
    for time, event_type in events:
        if count == 0 and event_type == 1:
            # Start of a new interval
            start = time
        
        count += event_type
        
        if count == 0:
            # End of an interval
            merged.append([start, time])
    
    return merged
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the merging step takes O(n) time.
**Space Complexity:** O(n) - We create a new list to store the events and merged intervals.

### 3. Alternative Solution - Brute Force

Check each pair of intervals to see if they overlap, and merge them if they do. Repeat until no more intervals can be merged.

```python
def merge(intervals):
    if not intervals:
        return []
    
    # Make a copy of the intervals to avoid modifying the input
    intervals = [list(interval) for interval in intervals]
    
    i = 0
    while i < len(intervals):
        j = i + 1
        while j < len(intervals):
            # Check if intervals[i] and intervals[j] overlap
            if max(intervals[i][0], intervals[j][0]) <= min(intervals[i][1], intervals[j][1]):
                # Merge intervals[j] into intervals[i]
                intervals[i][0] = min(intervals[i][0], intervals[j][0])
                intervals[i][1] = max(intervals[i][1], intervals[j][1])
                # Remove intervals[j]
                intervals.pop(j)
            else:
                j += 1
        i += 1
    
    return intervals
```

**Time Complexity:** O(n^2) - In the worst case, we need to check each pair of intervals.
**Space Complexity:** O(n) - We create a new list to store the intervals.

## Solution Choice and Explanation

The Sort and Merge solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log n) time complexity, which is optimal for this problem, and the space complexity is O(n).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of merging overlapping intervals.

The key insight of this approach is to sort the intervals by their start times and then merge overlapping intervals by updating the end time of the current interval if needed. By sorting the intervals, we ensure that if two intervals overlap, they will be adjacent in the sorted array, which simplifies the merging process.

For example, let's trace through the algorithm for intervals = [[1,3],[2,6],[8,10],[15,18]]:

1. Sort intervals by start time:
   - intervals = [[1,3],[2,6],[8,10],[15,18]] (already sorted)

2. Initialize merged = []

3. Iterate through the sorted intervals:
   - interval = [1,3]:
     - merged is empty, so add interval to merged
     - merged = [[1,3]]
   - interval = [2,6]:
     - merged[-1][1] = 3 >= interval[0] = 2, so merge
     - merged[-1][1] = max(3, 6) = 6
     - merged = [[1,6]]
   - interval = [8,10]:
     - merged[-1][1] = 6 < interval[0] = 8, so add interval to merged
     - merged = [[1,6],[8,10]]
   - interval = [15,18]:
     - merged[-1][1] = 10 < interval[0] = 15, so add interval to merged
     - merged = [[1,6],[8,10],[15,18]]

4. Return merged = [[1,6],[8,10],[15,18]]

For intervals = [[1,4],[4,5]]:

1. Sort intervals by start time:
   - intervals = [[1,4],[4,5]] (already sorted)

2. Initialize merged = []

3. Iterate through the sorted intervals:
   - interval = [1,4]:
     - merged is empty, so add interval to merged
     - merged = [[1,4]]
   - interval = [4,5]:
     - merged[-1][1] = 4 >= interval[0] = 4, so merge
     - merged[-1][1] = max(4, 5) = 5
     - merged = [[1,5]]

4. Return merged = [[1,5]]

The Line Sweep solution (Solution 2) is also efficient but may be more complex and less intuitive. The Brute Force solution (Solution 3) is less efficient and should be avoided for large inputs.

In an interview, I would first mention the Sort and Merge solution as the most intuitive approach for this problem, and then discuss the Line Sweep solution as an alternative if asked for a different approach. I would also mention that the Brute Force solution is less efficient and should be avoided for large inputs.
