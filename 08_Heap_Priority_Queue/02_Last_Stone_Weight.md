# Last Stone Weight

## Problem Statement

You are given an array of integers `stones` where `stones[i]` is the weight of the `ith` stone.

We are playing a game with the stones. On each turn, we choose the two heaviest stones and smash them together. Suppose the heaviest stone has weight `x` and the second heaviest has weight `y`, with `x <= y`. The result of this smash is:

- If `x == y`, both stones are destroyed.
- If `x != y`, the stone of weight `x` is destroyed, and the stone of weight `y` has its weight reduced to `y - x`.

At the end of the game, there is at most one stone left.

Return the weight of the last stone. If there are no stones left, return `0`.

**Example 1:**
```
Input: stones = [2,7,4,1,8,1]
Output: 1
Explanation: 
We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
we combine 1 and 1 to get 0 so the array converts to [1] then that's the value of the last stone.
```

**Example 2:**
```
Input: stones = [1]
Output: 1
```

**Constraints:**
- `1 <= stones.length <= 30`
- `1 <= stones[i] <= 1000`

## Concept Overview

This problem tests your understanding of heaps and priority queues. The key insight is to use a max-heap to efficiently find and remove the two heaviest stones in each turn.

## Solutions

### 1. Best Optimized Solution - Max-Heap

Use a max-heap to efficiently find and remove the two heaviest stones in each turn.

```python
import heapq

def lastStoneWeight(stones):
    # Convert stones to negative values to simulate a max-heap (Python's heapq is a min-heap)
    max_heap = [-stone for stone in stones]
    heapq.heapify(max_heap)
    
    # Continue until there is at most one stone left
    while len(max_heap) > 1:
        # Get the two heaviest stones
        stone1 = -heapq.heappop(max_heap)
        stone2 = -heapq.heappop(max_heap)
        
        # Smash them together
        if stone1 != stone2:
            heapq.heappush(max_heap, -(stone1 - stone2))
    
    # Return the weight of the last stone, or 0 if there are no stones left
    return -max_heap[0] if max_heap else 0
```

**Time Complexity:** O(n log n) - Heapifying the array takes O(n) time, and each of the n operations takes O(log n) time.
**Space Complexity:** O(n) - We store all stones in the heap.

### 2. Alternative Solution - Sorting

Sort the array in each turn and remove the two heaviest stones.

```python
def lastStoneWeight(stones):
    # Continue until there is at most one stone left
    while len(stones) > 1:
        # Sort the stones in ascending order
        stones.sort()
        
        # Get the two heaviest stones
        stone1 = stones.pop()
        stone2 = stones.pop()
        
        # Smash them together
        if stone1 != stone2:
            stones.append(stone1 - stone2)
    
    # Return the weight of the last stone, or 0 if there are no stones left
    return stones[0] if stones else 0
```

**Time Complexity:** O(n^2 log n) - Each of the n operations requires sorting, which takes O(n log n) time.
**Space Complexity:** O(1) - We use the input array without additional space.

### 3. Alternative Solution - Priority Queue

Use a priority queue to efficiently find and remove the two heaviest stones in each turn.

```python
import queue

def lastStoneWeight(stones):
    # Create a priority queue (max-heap)
    pq = queue.PriorityQueue()
    
    # Add stones to the priority queue
    for stone in stones:
        pq.put(-stone)  # Negate to simulate max-heap
    
    # Continue until there is at most one stone left
    while pq.qsize() > 1:
        # Get the two heaviest stones
        stone1 = -pq.get()
        stone2 = -pq.get()
        
        # Smash them together
        if stone1 != stone2:
            pq.put(-(stone1 - stone2))
    
    # Return the weight of the last stone, or 0 if there are no stones left
    return -pq.get() if not pq.empty() else 0
```

**Time Complexity:** O(n log n) - Adding n elements to the priority queue takes O(n log n) time, and each of the n operations takes O(log n) time.
**Space Complexity:** O(n) - We store all stones in the priority queue.

## Solution Choice and Explanation

The max-heap solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n log n) time complexity, which is optimal for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Efficiency**: It efficiently finds and removes the two heaviest stones in each turn.

The key insight of this approach is to use a max-heap to efficiently find and remove the two heaviest stones in each turn. Since Python's `heapq` module implements a min-heap, we negate the stone weights to simulate a max-heap.

For example, let's trace through the example with stones = [2,7,4,1,8,1]:
1. Convert to max-heap: max_heap = [-8, -7, -4, -1, -2, -1]
2. Pop the two heaviest stones: stone1 = 8, stone2 = 7
3. Smash them together: 8 - 7 = 1
4. Push the result back: max_heap = [-4, -2, -1, -1, -1]
5. Pop the two heaviest stones: stone1 = 4, stone2 = 2
6. Smash them together: 4 - 2 = 2
7. Push the result back: max_heap = [-2, -1, -1, -1]
8. Pop the two heaviest stones: stone1 = 2, stone2 = 1
9. Smash them together: 2 - 1 = 1
10. Push the result back: max_heap = [-1, -1, -1]
11. Pop the two heaviest stones: stone1 = 1, stone2 = 1
12. Smash them together: 1 - 1 = 0 (no result to push back)
13. max_heap = [-1]
14. Return the last stone weight: 1

The sorting solution (Solution 2) is less efficient, as it requires sorting the array in each turn, which takes O(n log n) time. The priority queue solution (Solution 3) is similar to Solution 1 but uses Python's `queue.PriorityQueue` instead of `heapq`.

In an interview, I would first mention the max-heap solution as the most efficient approach for this problem.
