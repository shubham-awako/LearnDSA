# LFU Cache

## Problem Statement

Design and implement a data structure for a Least Frequently Used (LFU) cache.

Implement the `LFUCache` class:
- `LFUCache(int capacity)` Initializes the object with the `capacity` of the data structure.
- `int get(int key)` Gets the value of the `key` if the `key` exists in the cache. Otherwise, returns `-1`.
- `void put(int key, int value)` Update the value of the `key` if present, or inserts the `key` if not already present. When the cache reaches its `capacity`, it should invalidate and remove the least frequently used key before inserting a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency), the least recently used key would be invalidated.

To determine the least frequently used key, a use counter is maintained for each key in the cache. The key with the smallest use counter is the least frequently used key.

When a key is first inserted into the cache, its use counter is set to `1` (due to the put operation). The use counter for a key in the cache is incremented either a `get` or `put` operation is called on it.

The functions `get` and `put` must each run in O(1) average time complexity.

**Example 1:**
```
Input
["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, 3, null, -1, 3, 4]

Explanation
// cnt(x) = the use counter for key x
// cache=[] will show the last used order for tiebreakers (leftmost element is most recent)
LFUCache lfu = new LFUCache(2);
lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
lfu.get(1);      // return 1
                 // cache=[1,2], cnt(2)=1, cnt(1)=2
lfu.put(3, 3);   // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
                 // cache=[3,1], cnt(3)=1, cnt(1)=2
lfu.get(2);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,1], cnt(3)=2, cnt(1)=2
lfu.put(4, 4);   // Both 1 and 3 have cnt=2, but 1 is LRU, invalidate 1.
                 // cache=[4,3], cnt(4)=1, cnt(3)=2
lfu.get(1);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,4], cnt(4)=1, cnt(3)=3
lfu.get(4);      // return 4
                 // cache=[4,3], cnt(4)=2, cnt(3)=3
```

**Constraints:**
- `0 <= capacity <= 10^4`
- `0 <= key <= 10^5`
- `0 <= value <= 10^9`
- At most `2 * 10^5` calls will be made to `get` and `put`.

## Concept Overview

This problem tests your understanding of data structure design and implementation of an LFU cache. The key insight is to use a combination of hash maps and doubly linked lists to efficiently track both frequency and recency of use.

## Solutions

### 1. Best Optimized Solution - Hash Maps + Doubly Linked Lists

Use two hash maps and multiple doubly linked lists to efficiently track both frequency and recency of use.

```python
class Node:
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.freq = 1
        self.prev = None
        self.next = None

class DLinkedList:
    def __init__(self):
        self.head = Node()  # Dummy head
        self.tail = Node()  # Dummy tail
        self.head.next = self.tail
        self.tail.prev = self.head
        self.size = 0

    def add_node(self, node):
        # Always add the new node right after head
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node
        self.size += 1

    def remove_node(self, node):
        # Remove an existing node from the doubly linked list
        prev = node.prev
        new = node.next
        prev.next = new
        new.prev = prev
        self.size -= 1

    def remove_tail(self):
        # Remove the node at the tail
        if self.size > 0:
            node = self.tail.prev
            self.remove_node(node)
            return node
        return None

class LFUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.size = 0
        self.min_freq = 0
        self.key_to_node = {}  # Map key to node
        self.freq_to_list = {}  # Map frequency to doubly linked list

    def get(self, key: int) -> int:
        if key not in self.key_to_node or self.capacity == 0:
            return -1
        
        # Get the node and update its frequency
        node = self.key_to_node[key]
        self._update_freq(node)
        
        return node.value

    def put(self, key: int, value: int) -> None:
        if self.capacity == 0:
            return
        
        # If key exists, update its value and frequency
        if key in self.key_to_node:
            node = self.key_to_node[key]
            node.value = value
            self._update_freq(node)
            return
        
        # If at capacity, remove the least frequently used item
        if self.size >= self.capacity:
            lfu_list = self.freq_to_list[self.min_freq]
            lfu_node = lfu_list.remove_tail()
            del self.key_to_node[lfu_node.key]
            self.size -= 1
        
        # Add the new key-value pair
        node = Node(key, value)
        self.key_to_node[key] = node
        
        # Add the node to the frequency 1 list
        if 1 not in self.freq_to_list:
            self.freq_to_list[1] = DLinkedList()
        self.freq_to_list[1].add_node(node)
        
        self.min_freq = 1
        self.size += 1

    def _update_freq(self, node):
        # Remove the node from its current frequency list
        freq = node.freq
        self.freq_to_list[freq].remove_node(node)
        
        # Update the min_freq if needed
        if freq == self.min_freq and self.freq_to_list[freq].size == 0:
            self.min_freq += 1
        
        # Increment the node's frequency
        node.freq += 1
        freq = node.freq
        
        # Add the node to the new frequency list
        if freq not in self.freq_to_list:
            self.freq_to_list[freq] = DLinkedList()
        self.freq_to_list[freq].add_node(node)
```

