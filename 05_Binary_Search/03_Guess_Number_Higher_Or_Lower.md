# Guess Number Higher Or Lower

## Problem Statement

We are playing the Guess Game. The game is as follows:

I pick a number from `1` to `n`. You have to guess which number I picked.

Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.

You call a pre-defined API `int guess(int num)`, which returns three possible results:
- `-1`: Your guess is higher than the number I picked (i.e. `num > pick`).
- `1`: Your guess is lower than the number I picked (i.e. `num < pick`).
- `0`: your guess is equal to the number I picked (i.e. `num == pick`).

Return the number that I picked.

**Example 1:**
```
Input: n = 10, pick = 6
Output: 6
```

**Example 2:**
```
Input: n = 1, pick = 1
Output: 1
```

**Example 3:**
```
Input: n = 2, pick = 1
Output: 1
```

**Constraints:**
- `1 <= n <= 2^31 - 1`
- `1 <= pick <= n`

## Concept Overview

This problem is a classic application of the binary search algorithm. The key insight is to use binary search to efficiently narrow down the range of possible numbers based on the feedback from the `guess` API.

## Solutions

### 1. Iterative Binary Search

Use binary search to efficiently find the picked number.

```python
def guessNumber(n):
    left, right = 1, n
    
    while left <= right:
        mid = left + (right - left) // 2
        result = guess(mid)
        
        if result == 0:
            return mid  # Correct guess
        elif result == -1:
            right = mid - 1  # The picked number is lower
        else:  # result == 1
            left = mid + 1  # The picked number is higher
    
    return -1  # This should never happen given the constraints
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Recursive Binary Search

Use recursion to find the picked number.

```python
def guessNumber(n):
    def binary_search(left, right):
        if left > right:
            return -1  # This should never happen given the constraints
        
        mid = left + (right - left) // 2
        result = guess(mid)
        
        if result == 0:
            return mid  # Correct guess
        elif result == -1:
            return binary_search(left, mid - 1)  # The picked number is lower
        else:  # result == 1
            return binary_search(mid + 1, right)  # The picked number is higher
    
    return binary_search(1, n)
```

**Time Complexity:** O(log n) - The search space is halved in each step.
**Space Complexity:** O(log n) - The recursion stack can go up to log n levels deep.

### 3. Alternative Solution - Ternary Search

Use ternary search to find the picked number by dividing the search space into three parts.

```python
def guessNumber(n):
    left, right = 1, n
    
    while left <= right:
        # Divide the search space into three parts
        mid1 = left + (right - left) // 3
        mid2 = right - (right - left) // 3
        
        result1 = guess(mid1)
        result2 = guess(mid2)
        
        if result1 == 0:
            return mid1  # Correct guess
        elif result2 == 0:
            return mid2  # Correct guess
        elif result1 == -1:
            right = mid1 - 1  # The picked number is lower than mid1
        elif result2 == 1:
            left = mid2 + 1  # The picked number is higher than mid2
        else:
            left = mid1 + 1
            right = mid2 - 1  # The picked number is between mid1 and mid2
    
    return -1  # This should never happen given the constraints
```

**Time Complexity:** O(log n) - The search space is reduced by a factor of 3 in each step.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

**Note:** While ternary search reduces the number of comparisons in theory, it may not be more efficient in practice due to the overhead of making two API calls in each iteration.

## Solution Choice and Explanation

The iterative binary search solution (Solution 1) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity, which is efficient for large values of n.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(log n) space used by the recursive approach.

3. **Simplicity**: It's straightforward to implement and understand.

4. **Efficiency**: It makes only one API call per iteration, which is more efficient than ternary search for this problem.

The key insight of this solution is to use binary search to efficiently narrow down the range of possible numbers based on the feedback from the `guess` API:
- If the guess is correct (result = 0), we return the number.
- If the guess is too high (result = -1), we search in the lower half.
- If the guess is too low (result = 1), we search in the upper half.

For example, let's find the picked number when n = 10 and pick = 6:
1. left = 1, right = 10, mid = 5, guess(5) = 1 (too low)
2. left = 6, right = 10, mid = 8, guess(8) = -1 (too high)
3. left = 6, right = 7, mid = 6, guess(6) = 0 (correct)
4. Return 6

The recursive binary search solution (Solution 2) is also efficient but uses O(log n) extra space for the recursion stack. The ternary search solution (Solution 3) makes more API calls per iteration, which may not be efficient in practice.

In an interview, I would first mention the iterative binary search approach as the most efficient solution for this problem.
