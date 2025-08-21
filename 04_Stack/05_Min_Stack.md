# Min Stack

## Problem Statement

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

Implement the `MinStack` class:
- `MinStack()` initializes the stack object.
- `void push(int val)` pushes the element `val` onto the stack.
- `void pop()` removes the element on the top of the stack.
- `int top()` gets the top element of the stack.
- `int getMin()` retrieves the minimum element in the stack.

You must implement a solution with `O(1)` time complexity for each function.

**Example 1:**
```
Input
["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]
Output
[null,null,null,null,-3,null,0,-2]

Explanation
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2
```

**Constraints:**
- `-2^31 <= val <= 2^31 - 1`
- Methods `pop`, `top` and `getMin` operations will always be called on non-empty stacks.
- At most `3 * 10^4` calls will be made to `push`, `pop`, `top`, and `getMin`.

## Concept Overview

This problem tests your understanding of how to design a data structure with specific requirements. The key insight is to find a way to track the minimum element in constant time while supporting all stack operations.

## Solutions

### 1. Using Two Stacks

Use two stacks: one for the actual elements and another for tracking the minimum element at each level.

```python
class MinStack:
    def __init__(self):
        self.stack = []  # Main stack
        self.min_stack = []  # Stack to track minimum elements

    def push(self, val):
        self.stack.append(val)
        
        # Update the minimum stack
        if not self.min_stack or val <= self.min_stack[-1]:
            self.min_stack.append(val)

    def pop(self):
        # If the popped element is the current minimum, remove it from min_stack as well
        if self.stack[-1] == self.min_stack[-1]:
            self.min_stack.pop()
        
        self.stack.pop()

    def top(self):
        return self.stack[-1]

    def getMin(self):
        return self.min_stack[-1]
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(n) - In the worst case, the min_stack can have all elements.

### 2. Using One Stack with Pairs

Use a single stack to store pairs of (value, current_min).

```python
class MinStack:
    def __init__(self):
        self.stack = []  # Stack of (value, current_min) pairs

    def push(self, val):
        # Calculate the new minimum
        current_min = min(val, self.getMin()) if self.stack else val
        self.stack.append((val, current_min))

    def pop(self):
        self.stack.pop()

    def top(self):
        return self.stack[-1][0]

    def getMin(self):
        return self.stack[-1][1] if self.stack else float('inf')
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(n) - We store pairs for each element.

### 3. Best Optimized Solution - Using One Stack with Encoded Values

Use a single stack and encode the minimum value in the stack elements.

```python
class MinStack:
    def __init__(self):
        self.stack = []  # Main stack
        self.min_val = float('inf')  # Current minimum value

    def push(self, val):
        # If the new value is smaller than or equal to the current minimum,
        # push the old minimum first and update the minimum
        if val <= self.min_val:
            self.stack.append(self.min_val)
            self.min_val = val
        
        self.stack.append(val)

    def pop(self):
        # If the popped value is the current minimum,
        # the next value in the stack is the previous minimum
        if self.stack.pop() == self.min_val:
            self.min_val = self.stack.pop()

    def top(self):
        return self.stack[-1]

    def getMin(self):
        return self.min_val
```

**Time Complexity:** O(1) for all operations.
**Space Complexity:** O(n) - In the worst case, we store 2n elements.

## Solution Choice and Explanation

The two stacks solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's straightforward to implement and understand.

2. **Efficiency**: It achieves O(1) time complexity for all operations, as required.

3. **Space Efficiency**: It uses less space than Solution 3 in the average case, as we only push to the min_stack when necessary.

The key insight of this approach is to use a separate stack to track the minimum element at each level. When we push a new element, we only add it to the min_stack if it's smaller than or equal to the current minimum. When we pop an element, we check if it's the current minimum, and if so, we also pop from the min_stack.

For example, let's say we push -2, 0, -3 to the stack:
1. Push -2: stack = [-2], min_stack = [-2]
2. Push 0: stack = [-2, 0], min_stack = [-2] (0 > -2, so we don't push to min_stack)
3. Push -3: stack = [-2, 0, -3], min_stack = [-2, -3] (-3 < -2, so we push to min_stack)

Now, when we call getMin(), we return the top of min_stack, which is -3.
When we pop(), we remove -3 from both stack and min_stack: stack = [-2, 0], min_stack = [-2].
When we call getMin() again, we return the top of min_stack, which is -2.

Solution 2 is also efficient but uses more space by storing pairs for each element. Solution 3 is clever but can be less intuitive and uses more space in the worst case.

In an interview, I would first mention the two stacks approach as the most straightforward and efficient solution for this problem.
