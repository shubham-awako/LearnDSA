# Daily Temperatures

## Problem Statement

Given an array of integers `temperatures` represents the daily temperatures, return an array `answer` such that `answer[i]` is the number of days you have to wait after the `i`th day to get a warmer temperature. If there is no future day for which this is possible, keep `answer[i] == 0` instead.

**Example 1:**
```
Input: temperatures = [73,74,75,71,69,72,76,73]
Output: [1,1,4,2,1,1,0,0]
```

**Example 2:**
```
Input: temperatures = [30,40,50,60]
Output: [1,1,1,0]
```

**Example 3:**
```
Input: temperatures = [30,60,90]
Output: [1,1,0]
```

**Constraints:**
- `1 <= temperatures.length <= 10^5`
- `30 <= temperatures[i] <= 100`

## Concept Overview

This problem tests your understanding of stack operations for finding the next greater element. The key insight is to use a stack to keep track of indices of temperatures and find the next warmer day.

## Solutions

### 1. Brute Force Approach

For each day, scan forward to find the next warmer day.

```python
def dailyTemperatures(temperatures):
    n = len(temperatures)
    answer = [0] * n
    
    for i in range(n):
        for j in range(i + 1, n):
            if temperatures[j] > temperatures[i]:
                answer[i] = j - i
                break
    
    return answer
```

**Time Complexity:** O(n²) - For each day, we scan forward to find the next warmer day.
**Space Complexity:** O(1) - Excluding the output array.

### 2. Best Optimized Solution - Stack

Use a stack to keep track of indices of temperatures and find the next warmer day.

```python
def dailyTemperatures(temperatures):
    n = len(temperatures)
    answer = [0] * n
    stack = []  # Stack to store indices of temperatures
    
    for i in range(n):
        # Pop indices from the stack if the current temperature is warmer
        while stack and temperatures[i] > temperatures[stack[-1]]:
            prev_idx = stack.pop()
            answer[prev_idx] = i - prev_idx
        
        # Push the current index onto the stack
        stack.append(i)
    
    return answer
```

**Time Complexity:** O(n) - We process each temperature at most twice (once when adding to the stack and once when popping from the stack).
**Space Complexity:** O(n) - In the worst case, the stack can have all indices.

### 3. Alternative Solution - Backwards Iteration

Iterate backwards and use the answer array to skip days.

```python
def dailyTemperatures(temperatures):
    n = len(temperatures)
    answer = [0] * n
    
    for i in range(n - 2, -1, -1):
        next_idx = i + 1
        
        # Keep moving forward until we find a warmer day or reach the end
        while next_idx < n and temperatures[next_idx] <= temperatures[i]:
            # If the next day is not warmer, skip to the day after that
            # If answer[next_idx] is 0, there's no warmer day after next_idx
            if answer[next_idx] == 0:
                next_idx = n  # No warmer day found
            else:
                next_idx += answer[next_idx]
        
        # If we found a warmer day, calculate the number of days to wait
        if next_idx < n:
            answer[i] = next_idx - i
    
    return answer
```

**Time Complexity:** O(n) - In the worst case, we might need to check all future days for each day, but each day is checked at most once.
**Space Complexity:** O(1) - Excluding the output array.

## Solution Choice and Explanation

The stack solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Natural Fit**: The problem is naturally modeled as a stack, where we keep track of indices of temperatures and find the next warmer day.

The key insight of this approach is to use a stack to keep track of indices of temperatures. We iterate through the temperatures from left to right:
- For each temperature, we check if it's warmer than the temperatures at the indices stored in the stack.
- If it is, we pop those indices from the stack and update their answer with the number of days to wait.
- Then, we push the current index onto the stack.

For example, let's simulate [73,74,75,71,69,72,76,73]:
1. Push 0 onto the stack: stack = [0]
2. For temperature 74 at index 1:
   - 74 > 73, so pop 0 from the stack and set answer[0] = 1 - 0 = 1
   - Push 1 onto the stack: stack = [1]
3. For temperature 75 at index 2:
   - 75 > 74, so pop 1 from the stack and set answer[1] = 2 - 1 = 1
   - Push 2 onto the stack: stack = [2]
4. For temperature 71 at index 3:
   - 71 < 75, so push 3 onto the stack: stack = [2, 3]
5. For temperature 69 at index 4:
   - 69 < 71, so push 4 onto the stack: stack = [2, 3, 4]
6. For temperature 72 at index 5:
   - 72 > 69, so pop 4 from the stack and set answer[4] = 5 - 4 = 1
   - 72 > 71, so pop 3 from the stack and set answer[3] = 5 - 3 = 2
   - 72 < 75, so push 5 onto the stack: stack = [2, 5]
7. For temperature 76 at index 6:
   - 76 > 72, so pop 5 from the stack and set answer[5] = 6 - 5 = 1
   - 76 > 75, so pop 2 from the stack and set answer[2] = 6 - 2 = 4
   - Push 6 onto the stack: stack = [6]
8. For temperature 73 at index 7:
   - 73 < 76, so push 7 onto the stack: stack = [6, 7]
9. The final answer is [1,1,4,2,1,1,0,0].

The backwards iteration approach (Solution 3) is also efficient but more complex to understand. The brute force approach (Solution 1) is inefficient with O(n²) time complexity.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
