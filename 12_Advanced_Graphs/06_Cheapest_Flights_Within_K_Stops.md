# Cheapest Flights Within K Stops

## Problem Statement

There are `n` cities connected by some number of flights. You are given an array `flights` where `flights[i] = [fromi, toi, pricei]` indicates that there is a flight from city `fromi` to city `toi` with cost `pricei`.

You are also given three integers `src`, `dst`, and `k`, return the cheapest price from `src` to `dst` with at most `k` stops. If there is no such route, return `-1`.

**Example 1:**
```
Input: n = 4, flights = [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]], src = 0, dst = 3, k = 1
Output: 700
Explanation:
The graph is shown above.
The optimal path with at most 1 stop from city 0 to 3 is marked in red and has cost 100 + 600 = 700.
Note that the path through cities [0,2,3] is cheaper but is invalid because it uses 2 stops.
```

**Example 2:**
```
Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 1
Output: 200
Explanation:
The graph is shown above.
The optimal path with at most 1 stop from city 0 to 2 is marked in red and has cost 100 + 100 = 200.
```

**Example 3:**
```
Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 0
Output: 500
Explanation:
The graph is shown above.
The optimal path with no stops from city 0 to 2 is marked in red and has cost 500.
```

**Constraints:**
- `1 <= n <= 100`
- `0 <= flights.length <= (n * (n - 1) / 2)`
- `flights[i].length == 3`
- `0 <= fromi, toi < n`
- `fromi != toi`
- `1 <= pricei <= 10^4`
- There will not be any multiple flights between two cities.
- `0 <= src, dst, k < n`
- `src != dst`

## Concept Overview

This problem is asking us to find the cheapest path from a source city to a destination city with at most `k` stops. The key insight is to use a modified version of Dijkstra's algorithm or Bellman-Ford algorithm to find the shortest path with a constraint on the number of stops.

## Solutions

### 1. Best Optimized Solution - Bellman-Ford Algorithm

Use the Bellman-Ford Algorithm to find the shortest path with at most `k` stops.

```python
def findCheapestPrice(n, flights, src, dst, k):
    # Initialize distances
    dist = [float('inf')] * n
    dist[src] = 0
    
    # Relax all edges k+1 times
    for i in range(k + 1):
        # Create a copy of the distances to avoid using updated values in the same iteration
        temp = dist.copy()
        
        for from_city, to_city, price in flights:
            if dist[from_city] != float('inf') and dist[from_city] + price < temp[to_city]:
                temp[to_city] = dist[from_city] + price
        
        dist = temp
    
    return dist[dst] if dist[dst] != float('inf') else -1
```

**Time Complexity:** O(k * E) - We need to relax all edges k+1 times, where E is the number of edges (flights).
**Space Complexity:** O(V) - We need to store the distance array, where V is the number of vertices (cities).

### 2. Alternative Solution - BFS with Queue

Use Breadth-First Search with a queue to find the shortest path with at most `k` stops.

```python
from collections import defaultdict, deque

def findCheapestPrice(n, flights, src, dst, k):
    # Build the graph
    graph = defaultdict(list)
    for from_city, to_city, price in flights:
        graph[from_city].append((to_city, price))
    
    # BFS
    queue = deque([(src, 0, 0)])  # (city, cost, stops)
    min_cost = float('inf')
    
    # Keep track of the minimum cost to reach each city with a certain number of stops
    visited = {}  # (city, stops) -> cost
    
    while queue:
        city, cost, stops = queue.popleft()
        
        # If we've reached the destination, update the minimum cost
        if city == dst:
            min_cost = min(min_cost, cost)
            continue
        
        # If we've used up all our stops or the cost is already greater than the minimum cost, skip
        if stops > k or cost >= min_cost:
            continue
        
        # Explore all neighbors
        for next_city, price in graph[city]:
            next_cost = cost + price
            next_stops = stops + 1
            
            # If we've already visited this city with fewer stops and lower cost, skip
            if (next_city, next_stops) in visited and visited[(next_city, next_stops)] <= next_cost:
                continue
            
            visited[(next_city, next_stops)] = next_cost
            queue.append((next_city, next_cost, next_stops))
    
    return min_cost if min_cost != float('inf') else -1
```

**Time Complexity:** O(V * k) - In the worst case, we visit each city k times, where V is the number of vertices (cities).
**Space Complexity:** O(V * k) - We need to store the visited map, which can have at most V * k entries.

### 3. Alternative Solution - Dijkstra's Algorithm with Stops

Use a modified version of Dijkstra's Algorithm to find the shortest path with at most `k` stops.

