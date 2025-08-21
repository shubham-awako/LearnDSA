# Same Tree

## Problem Statement

Given the roots of two binary trees `p` and `q`, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

**Example 1:**
```
Input: p = [1,2,3], q = [1,2,3]
Output: true
```

**Example 2:**
```
Input: p = [1,2], q = [1,null,2]
Output: false
```

**Example 3:**
```
Input: p = [1,2,1], q = [1,1,2]
Output: false
```

**Constraints:**
- The number of nodes in both trees is in the range `[0, 100]`.
- `-10^4 <= Node.val <= 10^4`

## Concept Overview

This problem tests your understanding of tree traversal and comparison. The key insight is to recursively compare the corresponding nodes of both trees.

## Solutions

### 1. Best Optimized Solution - Recursive Approach

Recursively compare the corresponding nodes of both trees.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isSameTree(p, q):
    # If both trees are empty, they are the same
    if not p and not q:
        return True
    
    # If one tree is empty but the other is not, they are different
    if not p or not q:
        return False
    
    # If the values are different, the trees are different
    if p.val != q.val:
        return False
    
    # Recursively check the left and right subtrees
    return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Iterative Approach with Queue (BFS)

Use a queue to perform a breadth-first traversal and compare the corresponding nodes.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isSameTree(p, q):
    # Use a queue for BFS
    queue = deque([(p, q)])
    
    while queue:
        node1, node2 = queue.popleft()
        
        # If both nodes are None, continue
        if not node1 and not node2:
            continue
        
        # If one node is None but the other is not, or if the values are different
        if not node1 or not node2 or node1.val != node2.val:
            return False
        
        # Add the children to the queue
        queue.append((node1.left, node2.left))
        queue.append((node1.right, node2.right))
    
    return True
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(w) - The queue can contain at most w nodes, where w is the maximum width of the tree. In the worst case, w = n/2 for a complete binary tree.

### 3. Alternative Solution - Iterative Approach with Stack (DFS)

Use a stack to perform a depth-first traversal and compare the corresponding nodes.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isSameTree(p, q):
    # Use a stack for DFS
    stack = [(p, q)]
    
    while stack:
        node1, node2 = stack.pop()
        
        # If both nodes are None, continue
        if not node1 and not node2:
            continue
        
        # If one node is None but the other is not, or if the values are different
        if not node1 or not node2 or node1.val != node2.val:
            return False
        
        # Add the children to the stack
        stack.append((node1.right, node2.right))
        stack.append((node1.left, node2.left))
    
    return True
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The recursive approach (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Readability**: It's easy to understand and follows the natural recursive structure of the problem.

3. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is typically O(log n) for a balanced tree.

The key insight of this approach is to use recursion to compare the corresponding nodes of both trees. For each pair of nodes, we:
1. Check if both nodes are null. If so, they are the same.
2. Check if one node is null but the other is not. If so, they are different.
3. Check if the values of the nodes are different. If so, they are different.
4. Recursively check if the left subtrees are the same and if the right subtrees are the same.

For example, let's check if the trees p = [1,2,3] and q = [1,2,3] are the same:
```
    1          1
   / \        / \
  2   3      2   3
```

1. At the roots (1, 1):
   - Both nodes are not null and have the same value (1).
   - Recursively check the left subtrees (2, 2).
   - Recursively check the right subtrees (3, 3).

2. At the left children (2, 2):
   - Both nodes are not null and have the same value (2).
   - Recursively check the left subtrees (null, null).
   - Recursively check the right subtrees (null, null).

3. At the right children (3, 3):
   - Both nodes are not null and have the same value (3).
   - Recursively check the left subtrees (null, null).
   - Recursively check the right subtrees (null, null).

4. At the null nodes:
   - Both nodes are null, so they are the same.

5. Final result: True

The iterative approaches (Solutions 2 and 3) are also efficient but slightly more complex. The BFS approach (Solution 2) uses a queue to process nodes level by level, while the DFS approach (Solution 3) uses a stack to process nodes in a depth-first manner.

In an interview, I would first mention the recursive approach as the most elegant solution for this problem, and then mention the iterative approaches as alternatives if asked for non-recursive solutions.
