# Letter Combinations of a Phone Number

## Problem Statement

Given a string containing digits from `2-9` inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.

A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

```
2 -> "abc"
3 -> "def"
4 -> "ghi"
5 -> "jkl"
6 -> "mno"
7 -> "pqrs"
8 -> "tuv"
9 -> "wxyz"
```

**Example 1:**
```
Input: digits = "23"
Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
```

**Example 2:**
```
Input: digits = ""
Output: []
```

**Example 3:**
```
Input: digits = "2"
Output: ["a","b","c"]
```

**Constraints:**
- `0 <= digits.length <= 4`
- `digits[i]` is a digit in the range `['2', '9']`.

## Concept Overview

This problem tests your understanding of backtracking and string manipulation. The key insight is to use backtracking to generate all possible combinations of letters by trying each letter for each digit.

## Solutions

### 1. Best Optimized Solution - Backtracking

Use backtracking to generate all possible combinations of letters.

```python
def letterCombinations(digits):
    if not digits:
        return []
    
    # Define the mapping of digits to letters
    phone_map = {
        '2': 'abc',
        '3': 'def',
        '4': 'ghi',
        '5': 'jkl',
        '6': 'mno',
        '7': 'pqrs',
        '8': 'tuv',
        '9': 'wxyz'
    }
    
    result = []
    
    def backtrack(index, path):
        # If we've processed all digits, we've found a valid combination
        if index == len(digits):
            result.append(''.join(path))
            return
        
        # Try each letter for the current digit
        for letter in phone_map[digits[index]]:
            # Include the current letter
            path.append(letter)
            
            # Recursively generate combinations with the current letter included
            backtrack(index + 1, path)
            
            # Exclude the current letter (backtrack)
            path.pop()
    
    backtrack(0, [])
    return result
```

**Time Complexity:** O(4^n * n) where n is the number of digits. In the worst case, each digit maps to 4 letters (e.g., '7' and '9'), and it takes O(n) time to copy each combination.
**Space Complexity:** O(n) for the recursion stack and to store each combination.

### 2. Alternative Solution - Iterative

Use an iterative approach to generate all possible combinations of letters.

```python
def letterCombinations(digits):
    if not digits:
        return []
    
    # Define the mapping of digits to letters
    phone_map = {
        '2': 'abc',
        '3': 'def',
        '4': 'ghi',
        '5': 'jkl',
        '6': 'mno',
        '7': 'pqrs',
        '8': 'tuv',
        '9': 'wxyz'
    }
    
    # Start with an empty combination
    result = ['']
    
    for digit in digits:
        # For each existing combination, create new combinations by adding each letter
        new_result = []
        for combo in result:
            for letter in phone_map[digit]:
                new_result.append(combo + letter)
        result = new_result
    
    return result
```

**Time Complexity:** O(4^n * n) where n is the number of digits. In the worst case, each digit maps to 4 letters (e.g., '7' and '9'), and it takes O(n) time to copy each combination.
**Space Complexity:** O(4^n * n) to store all combinations.

### 3. Alternative Solution - BFS

Use breadth-first search to generate all possible combinations of letters.

```python
from collections import deque

def letterCombinations(digits):
    if not digits:
        return []
    
    # Define the mapping of digits to letters
    phone_map = {
        '2': 'abc',
        '3': 'def',
        '4': 'ghi',
        '5': 'jkl',
        '6': 'mno',
        '7': 'pqrs',
        '8': 'tuv',
        '9': 'wxyz'
    }
    
    # Use a queue for BFS
    queue = deque([''])
    
    for digit in digits:
        size = len(queue)
        
        # Process all combinations at the current level
        for _ in range(size):
            combo = queue.popleft()
            
            # Add each letter for the current digit to the combination
            for letter in phone_map[digit]:
                queue.append(combo + letter)
    
    return list(queue)
```

**Time Complexity:** O(4^n * n) where n is the number of digits. In the worst case, each digit maps to 4 letters (e.g., '7' and '9'), and it takes O(n) time to copy each combination.
**Space Complexity:** O(4^n * n) to store all combinations.

