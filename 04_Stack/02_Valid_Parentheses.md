# Valid Parentheses

## Problem Statement

Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.
3. Every close bracket has a corresponding open bracket of the same type.

**Example 1:**
```
Input: s = "()"
Output: true
```

**Example 2:**
```
Input: s = "()[]{}"
Output: true
```

**Example 3:**
```
Input: s = "(]"
Output: false
```

**Constraints:**
- `1 <= s.length <= 10^4`
- `s` consists of parentheses only `'()[]{}'`.

## Concept Overview

This problem tests your understanding of stack operations for validating balanced parentheses. The key insight is to use a stack to keep track of opening brackets and check if they match with the closing brackets.

## Solutions

### 1. Best Optimized Solution - Stack

Use a stack to keep track of opening brackets and check if they match with the closing brackets.

```python
def isValid(s):
    stack = []
    bracket_map = {')': '(', '}': '{', ']': '['}
    
    for char in s:
        if char in bracket_map:  # Closing bracket
            if not stack or stack.pop() != bracket_map[char]:
                return False
        else:  # Opening bracket
            stack.append(char)
    
    return not stack  # Stack should be empty for a valid string
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(n) - In the worst case, the stack can have all opening brackets.

### 2. Alternative Solution - Counter

Use a counter to keep track of the number of opening and closing brackets of each type.

```python
def isValid(s):
    count = {'(': 0, '{': 0, '[': 0}
    
    for char in s:
        if char == '(':
            count['('] += 1
        elif char == '{':
            count['{'] += 1
        elif char == '[':
            count['['] += 1
        elif char == ')':
            count['('] -= 1
            if count['('] < 0:
                return False
        elif char == '}':
            count['{'] -= 1
            if count['{'] < 0:
                return False
        elif char == ']':
            count['['] -= 1
            if count['['] < 0:
                return False
    
    return count['('] == 0 and count['{'] == 0 and count['['] == 0
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(1) - We use a fixed-size counter.

**Note:** This solution doesn't check for the correct order of brackets, only the count. For example, it would incorrectly return true for "([)]".

### 3. Alternative Solution - Recursion

Use recursion to check if the string is valid by removing matched pairs of brackets.

```python
def isValid(s):
    if not s:
        return True
    
    # Remove matched pairs of brackets
    s_new = s.replace("()", "").replace("{}", "").replace("[]", "")
    
    # If s_new is the same as s, no more matched pairs can be removed
    if s_new == s:
        return False
    
    # Recursively check the remaining string
    return isValid(s_new)
```

**Time Complexity:** O(n²) - In the worst case, we need to scan the string O(n) times, each time taking O(n) time.
**Space Complexity:** O(n) - The recursion stack can go up to O(n) levels deep.

## Solution Choice and Explanation

The stack solution (Solution 1) is the best approach for this problem because:

1. **Natural Fit**: The problem is naturally modeled as a stack, where opening brackets are pushed onto the stack and closing brackets are matched with the top of the stack.

2. **Correct Validation**: It checks both the count and the order of brackets, ensuring that the string is truly valid.

3. **Optimal Time and Space Complexity**: It achieves O(n) time complexity and O(n) space complexity, which is optimal for this problem.

The key insight of this approach is to use a stack to keep track of opening brackets. For each character in the string:
- If it's an opening bracket, push it onto the stack.
- If it's a closing bracket, check if the stack is empty or if the top of the stack matches the corresponding opening bracket. If not, the string is invalid.

Finally, we check if the stack is empty. If it's not, there are unmatched opening brackets, and the string is invalid.

The counter solution (Solution 2) is simpler but doesn't check for the correct order of brackets. The recursion solution (Solution 3) is more complex and less efficient.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
