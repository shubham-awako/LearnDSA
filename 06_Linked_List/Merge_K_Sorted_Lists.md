# Merge K Sorted Lists

## Problem Statement

You are given an array of `k` linked-lists `lists`, each linked-list is sorted in ascending order.

Merge all the linked-lists into one sorted linked-list and return it.

**Example 1:**
```
Input: lists = [[1,4,5],[1,3,4],[2,6]]
Output: [1,1,2,3,4,4,5,6]
Explanation: The linked-lists are:
[
  1->4->5,
  1->3->4,
  2->6
]
merging them into one sorted list:
1->1->2->3->4->4->5->6
```

**Example 2:**
```
Input: lists = []
Output: []
```

**Example 3:**
```
Input: lists = [[]]
Output: []
```

**Constraints:**
- `k == lists.length`
- `0 <= k <= 10^4`
- `0 <= lists[i].length <= 500`
- `-10^4 <= lists[i][j] <= 10^4`
- `lists[i]` is sorted in ascending order.
- The sum of `lists[i].length` won't exceed `10^4`.

## Concept Overview

This problem tests your understanding of linked list manipulation and efficient merging techniques. The key insight is to use a min-heap to efficiently find the smallest element among the heads of all lists.

## Solutions

### 1. Brute Force Approach - Merge One by One

Merge the lists one by one using the merge two sorted lists algorithm.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def mergeKLists(lists):
    if not lists:
        return None
    
    result = lists[0]
    
    for i in range(1, len(lists)):
        result = mergeTwoLists(result, lists[i])
    
    return result

def mergeTwoLists(l1, l2):
    dummy = ListNode(0)
    current = dummy
    
    while l1 and l2:
        if l1.val <= l2.val:
            current.next = l1
            l1 = l1.next
        else:
            current.next = l2
            l2 = l2.next
        current = current.next
    
    if l1:
        current.next = l1
    else:
        current.next = l2
    
    return dummy.next
```

**Time Complexity:** O(N * k) - We merge k lists of total length N, and each merge operation takes O(N) time.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Best Optimized Solution - Min Heap

Use a min-heap to efficiently find the smallest element among the heads of all lists.

```python
import heapq

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def mergeKLists(lists):
    # Remove empty lists
    lists = [lst for lst in lists if lst]
    
    if not lists:
        return None
    
    # Create a min-heap of (value, node) pairs
    heap = []
    for i, node in enumerate(lists):
        # Use i as a tiebreaker to avoid comparing nodes
        heapq.heappush(heap, (node.val, i, node))
    
    dummy = ListNode(0)
    current = dummy
    
    while heap:
        val, i, node = heapq.heappop(heap)
        current.next = node
        current = current.next
        
        if node.next:
            heapq.heappush(heap, (node.next.val, i, node.next))
    
    return dummy.next
```

**Time Complexity:** O(N * log k) - We process each node once, and each heap operation takes O(log k) time.
**Space Complexity:** O(k) - The heap can contain at most k nodes.

### 3. Alternative Solution - Divide and Conquer

Use a divide-and-conquer approach to merge the lists.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def mergeKLists(lists):
    if not lists:
        return None
    
    return merge_lists(lists, 0, len(lists) - 1)

def merge_lists(lists, left, right):
    if left == right:
        return lists[left]
    
    if left < right:
        mid = left + (right - left) // 2
        l1 = merge_lists(lists, left, mid)
        l2 = merge_lists(lists, mid + 1, right)
        return mergeTwoLists(l1, l2)
    
    return None

def mergeTwoLists(l1, l2):
    dummy = ListNode(0)
    current = dummy
    
    while l1 and l2:
        if l1.val <= l2.val:
            current.next = l1
            l1 = l1.next
        else:
            current.next = l2
            l2 = l2.next
        current = current.next
    
    if l1:
        current.next = l1
    else:
        current.next = l2
    
    return dummy.next
```

**Time Complexity:** O(N * log k) - We merge log k times, and each merge operation takes O(N) time.
**Space Complexity:** O(log k) - The recursion stack can go up to log k levels deep.

## Solution Choice and Explanation

The min-heap solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(N * log k) time complexity, which is optimal for this problem.

2. **Efficiency**: It efficiently finds the smallest element among the heads of all lists using a min-heap.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use a min-heap to efficiently find the smallest element among the heads of all lists. We maintain a min-heap of (value, index, node) tuples, where index is used as a tiebreaker to avoid comparing nodes. We start by adding the head of each list to the heap, and then iteratively:
1. Pop the smallest element from the heap.
2. Add it to the result list.
3. If the node has a next node, add that to the heap.

For example, let's merge the lists [[1,4,5],[1,3,4],[2,6]]:
1. Initialize: heap = [(1, 0, node1), (1, 1, node2), (2, 2, node3)]
2. Pop (1, 0, node1): result = 1, heap = [(1, 1, node2), (2, 2, node3)], push (4, 0, node4)
3. Pop (1, 1, node2): result = 1->1, heap = [(2, 2, node3), (4, 0, node4)], push (3, 1, node5)
4. Pop (2, 2, node3): result = 1->1->2, heap = [(3, 1, node5), (4, 0, node4)], push (6, 2, node6)
5. Pop (3, 1, node5): result = 1->1->2->3, heap = [(4, 0, node4), (6, 2, node6)], push (4, 1, node7)
6. Pop (4, 0, node4): result = 1->1->2->3->4, heap = [(4, 1, node7), (6, 2, node6)], push (5, 0, node8)
7. Pop (4, 1, node7): result = 1->1->2->3->4->4, heap = [(5, 0, node8), (6, 2, node6)]
8. Pop (5, 0, node8): result = 1->1->2->3->4->4->5, heap = [(6, 2, node6)]
9. Pop (6, 2, node6): result = 1->1->2->3->4->4->5->6, heap = []
10. Return result = [1,1,2,3,4,4,5,6]

The brute force approach (Solution 1) is simple but has a higher time complexity of O(N * k). The divide-and-conquer approach (Solution 3) also achieves O(N * log k) time complexity but is more complex to implement.

In an interview, I would first mention the min-heap approach as the most efficient solution for this problem.
