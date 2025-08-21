# Kth Smallest Element in a BST

## Problem Statement

Given the `root` of a binary search tree, and an integer `k`, return the `k`th smallest value (1-indexed) of all the values of the nodes in the tree.

**Example 1:**
```
Input: root = [3,1,4,null,2], k = 1
Output: 1
```

**Example 2:**
```
Input: root = [5,3,6,2,4,null,null,1], k = 3
Output: 3
```

**Constraints:**
- The number of nodes in the tree is `n`.
- `1 <= k <= n <= 10^4`
- `0 <= Node.val <= 10^4`

**Follow up:** If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?

## Concept Overview

This problem tests your understanding of binary search trees and in-order traversal. The key insight is that an in-order traversal of a BST visits the nodes in ascending order.

## Solutions

### 1. Best Optimized Solution - In-Order Traversal

Use in-order traversal to visit the nodes in ascending order and return the kth node.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def kthSmallest(root, k):
    # Counter to keep track of the number of nodes visited
    count = [0]
    # Variable to store the result
    result = [0]
    
    def in_order(node):
        if not node:
            return
        
        # Visit the left subtree
        in_order(node.left)
        
        # Process the current node
        count[0] += 1
        if count[0] == k:
            result[0] = node.val
            return
        
        # Visit the right subtree
        in_order(node.right)
    
    in_order(root)
    return result[0]
```

**Time Complexity:** O(n) - In the worst case, we need to visit all nodes.
**Space Complexity:** O(h) - The recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Iterative In-Order Traversal

Use an iterative in-order traversal to visit the nodes in ascending order and return the kth node.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def kthSmallest(root, k):
    stack = []
    curr = root
    count = 0
    
    while stack or curr:
        # Traverse to the leftmost node
        while curr:
            stack.append(curr)
            curr = curr.left
        
        # Process the current node
        curr = stack.pop()
        count += 1
        
        # If this is the kth node, return its value
        if count == k:
            return curr.val
        
        # Move to the right subtree
        curr = curr.right
    
    return -1  # This line will not be reached if k is valid
```

**Time Complexity:** O(h + k) - We need to traverse down to the leftmost node (O(h)) and then visit k nodes.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - Augmented BST (Follow-up)

For the follow-up question, we can augment the BST to store the size of each subtree.

```python
# Definition for an augmented binary tree node.
class AugmentedTreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        self.size = 1  # Size of the subtree rooted at this node

class Solution:
    def kthSmallest(self, root, k):
        # Convert the BST to an augmented BST
        augmented_root = self._build_augmented_tree(root)
        
        # Find the kth smallest element
        return self._find_kth_smallest(augmented_root, k)
    
    def _build_augmented_tree(self, node):
        if not node:
            return None
        
        # Build the augmented tree recursively
        augmented_node = AugmentedTreeNode(node.val)
        augmented_node.left = self._build_augmented_tree(node.left)
        augmented_node.right = self._build_augmented_tree(node.right)
        
        # Update the size of the subtree
        if augmented_node.left:
            augmented_node.size += augmented_node.left.size
        if augmented_node.right:
            augmented_node.size += augmented_node.right.size
        
        return augmented_node
    
    def _find_kth_smallest(self, node, k):
        if not node:
            return -1
        
        # Calculate the size of the left subtree
        left_size = node.left.size if node.left else 0
        
        # If k is less than or equal to the size of the left subtree,
        # the kth smallest element is in the left subtree
        if k <= left_size:
            return self._find_kth_smallest(node.left, k)
        
        # If k is equal to the size of the left subtree plus 1,
        # the kth smallest element is the current node
        if k == left_size + 1:
            return node.val
        
        # Otherwise, the kth smallest element is in the right subtree
        return self._find_kth_smallest(node.right, k - left_size - 1)
```

**Time Complexity:**
- Building the augmented tree: O(n)
- Finding the kth smallest element: O(h)
- For frequent queries after building the tree: O(h) per query

**Space Complexity:** O(n) - We need to store the augmented tree.

## Solution Choice and Explanation

The iterative in-order traversal approach (Solution 2) is the best solution for this problem because:

1. **Efficiency**: It achieves O(h + k) time complexity, which is optimal for this problem when k is small.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Space Efficiency**: It uses O(h) space, which is typically O(log n) for a balanced tree.

The key insight of this approach is to use an iterative in-order traversal to visit the nodes in ascending order and return the kth node. The algorithm works as follows:
1. Use a stack to simulate the recursion stack of an in-order traversal.
2. Traverse to the leftmost node, pushing all nodes along the way onto the stack.
3. Pop a node from the stack, increment the count, and check if it's the kth node.
4. If it's the kth node, return its value.
5. Otherwise, move to the right subtree and repeat.

For example, let's find the 3rd smallest element in the BST [5,3,6,2,4,null,null,1]:
```
      5
     / \
    3   6
   / \
  2   4
 /
1
```

1. Initialize: stack = [], curr = 5, count = 0
2. Traverse to the leftmost node:
   - Push 5 onto the stack: stack = [5], curr = 3
   - Push 3 onto the stack: stack = [5, 3], curr = 2
   - Push 2 onto the stack: stack = [5, 3, 2], curr = 1
   - Push 1 onto the stack: stack = [5, 3, 2, 1], curr = null
3. Process nodes:
   - Pop 1 from the stack: stack = [5, 3, 2], curr = 1, count = 1
   - Move to the right subtree: curr = null
   - Pop 2 from the stack: stack = [5, 3], curr = 2, count = 2
   - Move to the right subtree: curr = null
   - Pop 3 from the stack: stack = [5], curr = 3, count = 3
   - This is the 3rd node, so return its value: 3

The recursive in-order traversal approach (Solution 1) is also efficient but slightly more complex due to the need for global variables or a wrapper function. The augmented BST approach (Solution 3) is the most efficient for the follow-up question where we need to find the kth smallest element frequently and the BST is modified often.

In an interview, I would first mention the iterative in-order traversal approach as the most efficient solution for the original problem, and then discuss the augmented BST approach for the follow-up question.
