# K Closest Points to Origin

## Problem Statement

Given an array of `points` where `points[i] = [xi, yi]` represents a point on the X-Y plane and an integer `k`, return the `k` closest points to the origin `(0, 0)`.

The distance between two points on the X-Y plane is the Euclidean distance (i.e., `√(x1 - x2)² + (y1 - y2)²`).

You may return the answer in any order. The answer is guaranteed to be unique (except for the order that it is in).

**Example 1:**
```
Input: points = [[1,3],[-2,2]], k = 1
Output: [[-2,2]]
Explanation:
The distance between (1, 3) and the origin is sqrt(10).
The distance between (-2, 2) and the origin is sqrt(8).
Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
We only want the closest k = 1 points from the origin, so the answer is just [[-2, 2]].
```

**Example 2:**
```
Input: points = [[3,3],[5,-1],[-2,4]], k = 2
Output: [[3,3],[-2,4]]
Explanation: The answer [[-2,4],[3,3]] would also be accepted.
```

**Constraints:**
- `1 <= k <= points.length <= 10^4`
- `-10^4 <= xi, yi <= 10^4`

## Concept Overview

This problem tests your understanding of heaps and priority queues. The key insight is to use a max-heap of size k to efficiently find the k closest points to the origin.

## Solutions

### 1. Best Optimized Solution - Min-Heap

Use a min-heap to efficiently find the k closest points to the origin.

```python
import heapq

def kClosest(points, k):
    # Calculate the distance of each point from the origin
    # We can use the square of the distance to avoid the square root calculation
    min_heap = [(x*x + y*y, [x, y]) for x, y in points]
    
    # Heapify the array
    heapq.heapify(min_heap)
    
    # Get the k closest points
    result = []
    for _ in range(k):
        _, point = heapq.heappop(min_heap)
        result.append(point)
    
    return result
```

**Time Complexity:** O(n + k log n) - Heapifying the array takes O(n) time, and extracting k elements takes O(k log n) time.
**Space Complexity:** O(n) - We store all points in the heap.

### 2. Alternative Solution - Max-Heap of Size K

Use a max-heap of size k to efficiently find the k closest points to the origin.

```python
import heapq

def kClosest(points, k):
    # Use a max-heap of size k to keep track of the k closest points
    max_heap = []
    
    for x, y in points:
        dist = x*x + y*y
        
        # If the heap has fewer than k elements, add the new point
        if len(max_heap) < k:
            heapq.heappush(max_heap, (-dist, [x, y]))
        # If the new point is closer than the farthest point in the heap, replace it
        elif -dist > max_heap[0][0]:
            heapq.heappushpop(max_heap, (-dist, [x, y]))
    
    # Extract the points from the heap
    return [point for _, point in max_heap]
```

**Time Complexity:** O(n log k) - We process n points, and each heap operation takes O(log k) time.
**Space Complexity:** O(k) - We store at most k points in the heap.

### 3. Alternative Solution - Quick Select

Use the quick select algorithm to find the k closest points to the origin.

```python
import random

def kClosest(points, k):
    def dist(point):
        return point[0]*point[0] + point[1]*point[1]
    
    def partition(left, right, pivot_index):
        pivot_dist = dist(points[pivot_index])
        # Move the pivot to the end
        points[pivot_index], points[right] = points[right], points[pivot_index]
        
        # Move all points with distance less than the pivot to the left
        store_index = left
        for i in range(left, right):
            if dist(points[i]) < pivot_dist:
                points[i], points[store_index] = points[store_index], points[i]
                store_index += 1
        
        # Move the pivot to its final place
        points[store_index], points[right] = points[right], points[store_index]
        
        return store_index
    
    def quick_select(left, right, k):
        if left == right:
            return
        
        # Choose a random pivot
        pivot_index = random.randint(left, right)
        
        # Partition the array around the pivot
        pivot_index = partition(left, right, pivot_index)
        
        # If the pivot is in the kth position, we're done
        if pivot_index == k:
            return
        # If the pivot is after the kth position, search in the left subarray
        elif pivot_index > k:
            quick_select(left, pivot_index - 1, k)
        # If the pivot is before the kth position, search in the right subarray
        else:
            quick_select(pivot_index + 1, right, k)
    
    # Use quick select to find the k closest points
    quick_select(0, len(points) - 1, k)
    
    # Return the first k points
    return points[:k]
```

**Time Complexity:** O(n) on average - The quick select algorithm has an average-case time complexity of O(n).
**Space Complexity:** O(1) - We modify the input array in-place.

## Solution Choice and Explanation

The min-heap solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(n + k log n) time complexity, which is efficient for this problem.

3. **Readability**: It's easy to understand and follows the natural approach to the problem.

The key insight of this approach is to use a min-heap to efficiently find the k closest points to the origin. We calculate the square of the Euclidean distance for each point (to avoid the square root calculation) and store it along with the point in a min-heap. Then, we extract the k smallest elements from the heap to get the k closest points.

For example, let's find the 2 closest points to the origin from points = [[3,3],[5,-1],[-2,4]]:
1. Calculate the distances:
   - (3,3): 3*3 + 3*3 = 18
   - (5,-1): 5*5 + (-1)*(-1) = 26
   - (-2,4): (-2)*(-2) + 4*4 = 20
2. Create a min-heap: [(18, [3,3]), (26, [5,-1]), (20, [-2,4])]
3. Extract the 2 smallest elements:
   - (18, [3,3])
   - (20, [-2,4])
4. Return the points: [[3,3], [-2,4]]

The max-heap of size k solution (Solution 2) is also efficient, with a time complexity of O(n log k), which is better than Solution 1 when k is much smaller than n. The quick select solution (Solution 3) has the best average-case time complexity of O(n), but it's more complex and modifies the input array in-place.

In an interview, I would first mention the min-heap solution as the most straightforward and elegant solution for this problem, and then mention the max-heap of size k solution as an optimization when k is much smaller than n. If asked for the most efficient solution, I would mention the quick select algorithm.
