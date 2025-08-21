# Find Median from Data Stream

## Problem Statement

The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value, and the median is the mean of the two middle values.

- For example, for `arr = [2,3,4]`, the median is `3`.
- For example, for `arr = [2,3]`, the median is `(2 + 3) / 2 = 2.5`.

Implement the MedianFinder class:

- `MedianFinder()` initializes the `MedianFinder` object.
- `void addNum(int num)` adds the integer `num` from the data stream to the data structure.
- `double findMedian()` returns the median of all elements so far. Answers within `10^-5` of the actual answer will be accepted.

**Example 1:**
```
Input
["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
[[], [1], [2], [], [3], []]
Output
[null, null, null, 1.5, null, 2.0]

Explanation
MedianFinder medianFinder = new MedianFinder();
medianFinder.addNum(1);    // arr = [1]
medianFinder.addNum(2);    // arr = [1, 2]
medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
medianFinder.addNum(3);    // arr = [1, 2, 3]
medianFinder.findMedian(); // return 2.0
```

**Constraints:**
- `-10^5 <= num <= 10^5`
- There will be at least one element in the data structure before calling `findMedian`.
- At most `5 * 10^4` calls will be made to `addNum` and `findMedian`.

**Follow up:**
- If all integer numbers from the stream are in the range `[0, 100]`, how would you optimize your solution?
- If `99%` of all integer numbers from the stream are in the range `[0, 100]`, how would you optimize your solution?

## Concept Overview

This problem tests your understanding of heaps and priority queues. The key insight is to maintain two heaps: a max-heap for the smaller half of the numbers and a min-heap for the larger half. The median can then be found by looking at the top elements of the heaps.

## Solutions

### 1. Best Optimized Solution - Two Heaps

Use a max-heap for the smaller half of the numbers and a min-heap for the larger half.

```python
import heapq

class MedianFinder:
    def __init__(self):
        # Initialize the MedianFinder object
        self.small = []  # Max-heap for the smaller half (implemented as a min-heap with negative values)
        self.large = []  # Min-heap for the larger half

    def addNum(self, num):
        # Add the number to the appropriate heap
        if len(self.small) == len(self.large):
            # If both heaps have the same size, add to the small heap
            # But first, we need to make sure the new number is smaller than the smallest in the large heap
            heapq.heappush(self.small, -heapq.heappushpop(self.large, num))
        else:
            # If the small heap has more elements, add to the large heap
            # But first, we need to make sure the new number is larger than the largest in the small heap
            heapq.heappush(self.large, -heapq.heappushpop(self.small, -num))

    def findMedian(self):
        # If both heaps have the same size, the median is the average of the tops
        if len(self.small) == len(self.large):
            return (-self.small[0] + self.large[0]) / 2
        # Otherwise, the median is the top of the small heap
        else:
            return -self.small[0]
```

**Time Complexity:**
- `addNum`: O(log n) - We perform heap operations, which take logarithmic time.
- `findMedian`: O(1) - We simply look at the top elements of the heaps.

**Space Complexity:** O(n) - We store all numbers in the heaps.

### 2. Alternative Solution - Insertion Sort

Maintain a sorted array and insert each new number in its correct position.

```python
import bisect

class MedianFinder:
    def __init__(self):
        # Initialize the MedianFinder object
        self.nums = []  # Sorted array of numbers

    def addNum(self, num):
        # Insert the number in its correct position
        bisect.insort(self.nums, num)

    def findMedian(self):
        # If the array has an odd number of elements, return the middle element
        if len(self.nums) % 2 == 1:
            return self.nums[len(self.nums) // 2]
        # Otherwise, return the average of the two middle elements
        else:
            return (self.nums[len(self.nums) // 2 - 1] + self.nums[len(self.nums) // 2]) / 2
```

**Time Complexity:**
- `addNum`: O(n) - Inserting a number in a sorted array takes linear time.
- `findMedian`: O(1) - We simply look at the middle elements of the array.

