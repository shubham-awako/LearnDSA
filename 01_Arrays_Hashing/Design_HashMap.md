# Design HashMap

## Problem Statement

Design a HashMap without using any built-in hash table libraries.

Implement the `MyHashMap` class:
- `MyHashMap()` initializes the object with an empty map.
- `void put(int key, int value)` inserts a `(key, value)` pair into the HashMap. If the `key` already exists in the map, update the corresponding `value`.
- `int get(int key)` returns the `value` to which the specified `key` is mapped, or `-1` if this map contains no mapping for the `key`.
- `void remove(key)` removes the `key` and its corresponding `value` if the map contains the mapping for the `key`.

**Example 1:**
```
Input
["MyHashMap", "put", "put", "get", "get", "put", "get", "remove", "get"]
[[], [1, 1], [2, 2], [1], [3], [2, 1], [2], [2], [2]]
Output
[null, null, null, 1, -1, null, 1, null, -1]

Explanation
MyHashMap myHashMap = new MyHashMap();
myHashMap.put(1, 1); // The map is now [[1,1]]
myHashMap.put(2, 2); // The map is now [[1,1], [2,2]]
myHashMap.get(1);    // return 1, The map is now [[1,1], [2,2]]
myHashMap.get(3);    // return -1 (i.e., not found), The map is now [[1,1], [2,2]]
myHashMap.put(2, 1); // The map is now [[1,1], [2,1]] (i.e., update the existing value)
myHashMap.get(2);    // return 1, The map is now [[1,1], [2,1]]
myHashMap.remove(2); // remove the mapping for 2, The map is now [[1,1]]
myHashMap.get(2);    // return -1 (i.e., not found), The map is now [[1,1]]
```

**Constraints:**
- `0 <= key, value <= 10^6`
- At most `10^4` calls will be made to `put`, `get`, and `remove`.

## Concept Overview

A HashMap is a data structure that stores key-value pairs and provides constant-time operations for adding, retrieving, and removing elements. The key insight is to design an efficient hash function and handle collisions appropriately.

## Solutions

### 1. Brute Force Approach - Array Implementation

Use a simple array to store values at indices corresponding to keys (not practical for large key ranges).

```python
class MyHashMap:
    def __init__(self):
        # Since key range is 0 to 10^6, this approach is not practical
        self.data = [-1] * (10**6 + 1)
        
    def put(self, key, value):
        self.data[key] = value
        
    def get(self, key):
        return self.data[key]
        
    def remove(self, key):
        self.data[key] = -1
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(10^6) - Fixed size regardless of the number of elements.

### 2. Improved Solution - Linked List with Modulo Hashing

Use a fixed number of buckets, each containing a linked list to handle collisions.

```python
class ListNode:
    def __init__(self, key, value):
        self.key = key
        self.value = value
        self.next = None

class MyHashMap:
    def __init__(self):
        self.size = 1000  # Number of buckets
        self.buckets = [None] * self.size
        
    def _hash(self, key):
        return key % self.size
    
    def put(self, key, value):
        index = self._hash(key)
        if not self.buckets[index]:
            self.buckets[index] = ListNode(key, value)
            return
        
        curr = self.buckets[index]
        # Check if key already exists
        if curr.key == key:
            curr.value = value
            return
        
        while curr.next:
            if curr.next.key == key:
                curr.next.value = value
                return
            curr = curr.next
            
        curr.next = ListNode(key, value)
        
    def get(self, key):
        index = self._hash(key)
        curr = self.buckets[index]
        
        while curr:
            if curr.key == key:
                return curr.value
            curr = curr.next
            
        return -1
        
    def remove(self, key):
        index = self._hash(key)
        if not self.buckets[index]:
            return
        
        # If key is at the head of the list
        if self.buckets[index].key == key:
            self.buckets[index] = self.buckets[index].next
            return
        
        curr = self.buckets[index]
        while curr.next and curr.next.key != key:
            curr = curr.next
            
        if curr.next:
            curr.next = curr.next.next
```

**Time Complexity:** 
- Average case: O(1) for all operations
- Worst case: O(n) if all keys hash to the same bucket

**Space Complexity:** O(n + k) where n is the number of elements and k is the number of buckets.

### 3. Best Optimized Solution - BST with Modulo Hashing

Use a fixed number of buckets, each containing a binary search tree to handle collisions more efficiently.

```python
class TreeNode:
    def __init__(self, key, value):
        self.key = key
        self.value = value
        self.left = None
        self.right = None

class MyHashMap:
    def __init__(self):
        self.size = 1000  # Number of buckets
        self.buckets = [None] * self.size
        
    def _hash(self, key):
        return key % self.size
    
    def _insert_to_tree(self, root, key, value):
        if not root:
            return TreeNode(key, value)
        
        if key == root.key:
            root.value = value
        elif key < root.key:
            root.left = self._insert_to_tree(root.left, key, value)
        else:
            root.right = self._insert_to_tree(root.right, key, value)
            
        return root
    
    def _search_in_tree(self, root, key):
        if not root:
            return -1
        
        if key == root.key:
            return root.value
        elif key < root.key:
            return self._search_in_tree(root.left, key)
        else:
            return self._search_in_tree(root.right, key)
    
    def _delete_from_tree(self, root, key):
        if not root:
            return None
        
        if key < root.key:
            root.left = self._delete_from_tree(root.left, key)
        elif key > root.key:
            root.right = self._delete_from_tree(root.right, key)
        else:
            # Node with only one child or no child
            if not root.left:
                return root.right
            elif not root.right:
                return root.left
            
            # Node with two children
            # Get the inorder successor (smallest in the right subtree)
            temp = root.right
            while temp.left:
                temp = temp.left
            
            root.key = temp.key
            root.value = temp.value
            root.right = self._delete_from_tree(root.right, temp.key)
            
        return root
    
    def put(self, key, value):
        index = self._hash(key)
        self.buckets[index] = self._insert_to_tree(self.buckets[index], key, value)
        
    def get(self, key):
        index = self._hash(key)
        return self._search_in_tree(self.buckets[index], key)
        
    def remove(self, key):
        index = self._hash(key)
        self.buckets[index] = self._delete_from_tree(self.buckets[index], key)
```

**Time Complexity:** 
- Average case: O(log n) for all operations
- Worst case: O(n) if the tree becomes unbalanced

**Space Complexity:** O(n + k) where n is the number of elements and k is the number of buckets.

## Solution Choice and Explanation

The linked list with modulo hashing solution (Solution 2) is the best approach for this problem because:

1. **Balance of Efficiency and Simplicity**: It provides a good balance between implementation complexity and performance.

2. **Reasonable Space Usage**: It uses space proportional to the number of elements stored, rather than the maximum possible key value.

3. **Collision Handling**: It effectively handles collisions using chaining with linked lists.

The BST solution (Solution 3) offers better theoretical performance for large buckets but adds significant implementation complexity. For the given constraints (at most 10^4 operations), the linked list solution is likely to perform well enough.

The array implementation (Solution 1) is simple but impractical for the given key range (0 to 10^6) as it would require too much memory regardless of how many elements are actually stored.

In an interview, I would first discuss the trade-offs between different implementations and then implement the linked list solution as a good balance between efficiency and simplicity. I would also mention that in a real-world scenario, we might want to implement dynamic resizing to maintain a good load factor and consider using a balanced BST (like a Red-Black tree or AVL tree) for better worst-case performance.