## Solution Choice and Explanation

The backtracking solution (Solution 1) is the best approach for this problem because:

1. **Clarity**: It clearly expresses the recursive nature of the problem and is easy to understand.

2. **Space Efficiency**: It uses less space than the iterative and BFS solutions because it only keeps track of the current combination during the recursion.

3. **Flexibility**: It can be easily extended to handle more complex constraints or variations of the problem.

The key insight of this approach is to use backtracking to generate all possible combinations of letters by trying each letter for each digit. We use a recursive function `backtrack(index, path)` that:
1. Checks if we've processed all digits, in which case we've found a valid combination.
2. Tries each letter for the current digit.
3. Recursively generates combinations with the current letter included.
4. Removes the current letter from the path (backtracking) to try other combinations.

For example, let's trace through the algorithm for digits = "23":
1. Start with index = 0, path = []
2. For digit '2', try each letter:
   - Include 'a': path = ['a']
     - Recursively backtrack with index = 1, path = ['a']
       - For digit '3', try each letter:
         - Include 'd': path = ['a', 'd']
           - index == len(digits), so we've found a valid combination
           - Add "ad" to result: result = ["ad"]
         - Exclude 'd', backtrack: path = ['a']
         - Include 'e': path = ['a', 'e']
           - index == len(digits), so we've found a valid combination
           - Add "ae" to result: result = ["ad", "ae"]
         - Exclude 'e', backtrack: path = ['a']
         - Include 'f': path = ['a', 'f']
           - index == len(digits), so we've found a valid combination
           - Add "af" to result: result = ["ad", "ae", "af"]
         - Exclude 'f', backtrack: path = ['a']
       - No more letters to try for digit '3', backtrack
     - Exclude 'a', backtrack: path = []
   - Include 'b': path = ['b']
     - Recursively backtrack with index = 1, path = ['b']
       - For digit '3', try each letter:
         - Include 'd': path = ['b', 'd']
           - index == len(digits), so we've found a valid combination
           - Add "bd" to result: result = ["ad", "ae", "af", "bd"]
         - Exclude 'd', backtrack: path = ['b']
         - Include 'e': path = ['b', 'e']
           - index == len(digits), so we've found a valid combination
           - Add "be" to result: result = ["ad", "ae", "af", "bd", "be"]
         - Exclude 'e', backtrack: path = ['b']
         - Include 'f': path = ['b', 'f']
           - index == len(digits), so we've found a valid combination
           - Add "bf" to result: result = ["ad", "ae", "af", "bd", "be", "bf"]
         - Exclude 'f', backtrack: path = ['b']
       - No more letters to try for digit '3', backtrack
     - Exclude 'b', backtrack: path = []
   - Include 'c': path = ['c']
     - Recursively backtrack with index = 1, path = ['c']
       - For digit '3', try each letter:
         - Include 'd': path = ['c', 'd']
           - index == len(digits), so we've found a valid combination
           - Add "cd" to result: result = ["ad", "ae", "af", "bd", "be", "bf", "cd"]
         - Exclude 'd', backtrack: path = ['c']
         - Include 'e': path = ['c', 'e']
           - index == len(digits), so we've found a valid combination
           - Add "ce" to result: result = ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce"]
         - Exclude 'e', backtrack: path = ['c']
         - Include 'f': path = ['c', 'f']
           - index == len(digits), so we've found a valid combination
           - Add "cf" to result: result = ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
         - Exclude 'f', backtrack: path = ['c']
       - No more letters to try for digit '3', backtrack
     - Exclude 'c', backtrack: path = []
   - No more letters to try for digit '2', backtrack
3. Final result: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]

The iterative solution (Solution 2) and the BFS solution (Solution 3) are also efficient but use more space.

In an interview, I would first mention the backtracking solution as the most intuitive approach for this problem, and then mention the iterative and BFS solutions as alternatives if asked for different approaches.
