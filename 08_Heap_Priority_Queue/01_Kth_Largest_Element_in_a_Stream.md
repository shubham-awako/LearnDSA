# Kth Largest Element in a Stream

## Problem Statement

Design a class to find the `kth` largest element in a stream. Note that it is the `kth` largest element in the sorted order, not the `kth` distinct element.

Implement `KthLargest` class:
- `KthLargest(int k, int[] nums)` Initializes the object with the integer `k` and the stream of integers `nums`.
- `int add(int val)` Appends the integer `val` to the stream and returns the element representing the `kth` largest element in the stream.

**Example 1:**
```
Input
["KthLargest", "add", "add", "add", "add", "add"]
[[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]
Output
[null, 4, 5, 5, 8, 8]

Explanation
KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
kthLargest.add(3);   // return 4
kthLargest.add(5);   // return 5
kthLargest.add(10);  // return 5
kthLargest.add(9);   // return 8
kthLargest.add(4);   // return 8
```

**Constraints:**
- `1 <= k <= 10^4`
- `0 <= nums.length <= 10^4`
- `-10^4 <= nums[i] <= 10^4`
- `-10^4 <= val <= 10^4`
- At most `10^4` calls will be made to `add`.
- It is guaranteed that there will be at least `k` elements in the array when you search for the `kth` element.

## Concept Overview

This problem tests your understanding of heaps and priority queues. The key insight is to maintain a min-heap of size k, which will contain the k largest elements seen so far. The smallest element in this heap (the root) will be the kth largest element in the stream.

## Solutions

### 1. Best Optimized Solution - Min-Heap of Size K

Use a min-heap of size k to keep track of the k largest elements seen so far.

```python
import heapq

class KthLargest:
    def __init__(self, k, nums):
        self.k = k
        self.min_heap = []
        
        # Initialize the min-heap with the first k elements (or all elements if there are fewer than k)
        for num in nums:
            self.add(num)
    
    def add(self, val):
        # If the heap has fewer than k elements, add the new element
        if len(self.min_heap) < self.k:
            heapq.heappush(self.min_heap, val)
        # If the new element is larger than the smallest element in the heap, replace it
        elif val > self.min_heap[0]:
            heapq.heappushpop(self.min_heap, val)
        
        # Return the kth largest element (the smallest element in the heap)
        return self.min_heap[0]
```

**Time Complexity:**
- Initialization: O(n log k) - We add n elements to the heap, and each addition takes O(log k) time.
- Add: O(log k) - We perform at most one push and one pop operation, each taking O(log k) time.

**Space Complexity:** O(k) - We store at most k elements in the heap.

### 2. Alternative Solution - Sorted List

Use a sorted list to keep track of the k largest elements seen so far.

```python
import bisect

class KthLargest:
    def __init__(self, k, nums):
        self.k = k
        self.sorted_list = sorted(nums)
        
        # Keep only the k largest elements
        if len(self.sorted_list) > k:
            self.sorted_list = self.sorted_list[-k:]
    
    def add(self, val):
        # Insert the new element in the sorted list
        bisect.insort(self.sorted_list, val)
        
        # Keep only the k largest elements
        if len(self.sorted_list) > self.k:
            self.sorted_list.pop(0)
        
        # Return the kth largest element (the smallest element in the list)
        return self.sorted_list[0]
```

**Time Complexity:**
- Initialization: O(n log n) - Sorting the array takes O(n log n) time.
- Add: O(k) - Inserting an element in a sorted list takes O(k) time in the worst case.

**Space Complexity:** O(k) - We store at most k elements in the list.

### 3. Alternative Solution - Full Min-Heap

Use a min-heap to store all elements and then extract the kth largest element.

```python
import heapq

class KthLargest:
    def __init__(self, k, nums):
        self.k = k
        self.nums = nums
        heapq.heapify(self.nums)
        
        # Remove elements until we have only k elements
        while len(self.nums) > k:
            heapq.heappop(self.nums)
    
    def add(self, val):
        # If the heap has fewer than k elements, add the new element
        if len(self.nums) < self.k:
            heapq.heappush(self.nums, val)
        # If the new element is larger than the smallest element in the heap, replace it
        elif val > self.nums[0]:
            heapq.heappushpop(self.nums, val)
        
        # Return the kth largest element (the smallest element in the heap)
        return self.nums[0]
```

**Time Complexity:**
- Initialization: O(n + (n - k) log n) - Heapifying the array takes O(n) time, and removing n - k elements takes O((n - k) log n) time.
- Add: O(log k) - We perform at most one push and one pop operation, each taking O(log k) time.

**Space Complexity:** O(k) - We store at most k elements in the heap.

## Solution Choice and Explanation

The min-heap of size k solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n log k) time complexity for initialization and O(log k) time complexity for each add operation, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(k) space, which is optimal for this problem.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to maintain a min-heap of size k, which will contain the k largest elements seen so far. The smallest element in this heap (the root) will be the kth largest element in the stream. When a new element arrives, we compare it with the smallest element in the heap:
- If the new element is larger, we replace the smallest element with the new element.
- If the new element is smaller or equal, we ignore it.

This way, the heap always contains the k largest elements seen so far, and the smallest element in the heap is the kth largest element.

For example, let's trace through the example:
1. Initialize KthLargest with k = 3 and nums = [4, 5, 8, 2]:
   - Add 4: heap = [4]
   - Add 5: heap = [4, 5]
   - Add 8: heap = [4, 5, 8]
   - Add 2: heap = [2, 5, 8] (replace 4 with 2)
   - After initialization, heap = [4, 5, 8]
2. Add 3: 3 < 4, so ignore it. Return 4.
3. Add 5: 5 > 4, so replace 4 with 5. Heap = [5, 5, 8]. Return 5.
4. Add 10: 10 > 5, so replace 5 with 10. Heap = [5, 8, 10]. Return 5.
5. Add 9: 9 > 5, so replace 5 with 9. Heap = [8, 9, 10]. Return 8.
6. Add 4: 4 < 8, so ignore it. Return 8.

The sorted list solution (Solution 2) is less efficient for the add operation, as inserting an element in a sorted list takes O(k) time in the worst case. The full min-heap solution (Solution 3) is similar to Solution 1 but initializes the heap differently.

In an interview, I would first mention the min-heap of size k solution as the most efficient approach for this problem.
