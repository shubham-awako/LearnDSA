# Design Circular Queue

## Problem Statement

Design your implementation of the circular queue. The circular queue is a linear data structure in which the operations are performed based on FIFO (First In First Out) principle and the last position is connected back to the first position to make a circle. It is also called "Ring Buffer".

One of the benefits of the circular queue is that we can make use of the spaces in front of the queue. In a normal queue, once the queue becomes full, we cannot insert the next element even if there is a space in front of the queue. But using the circular queue, we can use the space to store new values.

Implementation the `MyCircularQueue` class:
- `MyCircularQueue(k)` Initializes the object with the size of the queue to be `k`.
- `int Front()` Gets the front item from the queue. If the queue is empty, return -1.
- `int Rear()` Gets the last item from the queue. If the queue is empty, return -1.
- `boolean enQueue(int value)` Inserts an element into the circular queue. Return true if the operation is successful.
- `boolean deQueue()` Deletes an element from the circular queue. Return true if the operation is successful.
- `boolean isEmpty()` Checks whether the circular queue is empty or not.
- `boolean isFull()` Checks whether the circular queue is full or not.

You must solve the problem without using the built-in queue data structure in your programming language. 

**Example 1:**
```
Input
["MyCircularQueue", "enQueue", "enQueue", "enQueue", "enQueue", "Rear", "isFull", "deQueue", "enQueue", "Rear"]
[[3], [1], [2], [3], [4], [], [], [], [4], []]
Output
[null, true, true, true, false, 3, true, true, true, 4]

Explanation
MyCircularQueue myCircularQueue = new MyCircularQueue(3);
myCircularQueue.enQueue(1); // return True
myCircularQueue.enQueue(2); // return True
myCircularQueue.enQueue(3); // return True
myCircularQueue.enQueue(4); // return False
myCircularQueue.Rear();     // return 3
myCircularQueue.isFull();   // return True
myCircularQueue.deQueue();  // return True
myCircularQueue.enQueue(4); // return True
myCircularQueue.Rear();     // return 4
```

**Constraints:**
- `1 <= k <= 1000`
- `0 <= value <= 1000`
- At most `3000` calls will be made to `enQueue`, `deQueue`, `Front`, `Rear`, `isEmpty`, and `isFull`.

## Concept Overview

This problem tests your understanding of circular queue implementation. The key insight is to efficiently use a fixed-size array to implement a circular queue by using two pointers (head and tail) and a size counter.

## Solutions

### 1. Array-Based Implementation

Use an array to implement the circular queue with head and tail pointers.

```python
class MyCircularQueue:
    def __init__(self, k):
        self.queue = [0] * k
        self.head = -1  # Index of the front element
        self.tail = -1  # Index of the last element
        self.size = k   # Maximum size of the queue
        self.count = 0  # Current number of elements in the queue

    def enQueue(self, value):
        if self.isFull():
            return False
        
        if self.isEmpty():
            self.head = 0
        
        self.tail = (self.tail + 1) % self.size
        self.queue[self.tail] = value
        self.count += 1
        return True

    def deQueue(self):
        if self.isEmpty():
            return False
        
        self.count -= 1
        if self.count == 0:
            self.head = -1
            self.tail = -1
        else:
            self.head = (self.head + 1) % self.size
        
        return True

    def Front(self):
        if self.isEmpty():
            return -1
        return self.queue[self.head]

    def Rear(self):
        if self.isEmpty():
            return -1
        return self.queue[self.tail]

    def isEmpty(self):
        return self.count == 0

    def isFull(self):
        return self.count == self.size
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(k) - We use an array of size k to store the queue elements.

### 2. Best Optimized Solution - Array-Based Implementation with Modulo Arithmetic

Use an array with modulo arithmetic to implement the circular queue.

```python
class MyCircularQueue:
    def __init__(self, k):
        self.queue = [0] * k
        self.head = 0   # Index of the front element
        self.count = 0  # Current number of elements in the queue
        self.capacity = k  # Maximum size of the queue

    def enQueue(self, value):
        if self.isFull():
            return False
        
        # Calculate the index to insert the new element
        self.queue[(self.head + self.count) % self.capacity] = value
        self.count += 1
        return True

    def deQueue(self):
        if self.isEmpty():
            return False
        
        self.head = (self.head + 1) % self.capacity
        self.count -= 1
        return True

    def Front(self):
        if self.isEmpty():
            return -1
        return self.queue[self.head]

    def Rear(self):
        if self.isEmpty():
            return -1
        return self.queue[(self.head + self.count - 1) % self.capacity]

    def isEmpty(self):
        return self.count == 0

    def isFull(self):
        return self.count == self.capacity
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(k) - We use an array of size k to store the queue elements.

### 3. Alternative Solution - Linked List Implementation

Use a linked list to implement the circular queue.

```python
class Node:
    def __init__(self, value):
        self.value = value
        self.next = None

class MyCircularQueue:
    def __init__(self, k):
        self.capacity = k
        self.count = 0
        self.head = None
        self.tail = None

    def enQueue(self, value):
        if self.isFull():
            return False
        
        new_node = Node(value)
        
        if self.isEmpty():
            self.head = new_node
            self.tail = new_node
            new_node.next = new_node  # Point to itself to form a circle
        else:
            new_node.next = self.head
            self.tail.next = new_node
            self.tail = new_node
        
        self.count += 1
        return True

    def deQueue(self):
        if self.isEmpty():
            return False
        
        if self.count == 1:
            self.head = None
            self.tail = None
        else:
            self.head = self.head.next
            self.tail.next = self.head
        
        self.count -= 1
        return True

    def Front(self):
        if self.isEmpty():
            return -1
        return self.head.value

    def Rear(self):
        if self.isEmpty():
            return -1
        return self.tail.value

    def isEmpty(self):
        return self.count == 0

    def isFull(self):
        return self.count == self.capacity
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(k) - We use k nodes to store the queue elements.

## Solution Choice and Explanation

The array-based implementation with modulo arithmetic (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(1) time complexity for all operations, which is optimal for this problem.

2. **Simplicity**: It's more straightforward to implement and understand than the linked list approach.

3. **Memory Efficiency**: It uses a fixed-size array, which is more memory-efficient than a linked list for a fixed-size queue.

The key insight of this approach is to use modulo arithmetic to efficiently implement the circular behavior of the queue. We use a head pointer to track the front of the queue and a count variable to track the number of elements in the queue. The tail of the queue can be calculated as (head + count - 1) % capacity.

For example, let's implement a circular queue of size 3:
1. Initialize: queue = [0, 0, 0], head = 0, count = 0, capacity = 3
2. enQueue(1): queue = [1, 0, 0], head = 0, count = 1
3. enQueue(2): queue = [1, 2, 0], head = 0, count = 2
4. enQueue(3): queue = [1, 2, 3], head = 0, count = 3
5. enQueue(4): Returns False (queue is full)
6. Rear(): Returns 3 (the last element)
7. isFull(): Returns True
8. deQueue(): head = 1, count = 2
9. enQueue(4): queue = [1, 2, 4], head = 1, count = 3
10. Rear(): Returns 4 (the last element)

The first array-based implementation (Solution 1) is also efficient but uses an additional tail pointer, which makes the code slightly more complex. The linked list implementation (Solution 3) is more flexible but less memory-efficient for a fixed-size queue.

In an interview, I would first mention the array-based implementation with modulo arithmetic as the most efficient and straightforward solution for this problem.
