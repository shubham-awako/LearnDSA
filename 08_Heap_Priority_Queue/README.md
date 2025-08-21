# 08. Heap / Priority Queue

## Concept Overview

A heap is a specialized tree-based data structure that satisfies the heap property. In a min-heap, for any given node, the value of the node is less than or equal to the values of its children. In a max-heap, the value of the node is greater than or equal to the values of its children.

A priority queue is an abstract data type similar to a regular queue, but where each element has a "priority" associated with it. Elements with higher priorities are dequeued before elements with lower priorities. While priority queues are often implemented with heaps, they can also be implemented with other data structures.

### Key Concepts
- **Min-Heap**: A complete binary tree where the value of each node is less than or equal to the values of its children.
- **Max-Heap**: A complete binary tree where the value of each node is greater than or equal to the values of its children.
- **Complete Binary Tree**: A binary tree in which all levels are completely filled except possibly the last level, which is filled from left to right.
- **Priority Queue**: An abstract data type that operates similar to a queue but with priorities assigned to elements.
- **Heapify**: The process of converting a binary tree into a heap.

### Common Operations
- **Insert**: O(log n) - Add an element to the heap while maintaining the heap property.
- **Extract Min/Max**: O(log n) - Remove and return the minimum (for min-heap) or maximum (for max-heap) element.
- **Peek**: O(1) - View the minimum (for min-heap) or maximum (for max-heap) element without removing it.
- **Heapify**: O(n) - Convert an array into a heap.
- **Decrease/Increase Key**: O(log n) - Decrease or increase the value of a key and maintain the heap property.
- **Delete**: O(log n) - Remove a specific element from the heap.

### Common Techniques
- **Binary Heap Implementation**: Using an array to represent a binary heap.
- **Heap Sort**: Using a heap to sort an array in O(n log n) time.
- **K-way Merge**: Using a heap to merge k sorted arrays.
- **Top K Elements**: Using a heap to find the k largest or smallest elements.

### Advantages
- Efficient insertion and extraction of the minimum/maximum element.
- Simple implementation using arrays.
- Space-efficient representation of a complete binary tree.

### Disadvantages
- Searching for an arbitrary element takes O(n) time.
- Not cache-friendly due to non-contiguous memory access patterns.
- Limited flexibility compared to other data structures like balanced binary search trees.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Kth Largest Element in a Stream | Easy | [Solution](./Kth_Largest_Element_in_a_Stream.md) |
| 2 | Last Stone Weight | Easy | [Solution](./Last_Stone_Weight.md) |
| 3 | K Closest Points to Origin | Medium | [Solution](./K_Closest_Points_to_Origin.md) |
| 4 | Kth Largest Element in an Array | Medium | [Solution](./Kth_Largest_Element_in_an_Array.md) |
| 5 | Task Scheduler | Medium | [Solution](./Task_Scheduler.md) |
| 6 | Design Twitter | Medium | [Solution](./Design_Twitter.md) |
| 7 | Find Median from Data Stream | Hard | [Solution](./Find_Median_from_Data_Stream.md) |