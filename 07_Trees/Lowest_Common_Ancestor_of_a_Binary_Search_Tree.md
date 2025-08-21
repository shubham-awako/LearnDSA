# Lowest Common Ancestor of a Binary Search Tree

## Problem Statement

Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.

According to the definition of LCA on Wikipedia: "The lowest common ancestor is defined between two nodes `p` and `q` as the lowest node in `T` that has both `p` and `q` as descendants (where we allow a node to be a descendant of itself)."

**Example 1:**
```
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
Explanation: The LCA of nodes 2 and 8 is 6.
```

**Example 2:**
```
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
Output: 2
Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
```

**Example 3:**
```
Input: root = [2,1], p = 2, q = 1
Output: 2
```

**Constraints:**
- The number of nodes in the tree is in the range `[2, 10^5]`.
- `-10^9 <= Node.val <= 10^9`
- All `Node.val` are unique.
- `p != q`
- `p` and `q` will exist in the BST.

## Concept Overview

This problem tests your understanding of binary search trees and the concept of the lowest common ancestor. The key insight is to use the BST property to efficiently find the LCA.

## Solutions

### 1. Best Optimized Solution - Recursive Approach

Use the BST property to recursively find the LCA.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

def lowestCommonAncestor(root, p, q):
    # If both p and q are smaller than the current node, the LCA must be in the left subtree
    if p.val < root.val and q.val < root.val:
        return lowestCommonAncestor(root.left, p, q)
    
    # If both p and q are larger than the current node, the LCA must be in the right subtree
    if p.val > root.val and q.val > root.val:
        return lowestCommonAncestor(root.right, p, q)
    
    # If one is smaller and one is larger, or one of them is equal to the current node, the current node is the LCA
    return root
```

**Time Complexity:** O(h) - We traverse at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep.

### 2. Alternative Solution - Iterative Approach

Use the BST property to iteratively find the LCA.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

def lowestCommonAncestor(root, p, q):
    # Start from the root
    current = root
    
    while current:
        # If both p and q are smaller than the current node, go to the left subtree
        if p.val < current.val and q.val < current.val:
            current = current.left
        # If both p and q are larger than the current node, go to the right subtree
        elif p.val > current.val and q.val > current.val:
            current = current.right
        # If one is smaller and one is larger, or one of them is equal to the current node, the current node is the LCA
        else:
            return current
    
    return None  # This line will not be reached if p and q are in the tree
```

**Time Complexity:** O(h) - We traverse at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.
**Space Complexity:** O(1) - We use only a constant amount of extra space.

### 3. Alternative Solution - General Binary Tree Approach

Use the general binary tree approach to find the LCA.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

def lowestCommonAncestor(root, p, q):
    # Base case: if the root is None or one of the nodes, return the root
    if not root or root == p or root == q:
        return root
    
    # Recursively find the LCA in the left and right subtrees
    left = lowestCommonAncestor(root.left, p, q)
    right = lowestCommonAncestor(root.right, p, q)
    
    # If both left and right are not None, the current node is the LCA
    if left and right:
        return root
    
    # If only one of them is not None, return that one
    return left if left else right
```

**Time Complexity:** O(n) - We may need to visit all nodes in the worst case.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The iterative approach (Solution 2) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(h) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(h) space used by the recursive approach.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use the BST property to iteratively find the LCA:
- If both p and q are smaller than the current node, the LCA must be in the left subtree.
- If both p and q are larger than the current node, the LCA must be in the right subtree.
- If one is smaller and one is larger, or one of them is equal to the current node, the current node is the LCA.

For example, let's find the LCA of nodes 2 and 8 in the BST [6,2,8,0,4,7,9]:
```
      6
     / \
    2   8
   / \ / \
  0  4 7  9
    / \
   3   5
```

1. Start at the root (6):
   - 2 < 6 and 8 > 6, so one is smaller and one is larger.
   - The current node (6) is the LCA.

2. Final result: 6

Now, let's find the LCA of nodes 2 and 4:
1. Start at the root (6):
   - 2 < 6 and 4 < 6, so both are smaller.
   - Go to the left subtree (2).

2. At node 2:
   - 2 == 2 or 4 > 2, so one is equal and one is larger.
   - The current node (2) is the LCA.

3. Final result: 2

The recursive approach (Solution 1) is also efficient but uses O(h) extra space for the recursion stack. The general binary tree approach (Solution 3) is less efficient for BSTs but works for any binary tree.

In an interview, I would first mention the iterative approach as the most efficient solution for this problem, and then mention the recursive approach as an alternative if asked for a recursive solution.
