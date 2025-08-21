# LRU Cache

## Problem Statement

Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

Implement the `LRUCache` class:
- `LRUCache(int capacity)` Initialize the LRU cache with positive size `capacity`.
- `int get(int key)` Return the value of the `key` if the key exists, otherwise return `-1`.
- `void put(int key, int value)` Update the value of the `key` if the `key` exists. Otherwise, add the `key-value` pair to the cache. If the number of keys exceeds the `capacity` from this operation, evict the least recently used key.

The functions `get` and `put` must each run in O(1) average time complexity.

**Example 1:**
```
Input
["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, null, -1, 3, 4]

Explanation
LRUCache lRUCache = new LRUCache(2);
lRUCache.put(1, 1); // cache is {1=1}
lRUCache.put(2, 2); // cache is {1=1, 2=2}
lRUCache.get(1);    // return 1
lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
lRUCache.get(2);    // returns -1 (not found)
lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
lRUCache.get(1);    // return -1 (not found)
lRUCache.get(3);    // return 3
lRUCache.get(4);    // return 4
```

**Constraints:**
- `1 <= capacity <= 3000`
- `0 <= key <= 10^4`
- `0 <= value <= 10^5`
- At most `2 * 10^5` calls will be made to `get` and `put`.

## Concept Overview

This problem tests your understanding of data structure design and implementation of an LRU cache. The key insight is to use a combination of a hash map for O(1) lookups and a doubly linked list for O(1) insertions, deletions, and updates to the order of elements.

## Solutions

### 1. Best Optimized Solution - Hash Map + Doubly Linked List

Use a hash map for O(1) lookups and a doubly linked list for O(1) insertions, deletions, and updates to the order of elements.

```python
class DLinkedNode:
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity: int):
        self.cache = {}  # Map key to node
        self.size = 0
        self.capacity = capacity
        self.head = DLinkedNode()  # Dummy head
        self.tail = DLinkedNode()  # Dummy tail
        self.head.next = self.tail
        self.tail.prev = self.head

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        
        # Remove the node from its current position
        node = self.cache[key]
        self._remove_node(node)
        
        # Add the node to the front (most recently used)
        self._add_node(node)
        
        return node.value

    def put(self, key: int, value: int) -> None:
        # If key exists, remove it
        if key in self.cache:
            self._remove_node(self.cache[key])
            self.size -= 1
        
        # Create a new node
        node = DLinkedNode(key, value)
        self.cache[key] = node
        self._add_node(node)
        self.size += 1
        
        # If over capacity, remove the least recently used item (tail)
        if self.size > self.capacity:
            lru = self.tail.prev
            self._remove_node(lru)
            del self.cache[lru.key]
            self.size -= 1

    def _add_node(self, node):
        # Always add the new node right after head
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node

    def _remove_node(self, node):
        # Remove an existing node from the doubly linked list
        prev = node.prev
        new = node.next
        prev.next = new
        new.prev = prev
```

**Time Complexity:** O(1) for both get and put operations.
**Space Complexity:** O(capacity) - We store at most capacity key-value pairs.

### 2. Alternative Solution - Using OrderedDict

Use Python's OrderedDict, which maintains the order of insertion.

```python
from collections import OrderedDict

class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = OrderedDict()

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        
        # Move the key to the end to indicate it was recently used
        self.cache.move_to_end(key)
        return self.cache[key]

    def put(self, key: int, value: int) -> None:
        # If key exists, update its value and move it to the end
        if key in self.cache:
            self.cache[key] = value
            self.cache.move_to_end(key)
            return
        
        # If at capacity, remove the least recently used item (first item)
        if len(self.cache) >= self.capacity:
            self.cache.popitem(last=False)
        
        # Add the new key-value pair
        self.cache[key] = value
```

**Time Complexity:** O(1) for both get and put operations.
**Space Complexity:** O(capacity) - We store at most capacity key-value pairs.

### 3. Alternative Solution - Using a List for Order

Use a hash map for lookups and a list to maintain the order of elements.

```python
class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = {}  # Map key to value
        self.order = []  # List to maintain order of keys

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        
        # Update the order to indicate the key was recently used
        self.order.remove(key)
        self.order.append(key)
        
        return self.cache[key]

    def put(self, key: int, value: int) -> None:
        # If key exists, update its value and order
        if key in self.cache:
            self.cache[key] = value
            self.order.remove(key)
            self.order.append(key)
            return
        
        # If at capacity, remove the least recently used item
        if len(self.cache) >= self.capacity:
            lru_key = self.order.pop(0)
            del self.cache[lru_key]
        
        # Add the new key-value pair
        self.cache[key] = value
        self.order.append(key)
```

**Time Complexity:** O(n) for both get and put operations due to the list operations.
**Space Complexity:** O(capacity) - We store at most capacity key-value pairs.

**Note:** This solution doesn't meet the O(1) time complexity requirement for get and put operations.

## Solution Choice and Explanation

The hash map + doubly linked list solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(1) time complexity for both get and put operations, which satisfies the problem requirement.

2. **Efficiency**: It efficiently handles insertions, deletions, and updates to the order of elements.

3. **Control**: It provides full control over the implementation, which is important for understanding the underlying data structure.

The key insight of this approach is to use a combination of a hash map and a doubly linked list:
- The hash map provides O(1) lookups for the get operation.
- The doubly linked list provides O(1) insertions, deletions, and updates to the order of elements for both get and put operations.

For example, let's implement an LRU cache with capacity 2:
1. Initialize: cache = {}, head <-> tail
2. put(1, 1): cache = {1: node1}, head <-> node1 <-> tail
3. put(2, 2): cache = {1: node1, 2: node2}, head <-> node2 <-> node1 <-> tail
4. get(1): Move node1 to the front, head <-> node1 <-> node2 <-> tail
5. put(3, 3): Evict node2 (LRU), cache = {1: node1, 3: node3}, head <-> node3 <-> node1 <-> tail
6. get(2): Returns -1 (not found)
7. put(4, 4): Evict node1 (LRU), cache = {3: node3, 4: node4}, head <-> node4 <-> node3 <-> tail
8. get(1): Returns -1 (not found)
9. get(3): Move node3 to the front, head <-> node3 <-> node4 <-> tail
10. get(4): Move node4 to the front, head <-> node4 <-> node3 <-> tail

The OrderedDict solution (Solution 2) is also efficient and meets the O(1) time complexity requirement, but it's more of a high-level abstraction that hides the underlying implementation details. The list-based solution (Solution 3) doesn't meet the O(1) time complexity requirement due to the O(n) list operations.

In an interview, I would first mention the hash map + doubly linked list approach as the most efficient and detailed solution for this problem, and then mention the OrderedDict approach as a more concise alternative if the language provides such a data structure.
