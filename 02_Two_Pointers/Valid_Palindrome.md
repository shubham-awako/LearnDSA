# Valid Palindrome

## Problem Statement

A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string `s`, return `true` if it is a palindrome, or `false` otherwise.

**Example 1:**
```
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.
```

**Example 2:**
```
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.
```

**Example 3:**
```
Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
```

**Constraints:**
- `1 <= s.length <= 2 * 10^5`
- `s` consists only of printable ASCII characters.

## Concept Overview

This problem tests your ability to check if a string is a palindrome after preprocessing. The key insight is to use two pointers to compare characters from both ends of the string while ignoring non-alphanumeric characters.

## Solutions

### 1. Brute Force Approach - Create a New String

Preprocess the string by removing non-alphanumeric characters and converting to lowercase, then check if it equals its reverse.

```python
def isPalindrome(s):
    # Preprocess the string
    processed = ''.join(char.lower() for char in s if char.isalnum())
    
    # Check if the processed string equals its reverse
    return processed == processed[::-1]
```

**Time Complexity:** O(n) - We iterate through the string once for preprocessing and once for comparison.
**Space Complexity:** O(n) - We create a new string of potentially the same length.

### 2. Best Optimized Solution - Two Pointers

Use two pointers starting from opposite ends of the string and compare alphanumeric characters while moving toward the center.

```python
def isPalindrome(s):
    left, right = 0, len(s) - 1
    
    while left < right:
        # Skip non-alphanumeric characters from the left
        while left < right and not s[left].isalnum():
            left += 1
        
        # Skip non-alphanumeric characters from the right
        while left < right and not s[right].isalnum():
            right -= 1
        
        # Compare characters (case-insensitive)
        if s[left].lower() != s[right].lower():
            return False
        
        # Move pointers toward the center
        left += 1
        right -= 1
    
    return True
```

**Time Complexity:** O(n) - We process each character at most once.
**Space Complexity:** O(1) - We use only two pointers regardless of input size.

### 3. Alternative Solution - Regular Expression

Use regular expressions to remove non-alphanumeric characters, then check if the string equals its reverse.

```python
import re

def isPalindrome(s):
    # Remove non-alphanumeric characters and convert to lowercase
    processed = re.sub(r'[^a-zA-Z0-9]', '', s).lower()
    
    # Check if the processed string equals its reverse
    return processed == processed[::-1]
```

**Time Complexity:** O(n) - We process the string once for regex substitution and once for comparison.
**Space Complexity:** O(n) - We create a new string of potentially the same length.

## Solution Choice and Explanation

The two-pointer solution (Solution 2) is the best approach for this problem because:

1. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the other approaches.

2. **Early Termination**: It can return false as soon as a mismatch is found, without processing the entire string.

3. **In-Place Comparison**: It directly compares characters from the original string without creating a new string.

The key insight of this approach is to use two pointers starting from opposite ends of the string. We skip non-alphanumeric characters and compare the remaining characters in a case-insensitive manner. If all comparisons match, the string is a palindrome.

The brute force approach (Solution 1) is simple but uses O(n) extra space for the processed string. The regular expression approach (Solution 3) is concise but also uses O(n) extra space and may be less efficient due to the regex processing.

In an interview, I would first mention the two-pointer approach as the optimal solution that minimizes space usage and allows for early termination.
