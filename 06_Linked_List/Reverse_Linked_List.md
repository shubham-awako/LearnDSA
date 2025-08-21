# Reverse Linked List

## Problem Statement

Given the head of a singly linked list, reverse the list, and return the reversed list.

**Example 1:**
```
Input: head = [1,2,3,4,5]
Output: [5,4,3,2,1]
```

**Example 2:**
```
Input: head = [1,2]
Output: [2,1]
```

**Example 3:**
```
Input: head = []
Output: []
```

**Constraints:**
- The number of nodes in the list is the range `[0, 5000]`.
- `-5000 <= Node.val <= 5000`

**Follow up:** A linked list can be reversed either iteratively or recursively. Could you implement both?

## Concept Overview

This problem tests your understanding of linked list manipulation. The key insight is to reverse the direction of pointers in the list.

## Solutions

### 1. Iterative Approach

Iterate through the list and reverse the pointers.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseList(head):
    prev = None
    curr = head
    
    while curr:
        next_temp = curr.next  # Store the next node
        curr.next = prev       # Reverse the pointer
        prev = curr            # Move prev one step forward
        curr = next_temp       # Move curr one step forward
    
    return prev  # prev is the new head
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Recursive Approach

Use recursion to reverse the list.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseList(head):
    # Base case: empty list or single node
    if not head or not head.next:
        return head
    
    # Recursive case: reverse the rest of the list
    new_head = reverseList(head.next)
    
    # Reverse the pointer from the next node to the current node
    head.next.next = head
    
    # Set the current node's next to None to avoid cycles
    head.next = None
    
    return new_head
```

**Time Complexity:** O(n) - We process each node once.
**Space Complexity:** O(n) - The recursion stack can go up to n levels deep.

### 3. Alternative Approach - Stack

Use a stack to reverse the list.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseList(head):
    if not head:
        return None
    
    # Push all nodes onto a stack
    stack = []
    curr = head
    while curr:
        stack.append(curr)
        curr = curr.next
    
    # Pop nodes from the stack and update pointers
    new_head = stack.pop()
    curr = new_head
    
    while stack:
        curr.next = stack.pop()
        curr = curr.next
    
    # Set the last node's next to None
    curr.next = None
    
    return new_head
```

**Time Complexity:** O(n) - We process each node twice (once to push onto the stack and once to pop).
**Space Complexity:** O(n) - We store all nodes in the stack.

## Solution Choice and Explanation

The iterative approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the recursive and stack approaches.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use three pointers (prev, curr, and next_temp) to reverse the pointers in the list:
- `prev` starts as None and will become the new head of the reversed list.
- `curr` starts at the head of the original list and iterates through the list.
- `next_temp` temporarily stores the next node to avoid losing it when we reverse the pointer.

In each iteration:
1. Store the next node: `next_temp = curr.next`
2. Reverse the pointer: `curr.next = prev`
3. Move prev one step forward: `prev = curr`
4. Move curr one step forward: `curr = next_temp`

After the loop, `prev` will be the new head of the reversed list.

For example, let's reverse the list [1,2,3,4,5]:
1. Initialize: prev = None, curr = 1
2. Iteration 1: next_temp = 2, 1.next = None, prev = 1, curr = 2
3. Iteration 2: next_temp = 3, 2.next = 1, prev = 2, curr = 3
4. Iteration 3: next_temp = 4, 3.next = 2, prev = 3, curr = 4
5. Iteration 4: next_temp = 5, 4.next = 3, prev = 4, curr = 5
6. Iteration 5: next_temp = None, 5.next = 4, prev = 5, curr = None
7. Loop ends, return prev = 5

The recursive approach (Solution 2) is also efficient but uses O(n) extra space for the recursion stack. The stack approach (Solution 3) is less efficient and more complex.

In an interview, I would first mention the iterative approach as the most efficient solution, and then mention the recursive approach as an alternative if asked for multiple solutions.