**Space Complexity:** O(n) - We store all numbers in the array.

### 3. Alternative Solution - Self-Balancing Binary Search Tree

Use a self-balancing binary search tree (like an AVL tree or a Red-Black tree) to maintain the sorted order of the numbers.

```python
from sortedcontainers import SortedList

class MedianFinder:
    def __init__(self):
        # Initialize the MedianFinder object
        self.nums = SortedList()  # Sorted list of numbers

    def addNum(self, num):
        # Add the number to the sorted list
        self.nums.add(num)

    def findMedian(self):
        # If the list has an odd number of elements, return the middle element
        if len(self.nums) % 2 == 1:
            return self.nums[len(self.nums) // 2]
        # Otherwise, return the average of the two middle elements
        else:
            return (self.nums[len(self.nums) // 2 - 1] + self.nums[len(self.nums) // 2]) / 2
```

**Time Complexity:**
- `addNum`: O(log n) - Adding a number to a self-balancing binary search tree takes logarithmic time.
- `findMedian`: O(1) - We simply look at the middle elements of the tree.

**Space Complexity:** O(n) - We store all numbers in the tree.

## Solution Choice and Explanation

The two heaps solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity for `addNum` and O(1) time complexity for `findMedian`, which is optimal for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Efficiency**: It efficiently maintains the median without sorting the entire array.

The key insight of this approach is to divide the numbers into two halves: a smaller half and a larger half. We use a max-heap for the smaller half and a min-heap for the larger half. This way, the median can be found by looking at the top elements of the heaps:
- If both heaps have the same size, the median is the average of the tops.
- Otherwise, the median is the top of the heap with more elements (which is always the small heap in our implementation).

To maintain the balance between the heaps, we ensure that:
1. The size of the small heap is either equal to or one more than the size of the large heap.
2. All elements in the small heap are smaller than all elements in the large heap.

For example, let's trace through the example:
1. `addNum(1)`: Add 1 to the heaps.
   - Since both heaps are empty, we add 1 to the large heap and then move it to the small heap.
   - small = [-1], large = []
2. `addNum(2)`: Add 2 to the heaps.
   - Since the small heap has more elements, we add 2 to the large heap.
   - small = [-1], large = [2]
3. `findMedian()`: Find the median.
   - Both heaps have the same size, so the median is the average of the tops: (1 + 2) / 2 = 1.5
4. `addNum(3)`: Add 3 to the heaps.
   - Since both heaps have the same size, we add 3 to the large heap and then move the smallest element to the small heap.
   - But since 3 > 2, we add 3 directly to the large heap.
   - small = [-1], large = [2, 3]
   - We then move 2 to the small heap: small = [-1, -2], large = [3]
5. `findMedian()`: Find the median.
   - The small heap has more elements, so the median is the top of the small heap: 2

The insertion sort solution (Solution 2) is simple but less efficient for `addNum`, with a time complexity of O(n). The self-balancing binary search tree solution (Solution 3) is also efficient but requires a more complex data structure.

In an interview, I would first mention the two heaps solution as the most efficient approach for this problem.

**Follow-up Answers:**

1. If all integer numbers from the stream are in the range `[0, 100]`, we can use a counting sort approach:
   - Maintain an array `count` of size 101, where `count[i]` is the number of occurrences of `i` in the stream.
   - To find the median, we iterate through the `count` array and keep track of the position.
   - This gives us O(1) time complexity for `addNum` and O(100) = O(1) time complexity for `findMedian`.

2. If `99%` of all integer numbers from the stream are in the range `[0, 100]`, we can use a hybrid approach:
   - Use the counting sort approach for numbers in the range `[0, 100]`.
   - Use a self-balancing binary search tree for numbers outside this range.
   - This gives us O(1) time complexity for `addNum` in 99% of cases and O(log n) in the worst case, and O(1) time complexity for `findMedian`.
