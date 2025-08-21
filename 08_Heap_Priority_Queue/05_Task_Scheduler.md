# Task Scheduler

## Problem Statement

Given a characters array `tasks`, representing the tasks a CPU needs to do, where each letter represents a different task. Tasks could be done in any order. Each task is done in one unit of time. For each unit of time, the CPU could complete either one task or just be idle.

However, there is a non-negative integer `n` that represents the cooldown period between two same tasks (the same letter in the array), that is that there must be at least `n` units of time between any two same tasks.

Return the least number of units of time that the CPU will take to finish all the given tasks.

**Example 1:**
```
Input: tasks = ["A","A","A","B","B","B"], n = 2
Output: 8
Explanation: 
A -> B -> idle -> A -> B -> idle -> A -> B
There is at least 2 units of time between any two same tasks.
```

**Example 2:**
```
Input: tasks = ["A","A","A","B","B","B"], n = 0
Output: 6
Explanation: On this case any permutation of size 6 would work since n = 0.
["A","A","A","B","B","B"]
["A","B","A","B","A","B"]
["B","B","B","A","A","A"]
...
And so on.
```

**Example 3:**
```
Input: tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2
Output: 16
Explanation: 
One possible solution is
A -> B -> C -> A -> D -> E -> A -> F -> G -> A -> idle -> idle -> A -> idle -> idle -> A
```

**Constraints:**
- `1 <= task.length <= 10^4`
- `tasks[i]` is upper-case English letter.
- The integer `n` is in the range `[0, 100]`.

## Concept Overview

This problem tests your understanding of greedy algorithms and priority queues. The key insight is to schedule the most frequent tasks first, with the required cooldown period between the same tasks.

## Solutions

### 1. Best Optimized Solution - Greedy Approach

Use a greedy approach to schedule the tasks, starting with the most frequent tasks.

```python
from collections import Counter

def leastInterval(tasks, n):
    # Count the frequency of each task
    task_counts = Counter(tasks)
    
    # Find the maximum frequency
    max_freq = max(task_counts.values())
    
    # Count the number of tasks with the maximum frequency
    max_freq_tasks = sum(1 for count in task_counts.values() if count == max_freq)
    
    # Calculate the minimum time required
    # Formula: (max_freq - 1) * (n + 1) + max_freq_tasks
    # Explanation:
    # - (max_freq - 1) represents the number of complete cycles needed
    # - (n + 1) represents the length of each cycle (including the task and its cooldown)
    # - max_freq_tasks represents the number of tasks in the last cycle
    min_time = (max_freq - 1) * (n + 1) + max_freq_tasks
    
    # The actual time is the maximum of the minimum time and the total number of tasks
    return max(min_time, len(tasks))
```

**Time Complexity:** O(n) - We iterate through the tasks once to count their frequencies.
**Space Complexity:** O(1) - We use a constant amount of extra space to store the task counts (at most 26 for uppercase English letters).

### 2. Alternative Solution - Priority Queue

Use a priority queue to schedule the tasks, always choosing the task with the highest remaining frequency.

```python
import heapq
from collections import Counter

def leastInterval(tasks, n):
    # Count the frequency of each task
    task_counts = Counter(tasks)
    
    # Create a max-heap of task frequencies
    max_heap = [-count for count in task_counts.values()]
    heapq.heapify(max_heap)
    
    time = 0
    
    # Process tasks until the heap is empty
    while max_heap:
        # Store tasks that need to wait for their cooldown period
        waiting = []
        
        # Process at most (n+1) tasks in each cycle
        for _ in range(n + 1):
            if max_heap:
                # Get the task with the highest frequency
                count = heapq.heappop(max_heap)
                
                # If the task still has remaining instances, add it to the waiting list
                if count + 1 < 0:
                    waiting.append(count + 1)
            
            # Increment time
            time += 1
            
            # If both the heap and waiting list are empty, we're done
            if not max_heap and not waiting:
                break
        
        # Add the waiting tasks back to the heap
        for count in waiting:
            heapq.heappush(max_heap, count)
    
    return time
```

**Time Complexity:** O(n log m) - We process each task once, and each heap operation takes O(log m) time, where m is the number of distinct tasks.
**Space Complexity:** O(m) - We store the frequency of each distinct task in the heap.

### 3. Alternative Solution - Simulation

Simulate the scheduling process, always choosing the task with the highest remaining frequency that is not in its cooldown period.

```python
from collections import Counter, deque

def leastInterval(tasks, n):
    # Count the frequency of each task
    task_counts = Counter(tasks)
    
    # Create a list of (task, count) pairs, sorted by count in descending order
    task_list = [(task, count) for task, count in task_counts.items()]
    task_list.sort(key=lambda x: x[1], reverse=True)
    
    # Initialize the schedule
    schedule = []
    
    # Process tasks until all are scheduled
    while task_list:
        # Find the next task to schedule
        i = 0
        while i < len(task_list):
            task, count = task_list[i]
            
            # Check if the task is in its cooldown period
            if len(schedule) < n or task not in schedule[-n:]:
                # Schedule the task
                schedule.append(task)
                
                # Update the task count
                count -= 1
                if count == 0:
                    task_list.pop(i)
                else:
                    task_list[i] = (task, count)
                
                # Re-sort the task list
                task_list.sort(key=lambda x: x[1], reverse=True)
                
                break
            
            i += 1
        
        # If no task can be scheduled, add an idle period
        if i == len(task_list):
            schedule.append("idle")
    
    return len(schedule)
```

**Time Complexity:** O(n^2) - In the worst case, we need to check all tasks for each time slot.
**Space Complexity:** O(n) - We store the schedule.

## Solution Choice and Explanation

The greedy approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is optimal for this problem.

3. **Elegance**: It uses a mathematical formula to directly calculate the result without simulation.

The key insight of this approach is to recognize that the most frequent task will determine the minimum time required to complete all tasks. We need to schedule the most frequent task with the required cooldown period, and then fit other tasks into the idle slots.

Let's understand the formula: (max_freq - 1) * (n + 1) + max_freq_tasks
- max_freq is the frequency of the most frequent task.
- (max_freq - 1) represents the number of complete cycles needed.
- (n + 1) represents the length of each cycle (including the task and its cooldown).
- max_freq_tasks represents the number of tasks in the last cycle.

For example, let's calculate the minimum time for tasks = ["A","A","A","B","B","B"], n = 2:
1. Count the frequencies: A: 3, B: 3
2. max_freq = 3
3. max_freq_tasks = 2 (both A and B have frequency 3)
4. min_time = (3 - 1) * (2 + 1) + 2 = 2 * 3 + 2 = 8
5. The actual time is max(8, 6) = 8

Let's verify this with a schedule:
A -> B -> idle -> A -> B -> idle -> A -> B

For tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2:
1. Count the frequencies: A: 6, B: 1, C: 1, D: 1, E: 1, F: 1, G: 1
2. max_freq = 6
3. max_freq_tasks = 1 (only A has frequency 6)
4. min_time = (6 - 1) * (2 + 1) + 1 = 5 * 3 + 1 = 16
5. The actual time is max(16, 12) = 16

Let's verify this with a schedule:
A -> B -> C -> A -> D -> E -> A -> F -> G -> A -> idle -> idle -> A -> idle -> idle -> A

The priority queue solution (Solution 2) is also efficient but more complex. The simulation solution (Solution 3) is the most intuitive but least efficient.

In an interview, I would first mention the greedy approach as the most efficient solution for this problem, and then explain the intuition behind the formula.
