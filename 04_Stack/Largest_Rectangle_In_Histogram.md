# Largest Rectangle In Histogram

## Problem Statement

Given an array of integers `heights` representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.

**Example 1:**
```
Input: heights = [2,1,5,6,2,3]
Output: 10
Explanation: The above is a histogram where width of each bar is 1.
The largest rectangle is shown in the red area, which has an area = 10 units.
```

**Example 2:**
```
Input: heights = [2,4]
Output: 4
```

**Constraints:**
- `1 <= heights.length <= 10^5`
- `0 <= heights[i] <= 10^4`

## Concept Overview

This problem tests your understanding of stack operations for finding the largest rectangle in a histogram. The key insight is to use a stack to keep track of the indices of bars in ascending order of height.

## Solutions

### 1. Brute Force Approach

For each bar, extend to the left and right to find the largest rectangle that includes that bar.

```python
def largestRectangleArea(heights):
    n = len(heights)
    max_area = 0
    
    for i in range(n):
        # Find the left boundary
        left = i
        while left > 0 and heights[left - 1] >= heights[i]:
            left -= 1
        
        # Find the right boundary
        right = i
        while right < n - 1 and heights[right + 1] >= heights[i]:
            right += 1
        
        # Calculate the area
        width = right - left + 1
        area = heights[i] * width
        max_area = max(max_area, area)
    
    return max_area
```

**Time Complexity:** O(n²) - For each bar, we may need to scan the entire array.
**Space Complexity:** O(1) - We use only a few variables.

### 2. Improved Solution - Divide and Conquer

Use a divide and conquer approach to find the largest rectangle.

```python
def largestRectangleArea(heights):
    def calculate_area(start, end):
        if start > end:
            return 0
        
        if start == end:
            return heights[start]
        
        # Find the minimum height in the range
        min_idx = start
        for i in range(start, end + 1):
            if heights[i] < heights[min_idx]:
                min_idx = i
        
        # Calculate the area with the minimum height bar
        area_with_min = heights[min_idx] * (end - start + 1)
        
        # Calculate the area without the minimum height bar
        area_left = calculate_area(start, min_idx - 1)
        area_right = calculate_area(min_idx + 1, end)
        
        # Return the maximum area
        return max(area_with_min, area_left, area_right)
    
    return calculate_area(0, len(heights) - 1)
```

**Time Complexity:** O(n²) in the worst case, but can be O(n log n) on average.
**Space Complexity:** O(n) - The recursion stack can go up to O(n) levels deep.

### 3. Best Optimized Solution - Stack

Use a stack to keep track of the indices of bars in ascending order of height.

```python
def largestRectangleArea(heights):
    n = len(heights)
    stack = []  # Stack to store indices of bars
    max_area = 0
    
    for i in range(n):
        # Pop the stack while the current bar is shorter than the bar at the top of the stack
        while stack and heights[i] < heights[stack[-1]]:
            height = heights[stack.pop()]
            
            # Calculate the width of the rectangle
            width = i if not stack else i - stack[-1] - 1
            
            # Calculate the area and update the maximum area
            area = height * width
            max_area = max(max_area, area)
        
        # Push the current index onto the stack
        stack.append(i)
    
    # Process the remaining bars in the stack
    while stack:
        height = heights[stack.pop()]
        
        # Calculate the width of the rectangle
        width = n if not stack else n - stack[-1] - 1
        
        # Calculate the area and update the maximum area
        area = height * width
        max_area = max(max_area, area)
    
    return max_area
```

**Time Complexity:** O(n) - We process each bar at most twice (once when pushing onto the stack and once when popping from the stack).
**Space Complexity:** O(n) - In the worst case, the stack can have all bars.

### 4. Alternative Solution - Stack with Sentinel Values

Use a stack with sentinel values to simplify the code.

```python
def largestRectangleArea(heights):
    # Add sentinel values to handle edge cases
    heights = [0] + heights + [0]
    n = len(heights)
    stack = [0]  # Stack to store indices of bars
    max_area = 0
    
    for i in range(1, n):
        # Pop the stack while the current bar is shorter than the bar at the top of the stack
        while heights[i] < heights[stack[-1]]:
            height = heights[stack.pop()]
            width = i - stack[-1] - 1
            area = height * width
            max_area = max(max_area, area)
        
        # Push the current index onto the stack
        stack.append(i)
    
    return max_area
```

**Time Complexity:** O(n) - We process each bar at most twice.
**Space Complexity:** O(n) - In the worst case, the stack can have all bars.

## Solution Choice and Explanation

The stack solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Efficient Algorithm**: It efficiently finds the largest rectangle by maintaining a stack of indices in ascending order of height.

3. **Single Pass**: It processes the array in a single pass, making it more efficient than the brute force and divide and conquer approaches.

The key insight of this approach is to use a stack to keep track of the indices of bars in ascending order of height. For each bar:
- We pop bars from the stack while the current bar is shorter than the bar at the top of the stack. For each popped bar, we calculate the area of the rectangle with that bar's height and update the maximum area.
- We push the current bar's index onto the stack.

After processing all bars, we pop the remaining bars from the stack and calculate their areas.

For example, let's simulate [2,1,5,6,2,3]:
1. Push 0 onto the stack: stack = [0]
2. For bar 1 with height 1:
   - 1 < 2, so pop 0 from the stack and calculate the area: 2 * 1 = 2
   - Push 1 onto the stack: stack = [1]
3. For bar 2 with height 5:
   - 5 > 1, so push 2 onto the stack: stack = [1, 2]
4. For bar 3 with height 6:
   - 6 > 5, so push 3 onto the stack: stack = [1, 2, 3]
5. For bar 4 with height 2:
   - 2 < 6, so pop 3 from the stack and calculate the area: 6 * 1 = 6
   - 2 < 5, so pop 2 from the stack and calculate the area: 5 * 2 = 10
   - 2 > 1, so push 4 onto the stack: stack = [1, 4]
6. For bar 5 with height 3:
   - 3 > 2, so push 5 onto the stack: stack = [1, 4, 5]
7. After processing all bars, pop the remaining bars from the stack:
   - Pop 5 and calculate the area: 3 * 1 = 3
   - Pop 4 and calculate the area: 2 * 3 = 6
   - Pop 1 and calculate the area: 1 * 5 = 5
8. The maximum area is 10.

The stack solution with sentinel values (Solution 4) is also efficient and simplifies the code by adding sentinel values to handle edge cases. The brute force approach (Solution 1) is inefficient with O(n²) time complexity. The divide and conquer approach (Solution 2) has a worst-case time complexity of O(n²) but can be O(n log n) on average.

In an interview, I would first mention the stack approach as the most efficient solution for this problem.
