# Maximum Frequency Stack

## Problem Statement

Design a stack-like data structure to push elements to the stack and pop the most frequent element from the stack.

Implement the `FreqStack` class:
- `FreqStack()` constructs an empty frequency stack.
- `void push(int val)` pushes an integer `val` onto the top of the stack.
- `int pop()` removes and returns the most frequent element in the stack.
  - If there is a tie for the most frequent element, the element closest to the stack's top is removed and returned.

**Example 1:**
```
Input
["FreqStack", "push", "push", "push", "push", "push", "push", "pop", "pop", "pop", "pop"]
[[], [5], [7], [5], [7], [4], [5], [], [], [], []]
Output
[null, null, null, null, null, null, null, 5, 7, 5, 4]

Explanation
FreqStack freqStack = new FreqStack();
freqStack.push(5); // The stack is [5]
freqStack.push(7); // The stack is [5,7]
freqStack.push(5); // The stack is [5,7,5]
freqStack.push(7); // The stack is [5,7,5,7]
freqStack.push(4); // The stack is [5,7,5,7,4]
freqStack.push(5); // The stack is [5,7,5,7,4,5]
freqStack.pop();   // return 5, as 5 is the most frequent. The stack becomes [5,7,5,7,4].
freqStack.pop();   // return 7, as 5 and 7 is the most frequent, but 7 is closest to the top. The stack becomes [5,7,5,4].
freqStack.pop();   // return 5, as 5 is the most frequent. The stack becomes [5,7,4].
freqStack.pop();   // return 4, as 4, 5 and 7 is the most frequent, but 4 is closest to the top. The stack becomes [5,7].
```

**Constraints:**
- `0 <= val <= 10^9`
- At most `2 * 10^4` calls will be made to `push` and `pop`.
- It is guaranteed that there will be at least one element in the stack before calling `pop`.

## Concept Overview

This problem tests your understanding of how to design a data structure that efficiently tracks the frequency of elements and maintains the order of insertion. The key insight is to use a combination of hash maps and stacks to achieve this.

## Solutions

### 1. Best Optimized Solution - Hash Map of Stacks

Use a hash map to track the frequency of each element and another hash map to store stacks of elements with the same frequency.

```python
class FreqStack:
    def __init__(self):
        self.freq = {}  # Map from element to its frequency
        self.group = {}  # Map from frequency to stack of elements
        self.max_freq = 0  # Current maximum frequency

    def push(self, val):
        # Update the frequency of the element
        self.freq[val] = self.freq.get(val, 0) + 1
        freq = self.freq[val]
        
        # Update the maximum frequency
        self.max_freq = max(self.max_freq, freq)
        
        # Add the element to the stack of its frequency
        if freq not in self.group:
            self.group[freq] = []
        self.group[freq].append(val)

    def pop(self):
        # Get the stack of elements with the maximum frequency
        stack = self.group[self.max_freq]
        
        # Pop the most recent element with the maximum frequency
        val = stack.pop()
        
        # Update the frequency of the element
        self.freq[val] -= 1
        
        # If the stack is empty, decrement the maximum frequency
        if not stack:
            self.max_freq -= 1
        
        return val
```

**Time Complexity:** O(1) for both push and pop operations.
**Space Complexity:** O(n) - For storing the frequency map and the group map.

### 2. Alternative Solution - Priority Queue

Use a priority queue to track elements based on their frequency and insertion order.

```python
import heapq

class FreqStack:
    def __init__(self):
        self.freq = {}  # Map from element to its frequency
        self.heap = []  # Priority queue of (frequency, timestamp, element)
        self.timestamp = 0  # Counter for insertion order

    def push(self, val):
        # Update the frequency of the element
        self.freq[val] = self.freq.get(val, 0) + 1
        freq = self.freq[val]
        
        # Push the element to the heap with negative frequency and timestamp
        # (negative for max heap, and timestamp for tie-breaking)
        heapq.heappush(self.heap, (-freq, -self.timestamp, val))
        self.timestamp += 1

    def pop(self):
        # Pop the element with the highest frequency and most recent timestamp
        _, _, val = heapq.heappop(self.heap)
        
        # Update the frequency of the element
        self.freq[val] -= 1
        
        return val
```

