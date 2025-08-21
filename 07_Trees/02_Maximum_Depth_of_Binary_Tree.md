# Maximum Depth of Binary Tree

## Problem Statement

Given the `root` of a binary tree, return its maximum depth.

A binary tree's **maximum depth** is the number of nodes along the longest path from the root node down to the farthest leaf node.

**Example 1:**
```
Input: root = [3,9,20,null,null,15,7]
Output: 3
```

**Example 2:**
```
Input: root = [1,null,2]
Output: 2
```

**Constraints:**
- The number of nodes in the tree is in the range `[0, 10^4]`.
- `-100 <= Node.val <= 100`

## Concept Overview

This problem tests your understanding of tree traversal and recursion. The key insight is to recursively calculate the depth of the left and right subtrees and take the maximum.

## Solutions

### 1. Best Optimized Solution - Recursive Approach

Recursively calculate the depth of the left and right subtrees and take the maximum.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def maxDepth(root):
    # Base case: empty tree
    if not root:
        return 0
    
    # Recursive case: calculate the depth of the left and right subtrees
    left_depth = maxDepth(root.left)
    right_depth = maxDepth(root.right)
    
    # Return the maximum depth plus 1 (for the current node)
    return max(left_depth, right_depth) + 1
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Iterative Approach with Queue (BFS)

Use a queue to perform a breadth-first traversal and keep track of the depth.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def maxDepth(root):
    if not root:
        return 0
    
    # Use a queue for BFS
    queue = deque([(root, 1)])  # (node, depth)
    max_depth = 0
    
    while queue:
        node, depth = queue.popleft()
        max_depth = max(max_depth, depth)
        
        # Add the children to the queue with increased depth
        if node.left:
            queue.append((node.left, depth + 1))
        if node.right:
            queue.append((node.right, depth + 1))
    
    return max_depth
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(w) - The queue can contain at most w nodes, where w is the maximum width of the tree. In the worst case, w = n/2 for a complete binary tree.

### 3. Alternative Solution - Iterative Approach with Stack (DFS)

Use a stack to perform a depth-first traversal and keep track of the depth.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def maxDepth(root):
    if not root:
        return 0
    
    # Use a stack for DFS
    stack = [(root, 1)]  # (node, depth)
    max_depth = 0
    
    while stack:
        node, depth = stack.pop()
        max_depth = max(max_depth, depth)
        
        # Add the children to the stack with increased depth
        if node.right:
            stack.append((node.right, depth + 1))
        if node.left:
            stack.append((node.left, depth + 1))
    
    return max_depth
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The recursive approach (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Readability**: It's easy to understand and follows the natural recursive structure of the problem.

3. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is typically O(log n) for a balanced tree.

The key insight of this approach is to use recursion to:
1. Calculate the maximum depth of the left subtree.
2. Calculate the maximum depth of the right subtree.
3. Return the maximum of the two depths plus 1 (for the current node).

For example, let's calculate the maximum depth of the tree [3,9,20,null,null,15,7]:
```
    3
   / \
  9  20
    /  \
   15   7
```

1. At the root (3):
   - Calculate the depth of the left subtree (9)
   - Calculate the depth of the right subtree (20)
   - Return max(left_depth, right_depth) + 1

2. At node 9:
   - Calculate the depth of the left subtree (null) = 0
   - Calculate the depth of the right subtree (null) = 0
   - Return max(0, 0) + 1 = 1

3. At node 20:
   - Calculate the depth of the left subtree (15) = 1
   - Calculate the depth of the right subtree (7) = 1
   - Return max(1, 1) + 1 = 2

4. Back at the root (3):
   - left_depth = 1
   - right_depth = 2
   - Return max(1, 2) + 1 = 3

5. Final result: 3

The iterative approaches (Solutions 2 and 3) are also efficient but slightly more complex. The BFS approach (Solution 2) uses a queue to process nodes level by level, while the DFS approach (Solution 3) uses a stack to process nodes in a depth-first manner.

In an interview, I would first mention the recursive approach as the most elegant solution for this problem, and then mention the iterative approaches as alternatives if asked for non-recursive solutions.
