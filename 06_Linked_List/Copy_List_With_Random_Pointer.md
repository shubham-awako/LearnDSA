# Copy List With Random Pointer

## Problem Statement

A linked list of length `n` is given such that each node contains an additional random pointer, which could point to any node in the list, or `null`.

Construct a deep copy of the list. The deep copy should consist of exactly `n` brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the `next` and `random` pointer of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. None of the pointers in the new list should point to nodes in the original list.

For example, if there are two nodes `X` and `Y` in the original list, where `X.random --> Y`, then for the corresponding two nodes `x` and `y` in the copied list, `x.random --> y`.

Return the head of the copied linked list.

The linked list is represented in the input/output as a list of `n` nodes. Each node is represented as a pair of `[val, random_index]` where:
- `val`: an integer representing `Node.val`
- `random_index`: the index of the node (range from `0` to `n-1`) that the `random` pointer points to, or `null` if it does not point to any node.

Your code will only be given the `head` of the original linked list.

**Example 1:**
```
Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
```

**Example 2:**
```
Input: head = [[1,1],[2,1]]
Output: [[1,1],[2,1]]
```

**Example 3:**
```
Input: head = [[3,null],[3,0],[3,null]]
Output: [[3,null],[3,0],[3,null]]
```

**Constraints:**
- `0 <= n <= 1000`
- `-10^4 <= Node.val <= 10^4`
- `Node.random` is `null` or is pointing to some node in the linked list.

## Concept Overview

This problem tests your understanding of linked list manipulation and deep copying. The key insight is to handle the random pointers efficiently, which can be done using a hash map or by interweaving the original and copied lists.

## Solutions

### 1. Hash Map Approach - Two Pass

Use a hash map to map original nodes to their corresponding copied nodes.

```python
# Definition for a Node.
# class Node:
#     def __init__(self, x, next=None, random=None):
#         self.val = int(x)
#         self.next = next
#         self.random = random

def copyRandomList(head):
    if not head:
        return None
    
    # First pass: Create a copy of each node and store in a hash map
    old_to_new = {}
    curr = head
    while curr:
        old_to_new[curr] = Node(curr.val)
        curr = curr.next
    
    # Second pass: Set the next and random pointers for each copied node
    curr = head
    while curr:
        old_to_new[curr].next = old_to_new.get(curr.next)
        old_to_new[curr].random = old_to_new.get(curr.random)
        curr = curr.next
    
    return old_to_new[head]
```

**Time Complexity:** O(n) - We iterate through the list twice.
**Space Complexity:** O(n) - We store all nodes in the hash map.

### 2. Best Optimized Solution - Interweaving

Interweave the original and copied lists, then separate them.

```python
# Definition for a Node.
# class Node:
#     def __init__(self, x, next=None, random=None):
#         self.val = int(x)
#         self.next = next
#         self.random = random

def copyRandomList(head):
    if not head:
        return None
    
    # Step 1: Create a copy of each node and interweave them
    # Original list: A -> B -> C
    # After step 1: A -> A' -> B -> B' -> C -> C'
    curr = head
    while curr:
        copy = Node(curr.val)
        copy.next = curr.next
        curr.next = copy
        curr = copy.next
    
    # Step 2: Set the random pointers for the copied nodes
    curr = head
    while curr:
        if curr.random:
            curr.next.random = curr.random.next
        curr = curr.next.next
    
    # Step 3: Separate the original and copied lists
    curr = head
    copy_head = head.next
    copy_curr = copy_head
    
    while copy_curr.next:
        curr.next = curr.next.next
        copy_curr.next = copy_curr.next.next
        curr = curr.next
        copy_curr = copy_curr.next
    
    # Set the last node's next pointer
    curr.next = None
    
    return copy_head
```

**Time Complexity:** O(n) - We iterate through the list three times.
**Space Complexity:** O(1) - We don't use any extra space besides the copied list.

### 3. Alternative Solution - Recursive with Memoization

Use recursion with memoization to create a deep copy of the list.

```python
# Definition for a Node.
# class Node:
#     def __init__(self, x, next=None, random=None):
#         self.val = int(x)
#         self.next = next
#         self.random = random

def copyRandomList(head):
    # Dictionary to store already processed nodes
    visited = {}
    
    def copy_node(node):
        if not node:
            return None
        
        # If we've already processed this node, return the copy
        if node in visited:
            return visited[node]
        
        # Create a new node and store it in the dictionary
        copy = Node(node.val)
        visited[node] = copy
        
        # Recursively copy the next and random pointers
        copy.next = copy_node(node.next)
        copy.random = copy_node(node.random)
        
        return copy
    
    return copy_node(head)
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(n) - We store all nodes in the dictionary and use the recursion stack.

## Solution Choice and Explanation

The hash map approach (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's straightforward to implement and understand.

2. **Efficiency**: It achieves O(n) time complexity with just two passes through the list.

3. **Robustness**: It handles all cases correctly, including cycles in the random pointers.

The key insight of this approach is to use a hash map to map original nodes to their corresponding copied nodes. This allows us to efficiently set the random pointers in the copied list.

For example, let's copy the list [[7,null],[13,0],[11,4],[10,2],[1,0]]:
1. First pass: Create a copy of each node and store in a hash map
   - old_to_new = {7: 7', 13: 13', 11: 11', 10: 10', 1: 1'}
2. Second pass: Set the next and random pointers for each copied node
   - 7'.next = 13', 7'.random = null
   - 13'.next = 11', 13'.random = 7'
   - 11'.next = 10', 11'.random = 1'
   - 10'.next = 1', 10'.random = 11'
   - 1'.next = null, 1'.random = 7'
3. Return 7'

The interweaving approach (Solution 2) is also efficient and uses O(1) extra space, but it's more complex and error-prone. The recursive approach (Solution 3) is elegant but uses O(n) extra space for the recursion stack and the dictionary.

In an interview, I would first mention the hash map approach as the most straightforward solution, and then mention the interweaving approach as an optimization if asked for a solution with O(1) extra space.
