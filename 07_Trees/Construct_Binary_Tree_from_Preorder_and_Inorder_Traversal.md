# Construct Binary Tree from Preorder and Inorder Traversal

## Problem Statement

Given two integer arrays `preorder` and `inorder` where `preorder` is the preorder traversal of a binary tree and `inorder` is the inorder traversal of the same tree, construct and return the binary tree.

**Example 1:**
```
Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
Output: [3,9,20,null,null,15,7]
```

**Example 2:**
```
Input: preorder = [-1], inorder = [-1]
Output: [-1]
```

**Constraints:**
- `1 <= preorder.length <= 3000`
- `inorder.length == preorder.length`
- `-3000 <= preorder[i], inorder[i] <= 3000`
- `preorder` and `inorder` consist of unique values.
- Each value of `inorder` also appears in `preorder`.
- `preorder` is guaranteed to be the preorder traversal of the tree.
- `inorder` is guaranteed to be the inorder traversal of the tree.

## Concept Overview

This problem tests your understanding of tree traversals and tree construction. The key insight is to use the properties of preorder and inorder traversals to recursively construct the binary tree.

## Solutions

### 1. Best Optimized Solution - Recursive Approach with Hash Map

Use a hash map to quickly find the position of elements in the inorder traversal.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def buildTree(preorder, inorder):
    # Create a hash map to store the indices of elements in the inorder traversal
    inorder_indices = {val: i for i, val in enumerate(inorder)}
    
    def build(preorder_start, preorder_end, inorder_start, inorder_end):
        if preorder_start > preorder_end or inorder_start > inorder_end:
            return None
        
        # The first element in preorder is the root
        root_val = preorder[preorder_start]
        root = TreeNode(root_val)
        
        # Find the position of the root in inorder
        inorder_index = inorder_indices[root_val]
        
        # Calculate the size of the left subtree
        left_subtree_size = inorder_index - inorder_start
        
        # Recursively build the left and right subtrees
        root.left = build(preorder_start + 1, preorder_start + left_subtree_size,
                          inorder_start, inorder_index - 1)
        root.right = build(preorder_start + left_subtree_size + 1, preorder_end,
                          inorder_index + 1, inorder_end)
        
        return root
    
    return build(0, len(preorder) - 1, 0, len(inorder) - 1)
```

**Time Complexity:** O(n) - We process each node once.
**Space Complexity:** O(n) - We use a hash map to store the indices of elements in the inorder traversal, and the recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 2. Alternative Solution - Iterative Approach with Stack

Use a stack to simulate the recursion stack and construct the binary tree iteratively.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def buildTree(preorder, inorder):
    if not preorder or not inorder:
        return None
    
    # Create the root node from the first element in preorder
    root = TreeNode(preorder[0])
    stack = [root]
    inorder_index = 0
    
    # Iterate through the preorder traversal starting from the second element
    for i in range(1, len(preorder)):
        curr_val = preorder[i]
        curr = stack[-1]
        
        # If the top of the stack is not the current inorder element,
        # add the current value as the left child
        if curr.val != inorder[inorder_index]:
            curr.left = TreeNode(curr_val)
            stack.append(curr.left)
        else:
            # Keep popping from the stack until we find the right parent
            while stack and stack[-1].val == inorder[inorder_index]:
                curr = stack.pop()
                inorder_index += 1
            
            # Add the current value as the right child of the last popped node
            curr.right = TreeNode(curr_val)
            stack.append(curr.right)
    
    return root
```

**Time Complexity:** O(n) - We process each node once.
**Space Complexity:** O(h) - The stack can contain at most h nodes, where h is the height of the tree. In the worst case, h = n for a skewed tree.

### 3. Alternative Solution - Recursive Approach without Hash Map

Use the properties of preorder and inorder traversals to recursively construct the binary tree without using a hash map.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

def buildTree(preorder, inorder):
    def build(preorder, inorder):
        if not preorder or not inorder:
            return None
        
        # The first element in preorder is the root
        root_val = preorder[0]
        root = TreeNode(root_val)
        
        # Find the position of the root in inorder
        inorder_index = inorder.index(root_val)
        
        # Recursively build the left and right subtrees
        root.left = build(preorder[1:inorder_index+1], inorder[:inorder_index])
        root.right = build(preorder[inorder_index+1:], inorder[inorder_index+1:])
        
        return root
    
    return build(preorder, inorder)
```

**Time Complexity:** O(n^2) - For each node, we need to find its position in the inorder traversal, which takes O(n) time.
**Space Complexity:** O(n^2) - We create new lists for each recursive call, and the recursion stack can go up to h levels deep, where h is the height of the tree. In the worst case, h = n for a skewed tree.

## Solution Choice and Explanation

The recursive approach with a hash map (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Efficiency**: It uses a hash map to quickly find the position of elements in the inorder traversal, avoiding the O(n) time complexity of searching for each element.

3. **Clarity**: It clearly separates the logic for constructing the left and right subtrees.

The key insight of this approach is to use the properties of preorder and inorder traversals:
- The first element in the preorder traversal is the root of the tree.
- The elements to the left of the root in the inorder traversal form the left subtree.
- The elements to the right of the root in the inorder traversal form the right subtree.

We can use these properties to recursively construct the binary tree:
1. Create a hash map to quickly find the position of elements in the inorder traversal.
2. Define a recursive function that takes the start and end indices of the preorder and inorder traversals.
3. The first element in the preorder traversal is the root of the current subtree.
4. Find the position of the root in the inorder traversal.
5. Calculate the size of the left subtree.
6. Recursively construct the left and right subtrees.

For example, let's construct a binary tree from preorder = [3,9,20,15,7] and inorder = [9,3,15,20,7]:
```
preorder = [3,9,20,15,7]
inorder = [9,3,15,20,7]
```

1. Create a hash map: {9: 0, 3: 1, 15: 2, 20: 3, 7: 4}
2. The first element in preorder is 3, so the root is 3.
3. The position of 3 in inorder is 1.
4. The left subtree consists of elements inorder[0:1] = [9].
5. The right subtree consists of elements inorder[2:5] = [15,20,7].
6. Recursively construct the left subtree:
   - The next element in preorder is 9, so the root of the left subtree is 9.
   - The position of 9 in inorder is 0.
   - The left subtree of 9 is empty.
   - The right subtree of 9 is empty.
7. Recursively construct the right subtree:
   - The next element in preorder is 20, so the root of the right subtree is 20.
   - The position of 20 in inorder is 3.
   - The left subtree of 20 consists of elements inorder[2:3] = [15].
   - The right subtree of 20 consists of elements inorder[4:5] = [7].
   - Recursively construct the left and right subtrees of 20.
8. Final tree:
```
    3
   / \
  9  20
    /  \
   15   7
```

The iterative approach with a stack (Solution 2) is also efficient but more complex. The recursive approach without a hash map (Solution 3) is simpler but less efficient due to the O(n) time complexity of searching for each element in the inorder traversal.

In an interview, I would first mention the recursive approach with a hash map as the most efficient solution for this problem, and then mention the iterative approach as an alternative if asked for a non-recursive solution.
