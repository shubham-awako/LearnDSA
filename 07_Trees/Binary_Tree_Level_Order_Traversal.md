# Binary Tree Level Order Traversal

## Problem Statement

Given the `root` of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

**Example 1:**
```
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[9,20],[15,7]]
```

**Example 2:**
```
Input: root = [1]
Output: [[1]]
```

**Example 3:**
```
Input: root = []
Output: []
```

**Constraints:**
- The number of nodes in the tree is in the range `[0, 2000]`.
- `-1000 <= Node.val <= 1000`

## Concept Overview

This problem tests your understanding of breadth-first search (BFS) and level-order traversal of a binary tree. The key insight is to use a queue to process nodes level by level.

## Solutions

### 1. Best Optimized Solution - BFS with Queue

Use a queue to perform a breadth-first traversal of the tree.

```python
from collections import deque

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def levelOrder(root):
    if not root:
        return []
    
    result = []
    queue = deque([root])
    
    while queue:
        level_size = len(queue)
        level = []
        
        for _ in range(level_size):
            node = queue.popleft()
            level.append(node.val)
            
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        
        result.append(level)
    
    return result
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(n) - In the worst case, the queue can contain all nodes at the last level, which can be up to n/2 for a complete binary tree.

### 2. Alternative Solution - DFS with Recursion

Use depth-first search (DFS) with recursion to build the level-order traversal.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def levelOrder(root):
    result = []
    
    def dfs(node, level):
        if not node:
            return
        
        # If this is the first node at this level, add a new list
        if len(result) <= level:
            result.append([])
        
        # Add the node's value to the current level's list
        result[level].append(node.val)
        
        # Recursively process the left and right subtrees
        dfs(node.left, level + 1)
        dfs(node.right, level + 1)
    
    dfs(root, 0)
    return result
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - BFS with Two Queues

Use two queues to alternate between levels.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def levelOrder(root):
    if not root:
        return []
    
    result = []
    current_queue = [root]
    
    while current_queue:
        level = []
        next_queue = []
        
        for node in current_queue:
            level.append(node.val)
            
            if node.left:
                next_queue.append(node.left)
            if node.right:
                next_queue.append(node.right)
        
        result.append(level)
        current_queue = next_queue
    
    return result
```

**Time Complexity:** O(n) - We visit each node once.
**Space Complexity:** O(n) - In the worst case, the queues can contain all nodes at the last level, which can be up to n/2 for a complete binary tree.

## Solution Choice and Explanation

The BFS with Queue approach (Solution 1) is the best solution for this problem because:

1. **Intuitive**: It directly implements the level-order traversal using a queue, which is the natural data structure for BFS.

2. **Efficient**: It achieves O(n) time complexity, which is optimal for this problem.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use a queue to process nodes level by level. For each level:
1. Get the current size of the queue (which represents the number of nodes at the current level).
2. Process all nodes at the current level by dequeuing them one by one.
3. For each node, add its children to the queue for the next level.
4. Add the values of the current level's nodes to the result.

For example, let's perform a level-order traversal of the tree [3,9,20,null,null,15,7]:
```
    3
   / \
  9  20
    /  \
   15   7
```

1. Initialize: queue = [3], result = []
2. Level 0:
   - Size = 1
   - Dequeue 3, add its children: queue = [9, 20]
   - Add to result: result = [[3]]
3. Level 1:
   - Size = 2
   - Dequeue 9, add its children: queue = [20]
   - Dequeue 20, add its children: queue = [15, 7]
   - Add to result: result = [[3], [9, 20]]
4. Level 2:
   - Size = 2
   - Dequeue 15, add its children: queue = [7]
   - Dequeue 7, add its children: queue = []
   - Add to result: result = [[3], [9, 20], [15, 7]]
5. Queue is empty, return result = [[3], [9, 20], [15, 7]]

The DFS with Recursion approach (Solution 2) is also efficient but less intuitive for a level-order traversal. The BFS with Two Queues approach (Solution 3) is similar to Solution 1 but uses two queues instead of tracking the level size.

In an interview, I would first mention the BFS with Queue approach as the most intuitive and efficient solution for this problem.
