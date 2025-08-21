# Container With Most Water

## Problem Statement

You are given an integer array `height` of length `n`. There are `n` vertical lines drawn such that the two endpoints of the `i`th line are `(i, 0)` and `(i, height[i])`.

Find two lines that together with the x-axis form a container, such that the container contains the most water.

Return the maximum amount of water a container can store.

**Notice** that you may not slant the container.

**Example 1:**
```
Input: height = [1,8,6,2,5,4,8,3,7]
Output: 49
Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
```

**Example 2:**
```
Input: height = [1,1]
Output: 1
```

**Constraints:**
- `n == height.length`
- `2 <= n <= 10^5`
- `0 <= height[i] <= 10^4`

## Concept Overview

This problem asks us to find the maximum area that can be formed between two vertical lines and the x-axis. The key insight is to use a two-pointer approach to efficiently explore the search space.

## Solutions

### 1. Brute Force Approach

Check all possible pairs of lines and calculate the area.

```python
def maxArea(height):
    n = len(height)
    max_area = 0
    
    for i in range(n):
        for j in range(i + 1, n):
            # Calculate the area
            h = min(height[i], height[j])
            w = j - i
            area = h * w
            
            max_area = max(max_area, area)
    
    return max_area
```

**Time Complexity:** O(n²) - We check all possible pairs of lines.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

### 2. Best Optimized Solution - Two Pointers

Use two pointers starting from opposite ends of the array and move them based on the height of the lines.

```python
def maxArea(height):
    n = len(height)
    left, right = 0, n - 1
    max_area = 0
    
    while left < right:
        # Calculate the area
        h = min(height[left], height[right])
        w = right - left
        area = h * w
        
        max_area = max(max_area, area)
        
        # Move the pointer with the smaller height
        if height[left] < height[right]:
            left += 1
        else:
            right -= 1
    
    return max_area
```

**Time Complexity:** O(n) - We process each element at most once.
**Space Complexity:** O(1) - We use only a few variables regardless of input size.

## Solution Choice and Explanation

The two-pointer solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is significantly better than the O(n²) of the brute force approach.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is optimal for this problem.

3. **Efficient Search Strategy**: It intelligently narrows down the search space by moving the pointer with the smaller height.

The key insight of this approach is to start with the widest possible container (using the first and last lines) and then try to increase the height by moving the pointers. Since the area is determined by the minimum height of the two lines and the distance between them, we always move the pointer with the smaller height. This is because:

1. If we move the pointer with the larger height, the width decreases, and the height is still limited by the smaller line, so the area can only decrease.
2. If we move the pointer with the smaller height, the width decreases, but there's a chance that the height increases, potentially leading to a larger area.

For example, in the array [1,8,6,2,5,4,8,3,7]:
- We start with pointers at indices 0 and 8, giving an area of min(1, 7) * (8 - 0) = 1 * 8 = 8.
- Since height[0] < height[8], we move the left pointer to index 1.
- Now we have pointers at indices 1 and 8, giving an area of min(8, 7) * (8 - 1) = 7 * 7 = 49.
- And so on...

The brute force approach (Solution 1) is simple but inefficient with O(n²) time complexity, making it impractical for large arrays.

In an interview, I would first mention the two-pointer approach as the optimal solution that achieves O(n) time complexity with O(1) extra space. I would also explain the insight behind moving the pointer with the smaller height.
