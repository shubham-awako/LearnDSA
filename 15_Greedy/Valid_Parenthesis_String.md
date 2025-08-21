# Valid Parenthesis String

## Problem Statement

Given a string `s` containing only three types of characters: '(', ')' and '*', return `true` if `s` is valid.

The following rules define a valid string:
1. Any left parenthesis '(' must have a corresponding right parenthesis ')'.
2. Any right parenthesis ')' must have a corresponding left parenthesis '('.
3. Left parenthesis '(' must go before the corresponding right parenthesis ')'.
4. '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string "".

**Example 1:**
```
Input: s = "()"
Output: true
```

**Example 2:**
```
Input: s = "(*)"
Output: true
```

**Example 3:**
```
Input: s = "(*))"
Output: true
```

**Constraints:**
- `1 <= s.length <= 100`
- `s[i]` is '(', ')' or '*'.

## Concept Overview

This problem can be solved using a greedy approach. The key insight is to keep track of the minimum and maximum number of open parentheses as we iterate through the string.

## Solutions

### 1. Best Optimized Solution - Greedy Approach

Use a greedy approach to determine if the string is valid.

```python
def checkValidString(s):
    # Initialize the minimum and maximum number of open parentheses
    min_open = 0
    max_open = 0
    
    # Iterate through the string
    for char in s:
        if char == '(':
            min_open += 1
            max_open += 1
        elif char == ')':
            min_open = max(0, min_open - 1)
            max_open -= 1
        else:  # char == '*'
            min_open = max(0, min_open - 1)
            max_open += 1
        
        # If the maximum number of open parentheses becomes negative,
        # it means there are more closing parentheses than opening ones
        if max_open < 0:
            return False
    
    # The string is valid if the minimum number of open parentheses is 0
    return min_open == 0
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Two-Pass Approach

Use a two-pass approach to determine if the string is valid.

```python
def checkValidString(s):
    # First pass: Check if there are enough opening parentheses
    balance = 0
    for char in s:
        if char == '(' or char == '*':
            balance += 1
        else:  # char == ')'
            balance -= 1
        
        if balance < 0:
            return False
    
    # If there are no opening parentheses left, the string is valid
    if balance == 0:
        return True
    
    # Second pass: Check if there are enough closing parentheses
    balance = 0
    for char in s[::-1]:
        if char == ')' or char == '*':
            balance += 1
        else:  # char == '('
            balance -= 1
        
        if balance < 0:
            return False
    
    return True
```

**Time Complexity:** O(n) - We iterate through the string twice.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 3. Alternative Solution - Stack-based Approach

Use a stack-based approach to determine if the string is valid.

```python
def checkValidString(s):
    # Initialize stacks to keep track of the indices of opening parentheses and asterisks
    open_stack = []
    star_stack = []
    
    # Iterate through the string
    for i, char in enumerate(s):
        if char == '(':
            open_stack.append(i)
        elif char == '*':
            star_stack.append(i)
        else:  # char == ')'
            if open_stack:
                open_stack.pop()
            elif star_stack:
                star_stack.pop()
            else:
                return False
    
    # Match remaining opening parentheses with asterisks
    while open_stack and star_stack:
        if open_stack[-1] > star_stack[-1]:
            return False
        open_stack.pop()
        star_stack.pop()
    
    # The string is valid if there are no unmatched opening parentheses
    return len(open_stack) == 0
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(n) - In the worst case, we need to store all characters in the stacks.

## Solution Choice and Explanation

The Greedy Approach solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of determining if a string with wildcards is valid.

The key insight of this approach is to keep track of the minimum and maximum number of open parentheses as we iterate through the string. The minimum number of open parentheses assumes that all asterisks are treated as closing parentheses (or empty strings if that would make the minimum negative), and the maximum number of open parentheses assumes that all asterisks are treated as opening parentheses. If at any point the maximum number of open parentheses becomes negative, it means there are more closing parentheses than opening ones, so the string is invalid. At the end, the string is valid if the minimum number of open parentheses is 0, which means all opening parentheses can be matched with closing ones.

For example, let's trace through the algorithm for s = "(*)":

1. Initialize min_open = 0, max_open = 0

2. Iterate through the string:
   - char = '(':
     - min_open = 1, max_open = 1
   - char = '*':
     - min_open = max(0, 1 - 1) = 0, max_open = 1 + 1 = 2
   - char = ')':
     - min_open = max(0, 0 - 1) = 0, max_open = 2 - 1 = 1
     - max_open >= 0, so continue

3. Check if min_open == 0:
   - min_open = 0 == 0, so return True

For s = "(*))":

1. Initialize min_open = 0, max_open = 0

2. Iterate through the string:
   - char = '(':
     - min_open = 1, max_open = 1
   - char = '*':
     - min_open = max(0, 1 - 1) = 0, max_open = 1 + 1 = 2
   - char = ')':
     - min_open = max(0, 0 - 1) = 0, max_open = 2 - 1 = 1
     - max_open >= 0, so continue
   - char = ')':
     - min_open = max(0, 0 - 1) = 0, max_open = 1 - 1 = 0
     - max_open >= 0, so continue

3. Check if min_open == 0:
   - min_open = 0 == 0, so return True

For s = "())":

1. Initialize min_open = 0, max_open = 0

2. Iterate through the string:
   - char = '(':
     - min_open = 1, max_open = 1
   - char = ')':
     - min_open = max(0, 1 - 1) = 0, max_open = 1 - 1 = 0
     - max_open >= 0, so continue
   - char = ')':
     - min_open = max(0, 0 - 1) = 0, max_open = 0 - 1 = -1
     - max_open < 0, so return False

The Two-Pass Approach solution (Solution 2) is also efficient but may be less intuitive. The Stack-based Approach solution (Solution 3) is less efficient in terms of space but may be more intuitive for some people.

In an interview, I would first mention the Greedy Approach solution as the most efficient approach for this problem, and then discuss the Two-Pass Approach and Stack-based Approach solutions as alternatives if asked for different approaches.