**Time Complexity:** O(log n) for both push and pop operations.
**Space Complexity:** O(n) - For storing the frequency map and the heap.

**Note:** This solution doesn't handle the case where an element's frequency changes after it's pushed to the heap. It would require additional logic to handle this, making it more complex.

### 3. Alternative Solution - Stack of Stacks

Use a stack of stacks to track elements based on their frequency.

```python
class FreqStack:
    def __init__(self):
        self.freq = {}  # Map from element to its frequency
        self.stacks = []  # List of stacks, one for each frequency level

    def push(self, val):
        # Update the frequency of the element
        self.freq[val] = self.freq.get(val, 0) + 1
        freq = self.freq[val]
        
        # Ensure we have enough stacks
        while len(self.stacks) < freq:
            self.stacks.append([])
        
        # Add the element to the stack of its frequency
        self.stacks[freq - 1].append(val)

    def pop(self):
        # Get the stack with the highest frequency
        top_stack = self.stacks[-1]
        
        # Pop the most recent element with the highest frequency
        val = top_stack.pop()
        
        # If the stack is empty, remove it
        if not top_stack:
            self.stacks.pop()
        
        # Update the frequency of the element
        self.freq[val] -= 1
        
        return val
```

**Time Complexity:** O(1) for both push and pop operations.
**Space Complexity:** O(n) - For storing the frequency map and the stacks.

## Solution Choice and Explanation

The hash map of stacks solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(1) time complexity for both push and pop operations, which is optimal for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Efficient Data Structure**: It uses hash maps and stacks, which are efficient for the operations required in this problem.

The key insight of this approach is to use two hash maps:
- `freq`: Maps each element to its frequency.
- `group`: Maps each frequency to a stack of elements with that frequency.

We also keep track of the maximum frequency to efficiently find the most frequent element.

For push operations:
1. Increment the frequency of the element.
2. Update the maximum frequency if needed.
3. Add the element to the stack of its frequency.

For pop operations:
1. Get the stack of elements with the maximum frequency.
2. Pop the most recent element from that stack.
3. Decrement the frequency of the element.
4. If the stack is empty, decrement the maximum frequency.

For example, let's simulate the example:
1. Push 5: freq = {5: 1}, group = {1: [5]}, max_freq = 1
2. Push 7: freq = {5: 1, 7: 1}, group = {1: [5, 7]}, max_freq = 1
3. Push 5: freq = {5: 2, 7: 1}, group = {1: [5, 7], 2: [5]}, max_freq = 2
4. Push 7: freq = {5: 2, 7: 2}, group = {1: [5, 7], 2: [5, 7]}, max_freq = 2
5. Push 4: freq = {5: 2, 7: 2, 4: 1}, group = {1: [5, 7, 4], 2: [5, 7]}, max_freq = 2
6. Push 5: freq = {5: 3, 7: 2, 4: 1}, group = {1: [5, 7, 4], 2: [5, 7], 3: [5]}, max_freq = 3
7. Pop: Return 5 (from group[3]), freq = {5: 2, 7: 2, 4: 1}, group = {1: [5, 7, 4], 2: [5, 7], 3: []}, max_freq = 2
8. Pop: Return 7 (from group[2]), freq = {5: 2, 7: 1, 4: 1}, group = {1: [5, 7, 4], 2: [5], 3: []}, max_freq = 2
9. Pop: Return 5 (from group[2]), freq = {5: 1, 7: 1, 4: 1}, group = {1: [5, 7, 4], 2: [], 3: []}, max_freq = 1
10. Pop: Return 4 (from group[1]), freq = {5: 1, 7: 1, 4: 0}, group = {1: [5, 7], 2: [], 3: []}, max_freq = 1

The priority queue solution (Solution 2) is less efficient with O(log n) time complexity for push and pop operations. The stack of stacks solution (Solution 3) is also efficient but more complex to implement.

In an interview, I would first mention the hash map of stacks approach as the most efficient and straightforward solution for this problem.
