# Invert Binary Tree

## Problem Statement

Given the `root` of a binary tree, invert the tree, and return its root.

**Example 1:**
```
Input: root = [4,2,7,1,3,6,9]
Output: [4,7,2,9,6,3,1]
```

**Example 2:**
```
Input: root = [2,1,3]
Output: [2,3,1]
```

**Example 3:**
```
Input: root = []
Output: []
```

**Constraints:**
- The number of nodes in the tree is in the range `[0, 100]`.
- `-100 <= Node.val <= 100`

## Concept Overview

This problem tests your understanding of binary tree traversal and manipulation. The key insight is to swap the left and right children of each node recursively.

## Solutions

### 1. Best Optimized Solution - Recursive Approach

Recursively swap the left and right children of each node.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def invertTree(root):
    # Base case: empty tree
    if not root:
        return None
    
    # Swap the left and right children
    root.left, root.right = root.right, root.left
    
    # Recursively invert the left and right subtrees
    invertTree(root.left)
    invertTree(root.right)
    
    return root
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Iterative Approach with Queue (BFS)

Use a queue to perform a breadth-first traversal and invert the tree level by level.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def invertTree(root):
    if not root:
        return None
    
    # Use a queue for BFS
    queue = deque([root])
    
    while queue:
        node = queue.popleft()
        
        # Swap the left and right children
        node.left, node.right = node.right, node.left
        
        # Add the children to the queue
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)
    
    return root
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(w) - The queue can contain at most w nodes, where w is the maximum width of the tree. In the worst case, w = n/2 for a complete binary tree.

### 3. Alternative Solution - Iterative Approach with Stack (DFS)

Use a stack to perform a depth-first traversal and invert the tree.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def invertTree(root):
    if not root:
        return None
    
    # Use a stack for DFS
    stack = [root]
    
    while stack:
        node = stack.pop()
        
        # Swap the left and right children
        node.left, node.right = node.right, node.left
        
        # Add the children to the stack
        if node.right:
            stack.append(node.right)
        if node.left:
            stack.append(node.left)
    
    return root
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The recursive approach (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Readability**: It's easy to understand and follows the natural recursive structure of the problem.

3. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is typically O(log n) for a balanced tree.

The key insight of this approach is to use recursion to:
1. Swap the left and right children of the current node.
2. Recursively invert the left subtree.
3. Recursively invert the right subtree.

For example, let's invert the tree [4,2,7,1,3,6,9]:
```
    4
   / \
  2   7
 / \ / \
1  3 6  9
```

1. At the root (4):
   - Swap left and right: 4.left = 7, 4.right = 2
   ```
       4
      / \
     7   2
    / \ / \
   6  9 1  3
   ```
   - Recursively invert the left subtree (7)
   - Recursively invert the right subtree (2)

2. At node 7:
   - Swap left and right: 7.left = 9, 7.right = 6
   ```
       4
      / \
     7   2
    / \ / \
   9  6 1  3
   ```
   - Recursively invert the left subtree (9) - no children, so no change
   - Recursively invert the right subtree (6) - no children, so no change

3. At node 2:
   - Swap left and right: 2.left = 3, 2.right = 1
   ```
       4
      / \
     7   2
    / \ / \
   9  6 3  1
   ```
   - Recursively invert the left subtree (3) - no children, so no change
   - Recursively invert the right subtree (1) - no children, so no change

4. Final result: [4,7,2,9,6,3,1]

The iterative approaches (Solutions 2 and 3) are also efficient but slightly more complex. The BFS approach (Solution 2) uses a queue to process nodes level by level, while the DFS approach (Solution 3) uses a stack to process nodes in a depth-first manner.

In an interview, I would first mention the recursive approach as the most elegant solution for this problem, and then mention the iterative approaches as alternatives if asked for non-recursive solutions.