**Time Complexity:** O(1) for both get and put operations.
**Space Complexity:** O(capacity) - We store at most capacity key-value pairs.

### 2. Alternative Solution - Using OrderedDict

Use Python's OrderedDict to maintain the order of keys within each frequency group.

```python
from collections import defaultdict, OrderedDict

class LFUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.size = 0
        self.min_freq = 0
        self.key_to_freq = {}  # Map key to frequency
        self.freq_to_keys = defaultdict(OrderedDict)  # Map frequency to ordered keys

    def get(self, key: int) -> int:
        if key not in self.key_to_freq or self.capacity == 0:
            return -1
        
        # Get the frequency and update it
        freq = self.key_to_freq[key]
        value = self.freq_to_keys[freq][key]
        
        # Remove the key from its current frequency group
        del self.freq_to_keys[freq][key]
        
        # Update the min_freq if needed
        if freq == self.min_freq and not self.freq_to_keys[freq]:
            self.min_freq += 1
        
        # Increment the frequency and add the key to the new frequency group
        freq += 1
        self.key_to_freq[key] = freq
        self.freq_to_keys[freq][key] = value
        
        return value

    def put(self, key: int, value: int) -> None:
        if self.capacity == 0:
            return
        
        # If key exists, update its value and frequency
        if key in self.key_to_freq:
            freq = self.key_to_freq[key]
            self.freq_to_keys[freq][key] = value
            self.get(key)  # Update the frequency
            return
        
        # If at capacity, remove the least frequently used item
        if self.size >= self.capacity:
            # Get the least frequently used key
            lfu_key, _ = self.freq_to_keys[self.min_freq].popitem(last=False)
            del self.key_to_freq[lfu_key]
            self.size -= 1
        
        # Add the new key-value pair
        self.key_to_freq[key] = 1
        self.freq_to_keys[1][key] = value
        self.min_freq = 1
        self.size += 1
```

**Time Complexity:** O(1) for both get and put operations.
**Space Complexity:** O(capacity) - We store at most capacity key-value pairs.

### 3. Alternative Solution - Using a Heap

Use a min-heap to keep track of the least frequently used items.

