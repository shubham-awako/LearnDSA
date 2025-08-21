# Reverse String

## Problem Statement

Write a function that reverses a string. The input string is given as an array of characters `s`.

You must do this by modifying the input array in-place with O(1) extra memory.

**Example 1:**
```
Input: s = ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
```

**Example 2:**
```
Input: s = ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]
```

**Constraints:**
- `1 <= s.length <= 10^5`
- `s[i]` is a printable ASCII character.

## Concept Overview

This problem tests your ability to manipulate an array in-place using the two-pointer technique. The key insight is to swap characters from both ends of the array while moving the pointers toward each other.

## Solutions

### 1. Brute Force Approach - Using Extra Space

Create a new array with the characters in reverse order, then copy back to the original array.

```python
def reverseString(s):
    reversed_s = s[::-1]  # Create a reversed copy
    for i in range(len(s)):
        s[i] = reversed_s[i]  # Copy back to original array
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We create a new array of the same size.

**Note:** This approach doesn't satisfy the O(1) extra memory requirement.

### 2. Best Optimized Solution - Two Pointers

Use two pointers starting from opposite ends of the array and swap characters while moving toward the center.

```python
def reverseString(s):
    left, right = 0, len(s) - 1
    
    while left < right:
        # Swap characters at left and right pointers
        s[left], s[right] = s[right], s[left]
        
        # Move pointers toward the center
        left += 1
        right -= 1
```

**Time Complexity:** O(n) - We process each character once.
**Space Complexity:** O(1) - We use only two pointers regardless of input size.

### 3. Alternative Solution - Recursive Approach

Recursively swap characters from both ends of the array.

```python
def reverseString(s):
    def reverse_helper(left, right):
        if left < right:
            # Swap characters at left and right pointers
            s[left], s[right] = s[right], s[left]
            
            # Recursive call with updated pointers
            reverse_helper(left + 1, right - 1)
    
    reverse_helper(0, len(s) - 1)
```

**Time Complexity:** O(n) - We process each character once.
**Space Complexity:** O(n) - The recursion stack can go up to n/2 levels deep.

**Note:** This approach doesn't satisfy the O(1) extra memory requirement due to the recursion stack.

## Solution Choice and Explanation

The two-pointer solution (Solution 2) is the best approach for this problem because:

1. **In-Place Modification**: It directly modifies the input array without using extra space.

2. **Optimal Space Complexity**: It uses O(1) extra memory, as required by the problem.

3. **Optimal Time Complexity**: It achieves O(n) time complexity by processing each character once.

4. **Simplicity**: It's straightforward to implement and understand.

The key insight of this approach is to use two pointers starting from opposite ends of the array. We swap the characters at these positions and move the pointers toward each other until they meet in the middle. This effectively reverses the string in-place.

The brute force approach (Solution 1) is simple but uses O(n) extra space, which doesn't meet the problem's space requirement. The recursive approach (Solution 3) is elegant but uses O(n) space for the recursion stack, which also doesn't meet the space requirement.

In an interview, I would first mention the two-pointer approach as the optimal solution that meets all requirements, and implement it directly.
