# Meeting Rooms II

## Problem Statement

Given an array of meeting time intervals `intervals` where `intervals[i] = [starti, endi]`, return the minimum number of conference rooms required.

**Example 1:**
```
Input: intervals = [[0,30],[5,10],[15,20]]
Output: 2
Explanation: We need two meeting rooms.
Meeting room 1: [0,30]
Meeting room 2: [5,10], [15,20]
```

**Example 2:**
```
Input: intervals = [[7,10],[2,4]]
Output: 1
Explanation: We only need one meeting room since the meetings don't overlap.
```

**Constraints:**
- `1 <= intervals.length <= 10^4`
- `0 <= starti < endi <= 10^6`

## Concept Overview

This problem involves finding the minimum number of conference rooms required to accommodate all meetings. The key insight is to use a min heap to keep track of the end times of meetings in each room.

## Solutions

### 1. Best Optimized Solution - Min Heap

Sort the intervals by their start times and use a min heap to keep track of the end times of meetings in each room.

```python
import heapq

def minMeetingRooms(intervals):
    if not intervals:
        return 0
    
    # Sort intervals by start time
    intervals.sort(key=lambda x: x[0])
    
    # Use a min heap to keep track of the end times of meetings in each room
    rooms = []
    heapq.heappush(rooms, intervals[0][1])
    
    # Process the rest of the intervals
    for i in range(1, len(intervals)):
        # If the earliest ending meeting has ended by the time the current meeting starts,
        # we can reuse the room
        if intervals[i][0] >= rooms[0]:
            heapq.heappop(rooms)
        
        # Add the end time of the current meeting to the heap
        heapq.heappush(rooms, intervals[i][1])
    
    # The size of the heap is the minimum number of rooms required
    return len(rooms)
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the heap operations take O(log n) time per operation, for a total of O(n log n) time.
**Space Complexity:** O(n) - In the worst case, we need to store all n meetings in the heap.

### 2. Alternative Solution - Line Sweep

Use a line sweep algorithm to count the number of overlapping intervals at each point in time.

```python
def minMeetingRooms(intervals):
    # Create events for interval start and end
    events = []
    for start, end in intervals:
        events.append((start, 1))  # 1 for start event
        events.append((end, -1))   # -1 for end event
    
    # Sort events by time, and if times are equal, sort by event type (end before start)
    events.sort()
    
    rooms = 0
    max_rooms = 0
    for time, event_type in events:
        rooms += event_type
        max_rooms = max(max_rooms, rooms)
    
    return max_rooms
```

**Time Complexity:** O(n log n) - The sorting step takes O(n log n) time, and the counting step takes O(n) time.
**Space Complexity:** O(n) - We create a new list to store the events.

### 3. Alternative Solution - Two Pointers

Sort the start times and end times separately, then use two pointers to count the number of overlapping intervals.

```python
def minMeetingRooms(intervals):
    if not intervals:
        return 0
    
    # Extract start and end times
    start_times = sorted([interval[0] for interval in intervals])
    end_times = sorted([interval[1] for interval in intervals])
    
    # Use two pointers to count the number of overlapping intervals
    rooms = 0
    max_rooms = 0
    start_ptr = 0
    end_ptr = 0
    
    while start_ptr < len(intervals):
        if start_times[start_ptr] < end_times[end_ptr]:
            # A new meeting starts before the earliest ending meeting ends
            rooms += 1
            start_ptr += 1
        else:
            # The earliest ending meeting ends before a new meeting starts
            rooms -= 1
            end_ptr += 1
        
        max_rooms = max(max_rooms, rooms)
    
    return max_rooms
```

**Time Complexity:** O(n log n) - The sorting steps take O(n log n) time, and the counting step takes O(n) time.
**Space Complexity:** O(n) - We create two new lists to store the start and end times.

## Solution Choice and Explanation

The Min Heap solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log n) time complexity, which is optimal for this problem, and the space complexity is O(n).

2. **Intuitiveness**: It naturally maps to the concept of allocating rooms for meetings.

3. **Flexibility**: It can be easily extended to handle more complex scenarios, such as assigning specific rooms to meetings.

The key insight of this approach is to use a min heap to keep track of the end times of meetings in each room. By sorting the intervals by their start times, we ensure that we process the meetings in chronological order. For each meeting, we check if the earliest ending meeting has ended by the time the current meeting starts. If so, we can reuse the room; otherwise, we need a new room.

For example, let's trace through the algorithm for intervals = [[0,30],[5,10],[15,20]]:

1. Sort intervals by start time:
   - intervals = [[0,30],[5,10],[15,20]] (already sorted)

2. Initialize rooms = []

3. Process the intervals:
   - interval = [0,30]:
     - Add end time 30 to rooms: rooms = [30]
   - interval = [5,10]:
     - 5 < rooms[0] = 30, so we need a new room
     - Add end time 10 to rooms: rooms = [10, 30]
   - interval = [15,20]:
     - 15 >= rooms[0] = 10, so we can reuse the room
     - Remove 10 from rooms: rooms = [30]
     - Add end time 20 to rooms: rooms = [20, 30]

4. Return len(rooms) = 2

For intervals = [[7,10],[2,4]]:

1. Sort intervals by start time:
   - intervals = [[7,10],[2,4]] -> [[2,4],[7,10]]

2. Initialize rooms = []

3. Process the intervals:
   - interval = [2,4]:
     - Add end time 4 to rooms: rooms = [4]
   - interval = [7,10]:
     - 7 >= rooms[0] = 4, so we can reuse the room
     - Remove 4 from rooms: rooms = []
     - Add end time 10 to rooms: rooms = [10]

4. Return len(rooms) = 1

The Line Sweep solution (Solution 2) is also efficient and may be more intuitive for some people. The Two Pointers solution (Solution 3) is also efficient but may be less intuitive.

In an interview, I would first mention the Min Heap solution as the most intuitive approach for this problem, and then discuss the Line Sweep and Two Pointers solutions as alternatives if asked for different approaches.
