# Count Good Nodes in Binary Tree

## Problem Statement

Given a binary tree `root`, a node X in the tree is named **good** if in the path from root to X there are no nodes with a value greater than X.

Return the number of **good** nodes in the binary tree.

**Example 1:**
```
Input: root = [3,1,4,3,null,1,5]
Output: 4
Explanation: Nodes in blue are good.
Root Node (3) is always a good node.
Node 4 -> (3,4) is the maximum value in the path starting from the root.
Node 5 -> (3,4,5) is the maximum value in the path
Node 3 -> (3,1,3) is the maximum value in the path.
```

**Example 2:**
```
Input: root = [3,3,null,4,2]
Output: 3
Explanation: Node 2 -> (3,3,2) is not good, because "3" is higher than it.
```

**Example 3:**
```
Input: root = [1]
Output: 1
Explanation: Root is considered as good.
```

**Constraints:**
- The number of nodes in the binary tree is in the range `[1, 10^5]`.
- Each node's value is between `[-10^4, 10^4]`.

## Concept Overview

This problem tests your understanding of tree traversal and path tracking. The key insight is to keep track of the maximum value seen so far in the path from the root to the current node.

## Solutions

### 1. Best Optimized Solution - DFS with Max Value Tracking

Use depth-first search (DFS) with recursion to traverse the tree and keep track of the maximum value seen so far.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def goodNodes(root):
    def dfs(node, max_so_far):
        if not node:
            return 0
        
        # Check if the current node is a good node
        is_good = node.val >= max_so_far
        
        # Update the maximum value seen so far
        max_so_far = max(max_so_far, node.val)
        
        # Recursively count good nodes in the left and right subtrees
        left_count = dfs(node.left, max_so_far)
        right_count = dfs(node.right, max_so_far)
        
        # Return the total count of good nodes
        return left_count + right_count + (1 if is_good else 0)
    
    return dfs(root, float('-inf'))
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - BFS with Queue

Use breadth-first search (BFS) with a queue to traverse the tree and keep track of the maximum value seen so far for each node.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def goodNodes(root):
    if not root:
        return 0
    
    # Use a queue for BFS, storing (node, max_so_far) pairs
    queue = deque([(root, float('-inf'))])
    good_count = 0
    
    while queue:
        node, max_so_far = queue.popleft()
        
        # Check if the current node is a good node
        if node.val >= max_so_far:
            good_count += 1
        
        # Update the maximum value seen so far
        max_so_far = max(max_so_far, node.val)
        
        # Add the children to the queue with the updated maximum value
        if node.left:
            queue.append((node.left, max_so_far))
        if node.right:
            queue.append((node.right, max_so_far))
    
    return good_count
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(w) - The queue can contain at most w nodes, where w is the maximum width of the tree. In the worst case, w = n/2 for a complete binary tree.

### 3. Alternative Solution - Iterative DFS with Stack

Use depth-first search (DFS) with a stack to traverse the tree and keep track of the maximum value seen so far for each node.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def goodNodes(root):
    if not root:
        return 0
    
    # Use a stack for DFS, storing (node, max_so_far) pairs
    stack = [(root, float('-inf'))]
    good_count = 0
    
    while stack:
        node, max_so_far = stack.pop()
        
        # Check if the current node is a good node
        if node.val >= max_so_far:
            good_count += 1
        
        # Update the maximum value seen so far
        max_so_far = max(max_so_far, node.val)
        
        # Add the children to the stack with the updated maximum value
        if node.right:
            stack.append((node.right, max_so_far))
        if node.left:
            stack.append((node.left, max_so_far))
    
    return good_count
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The DFS with Max Value Tracking approach (Solution 1) is the best solution for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is typically O(log n) for a balanced tree.

3. **Readability**: It's easy to understand and follows the natural recursive structure of the problem.

The key insight of this approach is to use recursion to traverse the tree and keep track of the maximum value seen so far in the path from the root to the current node. For each node, we:
1. Check if the current node's value is greater than or equal to the maximum value seen so far. If so, it's a good node.
2. Update the maximum value seen so far to include the current node's value.
3. Recursively count good nodes in the left and right subtrees with the updated maximum value.
4. Return the total count of good nodes.

For example, let's count the good nodes in the tree [3,1,4,3,null,1,5]:
```
      3
     / \
    1   4
   /   / \
  3   1   5
```

1. Start at the root (3):
   - max_so_far = -inf
   - 3 >= -inf, so it's a good node
   - Update max_so_far = 3
   - Recursively count good nodes in the left subtree (1)
   - Recursively count good nodes in the right subtree (4)

2. At node 1:
   - max_so_far = 3
   - 1 < 3, so it's not a good node
   - Update max_so_far = 3 (no change)
   - Recursively count good nodes in the left subtree (3)
   - Recursively count good nodes in the right subtree (null)

3. At node 3 (left subtree of 1):
   - max_so_far = 3
   - 3 >= 3, so it's a good node
   - Update max_so_far = 3 (no change)
   - Recursively count good nodes in the left subtree (null)
   - Recursively count good nodes in the right subtree (null)

4. At node 4:
   - max_so_far = 3
   - 4 > 3, so it's a good node
   - Update max_so_far = 4
   - Recursively count good nodes in the left subtree (1)
   - Recursively count good nodes in the right subtree (5)

5. At node 1 (left subtree of 4):
   - max_so_far = 4
   - 1 < 4, so it's not a good node
   - Update max_so_far = 4 (no change)
   - Recursively count good nodes in the left subtree (null)
   - Recursively count good nodes in the right subtree (null)

6. At node 5:
   - max_so_far = 4
   - 5 > 4, so it's a good node
   - Update max_so_far = 5
   - Recursively count good nodes in the left subtree (null)
   - Recursively count good nodes in the right subtree (null)

7. Final count: 1 (root) + 0 (node 1) + 1 (node 3) + 1 (node 4) + 0 (node 1) + 1 (node 5) = 4

The BFS with Queue approach (Solution 2) and the Iterative DFS with Stack approach (Solution 3) are also efficient but slightly more complex. The BFS approach uses a queue to process nodes level by level, while the iterative DFS approach uses a stack to process nodes in a depth-first manner.

In an interview, I would first mention the recursive DFS approach as the most elegant solution for this problem, and then mention the iterative approaches as alternatives if asked for non-recursive solutions.
