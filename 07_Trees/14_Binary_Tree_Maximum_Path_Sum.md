# Binary Tree Maximum Path Sum

## Problem Statement

A **path** in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence **at most once**. Note that the path does not need to pass through the root.

The **path sum** of a path is the sum of the node's values in the path.

Given the `root` of a binary tree, return the maximum **path sum** of any non-empty path.

**Example 1:**
```
Input: root = [1,2,3]
Output: 6
Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.
```

**Example 2:**
```
Input: root = [-10,9,20,null,null,15,7]
Output: 42
Explanation: The optimal path is 15 -> 20 -> 7 with a path sum of 15 + 20 + 7 = 42.
```

**Constraints:**
- The number of nodes in the tree is in the range `[1, 3 * 10^4]`.
- `-1000 <= Node.val <= 1000`

## Concept Overview

This problem tests your understanding of tree traversal and path finding. The key insight is to calculate the maximum path sum that includes the current node as the highest node in the path, and update the global maximum path sum accordingly.

## Solutions

### 1. Best Optimized Solution - Recursive Approach with Global Variable

Use recursion to calculate the maximum path sum that includes the current node as the highest node in the path, and update the global maximum path sum.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def maxPathSum(root):
    max_sum = [float('-inf')]  # Use a list to store the maximum path sum (to allow modification in nested function)
    
    def max_gain(node):
        if not node:
            return 0
        
        # Calculate the maximum path sum that includes the left subtree
        left_gain = max(max_gain(node.left), 0)
        
        # Calculate the maximum path sum that includes the right subtree
        right_gain = max(max_gain(node.right), 0)
        
        # Calculate the maximum path sum that includes the current node as the highest node
        current_path_sum = node.val + left_gain + right_gain
        
        # Update the global maximum path sum
        max_sum[0] = max(max_sum[0], current_path_sum)
        
        # Return the maximum path sum that includes the current node but only one branch
        return node.val + max(left_gain, right_gain)
    
    max_gain(root)
    return max_sum[0]
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Recursive Approach with Return Value

Use recursion to calculate both the maximum path sum that includes the current node as the highest node in the path and the maximum path sum that includes the current node but only one branch.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def maxPathSum(root):
    def max_path_sum(node):
        if not node:
            return float('-inf'), 0
        
        # Calculate the maximum path sum for the left and right subtrees
        left_path_sum, left_branch_sum = max_path_sum(node.left)
        right_path_sum, right_branch_sum = max_path_sum(node.right)
        
        # Calculate the maximum path sum that includes the current node as the highest node
        current_path_sum = node.val + max(left_branch_sum, 0) + max(right_branch_sum, 0)
        
        # Calculate the maximum path sum that includes the current node but only one branch
        current_branch_sum = node.val + max(max(left_branch_sum, right_branch_sum), 0)
        
        # Calculate the maximum path sum for the current subtree
        max_sum = max(left_path_sum, right_path_sum, current_path_sum)
        
        return max_sum, current_branch_sum
    
    max_sum, _ = max_path_sum(root)
    return max_sum
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - Iterative Approach with Post-Order Traversal

Use an iterative post-order traversal to calculate the maximum path sum.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def maxPathSum(root):
    if not root:
        return 0
    
    max_sum = float('-inf')
    stack = [(root, False)]
    gains = {}  # Map node to its maximum gain
    
    while stack:
        node, visited = stack.pop()
        
        if visited:
            # Calculate the maximum gain for the current node
            left_gain = max(gains.get(node.left, 0), 0)
            right_gain = max(gains.get(node.right, 0), 0)
            
            # Calculate the maximum path sum that includes the current node as the highest node
            current_path_sum = node.val + left_gain + right_gain
            
            # Update the global maximum path sum
            nonlocal max_sum
            max_sum = max(max_sum, current_path_sum)
            
            # Store the maximum gain for the current node
            gains[node] = node.val + max(left_gain, right_gain)
        else:
            # Add the node back to the stack with visited = True
            stack.append((node, True))
            
            # Add the right and left children to the stack
            if node.right:
                stack.append((node.right, False))
            if node.left:
                stack.append((node.left, False))
    
    return max_sum
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(n) - We use a stack and a hash map to store the maximum gain for each node.

## Solution Choice and Explanation

The recursive approach with a global variable (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is typically O(log n) for a balanced tree.

3. **Clarity**: It clearly separates the logic for calculating the maximum path sum and the maximum gain.

The key insight of this approach is to use recursion to calculate the maximum path sum that includes the current node as the highest node in the path, and update the global maximum path sum accordingly. For each node, we:
1. Calculate the maximum gain from the left subtree (if it's negative, we don't include it).
2. Calculate the maximum gain from the right subtree (if it's negative, we don't include it).
3. Calculate the maximum path sum that includes the current node as the highest node (node.val + left_gain + right_gain).
4. Update the global maximum path sum.
5. Return the maximum gain that includes the current node but only one branch (node.val + max(left_gain, right_gain)).

For example, let's calculate the maximum path sum for the tree [-10,9,20,null,null,15,7]:
```
    -10
    / \
   9  20
     /  \
    15   7
```

1. Start at the root (-10):
   - Calculate the maximum gain from the left subtree (9):
     - 9 has no children, so left_gain = 0 and right_gain = 0
     - current_path_sum = 9 + 0 + 0 = 9
     - max_sum = max(-inf, 9) = 9
     - return 9 + max(0, 0) = 9
   - Calculate the maximum gain from the right subtree (20):
     - Calculate the maximum gain from the left subtree (15):
       - 15 has no children, so left_gain = 0 and right_gain = 0
       - current_path_sum = 15 + 0 + 0 = 15
       - max_sum = max(9, 15) = 15
       - return 15 + max(0, 0) = 15
     - Calculate the maximum gain from the right subtree (7):
       - 7 has no children, so left_gain = 0 and right_gain = 0
       - current_path_sum = 7 + 0 + 0 = 7
       - max_sum = max(15, 7) = 15
       - return 7 + max(0, 0) = 7
     - left_gain = 15, right_gain = 7
     - current_path_sum = 20 + 15 + 7 = 42
     - max_sum = max(15, 42) = 42
     - return 20 + max(15, 7) = 35
   - left_gain = 9, right_gain = 35
   - current_path_sum = -10 + 9 + 35 = 34
   - max_sum = max(42, 34) = 42
   - return -10 + max(9, 35) = 25

2. Final result: 42

The recursive approach with return value (Solution 2) is also efficient but more complex. The iterative approach (Solution 3) is the most complex and uses more space.

In an interview, I would first mention the recursive approach with a global variable as the most elegant solution for this problem.
