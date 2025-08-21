# Jump Game II

## Problem Statement

You are given a 0-indexed array of integers `nums` of length `n`. You are initially positioned at `nums[0]`.

Each element `nums[i]` represents the maximum length of a forward jump from index `i`. In other words, if you are at `nums[i]`, you can jump to any `nums[i + j]` where:

- `0 <= j <= nums[i]` and
- `i + j < n`

Return the minimum number of jumps to reach `nums[n - 1]`. The test cases are generated such that you can reach `nums[n - 1]`.

**Example 1:**
```
Input: nums = [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
```

**Example 2:**
```
Input: nums = [2,3,0,1,4]
Output: 2
```

**Constraints:**
- `1 <= nums.length <= 10^4`
- `0 <= nums[i] <= 1000`
- It's guaranteed that you can reach `nums[n - 1]`.

## Concept Overview

This problem is an extension of the Jump Game problem, where we need to find the minimum number of jumps to reach the last index. The key insight is to use a greedy approach to make the optimal jump at each step.

## Solutions

### 1. Best Optimized Solution - Greedy Approach

Use a greedy approach to find the minimum number of jumps.

```python
def jump(nums):
    n = len(nums)
    
    # If there's only one element, we don't need to jump
    if n == 1:
        return 0
    
    # The number of jumps
    jumps = 0
    
    # The furthest position we can reach after the current jump
    current_max_reach = 0
    
    # The furthest position we can reach after the next jump
    next_max_reach = 0
    
    # Iterate through the array
    for i in range(n - 1):
        # Update the furthest position we can reach after the next jump
        next_max_reach = max(next_max_reach, i + nums[i])
        
        # If we've reached the furthest position we can reach after the current jump,
        # we need to make another jump
        if i == current_max_reach:
            jumps += 1
            current_max_reach = next_max_reach
            
            # If we can already reach the last index, we're done
            if current_max_reach >= n - 1:
                break
    
    return jumps
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - BFS

Use Breadth-First Search to find the minimum number of jumps.

```python
from collections import deque

def jump(nums):
    n = len(nums)
    
    # If there's only one element, we don't need to jump
    if n == 1:
        return 0
    
    # Use BFS to find the minimum number of jumps
    queue = deque([(0, 0)])  # (position, jumps)
    visited = set([0])
    
    while queue:
        pos, jumps = queue.popleft()
        
        # Try all possible jumps from the current position
        for j in range(1, nums[pos] + 1):
            next_pos = pos + j
            
            # If we've reached the last index, return the number of jumps
            if next_pos >= n - 1:
                return jumps + 1
            
            # If we haven't visited this position before, add it to the queue
            if next_pos not in visited:
                visited.add(next_pos)
                queue.append((next_pos, jumps + 1))
    
    return -1  # This line is actually unreachable
```

**Time Complexity:** O(n^2) - In the worst case, we need to check all possible jumps for each position.
**Space Complexity:** O(n) - We use a queue and a set to keep track of the positions we've visited.

### 3. Alternative Solution - Dynamic Programming

Use dynamic programming to find the minimum number of jumps.

```python
def jump(nums):
    n = len(nums)
    
    # dp[i] represents the minimum number of jumps to reach index i
    dp = [float('inf')] * n
    dp[0] = 0
    
    # Fill the dp array
    for i in range(n):
        # Try all possible jumps from position i
        for j in range(1, nums[i] + 1):
            if i + j < n:
                dp[i + j] = min(dp[i + j], dp[i] + 1)
    
    return dp[n - 1]
```

**Time Complexity:** O(n^2) - In the worst case, we need to check all possible jumps for each position.
**Space Complexity:** O(n) - We use an array of size n to store the minimum number of jumps to reach each position.

## Solution Choice and Explanation

The Greedy Approach solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the minimum number of jumps.

The key insight of this approach is to keep track of the furthest position we can reach after the current jump and the furthest position we can reach after the next jump. When we've reached the furthest position we can reach after the current jump, we need to make another jump, and we update the furthest position we can reach after the current jump to the furthest position we can reach after the next jump.

For example, let's trace through the algorithm for nums = [2, 3, 1, 1, 4]:

1. Initialize jumps = 0, current_max_reach = 0, next_max_reach = 0
2. For i = 0 (nums[0] = 2):
   - next_max_reach = max(0, 0 + 2) = 2
   - i == current_max_reach, so jumps = 1, current_max_reach = 2
   - current_max_reach < n - 1, so continue
3. For i = 1 (nums[1] = 3):
   - next_max_reach = max(2, 1 + 3) = 4
   - i != current_max_reach, so continue
4. For i = 2 (nums[2] = 1):
   - next_max_reach = max(4, 2 + 1) = 4
   - i == current_max_reach, so jumps = 2, current_max_reach = 4
   - current_max_reach >= n - 1, so break
5. Return jumps = 2

For nums = [2, 3, 0, 1, 4]:

1. Initialize jumps = 0, current_max_reach = 0, next_max_reach = 0
2. For i = 0 (nums[0] = 2):
   - next_max_reach = max(0, 0 + 2) = 2
   - i == current_max_reach, so jumps = 1, current_max_reach = 2
   - current_max_reach < n - 1, so continue
3. For i = 1 (nums[1] = 3):
   - next_max_reach = max(2, 1 + 3) = 4
   - i != current_max_reach, so continue
4. For i = 2 (nums[2] = 0):
   - next_max_reach = max(4, 2 + 0) = 4
   - i == current_max_reach, so jumps = 2, current_max_reach = 4
   - current_max_reach >= n - 1, so break
5. Return jumps = 2

The BFS solution (Solution 2) is also efficient but uses more space. The Dynamic Programming solution (Solution 3) is less efficient but may be a good starting point for understanding the problem.

In an interview, I would first mention the Greedy Approach solution as the most efficient approach for this problem, and then discuss the BFS and Dynamic Programming solutions as alternatives if asked for different approaches.
