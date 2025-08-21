# 16. Intervals

## Concept Overview

Interval problems involve working with ranges or intervals, typically represented as pairs of start and end points. These problems often require sorting, merging, or finding overlaps between intervals. The key to solving interval problems is to understand how to efficiently manipulate and reason about these ranges.

### Key Concepts
- **Interval Representation**: An interval is typically represented as a pair of numbers [start, end], where start ≤ end.
- **Sorting**: Many interval problems involve sorting intervals, usually by their start or end points.
- **Overlapping Intervals**: Two intervals [a, b] and [c, d] overlap if and only if a ≤ d and c ≤ b.
- **Merging Intervals**: Combining overlapping intervals into a single interval that spans the entire range.
- **Interval Intersection**: Finding the common part of two overlapping intervals.
- **Interval Union**: Finding the combined range of two or more intervals.
- **Interval Difference**: Finding the parts of one interval that don't overlap with another.

### Common Patterns
- **Sort and Process**: Sort the intervals by their start or end points, then process them in order.
- **Greedy Approach**: Make locally optimal choices at each step, such as selecting the interval with the earliest end time.
- **Line Sweep**: Treat the start and end points as events, and process them in order.
- **Interval Tree**: A data structure that efficiently stores and queries intervals.
- **Segment Tree**: A data structure that efficiently performs range queries and updates.

### Common Applications
- **Meeting Room Scheduling**: Determining if a person can attend all meetings or how many meeting rooms are needed.
- **Merge Overlapping Intervals**: Combining overlapping intervals to get a minimal set of non-overlapping intervals.
- **Interval Coverage**: Finding the minimum number of intervals to cover a given range.
- **Interval Intersection**: Finding the common parts of two sets of intervals.
- **Range Queries**: Answering queries about ranges, such as finding the sum or maximum value in a range.
- **Skyline Problem**: Finding the outline of a city given the locations and heights of buildings.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Insert Interval | Medium | [Solution](./01_Insert_Interval.md) |
| 2 | Merge Intervals | Medium | [Solution](./02_Merge_Intervals.md) |
| 3 | Non-overlapping Intervals | Medium | [Solution](./03_Non_overlapping_Intervals.md) |
| 4 | Meeting Rooms | Easy | [Solution](./04_Meeting_Rooms.md) |
| 5 | Meeting Rooms II | Medium | [Solution](./05_Meeting_Rooms_II.md) |
| 6 | Minimum Interval to Include Each Query | Hard | [Solution](./06_Minimum_Interval_to_Include_Each_Query.md) |
