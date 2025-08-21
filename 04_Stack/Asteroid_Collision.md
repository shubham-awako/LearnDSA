# Asteroid Collision

## Problem Statement

We are given an array `asteroids` of integers representing asteroids in a row.

For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.

Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.

**Example 1:**
```
Input: asteroids = [5,10,-5]
Output: [5,10]
Explanation: The 10 and -5 collide resulting in 10. The 5 and 10 never collide.
```

**Example 2:**
```
Input: asteroids = [8,-8]
Output: []
Explanation: The 8 and -8 collide exploding each other.
```

**Example 3:**
```
Input: asteroids = [10,2,-5]
Output: [10]
Explanation: The 2 and -5 collide resulting in -5. The 10 and -5 collide resulting in 10.
```

**Constraints:**
- `2 <= asteroids.length <= 10^4`
- `-1000 <= asteroids[i] <= 1000`
- `asteroids[i] != 0`

## Concept Overview

This problem tests your understanding of stack operations for simulating collisions. The key insight is to use a stack to keep track of asteroids and handle collisions when they occur.

## Solutions

### 1. Best Optimized Solution - Stack

Use a stack to keep track of asteroids and handle collisions.

```python
def asteroidCollision(asteroids):
    stack = []
    
    for asteroid in asteroids:
        # Handle collisions
        while stack and stack[-1] > 0 and asteroid < 0:
            # If the top asteroid is smaller, it explodes
            if stack[-1] < abs(asteroid):
                stack.pop()
                continue
            # If both asteroids are the same size, both explode
            elif stack[-1] == abs(asteroid):
                stack.pop()
                break
            # If the incoming asteroid is smaller, it explodes
            else:
                break
        else:
            # No collision or the incoming asteroid survives
            stack.append(asteroid)
    
    return stack
```

**Time Complexity:** O(n) - We process each asteroid at most twice (once when adding to the stack and at most once when it collides).
**Space Complexity:** O(n) - In the worst case, the stack can have all asteroids.

### 2. Alternative Solution - Two-Pass Simulation

Simulate the collisions in two passes: first from left to right, then from right to left.

```python
def asteroidCollision(asteroids):
    n = len(asteroids)
    result = [0] * n
    size = 0
    
    # First pass: handle collisions from left to right
    for i in range(n):
        asteroid = asteroids[i]
        
        # If the asteroid is moving right or there's no collision
        if asteroid > 0 or size == 0 or result[size - 1] < 0:
            result[size] = asteroid
            size += 1
        # If the asteroid is moving left and there's a potential collision
        else:
            # Handle collisions
            while size > 0 and result[size - 1] > 0 and result[size - 1] < abs(asteroid):
                size -= 1
            
            # If all right-moving asteroids are destroyed or the last one is the same size
            if size == 0 or result[size - 1] < 0:
                result[size] = asteroid
                size += 1
            # If the last right-moving asteroid is the same size as the incoming one
            elif result[size - 1] == abs(asteroid):
                size -= 1
            # Otherwise, the incoming asteroid is destroyed
    
    return result[:size]
```

**Time Complexity:** O(n) - We process each asteroid at most twice.
**Space Complexity:** O(n) - For storing the result.

**Note:** This solution is more complex and error-prone than the stack solution.

### 3. Alternative Solution - Recursive Approach

Use recursion to handle collisions.

```python
def asteroidCollision(asteroids):
    def simulate(asteroids):
        if len(asteroids) <= 1:
            return asteroids
        
        # Find the first collision
        for i in range(len(asteroids) - 1):
            if asteroids[i] > 0 and asteroids[i + 1] < 0:
                # Handle the collision
                if abs(asteroids[i]) > abs(asteroids[i + 1]):
                    # The right asteroid explodes
                    return simulate(asteroids[:i + 1] + asteroids[i + 2:])
                elif abs(asteroids[i]) < abs(asteroids[i + 1]):
                    # The left asteroid explodes
                    return simulate(asteroids[:i] + asteroids[i + 1:])
                else:
                    # Both asteroids explode
                    return simulate(asteroids[:i] + asteroids[i + 2:])
        
        # No collisions found
        return asteroids
    
    return simulate(asteroids)
```

**Time Complexity:** O(n²) - In the worst case, we need to scan the array O(n) times, each time taking O(n) time.
**Space Complexity:** O(n²) - The recursion stack and creating new arrays can take up to O(n²) space.

## Solution Choice and Explanation

The stack solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Natural Fit**: The problem is naturally modeled as a stack, where we keep track of asteroids and handle collisions when they occur.

The key insight of this approach is to use a stack to keep track of asteroids. For each asteroid:
- If it's moving right (positive), push it onto the stack.
- If it's moving left (negative), check for collisions with asteroids at the top of the stack:
  - If the top asteroid is moving left (negative), there's no collision, so push the current asteroid onto the stack.
  - If the top asteroid is moving right (positive), there's a potential collision:
    - If the top asteroid is smaller, it explodes, so pop it from the stack and continue checking for collisions.
    - If both asteroids are the same size, both explode, so pop the top asteroid and don't push the current asteroid.
    - If the current asteroid is smaller, it explodes, so don't push it onto the stack.

For example, let's simulate [5,10,-5]:
1. Push 5 onto the stack: stack = [5]
2. Push 10 onto the stack: stack = [5, 10]
3. For -5:
   - Check for collision with 10: 10 > |-5|, so -5 explodes and doesn't get pushed onto the stack.
4. The final stack is [5, 10].

The two-pass simulation (Solution 2) is more complex and error-prone. The recursive approach (Solution 3) is inefficient with O(n²) time complexity.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
