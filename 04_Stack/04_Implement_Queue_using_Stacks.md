# Implement Queue using Stacks

## Problem Statement

Implement a first in first out (FIFO) queue using only two stacks. The implemented queue should support all the functions of a normal queue (`push`, `peek`, `pop`, and `empty`).

Implement the `MyQueue` class:
- `void push(int x)` Pushes element x to the back of the queue.
- `int pop()` Removes the element from the front of the queue and returns it.
- `int peek()` Returns the element at the front of the queue.
- `boolean empty()` Returns `true` if the queue is empty, `false` otherwise.

**Notes:**
- You must use only standard operations of a stack, which means only `push to top`, `peek/pop from top`, `size`, and `is empty` operations are valid.
- Depending on your language, the stack may not be supported natively. You may simulate a stack using a list or deque (double-ended queue) as long as you use only a stack's standard operations.

**Example 1:**
```
Input
["MyQueue", "push", "push", "peek", "pop", "empty"]
[[], [1], [2], [], [], []]
Output
[null, null, null, 1, 1, false]

Explanation
MyQueue myQueue = new MyQueue();
myQueue.push(1); // queue is: [1]
myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
myQueue.peek(); // return 1
myQueue.pop(); // return 1, queue is [2]
myQueue.empty(); // return false
```

**Constraints:**
- `1 <= x <= 9`
- At most `100` calls will be made to `push`, `pop`, `peek`, and `empty`.
- All the calls to `pop` and `peek` are valid.

**Follow-up:** Can you implement the queue such that each operation is amortized O(1) time complexity? In other words, performing n operations will take overall O(n) time even if one of those operations may take longer.

## Concept Overview

This problem tests your understanding of how to implement one data structure using another. The key insight is to find a way to reverse the order of elements in a stack to achieve the FIFO behavior of a queue.

## Solutions

### 1. Using Two Stacks - Push O(1), Pop O(n)

Use two stacks to implement a queue. Keep the input stack for push operations and transfer elements to the output stack during pop and peek operations.

```python
class MyQueue:
    def __init__(self):
        self.input_stack = []  # For push operations
        self.output_stack = []  # For pop and peek operations

    def push(self, x):
        self.input_stack.append(x)

    def pop(self):
        self._move_elements_if_needed()
        return self.output_stack.pop()

    def peek(self):
        self._move_elements_if_needed()
        return self.output_stack[-1]

    def empty(self):
        return len(self.input_stack) == 0 and len(self.output_stack) == 0
    
    def _move_elements_if_needed(self):
        # If output stack is empty, transfer all elements from input stack
        if not self.output_stack:
            while self.input_stack:
                self.output_stack.append(self.input_stack.pop())
```

**Time Complexity:**
- Push: O(1)
- Pop: Amortized O(1), worst case O(n)
- Peek: Amortized O(1), worst case O(n)
- Empty: O(1)

**Space Complexity:** O(n) - For storing the elements.

### 2. Using Two Stacks - Push O(n), Pop O(1)

Use two stacks to implement a queue. Make push operation expensive by rearranging elements to maintain FIFO order.

```python
class MyQueue:
    def __init__(self):
        self.stack1 = []  # Main stack
        self.stack2 = []  # Auxiliary stack

    def push(self, x):
        # Move all elements from stack1 to stack2
        while self.stack1:
            self.stack2.append(self.stack1.pop())
        
        # Push the new element to stack1
        self.stack1.append(x)
        
        # Move all elements back from stack2 to stack1
        while self.stack2:
            self.stack1.append(self.stack2.pop())

    def pop(self):
        return self.stack1.pop()

    def peek(self):
        return self.stack1[-1]

    def empty(self):
        return len(self.stack1) == 0
```

**Time Complexity:**
- Push: O(n)
- Pop: O(1)
- Peek: O(1)
- Empty: O(1)

**Space Complexity:** O(n) - For storing the elements.

### 3. Best Optimized Solution - Amortized O(1) for All Operations

Use two stacks to implement a queue. Keep the input stack for push operations and the output stack for pop and peek operations, transferring elements only when needed.

```python
class MyQueue:
    def __init__(self):
        self.input_stack = []  # For push operations
        self.output_stack = []  # For pop and peek operations

    def push(self, x):
        self.input_stack.append(x)

    def pop(self):
        self._move_elements_if_needed()
        return self.output_stack.pop()

    def peek(self):
        self._move_elements_if_needed()
        return self.output_stack[-1]

    def empty(self):
        return len(self.input_stack) == 0 and len(self.output_stack) == 0
    
    def _move_elements_if_needed(self):
        # If output stack is empty, transfer all elements from input stack
        if not self.output_stack:
            while self.input_stack:
                self.output_stack.append(self.input_stack.pop())
```

**Time Complexity:**
- Push: O(1)
- Pop: Amortized O(1), worst case O(n)
- Peek: Amortized O(1), worst case O(n)
- Empty: O(1)

**Space Complexity:** O(n) - For storing the elements.

## Solution Choice and Explanation

The amortized O(1) solution (Solution 3, which is the same as Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves amortized O(1) time complexity for all operations, which is optimal for this problem.

2. **Follows the Follow-up**: It satisfies the follow-up question of implementing the queue with amortized O(1) time complexity for all operations.

3. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use two stacks: one for push operations (input stack) and one for pop and peek operations (output stack). When we need to pop or peek and the output stack is empty, we transfer all elements from the input stack to the output stack. This reverses the order of elements, which is exactly what we need to achieve the FIFO behavior of a queue.

For example, let's say we push 1, 2, and 3 to the queue:
1. Push 1: input_stack = [1], output_stack = []
2. Push 2: input_stack = [1, 2], output_stack = []
3. Push 3: input_stack = [1, 2, 3], output_stack = []

Now, when we pop:
1. output_stack is empty, so we transfer all elements from input_stack: input_stack = [], output_stack = [3, 2, 1]
2. Pop returns 1, which is the first element we pushed (FIFO behavior): input_stack = [], output_stack = [3, 2]

The time complexity is amortized O(1) because each element is moved from the input stack to the output stack at most once. Even though a single pop operation might take O(n) time in the worst case (when we need to transfer all elements), n pop operations will take at most O(n) time in total.

Solution 2 makes pop and peek operations efficient but push operations expensive, which doesn't satisfy the follow-up question.

In an interview, I would first mention the amortized O(1) solution as the most efficient approach, especially considering the follow-up question.
