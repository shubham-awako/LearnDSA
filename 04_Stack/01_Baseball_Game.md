# Baseball Game

## Problem Statement

You are keeping score for a baseball game with strange rules. The game consists of several rounds, where the scores of past rounds may affect future rounds' scores.

At the beginning of the game, you start with an empty record. You are given a list of strings `ops`, where `ops[i]` is the `i`th operation you must apply to the record and is one of the following:

1. An integer `x` - Record a new score of `x`.
2. `"+"` - Record a new score that is the sum of the previous two scores. It is guaranteed there will always be two previous scores.
3. `"D"` - Record a new score that is double the previous score. It is guaranteed there will always be a previous score.
4. `"C"` - Invalidate the previous score, removing it from the record. It is guaranteed there will always be a previous score.

Return the sum of all the scores on the record.

**Example 1:**
```
Input: ops = ["5","2","C","D","+"]
Output: 30
Explanation:
"5" - Add 5 to the record, record is now [5].
"2" - Add 2 to the record, record is now [5, 2].
"C" - Invalidate and remove the previous score, record is now [5].
"D" - Add 2 * 5 = 10 to the record, record is now [5, 10].
"+" - Add 5 + 10 = 15 to the record, record is now [5, 10, 15].
The total sum is 5 + 10 + 15 = 30.
```

**Example 2:**
```
Input: ops = ["5","-2","4","C","D","9","+","+"]
Output: 27
Explanation:
"5" - Add 5 to the record, record is now [5].
"-2" - Add -2 to the record, record is now [5, -2].
"4" - Add 4 to the record, record is now [5, -2, 4].
"C" - Invalidate and remove the previous score, record is now [5, -2].
"D" - Add 2 * -2 = -4 to the record, record is now [5, -2, -4].
"9" - Add 9 to the record, record is now [5, -2, -4, 9].
"+" - Add -4 + 9 = 5 to the record, record is now [5, -2, -4, 9, 5].
"+" - Add 9 + 5 = 14 to the record, record is now [5, -2, -4, 9, 5, 14].
The total sum is 5 + (-2) + (-4) + 9 + 5 + 14 = 27.
```

**Example 3:**
```
Input: ops = ["1"]
Output: 1
```

**Constraints:**
- `1 <= ops.length <= 1000`
- `ops[i]` is `"C"`, `"D"`, `"+"`, or a string representing an integer in the range `[-3 * 10^4, 3 * 10^4]`.
- For operation `"+"`, there will always be at least two previous scores on the record.
- For operations `"C"` and `"D"`, there will always be at least one previous score on the record.

## Concept Overview

This problem tests your understanding of stack operations. The key insight is to use a stack to keep track of the scores and apply the operations as described.

## Solutions

### 1. Best Optimized Solution - Stack

Use a stack to keep track of the scores and apply the operations as described.

```python
def calPoints(ops):
    stack = []
    
    for op in ops:
        if op == "+":
            stack.append(stack[-1] + stack[-2])
        elif op == "D":
            stack.append(2 * stack[-1])
        elif op == "C":
            stack.pop()
        else:
            stack.append(int(op))
    
    return sum(stack)
```

**Time Complexity:** O(n) - We iterate through the operations once.
**Space Complexity:** O(n) - In the worst case, the stack can have all the operations.

### 2. Alternative Solution - Array

Use an array to keep track of the scores and apply the operations as described.

```python
def calPoints(ops):
    record = []
    
    for op in ops:
        if op == "+":
            record.append(record[-1] + record[-2])
        elif op == "D":
            record.append(2 * record[-1])
        elif op == "C":
            record.pop()
        else:
            record.append(int(op))
    
    return sum(record)
```

**Time Complexity:** O(n) - We iterate through the operations once.
**Space Complexity:** O(n) - In the worst case, the array can have all the operations.

### 3. Alternative Solution - Deque

Use a deque to keep track of the scores and apply the operations as described.

```python
from collections import deque

def calPoints(ops):
    record = deque()
    
    for op in ops:
        if op == "+":
            last = record.pop()
            second_last = record[-1]
            record.append(last)
            record.append(last + second_last)
        elif op == "D":
            record.append(2 * record[-1])
        elif op == "C":
            record.pop()
        else:
            record.append(int(op))
    
    return sum(record)
```

**Time Complexity:** O(n) - We iterate through the operations once.
**Space Complexity:** O(n) - In the worst case, the deque can have all the operations.

## Solution Choice and Explanation

The stack solution (Solution 1) is the best approach for this problem because:

1. **Natural Fit**: The problem is naturally modeled as a stack, where operations like "C" (remove the last score) and "+" (add the last two scores) are efficiently handled by stack operations.

2. **Simplicity**: The solution is straightforward to implement and understand.

3. **Optimal Time and Space Complexity**: It achieves O(n) time complexity and O(n) space complexity, which is optimal for this problem.

The key insight of this approach is to use a stack to keep track of the scores. For each operation:
- If it's an integer, push it onto the stack.
- If it's "+", push the sum of the top two elements onto the stack.
- If it's "D", push double the top element onto the stack.
- If it's "C", pop the top element from the stack.

Finally, we sum all the elements in the stack to get the total score.

The array solution (Solution 2) is essentially the same as the stack solution, as Python lists can be used as stacks. The deque solution (Solution 3) is more complex and doesn't offer any advantages for this problem.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
