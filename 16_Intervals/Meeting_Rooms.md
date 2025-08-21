# Meeting Rooms

## Problem Statement

Given an array of meeting time intervals where `intervals[i] = [starti, endi]`, determine if a person could attend all meetings.

**Example 1:**
```
Input: intervals = [[0,30],[5,10],[15,20]]
Output: false
Explanation: The person cannot attend all meetings because [0,30] and [5,10] overlap.
```

**Example 2:**
```
Input: intervals = [[7,10],[2,4]]
Output: true
Explanation: The person can attend all meetings because [7,10] and [2,4] don't overlap.
```

**Constraints:**
- `0 <= intervals.length <= 10^4`
- `intervals[i].length == 2`
- `0 <= starti < endi <= 10^6`

## Concept Overview

This problem involves checking if there are any overlapping intervals in a given array. The key insight is to sort the intervals by their start times and then check if any adjacent intervals overlap.

## Solutions

### 1. Best Optimized Solution - Sort and Check

Sort the intervals by their start times and then check if any adjacent intervals overlap.

```python
def canAttendMeetings(intervals):
    # Sort intervals by start time
    intervals.sort(key=lambda x: x[0])
    
    # Check if any adjacent intervals overlap
    for i in range(1, len(intervals)):
        if intervals[i][0] < intervals[i-1][1]:
            return False
    
    return True
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the checking step takes O(n) time.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Brute Force

Check each pair of intervals to see if they overlap.

```python
def canAttendMeetings(intervals):
    for i in range(len(intervals)):
        for j in range(i + 1, len(intervals)):
            if (intervals[i][0] <= intervals[j][0] < intervals[i][1]) or \
               (intervals[j][0] <= intervals[i][0] < intervals[j][1]):
                return False
    
    return True
```

**Time Complexity:** O(n^2) - We need to check each pair of intervals.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 3. Alternative Solution - Line Sweep

Use a line sweep algorithm to check if any intervals overlap.

```python
def canAttendMeetings(intervals):
    # Create events for interval start and end
    events = []
    for start, end in intervals:
        events.append((start, 1))  # 1 for start event
        events.append((end, -1))   # -1 for end event
    
    # Sort events by time, and if times are equal, sort by event type (end before start)
    events.sort()
    
    count = 0
    for time, event_type in events:
        count += event_type
        if count > 1:
            return False
    
    return True
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the checking step takes O(n) time.
**Space Complexity:** O(n) - We create a new list to store the events.

## Solution Choice and Explanation

The Sort and Check solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of checking if intervals overlap.

The key insight of this approach is to sort the intervals by their start times and then check if any adjacent intervals overlap. By sorting the intervals, we ensure that if two intervals overlap, they will be adjacent in the sorted array, which simplifies the checking process.

For example, let's trace through the algorithm for intervals = [[0,30],[5,10],[15,20]]:

1. Sort intervals by start time:
   - intervals = [[0,30],[5,10],[15,20]] -> [[0,30],[5,10],[15,20]] (already sorted)

2. Check if any adjacent intervals overlap:
   - intervals[1][0] = 5 < intervals[0][1] = 30, so they overlap
   - Return False

For intervals = [[7,10],[2,4]]:

1. Sort intervals by start time:
   - intervals = [[7,10],[2,4]] -> [[2,4],[7,10]]

2. Check if any adjacent intervals overlap:
   - intervals[1][0] = 7 >= intervals[0][1] = 4, so they don't overlap
   - Return True

The Brute Force solution (Solution 2) is less efficient and should be avoided for large inputs. The Line Sweep solution (Solution 3) is also efficient but may be more complex and uses more space.

In an interview, I would first mention the Sort and Check solution as the most intuitive approach for this problem, and then discuss the Line Sweep solution as an alternative if asked for a different approach. I would also mention that the Brute Force solution is less efficient and should be avoided for large inputs.
