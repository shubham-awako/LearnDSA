# Gas Station

## Problem Statement

There are `n` gas stations along a circular route, where the amount of gas at the `i`th station is `gas[i]`.

You have a car with an unlimited gas tank and it costs `cost[i]` of gas to travel from the `i`th station to its next `(i + 1)`th station. You begin the journey with an empty tank at one of the gas stations.

Given two integer arrays `gas` and `cost`, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return `-1`. If there exists a solution, it is guaranteed to be unique.

**Example 1:**
```
Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
Output: 3
Explanation:
Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
Travel to station 4. Your tank = 4 - 1 + 5 = 8
Travel to station 0. Your tank = 8 - 2 + 1 = 7
Travel to station 1. Your tank = 7 - 3 + 2 = 6
Travel to station 2. Your tank = 6 - 4 + 3 = 5
Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
Therefore, return 3 as the starting index.
```

**Example 2:**
```
Input: gas = [2,3,4], cost = [3,4,3]
Output: -1
Explanation:
You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
Travel to station 0. Your tank = 4 - 3 + 2 = 3
Travel to station 1. Your tank = 3 - 3 + 3 = 3
You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
Therefore, you can't travel around the circuit once no matter where you start.
```

**Constraints:**
- `n == gas.length == cost.length`
- `1 <= n <= 10^5`
- `0 <= gas[i], cost[i] <= 10^4`

## Concept Overview

This problem can be solved using a greedy approach. The key insight is that if the total amount of gas is greater than or equal to the total cost, there must be a valid starting station. We can find this station by keeping track of the current gas in the tank and the starting station.

## Solutions

### 1. Best Optimized Solution - Greedy Approach

Use a greedy approach to find the starting gas station.

```python
def canCompleteCircuit(gas, cost):
    n = len(gas)
    
    # If the total amount of gas is less than the total cost, there is no solution
    if sum(gas) < sum(cost):
        return -1
    
    # The current gas in the tank
    current_gas = 0
    
    # The starting station
    start = 0
    
    # Iterate through the gas stations
    for i in range(n):
        # Update the current gas in the tank
        current_gas += gas[i] - cost[i]
        
        # If we can't reach the next station, start from the next station
        if current_gas < 0:
            current_gas = 0
            start = i + 1
    
    return start
```

**Time Complexity:** O(n) - We iterate through the gas stations once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 2. Alternative Solution - Brute Force

Try each gas station as the starting point and check if we can complete the circuit.

```python
def canCompleteCircuit(gas, cost):
    n = len(gas)
    
    # Try each gas station as the starting point
    for start in range(n):
        # The current gas in the tank
        current_gas = 0
        
        # Check if we can complete the circuit starting from this station
        for i in range(n):
            # The current station
            station = (start + i) % n
            
            # Update the current gas in the tank
            current_gas += gas[station] - cost[station]
            
            # If we can't reach the next station, break
            if current_gas < 0:
                break
        
        # If we've completed the circuit, return the starting station
        if current_gas >= 0:
            return start
    
    return -1
```

**Time Complexity:** O(n^2) - We try each gas station as the starting point and check if we can complete the circuit.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

### 3. Alternative Solution - Two-Pass Approach

Use a two-pass approach to find the starting gas station.

```python
def canCompleteCircuit(gas, cost):
    n = len(gas)
    
    # Calculate the total gas and cost
    total_gas = sum(gas)
    total_cost = sum(cost)
    
    # If the total amount of gas is less than the total cost, there is no solution
    if total_gas < total_cost:
        return -1
    
    # The current gas in the tank
    current_gas = 0
    
    # The starting station
    start = 0
    
    # Iterate through the gas stations
    for i in range(n):
        # Update the current gas in the tank
        current_gas += gas[i] - cost[i]
        
        # If we can't reach the next station, start from the next station
        if current_gas < 0:
            current_gas = 0
            start = i + 1
    
    return start
```

**Time Complexity:** O(n) - We iterate through the gas stations once.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Greedy Approach solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n) time complexity, which is optimal for this problem, and the space complexity is O(1).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding the starting gas station.

The key insight of this approach is that if the total amount of gas is greater than or equal to the total cost, there must be a valid starting station. We can find this station by keeping track of the current gas in the tank and the starting station. If at any point we can't reach the next station, we start from the next station.

For example, let's trace through the algorithm for gas = [1, 2, 3, 4, 5] and cost = [3, 4, 5, 1, 2]:

1. Check if the total amount of gas is less than the total cost:
   - sum(gas) = 1 + 2 + 3 + 4 + 5 = 15
   - sum(cost) = 3 + 4 + 5 + 1 + 2 = 15
   - 15 >= 15, so there is a solution

2. Initialize current_gas = 0, start = 0

3. Iterate through the gas stations:
   - i = 0: current_gas += gas[0] - cost[0] = 0 + 1 - 3 = -2
     - current_gas < 0, so current_gas = 0, start = 1
   - i = 1: current_gas += gas[1] - cost[1] = 0 + 2 - 4 = -2
     - current_gas < 0, so current_gas = 0, start = 2
   - i = 2: current_gas += gas[2] - cost[2] = 0 + 3 - 5 = -2
     - current_gas < 0, so current_gas = 0, start = 3
   - i = 3: current_gas += gas[3] - cost[3] = 0 + 4 - 1 = 3
     - current_gas >= 0, so continue
   - i = 4: current_gas += gas[4] - cost[4] = 3 + 5 - 2 = 6
     - current_gas >= 0, so continue

4. Return start = 3

For gas = [2, 3, 4] and cost = [3, 4, 3]:

1. Check if the total amount of gas is less than the total cost:
   - sum(gas) = 2 + 3 + 4 = 9
   - sum(cost) = 3 + 4 + 3 = 10
   - 9 < 10, so there is no solution

2. Return -1

The Brute Force solution (Solution 2) is less efficient but may be a good starting point for understanding the problem. The Two-Pass Approach solution (Solution 3) is essentially the same as the Greedy Approach solution but explicitly calculates the total gas and cost.

In an interview, I would first mention the Greedy Approach solution as the most efficient approach for this problem, and then discuss the Brute Force and Two-Pass Approach solutions as alternatives if asked for different approaches.
