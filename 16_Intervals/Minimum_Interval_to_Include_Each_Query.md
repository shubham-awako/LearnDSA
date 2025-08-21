# Minimum Interval to Include Each Query

## Problem Statement

You are given a 2D integer array `intervals`, where `intervals[i] = [lefti, righti]` describes the `i`th interval starting at `lefti` and ending at `righti` (inclusive). The size of an interval is defined as the number of integers it contains, or more formally `righti - lefti + 1`.

You are also given an integer array `queries`. The answer to the `j`th query is the size of the smallest interval `i` such that `lefti <= queries[j] <= righti`. If no such interval exists, the answer is `-1`.

Return an array containing the answers to the queries.

**Example 1:**
```
Input: intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]
Output: [3,3,1,4]
Explanation:
- Query = 2: The interval [2,4] is the smallest interval containing 2. The answer is 4 - 2 + 1 = 3.
- Query = 3: The interval [2,4] is the smallest interval containing 3. The answer is 4 - 2 + 1 = 3.
- Query = 4: The interval [4,4] is the smallest interval containing 4. The answer is 4 - 4 + 1 = 1.
- Query = 5: The interval [3,6] is the smallest interval containing 5. The answer is 6 - 3 + 1 = 4.
```

**Example 2:**
```
Input: intervals = [[2,3],[2,5],[1,8],[20,25]], queries = [2,19,5,22]
Output: [2,-1,4,6]
Explanation:
- Query = 2: The interval [2,3] is the smallest interval containing 2. The answer is 3 - 2 + 1 = 2.
- Query = 19: None of the intervals contain 19. The answer is -1.
- Query = 5: The interval [2,5] is the smallest interval containing 5. The answer is 5 - 2 + 1 = 4.
- Query = 22: The interval [20,25] is the smallest interval containing 22. The answer is 25 - 20 + 1 = 6.
```

**Constraints:**
- `1 <= intervals.length <= 10^5`
- `1 <= queries.length <= 10^5`
- `intervals[i].length == 2`
- `1 <= lefti <= righti <= 10^7`
- `1 <= queries[j] <= 10^7`

## Concept Overview

This problem involves finding the smallest interval that contains each query point. The key insight is to sort the intervals by size and use a min heap to efficiently find the smallest interval containing each query point.

## Solutions

### 1. Best Optimized Solution - Min Heap and Sorting

Sort the queries and intervals, then use a min heap to efficiently find the smallest interval containing each query point.

```python
import heapq

def minInterval(intervals, queries):
    # Sort intervals by start time
    intervals.sort()
    
    # Create a list of (query, index) pairs and sort by query
    sorted_queries = sorted((q, i) for i, q in enumerate(queries))
    
    # Initialize the result array
    result = [-1] * len(queries)
    
    # Initialize the min heap to store (size, end) pairs
    heap = []
    i = 0
    
    # Process each query
    for query, idx in sorted_queries:
        # Add all intervals that start before or at the query point to the heap
        while i < len(intervals) and intervals[i][0] <= query:
            start, end = intervals[i]
            size = end - start + 1
            heapq.heappush(heap, (size, end))
            i += 1
        
        # Remove intervals that end before the query point
        while heap and heap[0][1] < query:
            heapq.heappop(heap)
        
        # If there's an interval in the heap, it's the smallest interval containing the query point
        if heap:
            result[idx] = heap[0][0]
    
    return result
```

**Time Complexity:** O((n + q) log (n + q)) - Sorting the intervals and queries takes O(n log n + q log q) time, and the heap operations take O(log n) time per operation, for a total of O((n + q) log (n + q)) time.
**Space Complexity:** O(n + q) - We store the intervals and queries in sorted order, and the heap can contain at most n intervals.

### 2. Alternative Solution - Binary Search

Sort the intervals by size, then use binary search to find the smallest interval containing each query point.

```python
def minInterval(intervals, queries):
    # Sort intervals by size
    intervals.sort(key=lambda x: x[1] - x[0])
    
    # Create a dictionary to store the result for each query
    result_dict = {}
    
    # Process each interval
    for start, end in intervals:
        size = end - start + 1
        
        # For each query point in the interval, update the result if it's smaller
        for q in range(start, end + 1):
            if q in queries and q not in result_dict:
                result_dict[q] = size
    
    # Construct the result array
    result = [result_dict.get(q, -1) for q in queries]
    
    return result
```

**Time Complexity:** O(n * r + q) - For each interval, we iterate through all integers in the range, which can be up to 10^7 in the worst case. This is inefficient for large intervals.
**Space Complexity:** O(q) - We store the result for each query.

### 3. Alternative Solution - Offline Processing with Sorting

Sort the queries and intervals, then process them in order to find the smallest interval containing each query point.

