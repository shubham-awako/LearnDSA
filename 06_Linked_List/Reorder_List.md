# Reorder List

## Problem Statement

You are given the head of a singly linked-list. The list can be represented as:

L0 → L1 → … → Ln-1 → Ln

Reorder the list to be on the following form:

L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …

You may not modify the values in the list's nodes. Only nodes themselves may be changed.

**Example 1:**
```
Input: head = [1,2,3,4]
Output: [1,4,2,3]
```

**Example 2:**
```
Input: head = [1,2,3,4,5]
Output: [1,5,2,4,3]
```

**Constraints:**
- The number of nodes in the list is in the range `[1, 5 * 10^4]`.
- `1 <= Node.val <= 1000`

## Concept Overview

This problem tests your understanding of linked list manipulation. The key insight is to break down the problem into three steps:
1. Find the middle of the linked list.
2. Reverse the second half of the linked list.
3. Merge the first half and the reversed second half alternately.

## Solutions

### 1. Best Optimized Solution - Three-Step Approach

Break down the problem into three steps: find the middle, reverse the second half, and merge alternately.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reorderList(head):
    if not head or not head.next:
        return
    
    # Step 1: Find the middle of the linked list
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    
    # Step 2: Reverse the second half of the linked list
    prev = None
    curr = slow
    while curr:
        next_temp = curr.next
        curr.next = prev
        prev = curr
        curr = next_temp
    
    # Step 3: Merge the first half and the reversed second half alternately
    first = head
    second = prev
    
    while second.next:
        temp1 = first.next
        temp2 = second.next
        
        first.next = second
        second.next = temp1
        
        first = temp1
        second = temp2
```

**Time Complexity:** O(n) - We iterate through the list three times (find middle, reverse, merge).
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Alternative Solution - Using a Stack

Use a stack to store the nodes and then reorder the list.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reorderList(head):
    if not head or not head.next:
        return
    
    # Put all nodes into a stack
    stack = []
    curr = head
    while curr:
        stack.append(curr)
        curr = curr.next
    
    # Reorder the list
    n = len(stack)
    curr = head
    
    for i in range(n // 2):
        temp = curr.next
        curr.next = stack.pop()
        curr.next.next = temp
        curr = temp
    
    # Set the last node's next to None
    curr.next = None
```

**Time Complexity:** O(n) - We iterate through the list twice (once to build the stack and once to reorder).
**Space Complexity:** O(n) - We store all nodes in the stack.

### 3. Alternative Solution - Using a Deque

Use a deque to store the nodes and then reorder the list.

```python
from collections import deque

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reorderList(head):
    if not head or not head.next:
        return
    
    # Put all nodes into a deque
    dq = deque()
    curr = head.next  # Start from the second node
    while curr:
        dq.append(curr)
        curr = curr.next
    
    # Reorder the list
    curr = head
    while dq:
        # Append the last node
        curr.next = dq.pop()
        curr = curr.next
        
        # Append the first node if there are nodes left
        if dq:
            curr.next = dq.popleft()
            curr = curr.next
    
    # Set the last node's next to None
    curr.next = None
```

**Time Complexity:** O(n) - We iterate through the list twice (once to build the deque and once to reorder).
**Space Complexity:** O(n) - We store all nodes in the deque.

## Solution Choice and Explanation

The three-step approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the stack and deque approaches.

3. **Clear Structure**: It breaks down the problem into three well-defined steps, making the solution easier to understand and implement.

The key insight of this approach is to break down the problem into three steps:
1. Find the middle of the linked list using the slow and fast pointer technique.
2. Reverse the second half of the linked list.
3. Merge the first half and the reversed second half alternately.

For example, let's reorder the list [1,2,3,4,5]:
1. Find the middle: slow = 3
2. Reverse the second half: [1,2] and [5,4,3]
3. Merge alternately: 1 -> 5 -> 2 -> 4 -> 3

The stack and deque approaches (Solutions 2 and 3) are also efficient in terms of time complexity but use O(n) extra space. The three-step approach achieves the same time complexity with O(1) extra space.

In an interview, I would first mention the three-step approach as the most efficient solution that uses O(1) extra space.
