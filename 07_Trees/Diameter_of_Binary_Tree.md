# Diameter of Binary Tree

## Problem Statement

Given the `root` of a binary tree, return the length of the **diameter** of the tree.

The **diameter** of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the `root`.

The length of a path between two nodes is represented by the number of edges between them.

**Example 1:**
```
Input: root = [1,2,3,4,5]
Output: 3
Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].
```

**Example 2:**
```
Input: root = [1,2]
Output: 1
```

**Constraints:**
- The number of nodes in the tree is in the range `[1, 10^4]`.
- `-100 <= Node.val <= 100`

## Concept Overview

This problem tests your understanding of tree traversal and recursion. The key insight is to recognize that the diameter of a binary tree is the maximum of:
1. The diameter of the left subtree
2. The diameter of the right subtree
3. The longest path that passes through the root (which is the sum of the heights of the left and right subtrees)

## Solutions

### 1. Best Optimized Solution - Recursive Approach with Height Calculation

Calculate the height of each subtree and update the diameter as we go.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def diameterOfBinaryTree(root):
    diameter = [0]  # Use a list to store the diameter (to allow modification in nested function)
    
    def height(node):
        if not node:
            return 0
        
        # Calculate the height of the left and right subtrees
        left_height = height(node.left)
        right_height = height(node.right)
        
        # Update the diameter if the path through this node is longer
        diameter[0] = max(diameter[0], left_height + right_height)
        
        # Return the height of this subtree
        return max(left_height, right_height) + 1
    
    height(root)
    return diameter[0]
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Two-Pass Approach

First, calculate the height of each node and store it in a dictionary, then calculate the diameter.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def diameterOfBinaryTree(root):
    # Calculate the height of each node
    heights = {}
    
    def calculate_heights(node):
        if not node:
            return 0
        
        left_height = calculate_heights(node.left)
        right_height = calculate_heights(node.right)
        
        heights[node] = max(left_height, right_height) + 1
        return heights[node]
    
    calculate_heights(root)
    
    # Calculate the diameter
    def calculate_diameter(node):
        if not node:
            return 0
        
        # Diameter through this node
        left_height = heights.get(node.left, 0)
        right_height = heights.get(node.right, 0)
        diameter_through_node = left_height + right_height
        
        # Maximum of the diameter through this node and the diameters of the subtrees
        return max(diameter_through_node, calculate_diameter(node.left), calculate_diameter(node.right))
    
    return calculate_diameter(root)
```

**Time Complexity:** O(n) - We visit each node twice.
**Space Complexity:** O(n) - We store the height of each node in the dictionary.

### 3. Alternative Solution - Post-Order Traversal with Pair Return

Use post-order traversal and return both the height and diameter for each subtree.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def diameterOfBinaryTree(root):
    def post_order(node):
        if not node:
            return 0, 0  # (height, diameter)
        
        # Get the height and diameter of the left and right subtrees
        left_height, left_diameter = post_order(node.left)
        right_height, right_diameter = post_order(node.right)
        
        # Calculate the height and diameter of the current subtree
        height = max(left_height, right_height) + 1
        diameter = max(left_height + right_height, left_diameter, right_diameter)
        
        return height, diameter
    
    _, diameter = post_order(root)
    return diameter
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The recursive approach with height calculation (Solution 1) is the best solution for this problem because:

1. **Efficiency**: It achieves O(n) time complexity with a single traversal of the tree.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Space Efficiency**: It uses O(h) space, which is typically O(log n) for a balanced tree.

The key insight of this approach is to calculate the height of each subtree and update the diameter as we go. For each node, we:
1. Calculate the height of the left subtree.
2. Calculate the height of the right subtree.
3. Update the diameter if the path through this node (left_height + right_height) is longer than the current diameter.
4. Return the height of this subtree (max(left_height, right_height) + 1).

For example, let's calculate the diameter of the tree [1,2,3,4,5]:
```
    1
   / \
  2   3
 / \
4   5
```

1. At node 4 (leaf):
   - left_height = 0, right_height = 0
   - diameter = max(0, 0 + 0) = 0
   - return height = 1

2. At node 5 (leaf):
   - left_height = 0, right_height = 0
   - diameter = max(0, 0 + 0) = 0
   - return height = 1

3. At node 2:
   - left_height = 1, right_height = 1
   - diameter = max(0, 1 + 1) = 2
   - return height = 2

4. At node 3 (leaf):
   - left_height = 0, right_height = 0
   - diameter = max(2, 0 + 0) = 2
   - return height = 1

5. At node 1 (root):
   - left_height = 2, right_height = 1
   - diameter = max(2, 2 + 1) = 3
   - return height = 3

6. Final result: 3

The two-pass approach (Solution 2) is also efficient but requires more space to store the heights. The post-order traversal with pair return (Solution 3) is elegant but slightly more complex.

In an interview, I would first mention the recursive approach with height calculation as the most efficient solution for this problem.
