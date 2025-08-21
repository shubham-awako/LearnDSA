# Balanced Binary Tree

## Problem Statement

Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as:
> a binary tree in which the left and right subtrees of every node differ in height by no more than 1.

**Example 1:**
```
Input: root = [3,9,20,null,null,15,7]
Output: true
```

**Example 2:**
```
Input: root = [1,2,2,3,3,null,null,4,4]
Output: false
```

**Example 3:**
```
Input: root = []
Output: true
```

**Constraints:**
- The number of nodes in the tree is in the range `[0, 5000]`.
- `-10^4 <= Node.val <= 10^4`

## Concept Overview

This problem tests your understanding of tree traversal and the concept of balanced binary trees. The key insight is to calculate the height of each subtree and check if the difference between the heights of the left and right subtrees is at most 1 for every node.

## Solutions

### 1. Best Optimized Solution - Bottom-Up Approach

Calculate the height of each subtree and check if it's balanced in a single traversal.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isBalanced(root):
    def dfs(node):
        if not node:
            return 0, True  # (height, is_balanced)
        
        # Calculate the height and check if the left subtree is balanced
        left_height, left_balanced = dfs(node.left)
        if not left_balanced:
            return 0, False
        
        # Calculate the height and check if the right subtree is balanced
        right_height, right_balanced = dfs(node.right)
        if not right_balanced:
            return 0, False
        
        # Check if the current node is balanced
        is_balanced = abs(left_height - right_height) <= 1
        height = max(left_height, right_height) + 1
        
        return height, is_balanced
    
    _, is_balanced = dfs(root)
    return is_balanced
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Top-Down Approach

Calculate the height of each subtree separately and check if it's balanced.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isBalanced(root):
    if not root:
        return True
    
    # Calculate the height of a subtree
    def height(node):
        if not node:
            return 0
        return max(height(node.left), height(node.right)) + 1
    
    # Check if the current node is balanced
    left_height = height(root.left)
    right_height = height(root.right)
    
    if abs(left_height - right_height) > 1:
        return False
    
    # Check if the left and right subtrees are balanced
    return isBalanced(root.left) and isBalanced(root.right)
```

**Time Complexity:** O(n^2) - In the worst case, we calculate the height for each node, and calculating the height takes O(n) time.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - Using a Special Value to Indicate Unbalanced

Use a special value (-1) to indicate that a subtree is unbalanced.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def isBalanced(root):
    def height(node):
        if not node:
            return 0
        
        # Calculate the height of the left subtree
        left_height = height(node.left)
        if left_height == -1:
            return -1
        
        # Calculate the height of the right subtree
        right_height = height(node.right)
        if right_height == -1:
            return -1
        
        # Check if the current node is balanced
        if abs(left_height - right_height) > 1:
            return -1
        
        return max(left_height, right_height) + 1
    
    return height(root) != -1
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The bottom-up approach (Solution 1) is the best solution for this problem because:

1. **Efficiency**: It achieves O(n) time complexity with a single traversal of the tree.

2. **Early Termination**: It stops as soon as an unbalanced subtree is found, which can save time.

3. **Clarity**: It clearly separates the height calculation and the balance check.

The key insight of this approach is to calculate the height of each subtree and check if it's balanced in a single traversal. For each node, we:
1. Calculate the height and check if the left subtree is balanced.
2. If the left subtree is not balanced, return (0, False).
3. Calculate the height and check if the right subtree is balanced.
4. If the right subtree is not balanced, return (0, False).
5. Check if the current node is balanced (the difference between the heights of the left and right subtrees is at most 1).
6. Return the height of the current subtree and whether it's balanced.

For example, let's check if the tree [3,9,20,null,null,15,7] is balanced:
```
    3
   / \
  9  20
    /  \
   15   7
```

1. At node 9 (leaf):
   - left_height = 0, right_height = 0
   - is_balanced = abs(0 - 0) <= 1 = True
   - return (1, True)

2. At node 15 (leaf):
   - left_height = 0, right_height = 0
   - is_balanced = abs(0 - 0) <= 1 = True
   - return (1, True)

3. At node 7 (leaf):
   - left_height = 0, right_height = 0
   - is_balanced = abs(0 - 0) <= 1 = True
   - return (1, True)

4. At node 20:
   - left_height = 1, right_height = 1
   - is_balanced = abs(1 - 1) <= 1 = True
   - return (2, True)

5. At node 3 (root):
   - left_height = 1, right_height = 2
   - is_balanced = abs(1 - 2) <= 1 = True
   - return (3, True)

6. Final result: True

The top-down approach (Solution 2) is simpler but less efficient, with a time complexity of O(n^2) in the worst case. The approach using a special value (Solution 3) is also efficient but slightly less clear.

In an interview, I would first mention the bottom-up approach as the most efficient solution for this problem.
