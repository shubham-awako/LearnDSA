# Reverse Nodes In K Group

## Problem Statement

Given the `head` of a linked list, reverse the nodes of the list `k` at a time, and return the modified list.

`k` is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of `k` then left-out nodes, in the end, should remain as it is.

You may not alter the values in the list's nodes, only nodes themselves may be changed.

**Example 1:**
```
Input: head = [1,2,3,4,5], k = 2
Output: [2,1,4,3,5]
```

**Example 2:**
```
Input: head = [1,2,3,4,5], k = 3
Output: [3,2,1,4,5]
```

**Example 3:**
```
Input: head = [1,2,3,4,5], k = 1
Output: [1,2,3,4,5]
```

**Example 4:**
```
Input: head = [1], k = 1
Output: [1]
```

**Constraints:**
- The number of nodes in the list is `n`.
- `1 <= k <= n <= 5000`
- `0 <= Node.val <= 1000`

**Follow-up:** Can you solve the problem in O(1) extra memory space?

## Concept Overview

This problem tests your understanding of linked list manipulation and group reversal. The key insight is to reverse each group of k nodes and carefully connect the groups together.

## Solutions

### 1. Best Optimized Solution - Iterative Approach

Reverse each group of k nodes iteratively and connect the groups together.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseKGroup(head, k):
    # Create a dummy node to simplify edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Initialize pointers
    prev_group_end = dummy
    
    while True:
        # Check if there are at least k nodes left
        kth_node = get_kth_node(prev_group_end, k)
        if not kth_node:
            break
        
        # Save the start of the next group
        next_group_start = kth_node.next
        
        # Reverse the current group
        curr = prev_group_end.next
        prev = next_group_start
        
        for _ in range(k):
            temp = curr.next
            curr.next = prev
            prev = curr
            curr = temp
        
        # Connect the reversed group to the rest of the list
        group_start = prev_group_end.next
        prev_group_end.next = kth_node
        prev_group_end = group_start
    
    return dummy.next

def get_kth_node(curr, k):
    # Return the kth node after curr, or None if there are fewer than k nodes
    for _ in range(k):
        curr = curr.next
        if not curr:
            return None
    return curr
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Recursive Approach

Reverse each group of k nodes recursively.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseKGroup(head, k):
    # Check if there are at least k nodes left
    curr = head
    count = 0
    while curr and count < k:
        curr = curr.next
        count += 1
    
    if count < k:
        return head
    
    # Reverse the first k nodes
    curr = head
    prev = None
    next_temp = None
    
    for _ in range(k):
        next_temp = curr.next
        curr.next = prev
        prev = curr
        curr = next_temp
    
    # Recursively reverse the rest of the list
    head.next = reverseKGroup(curr, k)
    
    return prev
```

**Time Complexity:** O(n) - We process each node once.
**Space Complexity:** O(n/k) - The recursion stack can go up to n/k levels deep.

### 3. Alternative Solution - Stack-Based Approach

Use a stack to reverse each group of k nodes.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def reverseKGroup(head, k):
    # Create a dummy node to simplify edge cases
    dummy = ListNode(0)
    dummy.next = head
    
    # Initialize pointers
    prev = dummy
    curr = head
    
    while curr:
        # Check if there are at least k nodes left
        count = 0
        temp = curr
        while temp and count < k:
            temp = temp.next
            count += 1
        
        if count < k:
            break
        
        # Use a stack to reverse the current group
        stack = []
        for _ in range(k):
            stack.append(curr)
            curr = curr.next
        
        # Connect the reversed group to the rest of the list
        while stack:
            prev.next = stack.pop()
            prev = prev.next
        
        prev.next = curr
    
    return dummy.next
```

**Time Complexity:** O(n) - We process each node once.
**Space Complexity:** O(k) - The stack can contain at most k nodes.

## Solution Choice and Explanation

The iterative approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which satisfies the follow-up challenge.

3. **Robustness**: It handles all cases correctly, including when the list length is not a multiple of k.

The key insight of this approach is to:
1. Use a dummy node to simplify edge cases.
2. Keep track of the end of the previous group to connect it to the reversed current group.
3. Check if there are at least k nodes left before reversing a group.
4. Reverse each group of k nodes in-place.
5. Connect the reversed group to the rest of the list.

For example, let's reverse the list [1,2,3,4,5] with k = 2:
1. Initialize: dummy -> 1 -> 2 -> 3 -> 4 -> 5, prev_group_end = dummy
2. First group: kth_node = 2, next_group_start = 3
   - Reverse: 1 -> 2 becomes 2 -> 1
   - Connect: dummy -> 2 -> 1 -> 3 -> 4 -> 5, prev_group_end = 1
3. Second group: kth_node = 4, next_group_start = 5
   - Reverse: 3 -> 4 becomes 4 -> 3
   - Connect: dummy -> 2 -> 1 -> 4 -> 3 -> 5, prev_group_end = 3
4. Third group: There are fewer than k nodes left, so don't reverse
5. Return dummy.next = [2,1,4,3,5]

The recursive approach (Solution 2) is elegant but uses O(n/k) extra space for the recursion stack. The stack-based approach (Solution 3) is also efficient but uses O(k) extra space for the stack.

In an interview, I would first mention the iterative approach as the most efficient solution that satisfies the follow-up challenge of using O(1) extra space.
