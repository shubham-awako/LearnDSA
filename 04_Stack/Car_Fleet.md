# Car Fleet

## Problem Statement

There are `n` cars going to the same destination along a one-lane road. The destination is `target` miles away.

You are given two integer array `position` and `speed`, both of length `n`, where `position[i]` is the position of the `i`th car and `speed[i]` is the speed of the `i`th car (in miles per hour).

A car can never pass another car ahead of it, but it can catch up to it and drive bumper to bumper at the same speed. The faster car will slow down to match the slower car's speed. The distance between these two cars is ignored (i.e., they are assumed to have the same position).

A car fleet is some non-empty set of cars driving at the same speed. Note that a single car is also a car fleet.

If a car catches up to a car fleet right at the destination point, it will still be considered as one car fleet.

Return the number of car fleets that will arrive at the destination.

**Example 1:**
```
Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]
Output: 3
Explanation:
The cars starting at 10 (speed 2) and 8 (speed 4) become a fleet, meeting at 12.
The car starting at 0 (speed 1) doesn't catch up to any other car, so it is a fleet by itself.
The cars starting at 5 (speed 1) and 3 (speed 3) become a fleet, meeting at 6. The fleet moves at speed 1 until it reaches target.
Note that no other cars meet these fleets before the destination, so the answer is 3.
```

**Example 2:**
```
Input: target = 10, position = [3], speed = [3]
Output: 1
Explanation: There is only one car, hence there is only one fleet.
```

**Example 3:**
```
Input: target = 100, position = [0,2,4], speed = [4,2,1]
Output: 1
Explanation:
The cars starting at 0 (speed 4) and 2 (speed 2) become a fleet, meeting at 4. The fleet moves at speed 2.
Then, the fleet (speed 2) and the car starting at 4 (speed 1) become one fleet, meeting at 6. The fleet moves at speed 1 until it reaches target.
```

**Constraints:**
- `n == position.length == speed.length`
- `1 <= n <= 10^5`
- `0 <= position[i] < target`
- `0 < speed[i] <= 10^6`
- All the values of `position` are unique.

## Concept Overview

This problem tests your understanding of car fleets and how to determine the number of fleets that will arrive at the destination. The key insight is to calculate the time each car takes to reach the destination and then determine which cars will form fleets.

## Solutions

### 1. Brute Force Approach - Simulation

Simulate the movement of each car and track when they form fleets.

```python
def carFleet(target, position, speed):
    n = len(position)
    
    # Create a list of (position, speed) pairs
    cars = list(zip(position, speed))
    
    # Sort cars by position in descending order
    cars.sort(reverse=True)
    
    fleets = 0
    i = 0
    
    while i < n:
        fleets += 1
        current_pos, current_speed = cars[i]
        
        # Find all cars that will join this fleet
        j = i + 1
        while j < n:
            next_pos, next_speed = cars[j]
            
            # Calculate time to reach the destination for both cars
            time_current = (target - current_pos) / current_speed
            time_next = (target - next_pos) / next_speed
            
            # If the next car catches up, it joins the fleet
            if time_next <= time_current:
                j += 1
            else:
                break
        
        i = j
    
    return fleets
```

**Time Complexity:** O(n²) - In the worst case, we need to check each car against all others.
**Space Complexity:** O(n) - For storing the cars.

### 2. Best Optimized Solution - Stack

Sort cars by position and use a stack to track the time each car takes to reach the destination.

```python
def carFleet(target, position, speed):
    # Create a list of (position, time) pairs
    cars = [(p, (target - p) / s) for p, s in zip(position, speed)]
    
    # Sort cars by position in descending order
    cars.sort(reverse=True)
    
    stack = []
    
    for _, time in cars:
        # If the current car takes longer to reach the destination than the car ahead,
        # it will form a new fleet
        if not stack or time > stack[-1]:
            stack.append(time)
    
    return len(stack)
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(n) - For storing the cars and the stack.

### 3. Alternative Solution - Greedy Approach

Sort cars by position and greedily determine the number of fleets.

```python
def carFleet(target, position, speed):
    # Create a list of (position, time) pairs
    cars = [(p, (target - p) / s) for p, s in zip(position, speed)]
    
    # Sort cars by position in descending order
    cars.sort(reverse=True)
    
    fleets = 0
    max_time = 0
    
    for _, time in cars:
        # If the current car takes longer to reach the destination than the car ahead,
        # it will form a new fleet
        if time > max_time:
            fleets += 1
            max_time = time
    
    return fleets
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(n) - For storing the cars.

## Solution Choice and Explanation

The stack solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n log n) time complexity, which is optimal for this problem.

2. **Clarity**: It clearly models the problem as a stack, where cars that take longer to reach the destination form new fleets.

3. **Efficient Handling of Fleets**: It efficiently determines which cars will form fleets based on their arrival times.

The key insight of this approach is to sort the cars by position in descending order (from closest to the destination to furthest) and calculate the time each car takes to reach the destination. Then, we use a stack to track the arrival times:
- If a car takes longer to reach the destination than the car ahead (the top of the stack), it will form a new fleet.
- Otherwise, it will catch up to the car ahead and join its fleet.

For example, let's simulate target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]:
1. Calculate arrival times: [(10, 1), (8, 1), (0, 12), (5, 7), (3, 3)] (position, time)
2. Sort by position in descending order: [(10, 1), (8, 1), (5, 7), (3, 3), (0, 12)]
3. Process the cars:
   - Car at position 10: stack = [1]
   - Car at position 8: time = 1, which is not greater than the top of the stack, so it joins the fleet. stack = [1]
   - Car at position 5: time = 7, which is greater than the top of the stack, so it forms a new fleet. stack = [1, 7]
   - Car at position 3: time = 3, which is not greater than the top of the stack, so it joins the fleet. stack = [1, 7]
   - Car at position 0: time = 12, which is greater than the top of the stack, so it forms a new fleet. stack = [1, 7, 12]
4. The number of fleets is the size of the stack: 3.

The greedy approach (Solution 3) is essentially the same as the stack solution but without explicitly using a stack. The brute force approach (Solution 1) is inefficient with O(n²) time complexity.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
