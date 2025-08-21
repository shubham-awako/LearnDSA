# 07. Trees

## Concept Overview

A tree is a hierarchical data structure consisting of nodes connected by edges. Each node can have zero or more child nodes, and each node has exactly one parent node, except for the root node, which has no parent.

### Key Concepts
- **Node**: Basic unit of a tree, containing data and references to its children
- **Root**: Topmost node of the tree
- **Leaf**: Node with no children
- **Parent**: Node that has children
- **Child**: Node that has a parent
- **Siblings**: Nodes that share the same parent
- **Depth**: Length of the path from the root to the node
- **Height**: Length of the longest path from the node to a leaf
- **Binary Tree**: Each node has at most two children (left and right)
- **Binary Search Tree (BST)**: Binary tree where the left subtree of a node contains only nodes with keys less than the node's key, and the right subtree contains only nodes with keys greater than the node's key
- **Balanced Tree**: Tree where the height of the left and right subtrees of any node differ by at most one
- **Complete Binary Tree**: Every level is completely filled except possibly the last level, which is filled from left to right
- **Full Binary Tree**: Every node has either 0 or 2 children
- **Perfect Binary Tree**: All internal nodes have exactly two children and all leaf nodes are at the same level

### Common Operations
- **Traversal**: O(n) - Visit each node in the tree
  - **Pre-order**: Root, Left, Right
  - **In-order**: Left, Root, Right (gives sorted order in a BST)
  - **Post-order**: Left, Right, Root
  - **Level-order**: Level by level, from left to right
- **Search**: O(log n) for balanced BST, O(n) for unbalanced
- **Insertion**: O(log n) for balanced BST, O(n) for unbalanced
- **Deletion**: O(log n) for balanced BST, O(n) for unbalanced

### Common Techniques
- **Recursion**: Most tree problems can be solved recursively
- **Depth-First Search (DFS)**: Pre-order, In-order, Post-order traversals
- **Breadth-First Search (BFS)**: Level-order traversal
- **Dynamic Programming on Trees**: Solving problems by breaking them down into subproblems on subtrees

### Advantages
- Hierarchical representation of data
- Fast search, insertion, and deletion in balanced trees
- Naturally recursive structure

### Disadvantages
- Extra space for pointers
- Rebalancing overhead for balanced trees
- Not cache-friendly due to non-contiguous memory allocation

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Invert Binary Tree | Easy | [Solution](./01_Invert_Binary_Tree.md) |
| 2 | Maximum Depth of Binary Tree | Easy | [Solution](./02_Maximum_Depth_of_Binary_Tree.md) |
| 3 | Diameter of Binary Tree | Easy | [Solution](./03_Diameter_of_Binary_Tree.md) |
| 4 | Balanced Binary Tree | Easy | [Solution](./04_Balanced_Binary_Tree.md) |
| 5 | Same Tree | Easy | [Solution](./05_Same_Tree.md) |
| 6 | Subtree of Another Tree | Easy | [Solution](./06_Subtree_of_Another_Tree.md) |
| 7 | Lowest Common Ancestor of a Binary Search Tree | Easy | [Solution](./07_Lowest_Common_Ancestor_of_a_Binary_Search_Tree.md) |
| 8 | Binary Tree Level Order Traversal | Medium | [Solution](./08_Binary_Tree_Level_Order_Traversal.md) |
| 9 | Binary Tree Right Side View | Medium | [Solution](./09_Binary_Tree_Right_Side_View.md) |
| 10 | Count Good Nodes in Binary Tree | Medium | [Solution](./10_Count_Good_Nodes_in_Binary_Tree.md) |
| 11 | Validate Binary Search Tree | Medium | [Solution](./11_Validate_Binary_Search_Tree.md) |
| 12 | Kth Smallest Element in a BST | Medium | [Solution](./12_Kth_Smallest_Element_in_a_BST.md) |
| 13 | Construct Binary Tree from Preorder and Inorder Traversal | Medium | [Solution](./13_Construct_Binary_Tree_from_Preorder_and_Inorder_Traversal.md) |
| 14 | Binary Tree Maximum Path Sum | Hard | [Solution](./14_Binary_Tree_Maximum_Path_Sum.md) |
| 15 | Serialize and Deserialize Binary Tree | Hard | [Solution](./15_Serialize_and_Deserialize_Binary_Tree.md) |
