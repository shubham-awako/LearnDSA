# Binary Tree Right Side View

## Problem Statement

Given the `root` of a binary tree, imagine yourself standing on the **right side** of it, return the values of the nodes you can see ordered from top to bottom.

**Example 1:**
```
Input: root = [1,2,3,null,5,null,4]
Output: [1,3,4]
```

**Example 2:**
```
Input: root = [1,null,3]
Output: [1,3]
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

This problem tests your understanding of tree traversal and the concept of the right side view. The key insight is to use a level-order traversal (BFS) and take the rightmost node at each level, or to use a modified DFS that visits the right subtree before the left subtree.

## Solutions

### 1. Best Optimized Solution - BFS with Queue

Use a queue to perform a level-order traversal and take the rightmost node at each level.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def rightSideView(root):
    if not root:
        return []
    
    result = []
    queue = deque([root])
    
    while queue:
        level_size = len(queue)
        
        for i in range(level_size):
            node = queue.popleft()
            
            # If this is the rightmost node at this level, add it to the result
            if i == level_size - 1:
                result.append(node.val)
            
            # Add the children to the queue
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
    
    return result
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(w) - The queue can contain at most w nodes, where w is the maximum width of the tree. In the worst case, w = n/2 for a complete binary tree.

### 2. Alternative Solution - DFS with Recursion (Right to Left)

Use depth-first search (DFS) with recursion to visit the right subtree before the left subtree.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def rightSideView(root):
    result = []
    
    def dfs(node, level):
        if not node:
            return
        
        # If this is the first node at this level, add it to the result
        if len(result) <= level:
            result.append(node.val)
        
        # Visit the right subtree first, then the left subtree
        dfs(node.right, level + 1)
        dfs(node.left, level + 1)
    
    dfs(root, 0)
    return result
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - BFS with Last Node

Use a queue to perform a level-order traversal and keep track of the last node at each level.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def rightSideView(root):
    if not root:
        return []
    
    result = []
    queue = deque([root])
    
    while queue:
        level_size = len(queue)
        last_node = None
        
        for _ in range(level_size):
            node = queue.popleft()
            last_node = node
            
            # Add the children to the queue
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        
        # Add the last node at this level to the result
        result.append(last_node.val)
    
    return result
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(w) - The queue can contain at most w nodes, where w is the maximum width of the tree. In the worst case, w = n/2 for a complete binary tree.

## Solution Choice and Explanation

The BFS with Queue approach (Solution 1) is the best solution for this problem because:

1. **Intuitive**: It directly implements the right side view using a level-order traversal, which is a natural way to think about the problem.

2. **Efficient**: It achieves O(n) time complexity, which is optimal for this problem.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use a queue to process nodes level by level and take the rightmost node at each level. For each level:
1. Get the current size of the queue (which represents the number of nodes at the current level).
2. Process all nodes at the current level by dequeuing them one by one.
3. For each node, add its children to the queue for the next level.
4. Add the value of the rightmost node at the current level to the result.

For example, let's find the right side view of the tree [1,2,3,null,5,null,4]:
```
    1
   / \
  2   3
   \   \
    5   4
```

1. Initialize: queue = [1], result = []
2. Level 0:
   - Size = 1
   - Dequeue 1, add its children: queue = [2, 3]
   - Rightmost node is 1, add to result: result = [1]
3. Level 1:
   - Size = 2
   - Dequeue 2, add its children: queue = [3, 5]
   - Dequeue 3, add its children: queue = [5, 4]
   - Rightmost node is 3, add to result: result = [1, 3]
4. Level 2:
   - Size = 2
   - Dequeue 5, add its children: queue = [4]
   - Dequeue 4, add its children: queue = []
   - Rightmost node is 4, add to result: result = [1, 3, 4]
5. Queue is empty, return result = [1, 3, 4]

The DFS with Recursion approach (Solution 2) is also efficient but less intuitive for a right side view. The BFS with Last Node approach (Solution 3) is similar to Solution 1 but keeps track of the last node at each level instead of checking if the current node is the rightmost.

In an interview, I would first mention the BFS with Queue approach as the most intuitive and efficient solution for this problem, and then mention the DFS approach as an alternative if asked for a different approach.
