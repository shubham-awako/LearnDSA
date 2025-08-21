# Evaluate Reverse Polish Notation

## Problem Statement

You are given an array of strings `tokens` that represents an arithmetic expression in a Reverse Polish Notation (RPN).

Evaluate the expression. Return an integer that represents the value of the expression.

**Note** that:
- The valid operators are `'+'`, `'-'`, `'*'`, and `'/'`.
- Each operand may be an integer or another expression.
- The division between two integers always truncates toward zero.
- There will not be any division by zero.
- The input represents a valid arithmetic expression in a reverse polish notation.
- The answer and all the intermediate calculations can be represented in a 32-bit integer.

**Example 1:**
```
Input: tokens = ["2","1","+","3","*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9
```

**Example 2:**
```
Input: tokens = ["4","13","5","/","+"]
Output: 6
Explanation: (4 + (13 / 5)) = 6
```

**Example 3:**
```
Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
Output: 22
Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
= ((10 * (6 / (12 * -11))) + 17) + 5
= ((10 * (6 / -132)) + 17) + 5
= ((10 * 0) + 17) + 5
= (0 + 17) + 5
= 17 + 5
= 22
```

**Constraints:**
- `1 <= tokens.length <= 10^4`
- `tokens[i]` is either an operator: `"+"`, `"-"`, `"*"`, or `"/"`, or an integer in the range `[-200, 200]`.

## Concept Overview

This problem tests your understanding of stack operations for evaluating expressions in Reverse Polish Notation (RPN). The key insight is to use a stack to keep track of operands and perform operations when an operator is encountered.

## Solutions

### 1. Best Optimized Solution - Stack

Use a stack to keep track of operands and perform operations when an operator is encountered.

```python
def evalRPN(tokens):
    stack = []
    
    for token in tokens:
        if token in ["+", "-", "*", "/"]:
            # Pop the top two operands
            b = stack.pop()
            a = stack.pop()
            
            # Perform the operation
            if token == "+":
                stack.append(a + b)
            elif token == "-":
                stack.append(a - b)
            elif token == "*":
                stack.append(a * b)
            elif token == "/":
                # Division truncates toward zero
                stack.append(int(a / b))
        else:
            # Push the operand onto the stack
            stack.append(int(token))
    
    # The final result is the only element left in the stack
    return stack[0]
```

**Time Complexity:** O(n) - We iterate through the tokens once.
**Space Complexity:** O(n) - In the worst case, the stack can have all operands.

### 2. Alternative Solution - Using a Function Map

Use a dictionary to map operators to functions.

```python
def evalRPN(tokens):
    stack = []
    
    # Map operators to functions
    operations = {
        "+": lambda a, b: a + b,
        "-": lambda a, b: a - b,
        "*": lambda a, b: a * b,
        "/": lambda a, b: int(a / b)  # Division truncates toward zero
    }
    
    for token in tokens:
        if token in operations:
            # Pop the top two operands
            b = stack.pop()
            a = stack.pop()
            
            # Perform the operation
            stack.append(operations[token](a, b))
        else:
            # Push the operand onto the stack
            stack.append(int(token))
    
    # The final result is the only element left in the stack
    return stack[0]
```

**Time Complexity:** O(n) - We iterate through the tokens once.
**Space Complexity:** O(n) - In the worst case, the stack can have all operands.

### 3. Alternative Solution - Recursion

Use recursion to evaluate the expression.

```python
def evalRPN(tokens):
    def evaluate(index):
        token = tokens[index]
        
        if token in ["+", "-", "*", "/"]:
            # Evaluate the right operand first (since we're working backwards)
            right_val, right_index = evaluate(index - 1)
            # Then evaluate the left operand
            left_val, left_index = evaluate(right_index - 1)
            
            # Perform the operation
            if token == "+":
                return left_val + right_val, left_index
            elif token == "-":
                return left_val - right_val, left_index
            elif token == "*":
                return left_val * right_val, left_index
            elif token == "/":
                return int(left_val / right_val), left_index
        else:
            # Return the operand value and the previous index
            return int(token), index - 1
    
    # Start from the end of the tokens
    result, _ = evaluate(len(tokens) - 1)
    return result
```

**Time Complexity:** O(n) - We process each token once.
**Space Complexity:** O(n) - The recursion stack can go up to O(n) levels deep.

**Note:** This solution is not practical for this problem as it requires working backwards from the end of the tokens, which is not how RPN is typically evaluated.

## Solution Choice and Explanation

The stack solution (Solution 1) is the best approach for this problem because:

1. **Natural Fit**: The problem is naturally modeled as a stack, where operands are pushed onto the stack and operators pop the top two operands, perform the operation, and push the result back.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Optimal Time and Space Complexity**: It achieves O(n) time complexity and O(n) space complexity, which is optimal for this problem.

The key insight of this approach is to use a stack to keep track of operands. For each token:
- If it's an operand, push it onto the stack.
- If it's an operator, pop the top two operands, perform the operation, and push the result back onto the stack.

For example, let's evaluate ["2","1","+","3","*"]:
1. Push 2 onto the stack: stack = [2]
2. Push 1 onto the stack: stack = [2, 1]
3. Encounter "+": Pop 1 and 2, compute 2 + 1 = 3, push 3 onto the stack: stack = [3]
4. Push 3 onto the stack: stack = [3, 3]
5. Encounter "*": Pop 3 and 3, compute 3 * 3 = 9, push 9 onto the stack: stack = [9]
6. The final result is 9.

The function map solution (Solution 2) is also efficient and can be more elegant, but it's slightly more complex. The recursion solution (Solution 3) is not practical for this problem as it requires working backwards from the end of the tokens.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
