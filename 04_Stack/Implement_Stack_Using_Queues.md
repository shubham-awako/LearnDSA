# Implement Stack Using Queues

## Problem Statement

Implement a last-in-first-out (LIFO) stack using only two queues. The implemented stack should support all the functions of a normal stack (`push`, `top`, `pop`, and `empty`).

Implement the `MyStack` class:
- `void push(int x)` Pushes element x to the top of the stack.
- `int pop()` Removes the element on the top of the stack and returns it.
- `int top()` Returns the element on the top of the stack.
- `boolean empty()` Returns `true` if the stack is empty, `false` otherwise.

**Notes:**
- You must use only standard operations of a queue, which means that only `push to back`, `peek/pop from front`, `size` and `is empty` operations are valid.
- Depending on your language, the queue may not be supported natively. You may simulate a queue using a list or deque (double-ended queue) as long as you use only a queue's standard operations.

**Example 1:**
```
Input
["MyStack", "push", "push", "top", "pop", "empty"]
[[], [1], [2], [], [], []]
Output
[null, null, null, 2, 2, false]

Explanation
MyStack myStack = new MyStack();
myStack.push(1);
myStack.push(2);
myStack.top(); // return 2
myStack.pop(); // return 2
myStack.empty(); // return False
```

**Constraints:**
- `1 <= x <= 9`
- At most `100` calls will be made to `push`, `pop`, `top`, and `empty`.
- All the calls to `pop` and `top` are valid.

**Follow-up:** Can you implement the stack using only one queue?

## Concept Overview

This problem tests your understanding of how to implement one data structure using another. The key insight is to find a way to reverse the order of elements in a queue to achieve the LIFO behavior of a stack.

## Solutions

### 1. Using Two Queues - Push O(1), Pop O(n)

Use two queues to implement a stack. Keep the main queue for storage and use the auxiliary queue during pop operations.

```python
from collections import deque

class MyStack:
    def __init__(self):
        self.queue1 = deque()  # Main queue
        self.queue2 = deque()  # Auxiliary queue

    def push(self, x):
        self.queue1.append(x)

    def pop(self):
        # Move all elements except the last one to queue2
        while len(self.queue1) > 1:
            self.queue2.append(self.queue1.popleft())
        
        # Get the last element (top of the stack)
        result = self.queue1.popleft()
        
        # Swap queue1 and queue2
        self.queue1, self.queue2 = self.queue2, self.queue1
        
        return result

    def top(self):
        # Move all elements except the last one to queue2
        while len(self.queue1) > 1:
            self.queue2.append(self.queue1.popleft())
        
        # Get the last element (top of the stack)
        result = self.queue1.popleft()
        
        # Put the last element back to queue2
        self.queue2.append(result)
        
        # Swap queue1 and queue2
        self.queue1, self.queue2 = self.queue2, self.queue1
        
        return result

    def empty(self):
        return len(self.queue1) == 0
```

**Time Complexity:**
- Push: O(1)
- Pop: O(n)
- Top: O(n)
- Empty: O(1)

**Space Complexity:** O(n) - For storing the elements.

### 2. Using Two Queues - Push O(n), Pop O(1)

Use two queues to implement a stack. Make push operation expensive by rearranging elements to maintain LIFO order.

```python
from collections import deque

class MyStack:
    def __init__(self):
        self.queue1 = deque()  # Main queue
        self.queue2 = deque()  # Auxiliary queue

    def push(self, x):
        # Add the new element to queue2
        self.queue2.append(x)
        
        # Move all elements from queue1 to queue2
        while self.queue1:
            self.queue2.append(self.queue1.popleft())
        
        # Swap queue1 and queue2
        self.queue1, self.queue2 = self.queue2, self.queue1

    def pop(self):
        return self.queue1.popleft()

    def top(self):
        return self.queue1[0]

    def empty(self):
        return len(self.queue1) == 0
```

**Time Complexity:**
- Push: O(n)
- Pop: O(1)
- Top: O(1)
- Empty: O(1)

**Space Complexity:** O(n) - For storing the elements.

### 3. Best Optimized Solution - Using One Queue

Use a single queue to implement a stack by rotating the queue after each push operation.

```python
from collections import deque

class MyStack:
    def __init__(self):
        self.queue = deque()

    def push(self, x):
        self.queue.append(x)
        
        # Rotate the queue to bring the last element to the front
        for _ in range(len(self.queue) - 1):
            self.queue.append(self.queue.popleft())

    def pop(self):
        return self.queue.popleft()

    def top(self):
        return self.queue[0]

    def empty(self):
        return len(self.queue) == 0
```

**Time Complexity:**
- Push: O(n)
- Pop: O(1)
- Top: O(1)
- Empty: O(1)

**Space Complexity:** O(n) - For storing the elements.

## Solution Choice and Explanation

The one queue solution (Solution 3) is the best approach for this problem because:

1. **Simplicity**: It uses only one queue, which simplifies the implementation and reduces the space overhead.

2. **Efficiency**: It achieves O(1) time complexity for pop, top, and empty operations, which are the most common operations in a stack.

3. **Follows the Follow-up**: It satisfies the follow-up question of implementing the stack using only one queue.

The key insight of this approach is to rotate the queue after each push operation to bring the last element (which should be the top of the stack) to the front of the queue. This way, we can achieve the LIFO behavior of a stack using a queue.

For example, let's say we push 1, 2, and 3 to the stack:
1. Push 1: queue = [1]
2. Push 2: queue = [2, 1] (after rotation)
3. Push 3: queue = [3, 2, 1] (after rotation)

Now, when we pop, we get 3, which is the last element we pushed (LIFO behavior).

The two-queue solutions (Solutions 1 and 2) are also valid but use more space and are more complex. Solution 1 makes push operations efficient but pop and top operations expensive, while Solution 2 makes pop and top operations efficient but push operations expensive.

In an interview, I would first mention the one queue solution as the most elegant and efficient approach, especially considering the follow-up question.
