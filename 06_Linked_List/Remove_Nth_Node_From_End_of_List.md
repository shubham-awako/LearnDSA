# Remove Nth Node From End of List

## Problem Statement

Given the `head` of a linked list, remove the `n`th node from the end of the list and return its head.

**Example 1:**
```
Input: head = [1,2,3,4,5], n = 2
Output: [1,2,3,5]
```

**Example 2:**
```
Input: head = [1], n = 1
Output: []
```

**Example 3:**
```
Input: head = [1,2], n = 1
Output: [1]
```

**Constraints:**
- The number of nodes in the list is `sz`.
- `1 <= sz <= 30`
- `0 <= Node.val <= 100`
- `1 <= n <= sz`

**Follow up:** Could you do this in one pass?

## Concept Overview

This problem tests your understanding of linked list manipulation and the two-pointer technique. The key insight is to use two pointers with a gap of n nodes to find the node before the one to be removed.

## Solutions

### 1. Two-Pass Approach

First, count the number of nodes in the list, then remove the (length - n)th node.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def removeNthFromEnd(head, n):
    # Count the number of nodes
    length = 0
    curr = head
    while curr:
        length += 1
        curr = curr.next
    
    # If removing the first node
    if length == n:
        return head.next
    
    # Find the node before the one to be removed
    curr = head
    for i in range(length - n - 1):
        curr = curr.next
    
    # Remove the nth node from the end
    curr.next = curr.next.next
    
    return head
```

**Time Complexity:** O(n) - We iterate through the list twice.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Best Optimized Solution - One-Pass with Two Pointers

Use two pointers with a gap of n nodes to find the node before the one to be removed.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def removeNthFromEnd(head, n):
    # Create a dummy node to handle edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Initialize two pointers
    first = dummy
    second = dummy
    
    # Advance the first pointer by n+1 steps
    for i in range(n + 1):
        first = first.next
        if not first and i < n:  # If n is greater than the length of the list
            return head
    
    # Move both pointers until the first pointer reaches the end
    while first:
        first = first.next
        second = second.next
    
    # Remove the nth node from the end
    second.next = second.next.next
    
    return dummy.next
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 3. Alternative Solution - Using a Stack

Use a stack to keep track of the nodes and then remove the nth node from the end.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def removeNthFromEnd(head, n):
    # Create a dummy node to handle edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Push all nodes onto a stack
    stack = []
    curr = dummy
    while curr:
        stack.append(curr)
        curr = curr.next
    
    # Pop n nodes from the stack
    for i in range(n):
        stack.pop()
    
    # The node at the top of the stack is the one before the node to be removed
    prev = stack[-1]
    prev.next = prev.next.next
    
    return dummy.next
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(n) - We store all nodes in the stack.

## Solution Choice and Explanation

The one-pass with two pointers solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity with a single pass through the list, which satisfies the follow-up challenge.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the stack approach.

3. **Elegant Approach**: It uses the two-pointer technique to efficiently find the node before the one to be removed.

The key insight of this approach is to use two pointers with a gap of n nodes:
1. Initialize both pointers to a dummy node (to handle edge cases where the head needs to be removed).
2. Advance the first pointer by n+1 steps.
3. Move both pointers until the first pointer reaches the end of the list.
4. At this point, the second pointer will be at the node before the one to be removed.
5. Remove the nth node from the end by updating the next pointer of the second pointer.

For example, let's remove the 2nd node from the end of the list [1,2,3,4,5]:
1. Initialize: dummy -> 1 -> 2 -> 3 -> 4 -> 5, first = dummy, second = dummy
2. Advance first by 3 steps: first = 3
3. Move both pointers until first reaches the end:
   - first = 4, second = 1
   - first = 5, second = 2
   - first = null, second = 3
4. Remove the 2nd node from the end: 3.next = 3.next.next (skip 4)
5. Result: [1,2,3,5]

The two-pass approach (Solution 1) is also efficient but requires two passes through the list. The stack approach (Solution 3) is elegant but uses O(n) extra space.

In an interview, I would first mention the one-pass with two pointers approach as the most efficient solution that satisfies the follow-up challenge of doing it in one pass.
