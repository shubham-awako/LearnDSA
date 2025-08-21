# Subtree of Another Tree

## Problem Statement

Given the roots of two binary trees `root` and `subRoot`, return `true` if there is a subtree of `root` with the same structure and node values of `subRoot` and `false` otherwise.

A subtree of a binary tree `tree` is a tree that consists of a node in `tree` and all of this node's descendants. The tree `tree` could also be considered as a subtree of itself.

**Example 1:**
```
Input: root = [3,4,5,1,2], subRoot = [4,1,2]
Output: true
```

**Example 2:**
```
Input: root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]
Output: false
```

**Constraints:**
- The number of nodes in the `root` tree is in the range `[1, 2000]`.
- The number of nodes in the `subRoot` tree is in the range `[1, 1000]`.
- `-10^4 <= root.val <= 10^4`
- `-10^4 <= subRoot.val <= 10^4`

## Concept Overview

This problem tests your understanding of tree traversal and comparison. The key insight is to check if the subtree is the same as the main tree at any node.

## Solutions

### 1. Best Optimized Solution - Recursive Approach

Recursively check if the subtree is the same as the main tree at any node.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isSubtree(root, subRoot):
    # If the subtree is empty, it's always a subtree
    if not subRoot:
        return True
    
    # If the main tree is empty but the subtree is not, it's not a subtree
    if not root:
        return False
    
    # Check if the current subtree is the same as subRoot
    if isSameTree(root, subRoot):
        return True
    
    # Recursively check the left and right subtrees
    return isSubtree(root.left, subRoot) or isSubtree(root.right, subRoot)

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

**Time Complexity:** O(m * n) - In the worst case, we need to check if the subtree is the same at each node of the main tree, where m is the number of nodes in the main tree and n is the number of nodes in the subtree.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the main tree. In the worst case, h = m for a skewed tree.

### 2. Alternative Solution - String Serialization

Convert both trees to strings and check if the subtree string is a substring of the main tree string.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isSubtree(root, subRoot):
    # Convert both trees to strings
    root_str = serialize(root)
    subRoot_str = serialize(subRoot)
    
    # Check if the subtree string is a substring of the main tree string
    return subRoot_str in root_str

def serialize(root):
    if not root:
        return "#"
    
    # Use a special character to mark the end of a node to avoid false positives
    # For example, "1,2" should not match "12"
    return "^" + str(root.val) + "," + serialize(root.left) + "," + serialize(root.right)
```

**Time Complexity:** O(m + n) - We need to serialize both trees and check if one string is a substring of the other.
**Space Complexity:** O(m + n) - We need to store the serialized strings of both trees.

### 3. Alternative Solution - Iterative Approach

Use a queue to perform a breadth-first traversal of the main tree and check if the subtree is the same at any node.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isSubtree(root, subRoot):
    # If the subtree is empty, it's always a subtree
    if not subRoot:
        return True
    
    # If the main tree is empty but the subtree is not, it's not a subtree
    if not root:
        return False
    
    # Use a queue for BFS
    queue = deque([root])
    
    while queue:
        node = queue.popleft()
        
        # Check if the current subtree is the same as subRoot
        if node.val == subRoot.val and isSameTree(node, subRoot):
            return True
        
        # Add the children to the queue
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)
    
    return False

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

**Time Complexity:** O(m * n) - In the worst case, we need to check if the subtree is the same at each node of the main tree.
**Space Complexity:** O(m) - The queue can contain at most m nodes, where m is the number of nodes in the main tree.

## Solution Choice and Explanation

The recursive approach (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Readability**: It's easy to understand and follows the natural recursive structure of the problem.

3. **Efficiency**: It achieves O(m * n) time complexity, which is reasonable for this problem, and the space complexity is typically O(log m) for a balanced tree.

The key insight of this approach is to recursively check if the subtree is the same as the main tree at any node. For each node in the main tree, we:
1. Check if the current subtree is the same as the target subtree.
2. If not, recursively check if the target subtree is a subtree of the left subtree or the right subtree.

For example, let's check if the tree [4,1,2] is a subtree of [3,4,5,1,2]:
```
    3          4
   / \        / \
  4   5      1   2
 / \
1   2
```

1. At the root (3):
   - 3 != 4, so the current subtree is not the same.
   - Recursively check the left subtree (4).
   - Recursively check the right subtree (5).

2. At the left child (4):
   - 4 == 4, so check if the current subtree is the same.
   - The left subtree (1) is the same.
   - The right subtree (2) is the same.
   - The current subtree is the same, so return true.

3. Final result: True

The string serialization approach (Solution 2) is elegant but has potential issues with false positives if not implemented carefully. The iterative approach (Solution 3) is also efficient but slightly more complex.

In an interview, I would first mention the recursive approach as the most elegant solution for this problem, and then mention the string serialization approach as an alternative if asked for a different approach.
