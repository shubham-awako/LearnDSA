# Design HashSet

## Problem Statement

Design a HashSet without using any built-in hash table libraries.

Implement `MyHashSet` class:
- `void add(key)` Inserts the value `key` into the HashSet.
- `bool contains(key)` Returns whether the value `key` exists in the HashSet or not.
- `void remove(key)` Removes the value `key` in the HashSet. If `key` does not exist in the HashSet, do nothing.

**Example 1:**
```
Input
["MyHashSet", "add", "add", "contains", "contains", "add", "contains", "remove", "contains"]
[[], [1], [2], [1], [3], [2], [2], [2], [2]]
Output
[null, null, null, true, false, null, true, null, false]

Explanation
MyHashSet myHashSet = new MyHashSet();
myHashSet.add(1);      // set = [1]
myHashSet.add(2);      // set = [1, 2]
myHashSet.contains(1); // return True
myHashSet.contains(3); // return False, (not found)
myHashSet.add(2);      // set = [1, 2]
myHashSet.contains(2); // return True
myHashSet.remove(2);   // set = [1]
myHashSet.contains(2); // return False, (already removed)
```

**Constraints:**
- `0 <= key <= 10^6`
- At most `10^4` calls will be made to `add`, `remove`, and `contains`.

## Concept Overview

A HashSet is a data structure that stores unique elements and provides constant-time operations for adding, removing, and checking if an element exists. The key insight is to design an efficient hash function and handle collisions appropriately.

## Solutions

### 1. Brute Force Approach - Array Implementation

Use a simple array to store all possible values (not practical for large key ranges).

```python
class MyHashSet:
    def __init__(self):
        # Since key range is 0 to 10^6, this approach is not practical
        self.data = [False] * (10**6 + 1)
        
    def add(self, key):
        self.data[key] = True
        
    def remove(self, key):
        self.data[key] = False
        
    def contains(self, key):
        return self.data[key]
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(10^6) - Fixed size regardless of the number of elements.

### 2. Improved Solution - Linked List with Modulo Hashing

Use a fixed number of buckets, each containing a linked list to handle collisions.

```python
class ListNode:
    def __init__(self, key):
        self.key = key
        self.next = None

class MyHashSet:
    def __init__(self):
        self.size = 1000  # Number of buckets
        self.buckets = [None] * self.size
        
    def _hash(self, key):
        return key % self.size
    
    def add(self, key):
        index = self._hash(key)
        if not self.buckets[index]:
            self.buckets[index] = ListNode(key)
            return
        
        curr = self.buckets[index]
        # Check if key already exists
        if curr.key == key:
            return
        
        while curr.next:
            if curr.next.key == key:
                return
            curr = curr.next
            
        curr.next = ListNode(key)
        
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
        
    def contains(self, key):
        index = self._hash(key)
        curr = self.buckets[index]
        
        while curr:
            if curr.key == key:
                return True
            curr = curr.next
            
        return False
```

**Time Complexity:** 
- Average case: O(1) for all operations
- Worst case: O(n) if all keys hash to the same bucket

**Space Complexity:** O(n + k) where n is the number of elements and k is the number of buckets.

### 3. Best Optimized Solution - BST with Modulo Hashing

Use a fixed number of buckets, each containing a binary search tree to handle collisions more efficiently.

```python
class TreeNode:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None

class MyHashSet:
    def __init__(self):
        self.size = 1000  # Number of buckets
        self.buckets = [None] * self.size
        
    def _hash(self, key):
        return key % self.size
    
    def _insert_to_tree(self, root, key):
        if not root:
            return TreeNode(key)
        
        if key == root.key:
            return root
        elif key < root.key:
            root.left = self._insert_to_tree(root.left, key)
        else:
            root.right = self._insert_to_tree(root.right, key)
            
        return root
    
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
            root.right = self._delete_from_tree(root.right, temp.key)
            
        return root
    
    def _search_in_tree(self, root, key):
        if not root:
            return False
        
        if key == root.key:
            return True
        elif key < root.key:
            return self._search_in_tree(root.left, key)
        else:
            return self._search_in_tree(root.right, key)
    
    def add(self, key):
        index = self._hash(key)
        self.buckets[index] = self._insert_to_tree(self.buckets[index], key)
        
    def remove(self, key):
        index = self._hash(key)
        self.buckets[index] = self._delete_from_tree(self.buckets[index], key)
        
    def contains(self, key):
        index = self._hash(key)
        return self._search_in_tree(self.buckets[index], key)
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

In an interview, I would first discuss the trade-offs between different implementations and then implement the linked list solution as a good balance between efficiency and simplicity. I would also mention that in a real-world scenario, we might want to implement dynamic resizing to maintain a good load factor.
