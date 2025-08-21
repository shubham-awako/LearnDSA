# Reverse Linked List II

## Problem Statement

Given the `head` of a singly linked list and two integers `left` and `right` where `left <= right`, reverse the nodes of the list from position `left` to position `right`, and return the reversed list.

**Example 1:**
```
Input: head = [1,2,3,4,5], left = 2, right = 4
Output: [1,4,3,2,5]
```

**Example 2:**
```
Input: head = [5], left = 1, right = 1
Output: [5]
```

**Constraints:**
- The number of nodes in the list is `n`.
- `1 <= n <= 500`
- `-500 <= Node.val <= 500`
- `1 <= left <= right <= n`

**Follow up:** Could you do it in one pass?

## Concept Overview

This problem tests your understanding of linked list manipulation and partial reversal. The key insight is to carefully track the nodes before and after the reversed section, and then reverse the nodes in the specified range.

## Solutions

### 1. Best Optimized Solution - One-Pass Approach

Reverse the nodes in the specified range in a single pass.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseBetween(head, left, right):
    # If the list is empty or there's only one node, or no reversal needed
    if not head or not head.next or left == right:
        return head
    
    # Create a dummy node to handle edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Find the node before the reversal starts
    prev = dummy
    for i in range(left - 1):
        prev = prev.next
    
    # Start of the sublist to be reversed
    current = prev.next
    
    # Reverse the sublist from left to right
    for i in range(right - left):
        temp = current.next
        current.next = temp.next
        temp.next = prev.next
        prev.next = temp
    
    return dummy.next
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Two-Pass Approach

First, find the nodes before and after the reversed section, then reverse the nodes in the specified range.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseBetween(head, left, right):
    # If the list is empty or there's only one node, or no reversal needed
    if not head or not head.next or left == right:
        return head
    
    # Create a dummy node to handle edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Find the node before the reversal starts
    prev = dummy
    for i in range(left - 1):
        prev = prev.next
    
    # Find the node where the reversal ends
    end = prev.next
    for i in range(right - left):
        end = end.next
    
    # Find the node after the reversal ends
    after = end.next
    
    # Cut the connection to isolate the sublist
    end.next = None
    
    # Reverse the sublist
    reversed_head = reverse(prev.next)
    
    # Connect the reversed sublist back to the original list
    prev.next.next = after
    prev.next = reversed_head
    
    return dummy.next

def reverse(head):
    prev = None
    curr = head
    
    while curr:
        next_temp = curr.next
        curr.next = prev
        prev = curr
        curr = next_temp
    
    return prev
```

**Time Complexity:** O(n) - We iterate through the list twice.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 3. Alternative Solution - Recursive Approach

Use recursion to reverse the nodes in the specified range.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseBetween(head, left, right):
    # Base case: empty list or only one node
    if not head or not head.next:
        return head
    
    # Create a dummy node to handle edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Find the node before the reversal starts
    prev = dummy
    for i in range(left - 1):
        prev = prev.next
    
    # Start of the sublist to be reversed
    current = prev.next
    
    # Recursive function to reverse the sublist
    def reverse_sublist(node, count):
        if count == right - left:
            # End of the sublist to be reversed
            return node
        
        # Reverse the next node
        next_node = node.next
        rest = reverse_sublist(next_node, count + 1)
        
        # Reverse the pointers
        next_node.next = node
        
        return rest
    
    # Reverse the sublist
    tail = current
    new_head = reverse_sublist(current, 0)
    
    # Connect the reversed sublist back to the original list
    prev.next = new_head
    tail.next = None  # Cut the connection to avoid cycles
    
    # Find the end of the reversed sublist
    end = new_head
    for i in range(right - left):
        end = end.next
    
    # Connect the end of the reversed sublist to the rest of the list
    end.next = None  # Cut the connection to avoid cycles
    tail.next = end.next
    
    return dummy.next
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(n) - The recursion stack can go up to n levels deep in the worst case.

**Note:** This solution is more complex and error-prone than the iterative approaches.

## Solution Choice and Explanation

The one-pass approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity with a single pass through the list, which satisfies the follow-up challenge.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is optimal for this problem.

3. **Simplicity**: It's more straightforward to implement and understand than the recursive approach.

The key insight of this approach is to use a dummy node to handle edge cases and carefully track the nodes before and after the reversed section. The reversal is done in-place by iteratively changing the pointers.

For example, let's reverse the list [1,2,3,4,5] from position 2 to 4:
1. Initialize: dummy -> 1 -> 2 -> 3 -> 4 -> 5, prev = dummy
2. Move prev to the node before the reversal starts: prev = 1
3. Set current to the start of the sublist to be reversed: current = 2
4. Reverse the sublist from left to right:
   - Iteration 1: temp = 3, current.next = 4, temp.next = 2, prev.next = 3
     Result: 1 -> 3 -> 2 -> 4 -> 5
   - Iteration 2: temp = 4, current.next = 5, temp.next = 3, prev.next = 4
     Result: 1 -> 4 -> 3 -> 2 -> 5
   - Iteration 3: No more iterations needed
5. Return dummy.next = [1,4,3,2,5]

The two-pass approach (Solution 2) is also efficient but requires two passes through the list. The recursive approach (Solution 3) is more complex and uses O(n) extra space for the recursion stack.

In an interview, I would first mention the one-pass approach as the most efficient solution that satisfies the follow-up challenge of doing it in one pass.