```python
import heapq

class LFUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.size = 0
        self.key_to_value = {}  # Map key to value
        self.key_to_freq = {}   # Map key to frequency
        self.key_to_time = {}   # Map key to last access time
        self.time = 0           # Global time counter
        self.heap = []          # Min-heap of (frequency, time, key)

    def get(self, key: int) -> int:
        if key not in self.key_to_value or self.capacity == 0:
            return -1
        
        # Update the frequency and time
        self.key_to_freq[key] += 1
        self.time += 1
        self.key_to_time[key] = self.time
        
        # Add the updated key to the heap
        heapq.heappush(self.heap, (self.key_to_freq[key], self.key_to_time[key], key))
        
        return self.key_to_value[key]

    def put(self, key: int, value: int) -> None:
        if self.capacity == 0:
            return
        
        # If key exists, update its value, frequency, and time
        if key in self.key_to_value:
            self.key_to_value[key] = value
            self.get(key)  # Update the frequency and time
            return
        
        # If at capacity, remove the least frequently used item
        if self.size >= self.capacity:
            # Find the least frequently used key
            while self.heap:
                freq, time, lfu_key = heapq.heappop(self.heap)
                if lfu_key in self.key_to_value and self.key_to_freq[lfu_key] == freq and self.key_to_time[lfu_key] == time:
                    del self.key_to_value[lfu_key]
                    del self.key_to_freq[lfu_key]
                    del self.key_to_time[lfu_key]
                    self.size -= 1
                    break
        
        # Add the new key-value pair
        self.key_to_value[key] = value
        self.key_to_freq[key] = 1
        self.time += 1
        self.key_to_time[key] = self.time
        heapq.heappush(self.heap, (1, self.time, key))
        self.size += 1
```

**Time Complexity:** O(log n) for both get and put operations due to the heap operations.
**Space Complexity:** O(capacity) - We store at most capacity key-value pairs.

**Note:** This solution doesn't meet the O(1) time complexity requirement for get and put operations.

## Solution Choice and Explanation

The hash maps + doubly linked lists solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(1) time complexity for both get and put operations, which satisfies the problem requirement.

2. **Efficiency**: It efficiently tracks both frequency and recency of use.

3. **Control**: It provides full control over the implementation, which is important for understanding the underlying data structure.

The key insight of this approach is to use a combination of hash maps and doubly linked lists:
- One hash map maps keys to nodes for O(1) lookups.
- Another hash map maps frequencies to doubly linked lists of nodes with that frequency.
- Each doubly linked list maintains the order of keys within a frequency group, with the most recently used key at the head and the least recently used key at the tail.

For example, let's implement an LFU cache with capacity 2:
1. Initialize: key_to_node = {}, freq_to_list = {}, min_freq = 0, size = 0
2. put(1, 1): key_to_node = {1: node1}, freq_to_list = {1: [node1]}, min_freq = 1, size = 1
3. put(2, 2): key_to_node = {1: node1, 2: node2}, freq_to_list = {1: [node2, node1]}, min_freq = 1, size = 2
4. get(1): key_to_node = {1: node1, 2: node2}, freq_to_list = {1: [node2], 2: [node1]}, min_freq = 1, size = 2
5. put(3, 3): Evict node2 (LFU), key_to_node = {1: node1, 3: node3}, freq_to_list = {1: [node3], 2: [node1]}, min_freq = 1, size = 2
6. get(2): Returns -1 (not found)
7. get(3): key_to_node = {1: node1, 3: node3}, freq_to_list = {2: [node1, node3]}, min_freq = 2, size = 2
8. put(4, 4): Evict node1 (LRU), key_to_node = {3: node3, 4: node4}, freq_to_list = {1: [node4], 2: [node3]}, min_freq = 1, size = 2
9. get(1): Returns -1 (not found)
10. get(3): key_to_node = {3: node3, 4: node4}, freq_to_list = {1: [node4], 3: [node3]}, min_freq = 1, size = 2
11. get(4): key_to_node = {3: node3, 4: node4}, freq_to_list = {2: [node4], 3: [node3]}, min_freq = 2, size = 2

The OrderedDict solution (Solution 2) is also efficient and meets the O(1) time complexity requirement, but it's more of a high-level abstraction that hides the underlying implementation details. The heap-based solution (Solution 3) doesn't meet the O(1) time complexity requirement due to the O(log n) heap operations.

In an interview, I would first mention the hash maps + doubly linked lists approach as the most efficient and detailed solution for this problem, and then mention the OrderedDict approach as a more concise alternative if the language provides such a data structure.
