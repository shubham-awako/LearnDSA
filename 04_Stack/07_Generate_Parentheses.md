# Generate Parentheses

## Problem Statement

Given `n` pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

**Example 1:**
```
Input: n = 3
Output: ["((()))","(()())","(())()","()(())","()()()"]
```

**Example 2:**
```
Input: n = 1
Output: ["()"]
```

**Constraints:**
- `1 <= n <= 8`

## Concept Overview

This problem asks us to generate all valid combinations of parentheses. The key insight is to use backtracking to build the combinations, ensuring that the parentheses are well-formed at each step.

## Solutions

### 1. Brute Force Approach - Generate All Combinations

Generate all possible combinations of parentheses and filter out the invalid ones.

```python
def generateParenthesis(n):
    def is_valid(s):
        count = 0
        for char in s:
            if char == '(':
                count += 1
            else:
                count -= 1
            if count < 0:
                return False
        return count == 0
    
    def generate(current, n):
        if len(current) == 2 * n:
            if is_valid(current):
                result.append(current)
            return
        
        generate(current + '(', n)
        generate(current + ')', n)
    
    result = []
    generate('', n)
    return result
```

**Time Complexity:** O(2^(2n) * n) - We generate 2^(2n) combinations and check each one in O(n) time.
**Space Complexity:** O(2^(2n) * n) - For storing the valid combinations.

### 2. Best Optimized Solution - Backtracking

Use backtracking to generate only valid combinations by keeping track of the number of opening and closing parentheses.

```python
def generateParenthesis(n):
    result = []
    
    def backtrack(s, open_count, close_count):
        if len(s) == 2 * n:
            result.append(s)
            return
        
        if open_count < n:
            backtrack(s + '(', open_count + 1, close_count)
        
        if close_count < open_count:
            backtrack(s + ')', open_count, close_count + 1)
    
    backtrack('', 0, 0)
    return result
```

**Time Complexity:** O(4^n / sqrt(n)) - The number of valid combinations is the nth Catalan number.
**Space Complexity:** O(4^n / sqrt(n)) - For storing the valid combinations.

### 3. Alternative Solution - Dynamic Programming

Use dynamic programming to build the combinations iteratively.

```python
def generateParenthesis(n):
    if n == 0:
        return [""]
    
    result = []
    for i in range(n):
        for left in generateParenthesis(i):
            for right in generateParenthesis(n - 1 - i):
                result.append('(' + left + ')' + right)
    
    return result
```

**Time Complexity:** O(4^n / sqrt(n)) - The number of valid combinations is the nth Catalan number.
**Space Complexity:** O(4^n / sqrt(n)) - For storing the valid combinations.

## Solution Choice and Explanation

The backtracking solution (Solution 2) is the best approach for this problem because:

1. **Efficiency**: It generates only valid combinations, avoiding the need to check validity after generation.

2. **Optimal Time Complexity**: It achieves O(4^n / sqrt(n)) time complexity, which is optimal for this problem.

3. **Intuitive Approach**: It directly models the problem as a decision tree, where at each step we decide whether to add an opening or closing parenthesis.

The key insight of this approach is to use backtracking to generate only valid combinations by maintaining two counters:
- `open_count`: The number of opening parentheses used so far.
- `close_count`: The number of closing parentheses used so far.

We can add an opening parenthesis as long as we haven't used all n opening parentheses. We can add a closing parenthesis as long as the number of closing parentheses is less than the number of opening parentheses.

For example, with n = 2:
1. Start with an empty string: ""
2. Add an opening parenthesis: "("
   a. Add another opening parenthesis: "(("
      i. Add a closing parenthesis: "(()"
         - Add another closing parenthesis: "(())"
   b. Add a closing parenthesis: "()"
      i. Add another opening parenthesis: "()("
         - Add another closing parenthesis: "()()"

This gives us the valid combinations: ["(())", "()()"].

The brute force approach (Solution 1) is inefficient as it generates many invalid combinations. The dynamic programming approach (Solution 3) is also efficient but more complex to understand.

In an interview, I would first mention the backtracking approach as the most intuitive and efficient solution for this problem.
