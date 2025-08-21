# 06. Linked List

## Concept Overview

A linked list is a linear data structure where elements are stored in nodes, and each node points to the next node in the sequence. Unlike arrays, linked lists do not store elements in contiguous memory locations, which allows for efficient insertions and deletions.

### Key Concepts
- **Node**: Basic unit of a linked list, containing data and a reference to the next node
- **Head**: First node of the linked list
- **Tail**: Last node of the linked list (points to null)
- **Singly Linked List**: Each node points only to the next node
- **Doubly Linked List**: Each node points to both the next and previous nodes
- **Circular Linked List**: The last node points back to the first node

### Common Operations
- **Traversal**: O(n) - Visit each node in the list
- **Insertion**: O(1) at the beginning or end (with tail pointer), O(n) in the middle
- **Deletion**: O(1) at the beginning, O(n) in the middle or end
- **Search**: O(n) - Find a specific node in the list

### Common Techniques
- **Two Pointers**: Fast and slow pointers for detecting cycles, finding the middle, etc.
- **Dummy Node**: Simplifies edge cases when manipulating the list
- **Recursion**: Useful for operations like reversing a linked list
- **Iterative Approach**: Often more space-efficient than recursion

### Advantages
- Dynamic size
- Efficient insertions and deletions
- No need to pre-allocate memory

### Disadvantages
- No random access (must traverse from the beginning)
- Extra memory for pointers
- Not cache-friendly due to non-contiguous memory allocation

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Reverse Linked List | Easy | [Solution](./01_Reverse_Linked_List.md) |
| 2 | Merge Two Sorted Lists | Easy | [Solution](./02_Merge_Two_Sorted_Lists.md) |
| 3 | Linked List Cycle | Easy | [Solution](./03_Linked_List_Cycle.md) |
| 4 | Reorder List | Medium | [Solution](./04_Reorder_List.md) |
| 5 | Remove Nth Node From End of List | Medium | [Solution](./05_Remove_Nth_Node_From_End_of_List.md) |
| 6 | Copy List With Random Pointer | Medium | [Solution](./06_Copy_List_With_Random_Pointer.md) |
| 7 | Add Two Numbers | Medium | [Solution](./07_Add_Two_Numbers.md) |
| 8 | Find The Duplicate Number | Medium | [Solution](./08_Find_The_Duplicate_Number.md) |
| 9 | Reverse Linked List II | Medium | [Solution](./09_Reverse_Linked_List_II.md) |
| 10 | Design Circular Queue | Medium | [Solution](./10_Design_Circular_Queue.md) |
| 11 | LRU Cache | Medium | [Solution](./11_LRU_Cache.md) |
| 12 | LFU Cache | Hard | [Solution](./12_LFU_Cache.md) |
| 13 | Merge K Sorted Lists | Hard | [Solution](./13_Merge_K_Sorted_Lists.md) |
| 14 | Reverse Nodes In K Group | Hard | [Solution](./14_Reverse_Nodes_In_K_Group.md) |
