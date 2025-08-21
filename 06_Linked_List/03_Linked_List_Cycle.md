# Linked List Cycle

## Problem Statement

Given `head`, the head of a linked list, determine if the linked list has a cycle in it.

There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the `next` pointer. Internally, `pos` is used to denote the index of the node that tail's `next` pointer is connected to. **Note that `pos` is not passed as a parameter**.

Return `true` if there is a cycle in the linked list. Otherwise, return `false`.

**Example 1:**
```
Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).
```

**Example 2:**
```
Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.
```

**Example 3:**
```
Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.
```

**Constraints:**
- The number of the nodes in the list is in the range `[0, 10^4]`.
- `-10^5 <= Node.val <= 10^5`
- `pos` is `-1` or a valid index in the linked-list.

**Follow up:** Can you solve it using O(1) extra space?

## Concept Overview

This problem tests your understanding of cycle detection in linked lists. The key insight is to use the Floyd's Cycle-Finding Algorithm (also known as the "tortoise and hare" algorithm) to detect cycles efficiently.

## Solutions

### 1. Hash Set Approach

Use a hash set to keep track of visited nodes.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

def hasCycle(head):
    visited = set()
    
    current = head
    while current:
        if current in visited:
            return True
        visited.add(current)
        current = current.next
    
    return False
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(n) - In the worst case, we store all nodes in the hash set.

### 2. Best Optimized Solution - Floyd's Cycle-Finding Algorithm

Use two pointers (slow and fast) to detect cycles.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

def hasCycle(head):
    if not head or not head.next:
        return False
    
    slow = head
    fast = head.next
    
    while slow != fast:
        if not fast or not fast.next:
            return False
        slow = slow.next
        fast = fast.next.next
    
    return True
```

**Time Complexity:** O(n) - In the worst case, we iterate through the list once.
**Space Complexity:** O(1) - We use only two pointers regardless of input size.

### 3. Alternative Solution - Marking Nodes

Modify the nodes to mark them as visited.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

def hasCycle(head):
    while head:
        # If we've already marked this node, there's a cycle
        if head.val == float('inf'):
            return True
        
        # Mark the node as visited
        head.val = float('inf')
        head = head.next
    
    return False
```

**Time Complexity:** O(n) - We iterate through the list once.
**Space Complexity:** O(1) - We don't use any extra space.

**Note:** This solution modifies the original list, which may not be allowed in some cases.

## Solution Choice and Explanation

The Floyd's Cycle-Finding Algorithm (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which satisfies the follow-up challenge.

3. **Non-Destructive**: It doesn't modify the original list, unlike the marking nodes approach.

The key insight of this approach is to use two pointers that move at different speeds:
- The slow pointer moves one step at a time.
- The fast pointer moves two steps at a time.

If there's a cycle, the fast pointer will eventually catch up to the slow pointer. If there's no cycle, the fast pointer will reach the end of the list.

For example, consider a linked list with a cycle: 3 -> 2 -> 0 -> -4 -> (back to 2)
1. Initialize: slow = 3, fast = 2
2. Iteration 1: slow = 2, fast = -4
3. Iteration 2: slow = 0, fast = 2
4. Iteration 3: slow = -4, fast = -4
5. slow == fast, so there's a cycle

The hash set approach (Solution 1) is also efficient but uses O(n) extra space. The marking nodes approach (Solution 3) is efficient in terms of time and space but modifies the original list, which may not be acceptable.

In an interview, I would first mention the Floyd's Cycle-Finding Algorithm as the most efficient solution that satisfies the follow-up challenge of using O(1) extra space.