```python
import heapq
from collections import defaultdict

def findCheapestPrice(n, flights, src, dst, k):
    # Build the graph
    graph = defaultdict(list)
    for from_city, to_city, price in flights:
        graph[from_city].append((to_city, price))
    
    # Dijkstra's Algorithm
    min_heap = [(0, src, 0)]  # (cost, city, stops)
    # Keep track of the minimum cost to reach each city with a certain number of stops
    visited = {}  # (city, stops) -> cost
    
    while min_heap:
        cost, city, stops = heapq.heappop(min_heap)
        
        # If we've reached the destination, return the cost
        if city == dst:
            return cost
        
        # If we've used up all our stops, skip
        if stops > k:
            continue
        
        # If we've already visited this city with fewer stops and lower cost, skip
        if (city, stops) in visited and visited[(city, stops)] < cost:
            continue
        
        visited[(city, stops)] = cost
        
        # Explore all neighbors
        for next_city, price in graph[city]:
            next_cost = cost + price
            next_stops = stops + 1
            
            if (next_city, next_stops) not in visited or next_cost < visited[(next_city, next_stops)]:
                heapq.heappush(min_heap, (next_cost, next_city, next_stops))
    
    return -1
```

**Time Complexity:** O(V * k * log(V * k)) - In the worst case, we visit each city k times, and each heap operation takes O(log(V * k)) time, where V is the number of vertices (cities).
**Space Complexity:** O(V * k) - We need to store the visited map and the min heap, which can have at most V * k entries.

## Solution Choice and Explanation

The Bellman-Ford Algorithm solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(k * E) time complexity, which is optimal for this problem, and the space complexity is O(V).

3. **Intuitiveness**: It naturally maps to the concept of finding the shortest path with a constraint on the number of stops.

The key insight of this approach is to use the Bellman-Ford Algorithm to find the shortest path with at most `k` stops. The Bellman-Ford Algorithm works by relaxing all edges k+1 times, where k is the maximum number of stops allowed. In each iteration, we update the distances to all cities that can be reached with one more stop.

For example, let's trace through the algorithm for the second example:
```
n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 1
```

1. Initialize distances:
   - dist = [0, inf, inf]

2. Relax all edges k+1 = 2 times:
   - Iteration 1:
     - Edge (0, 1, 100): dist[1] = min(inf, 0 + 100) = 100
     - Edge (1, 2, 100): dist[2] = min(inf, 100 + 100) = 200
     - Edge (0, 2, 500): dist[2] = min(200, 0 + 500) = 200
   - Iteration 2:
     - Edge (0, 1, 100): dist[1] = min(100, 0 + 100) = 100
     - Edge (1, 2, 100): dist[2] = min(200, 100 + 100) = 200
     - Edge (0, 2, 500): dist[2] = min(200, 0 + 500) = 200

3. Final distances: dist = [0, 100, 200]

4. Return dist[dst] = dist[2] = 200

For the third example:
```
n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 0
```

1. Initialize distances:
   - dist = [0, inf, inf]

2. Relax all edges k+1 = 1 time:
   - Iteration 1:
     - Edge (0, 1, 100): dist[1] = min(inf, 0 + 100) = 100
     - Edge (1, 2, 100): dist[2] = min(inf, 100 + 100) = 200
     - Edge (0, 2, 500): dist[2] = min(200, 0 + 500) = 200

3. Final distances: dist = [0, 100, 200]

4. But since k = 0, we can only have direct flights from src to dst, so the answer should be 500.

Wait, there's an issue with our algorithm for the third example. Let's correct it:

```python
def findCheapestPrice(n, flights, src, dst, k):
    # Initialize distances
    dist = [float('inf')] * n
    dist[src] = 0
    
    # Relax all edges k+1 times
    for i in range(k + 1):
        # Create a copy of the distances to avoid using updated values in the same iteration
        temp = dist.copy()
        
        for from_city, to_city, price in flights:
            if dist[from_city] != float('inf'):
                temp[to_city] = min(temp[to_city], dist[from_city] + price)
        
        dist = temp
    
    return dist[dst] if dist[dst] != float('inf') else -1
```

Now, let's trace through the corrected algorithm for the third example:
```
n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 0
```

1. Initialize distances:
   - dist = [0, inf, inf]

2. Relax all edges k+1 = 1 time:
   - Iteration 1:
     - Edge (0, 1, 100): temp[1] = min(inf, 0 + 100) = 100
     - Edge (1, 2, 100): temp[2] = min(inf, inf + 100) = inf (since dist[1] is still inf in this iteration)
     - Edge (0, 2, 500): temp[2] = min(inf, 0 + 500) = 500
   - Update dist = temp = [0, 100, 500]

3. Final distances: dist = [0, 100, 500]

4. Return dist[dst] = dist[2] = 500

The BFS with Queue solution (Solution 2) and the Dijkstra's Algorithm with Stops solution (Solution 3) are also correct but may be less efficient or more complex.

In an interview, I would first mention the Bellman-Ford Algorithm solution as the most straightforward approach for this problem, and then discuss the BFS with Queue and Dijkstra's Algorithm with Stops solutions as alternatives if asked for different approaches.
