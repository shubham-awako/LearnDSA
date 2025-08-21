# Valid Palindrome II

## Problem Statement

Given a string `s`, return `true` if the string can be palindrome after deleting at most one character from it.

**Example 1:**
```
Input: s = "aba"
Output: true
```

**Example 2:**
```
Input: s = "abca"
Output: true
Explanation: You could delete the character 'c'.
```

**Example 3:**
```
Input: s = "abc"
Output: false
```

**Constraints:**
- `1 <= s.length <= 10^5`
- `s` consists of lowercase English letters.

## Concept Overview

This problem extends the concept of palindrome checking by allowing the deletion of at most one character. The key insight is to use two pointers and, when a mismatch is found, check if skipping either the left or right character results in a palindrome.

## Solutions

### 1. Brute Force Approach - Check All Possible Deletions

Try deleting each character and check if the resulting string is a palindrome.

```python
def validPalindrome(s):
    def is_palindrome(string):
        return string == string[::-1]
    
    # Check if the original string is a palindrome
    if is_palindrome(s):
        return True
    
    # Try deleting each character
    for i in range(len(s)):
        deleted = s[:i] + s[i+1:]
        if is_palindrome(deleted):
            return True
    
    return False
```

**Time Complexity:** O(n²) - For each of the n characters, we check if a string of length n-1 is a palindrome, which takes O(n) time.
**Space Complexity:** O(n) - We create new strings of length n-1.

### 2. Best Optimized Solution - Two Pointers with One Skip

Use two pointers and, when a mismatch is found, check if skipping either the left or right character results in a palindrome.

```python
def validPalindrome(s):
    def is_palindrome(left, right):
        while left < right:
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        return True
    
    left, right = 0, len(s) - 1
    
    while left < right:
        if s[left] != s[right]:
            # Try skipping the left character or the right character
            return is_palindrome(left + 1, right) or is_palindrome(left, right - 1)
        left += 1
        right -= 1
    
    return True
```

**Time Complexity:** O(n) - We process each character at most three times (once in the main loop and at most twice in the is_palindrome function).
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 3. Alternative Solution - Recursive Approach

Use recursion to check if the string is a palindrome with at most one deletion.

```python
def validPalindrome(s):
    def is_palindrome(left, right, deleted):
        while left < right:
            if s[left] != s[right]:
                if deleted:
                    return False
                # Try skipping the left character or the right character
                return is_palindrome(left + 1, right, True) or is_palindrome(left, right - 1, True)
            left += 1
            right -= 1
        return True
    
    return is_palindrome(0, len(s) - 1, False)
```

**Time Complexity:** O(n) - We process each character at most three times.
**Space Complexity:** O(n) - The recursion stack can go up to n levels deep in the worst case.

## Solution Choice and Explanation

The two pointers with one skip solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity by processing each character at most three times.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the recursive approach.

3. **Early Termination**: It can return false as soon as it determines that the string cannot be a palindrome with at most one deletion.

The key insight of this approach is to use two pointers starting from opposite ends of the string. When a mismatch is found, we have two options: skip the character at the left pointer or skip the character at the right pointer. We check if either option results in a palindrome.

For example, in the string "abca", when we compare 'b' and 'c', they don't match. We then check if skipping 'b' ("aca") or skipping 'c' ("aba") results in a palindrome. Since "aba" is a palindrome, we return true.

The brute force approach (Solution 1) is inefficient with O(n²) time complexity. The recursive approach (Solution 3) has the same time complexity as Solution 2 but uses O(n) space for the recursion stack.

In an interview, I would first mention the two pointers approach as the optimal solution that minimizes both time and space complexity.