```python
def minInterval(intervals, queries):
    # Sort intervals by start time
    intervals.sort()
    
    # Create a list of (query, index) pairs and sort by query
    sorted_queries = sorted((q, i) for i, q in enumerate(queries))
    
    # Initialize the result array
    result = [-1] * len(queries)
    
    # Initialize a list to store active intervals (end, size)
    active = []
    i = 0
    
    # Process each query
    for query, idx in sorted_queries:
        # Add all intervals that start before or at the query point to the active list
        while i < len(intervals) and intervals[i][0] <= query:
            start, end = intervals[i]
            size = end - start + 1
            active.append((end, size))
            i += 1
        
        # Sort active intervals by size
        active.sort(key=lambda x: x[1])
        
        # Find the smallest interval containing the query point
        for end, size in active:
            if end >= query:
                result[idx] = size
                break
        
        # Remove intervals that end before the query point
        active = [(end, size) for end, size in active if end >= query]
    
    return result
```

**Time Complexity:** O((n + q) log (n + q)) - Sorting the intervals and queries takes O(n log n + q log q) time, and sorting the active intervals takes O(n log n) time in the worst case, for a total of O((n + q) log (n + q)) time.
**Space Complexity:** O(n + q) - We store the intervals and queries in sorted order, and the active list can contain at most n intervals.

## Solution Choice and Explanation

The Min Heap and Sorting solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O((n + q) log (n + q)) time complexity, which is optimal for this problem, and the space complexity is O(n + q).

2. **Elegance**: It uses a min heap to efficiently find the smallest interval containing each query point, which is a natural fit for this problem.

3. **Scalability**: It can handle large intervals efficiently, unlike the Binary Search solution.

The key insight of this approach is to sort the queries and intervals, then use a min heap to efficiently find the smallest interval containing each query point. By sorting the intervals by start time and the queries in ascending order, we can process them in a way that minimizes the number of heap operations.

For example, let's trace through the algorithm for intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]:

1. Sort intervals by start time:
   - intervals = [[1,4],[2,4],[3,6],[4,4]] (already sorted)

2. Sort queries:
   - sorted_queries = [(2, 0), (3, 1), (4, 2), (5, 3)]

3. Initialize result = [-1, -1, -1, -1], heap = [], i = 0

4. Process each query:
   - query = 2, idx = 0:
     - Add intervals that start before or at 2: [1,4], [2,4]
     - heap = [(4, 4), (3, 4)] (size, end)
     - result[0] = 3
   - query = 3, idx = 1:
     - Add intervals that start before or at 3: [3,6]
     - heap = [(3, 4), (4, 4), (4, 6)]
     - result[1] = 3
   - query = 4, idx = 2:
     - Add intervals that start before or at 4: [4,4]
     - heap = [(1, 4), (3, 4), (4, 4), (4, 6)]
     - result[2] = 1
   - query = 5, idx = 3:
     - No new intervals to add
     - Remove intervals that end before 5: [1,4], [2,4], [3,6], [4,4]
     - heap = [(4, 6)]
     - result[3] = 4

5. Return result = [3, 3, 1, 4]

For intervals = [[2,3],[2,5],[1,8],[20,25]], queries = [2,19,5,22]:

1. Sort intervals by start time:
   - intervals = [[1,8],[2,3],[2,5],[20,25]]

2. Sort queries:
   - sorted_queries = [(2, 0), (5, 2), (19, 1), (22, 3)]

3. Initialize result = [-1, -1, -1, -1], heap = [], i = 0

4. Process each query:
   - query = 2, idx = 0:
     - Add intervals that start before or at 2: [1,8], [2,3], [2,5]
     - heap = [(2, 3), (4, 5), (8, 8)]
     - result[0] = 2
   - query = 5, idx = 2:
     - No new intervals to add
     - Remove intervals that end before 5: [2,3]
     - heap = [(4, 5), (8, 8)]
     - result[2] = 4
   - query = 19, idx = 1:
     - No new intervals to add
     - Remove intervals that end before 19: [2,5], [1,8]
     - heap = []
     - result[1] = -1
   - query = 22, idx = 3:
     - Add intervals that start before or at 22: [20,25]
     - heap = [(6, 25)]
     - result[3] = 6

5. Return result = [2, -1, 4, 6]

The Binary Search solution (Solution 2) is inefficient for large intervals and should be avoided. The Offline Processing with Sorting solution (Solution 3) is also efficient but may be less elegant than the Min Heap and Sorting solution.

In an interview, I would first mention the Min Heap and Sorting solution as the most efficient approach for this problem, and then discuss the Offline Processing with Sorting solution as an alternative if asked for a different approach. I would also mention that the Binary Search solution is inefficient for large intervals and should be avoided.
