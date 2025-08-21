# Validate Binary Search Tree

## Problem Statement

Given the `root` of a binary tree, determine if it is a valid binary search tree (BST).

A **valid BST** is defined as follows:
- The left subtree of a node contains only nodes with keys **less than** the node's key.
- The right subtree of a node contains only nodes with keys **greater than** the node's key.
- Both the left and right subtrees must also be binary search trees.

**Example 1:**
```
Input: root = [2,1,3]
Output: true
```

**Example 2:**
```
Input: root = [5,1,4,null,null,3,6]
Output: false
Explanation: The root node's value is 5 but its right child's value is 4.
```

**Constraints:**
- The number of nodes in the tree is in the range `[1, 10^4]`.
- `-2^31 <= Node.val <= 2^31 - 1`

## Concept Overview

This problem tests your understanding of binary search trees and their properties. The key insight is to check if each node's value is within a valid range based on its position in the tree.

## Solutions

### 1. Best Optimized Solution - Recursive Approach with Range Checking

Use recursion to check if each node's value is within a valid range.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isValidBST(root):
    def is_valid(node, lower=float('-inf'), upper=float('inf')):
        if not node:
            return True
        
        # Check if the current node's value is within the valid range
        if node.val <= lower or node.val >= upper:
            return False
        
        # Recursively check the left and right subtrees with updated ranges
        return (is_valid(node.left, lower, node.val) and
                is_valid(node.right, node.val, upper))
    
    return is_valid(root)
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - In-Order Traversal

Use in-order traversal to check if the values are in ascending order.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isValidBST(root):
    prev = [float('-inf')]  # Use a list to store the previous value (to allow modification in nested function)
    
    def in_order(node):
        if not node:
            return True
        
        # Check the left subtree
        if not in_order(node.left):
            return False
        
        # Check the current node
        if node.val <= prev[0]:
            return False
        prev[0] = node.val
        
        # Check the right subtree
        return in_order(node.right)
    
    return in_order(root)
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - Iterative In-Order Traversal

Use an iterative in-order traversal to check if the values are in ascending order.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isValidBST(root):
    stack = []
    prev = float('-inf')
    curr = root
    
    while stack or curr:
        # Traverse to the leftmost node
        while curr:
            stack.append(curr)
            curr = curr.left
        
        # Process the current node
        curr = stack.pop()
        
        # Check if the current node's value is greater than the previous value
        if curr.val <= prev:
            return False
        prev = curr.val
        
        # Move to the right subtree
        curr = curr.right
    
    return True
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The recursive approach with range checking (Solution 1) is the best solution for this problem because:

1. **Intuitive**: It directly implements the definition of a valid BST by checking if each node's value is within a valid range.

2. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is typically O(log n) for a balanced tree.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use recursion to check if each node's value is within a valid range based on its position in the tree. For each node, we:
1. Check if the node's value is within the valid range (lower < node.val < upper).
2. Recursively check the left subtree with an updated upper bound (the current node's value).
3. Recursively check the right subtree with an updated lower bound (the current node's value).

For example, let's validate the BST [2,1,3]:
```
  2
 / \
1   3
```

1. Start at the root (2):
   - lower = -inf, upper = inf
   - 2 > -inf and 2 < inf, so it's valid
   - Recursively check the left subtree (1) with lower = -inf, upper = 2
   - Recursively check the right subtree (3) with lower = 2, upper = inf

2. At node 1:
   - lower = -inf, upper = 2
   - 1 > -inf and 1 < 2, so it's valid
   - Recursively check the left subtree (null) with lower = -inf, upper = 1
   - Recursively check the right subtree (null) with lower = 1, upper = 2

3. At node 3:
   - lower = 2, upper = inf
   - 3 > 2 and 3 < inf, so it's valid
   - Recursively check the left subtree (null) with lower = 2, upper = 3
   - Recursively check the right subtree (null) with lower = 3, upper = inf

4. Final result: True

Now, let's validate the BST [5,1,4,null,null,3,6]:
```
    5
   / \
  1   4
     / \
    3   6
```

1. Start at the root (5):
   - lower = -inf, upper = inf
   - 5 > -inf and 5 < inf, so it's valid
   - Recursively check the left subtree (1) with lower = -inf, upper = 5
   - Recursively check the right subtree (4) with lower = 5, upper = inf

2. At node 1:
   - lower = -inf, upper = 5
   - 1 > -inf and 1 < 5, so it's valid
   - Recursively check the left subtree (null) with lower = -inf, upper = 1
   - Recursively check the right subtree (null) with lower = 1, upper = 5

3. At node 4:
   - lower = 5, upper = inf
   - 4 <= 5, which is invalid
   - Return False

4. Final result: False

The in-order traversal approaches (Solutions 2 and 3) are also efficient and leverage the property that an in-order traversal of a BST should yield values in ascending order. The recursive in-order traversal (Solution 2) is more concise, while the iterative in-order traversal (Solution 3) avoids the overhead of recursion.

In an interview, I would first mention the recursive approach with range checking as the most intuitive solution for this problem, and then mention the in-order traversal approaches as alternatives if asked for different approaches.
