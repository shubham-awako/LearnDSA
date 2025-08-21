# Decode String

## Problem Statement

Given an encoded string, return its decoded string.

The encoding rule is: `k[encoded_string]`, where the `encoded_string` inside the square brackets is being repeated exactly `k` times. Note that `k` is guaranteed to be a positive integer.

You may assume that the input string is always valid; there are no extra white spaces, square brackets are well-formed, etc. Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, `k`. For example, there will not be input like `3a` or `2[4]`.

The test cases are generated so that the length of the output will never exceed `10^5`.

**Example 1:**
```
Input: s = "3[a]2[bc]"
Output: "aaabcbc"
```

**Example 2:**
```
Input: s = "3[a2[c]]"
Output: "accaccacc"
```

**Example 3:**
```
Input: s = "2[abc]3[cd]ef"
Output: "abcabccdcdcdef"
```

**Constraints:**
- `1 <= s.length <= 30`
- `s` consists of lowercase English letters, digits, and square brackets `'[]'`.
- `s` is guaranteed to be a valid input.
- All the integers in `s` are in the range `[1, 300]`.

## Concept Overview

This problem tests your understanding of stack operations for parsing and decoding nested strings. The key insight is to use a stack to keep track of the current state and handle nested brackets.

## Solutions

### 1. Best Optimized Solution - Stack

Use a stack to keep track of the current state and handle nested brackets.

```python
def decodeString(s):
    stack = []
    current_num = 0
    current_str = ""
    
    for char in s:
        if char.isdigit():
            current_num = current_num * 10 + int(char)
        elif char == '[':
            # Push the current number and string onto the stack
            stack.append((current_str, current_num))
            current_str = ""
            current_num = 0
        elif char == ']':
            # Pop the previous state from the stack
            prev_str, num = stack.pop()
            # Decode the current string
            current_str = prev_str + current_str * num
        else:
            current_str += char
    
    return current_str
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(n) - For storing the stack.

### 2. Alternative Solution - Recursion

Use recursion to handle nested brackets.

```python
def decodeString(s):
    def decode(s, i):
        result = ""
        num = 0
        
        while i < len(s):
            char = s[i]
            
            if char.isdigit():
                num = num * 10 + int(char)
            elif char == '[':
                # Recursively decode the nested string
                nested_str, next_i = decode(s, i + 1)
                result += nested_str * num
                num = 0
                i = next_i
            elif char == ']':
                return result, i
            else:
                result += char
            
            i += 1
        
        return result, i
    
    return decode(s, 0)[0]
```

**Time Complexity:** O(n) - We process each character once.
**Space Complexity:** O(n) - The recursion stack can go up to O(n) levels deep.

### 3. Alternative Solution - Two Stacks

Use two separate stacks: one for numbers and one for strings.

```python
def decodeString(s):
    num_stack = []
    str_stack = []
    current_num = 0
    current_str = ""
    
    for char in s:
        if char.isdigit():
            current_num = current_num * 10 + int(char)
        elif char == '[':
            # Push the current number and string onto the stacks
            num_stack.append(current_num)
            str_stack.append(current_str)
            current_num = 0
            current_str = ""
        elif char == ']':
            # Pop the previous state from the stacks
            num = num_stack.pop()
            prev_str = str_stack.pop()
            # Decode the current string
            current_str = prev_str + current_str * num
        else:
            current_str += char
    
    return current_str
```

**Time Complexity:** O(n) - We iterate through the string once.
**Space Complexity:** O(n) - For storing the stacks.

## Solution Choice and Explanation

The stack solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's straightforward to implement and understand.

2. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

3. **Natural Fit**: The problem is naturally modeled as a stack, where we push the current state when we encounter an opening bracket and pop when we encounter a closing bracket.

The key insight of this approach is to use a stack to keep track of the current state (string and number) when we encounter nested brackets. For each character:
- If it's a digit, we update the current number.
- If it's an opening bracket, we push the current state onto the stack and reset the current state.
- If it's a closing bracket, we pop the previous state from the stack, decode the current string, and update the current string.
- Otherwise, we append the character to the current string.

For example, let's decode "3[a2[c]]":
1. current_num = 3, current_str = ""
2. Encounter '[': Push ("", 3) onto the stack. current_num = 0, current_str = ""
3. Append 'a': current_str = "a"
4. current_num = 2, current_str = "a"
5. Encounter '[': Push ("a", 2) onto the stack. current_num = 0, current_str = ""
6. Append 'c': current_str = "c"
7. Encounter ']': Pop ("a", 2) from the stack. current_str = "a" + "c" * 2 = "acc"
8. Encounter ']': Pop ("", 3) from the stack. current_str = "" + "acc" * 3 = "accaccacc"
9. Return "accaccacc"

The recursion solution (Solution 2) is also efficient but may be less intuitive for some. The two stacks solution (Solution 3) is essentially the same as the stack solution but uses two separate stacks.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
