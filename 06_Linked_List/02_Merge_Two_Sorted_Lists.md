# Merge Two Sorted Lists

## Problem Statement

You are given the heads of two sorted linked lists `list1` and `list2`.

Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.

**Example 1:**
```
Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]
```

**Example 2:**
```
Input: list1 = [], list2 = []
Output: []
```

**Example 3:**
```
Input: list1 = [], list2 = [0]
Output: [0]
```

**Constraints:**
- The number of nodes in both lists is in the range `[0, 50]`.
- `-100 <= Node.val <= 100`
- Both `list1` and `list2` are sorted in non-decreasing order.

## Concept Overview

This problem tests your understanding of linked list manipulation and merging sorted lists. The key insight is to compare nodes from both lists and build a new sorted list by choosing the smaller node at each step.

## Solutions

### 1. Iterative Approach

Iterate through both lists and merge them by selecting the smaller node at each step.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def mergeTwoLists(list1, list2):
    # Create a dummy node to simplify edge cases
    dummy = ListNode(0)
    current = dummy
    
    # Iterate through both lists
    while list1 and list2:
        if list1.val <= list2.val:
            current.next = list1
            list1 = list1.next
        else:
            current.next = list2
            list2 = list2.next
        current = current.next
    
    # Append the remaining nodes from either list
    if list1:
        current.next = list1
    else:
        current.next = list2
    
    return dummy.next
```

**Time Complexity:** O(n + m) - We iterate through both lists once, where n and m are the lengths of list1 and list2.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 2. Recursive Approach

Use recursion to merge the two lists.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def mergeTwoLists(list1, list2):
    # Base cases
    if not list1:
        return list2
    if not list2:
        return list1
    
    # Recursive case
    if list1.val <= list2.val:
        list1.next = mergeTwoLists(list1.next, list2)
        return list1
    else:
        list2.next = mergeTwoLists(list1, list2.next)
        return list2
```

**Time Complexity:** O(n + m) - We process each node once.
**Space Complexity:** O(n + m) - The recursion stack can go up to n + m levels deep in the worst case.

### 3. Alternative Approach - Create a New List

Create a new list by copying nodes from both input lists.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def mergeTwoLists(list1, list2):
    # Create a dummy node to simplify edge cases
    dummy = ListNode(0)
    current = dummy
    
    # Iterate through both lists
    while list1 and list2:
        if list1.val <= list2.val:
            current.next = ListNode(list1.val)
            list1 = list1.next
        else:
            current.next = ListNode(list2.val)
            list2 = list2.next
        current = current.next
    
    # Append the remaining nodes from either list
    while list1:
        current.next = ListNode(list1.val)
        list1 = list1.next
        current = current.next
    
    while list2:
        current.next = ListNode(list2.val)
        list2 = list2.next
        current = current.next
    
    return dummy.next
```

**Time Complexity:** O(n + m) - We process each node once.
**Space Complexity:** O(n + m) - We create new nodes for all elements in both lists.

## Solution Choice and Explanation

The iterative approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n + m) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n + m) space used by the recursive and new list approaches.

3. **In-Place Merging**: It reuses the existing nodes rather than creating new ones, which is more efficient.

The key insight of this approach is to use a dummy node to simplify edge cases and iterate through both lists, selecting the smaller node at each step. The dummy node serves as the starting point for the merged list, and we maintain a current pointer to keep track of the last node in the merged list.

For example, let's merge list1 = [1,2,4] and list2 = [1,3,4]:
1. Initialize: dummy = 0, current = dummy
2. Compare 1 and 1: Both are equal, so choose list1. current.next = 1 (from list1), list1 = [2,4], current = 1
3. Compare 2 and 1: 2 > 1, so choose list2. current.next = 1 (from list2), list2 = [3,4], current = 1
4. Compare 2 and 3: 2 < 3, so choose list1. current.next = 2 (from list1), list1 = [4], current = 2
5. Compare 4 and 3: 4 > 3, so choose list2. current.next = 3 (from list2), list2 = [4], current = 3
6. Compare 4 and 4: Both are equal, so choose list1. current.next = 4 (from list1), list1 = [], current = 4
7. list1 is empty, so append the rest of list2: current.next = 4 (from list2)
8. Return dummy.next = [1,1,2,3,4,4]

The recursive approach (Solution 2) is also elegant but uses O(n + m) extra space for the recursion stack. The alternative approach (Solution 3) is less efficient as it creates new nodes for all elements.

In an interview, I would first mention the iterative approach as the most efficient solution, and then mention the recursive approach as an alternative if asked for multiple solutions.
