# Reconstruct Itinerary

## Problem Statement

You are given a list of airline `tickets` where `tickets[i] = [fromi, toi]` represent the departure and the arrival airports of one flight. Reconstruct the itinerary in order and return it.

All of the tickets belong to a man who departs from "JFK", thus, the itinerary must begin with "JFK". If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string.

For example, the itinerary `["JFK", "LGA"]` has a smaller lexical order than `["JFK", "LGB"]`.

You may assume all tickets form at least one valid itinerary. You must use all the tickets once and only once.

**Example 1:**
```
Input: tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
Output: ["JFK","MUC","LHR","SFO","SJC"]
```

**Example 2:**
```
Input: tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
```

**Constraints:**
- `1 <= tickets.length <= 300`
- `tickets[i].length == 2`
- `fromi.length == 3`
- `toi.length == 3`
- `fromi` and `toi` consist of uppercase English letters.
- `fromi != toi`

## Concept Overview

This problem is asking us to find an Eulerian path in a directed graph, which is a path that visits every edge exactly once. The key insight is to use a modified version of Hierholzer's algorithm to find the Eulerian path, starting from the "JFK" airport.

## Solutions

### 1. Best Optimized Solution - Hierholzer's Algorithm

Use Hierholzer's Algorithm to find the Eulerian path.

```python
import heapq
from collections import defaultdict

def findItinerary(tickets):
    # Build the graph
    graph = defaultdict(list)
    for from_airport, to_airport in tickets:
        heapq.heappush(graph[from_airport], to_airport)
    
    # Hierholzer's Algorithm
    itinerary = []
    
    def dfs(airport):
        while graph[airport]:
            next_airport = heapq.heappop(graph[airport])
            dfs(next_airport)
        itinerary.append(airport)
    
    dfs("JFK")
    
    # Reverse the itinerary to get the correct order
    return itinerary[::-1]
```

**Time Complexity:** O(E * log(E)) - We need to build the graph, which takes O(E * log(E)) time due to the heap operations, where E is the number of edges (tickets), and then perform a DFS, which takes O(E) time.
**Space Complexity:** O(E) - We need to store the graph and the itinerary.

### 2. Alternative Solution - Hierholzer's Algorithm with Sorting

Use Hierholzer's Algorithm with sorting to find the Eulerian path.

```python
from collections import defaultdict

def findItinerary(tickets):
    # Build the graph
    graph = defaultdict(list)
    for from_airport, to_airport in tickets:
        graph[from_airport].append(to_airport)
    
    # Sort the destinations
    for airport in graph:
        graph[airport].sort()
    
    # Hierholzer's Algorithm
    itinerary = []
    
    def dfs(airport):
        while graph[airport]:
            next_airport = graph[airport].pop(0)  # Pop from the front (smallest lexical order)
            dfs(next_airport)
        itinerary.append(airport)
    
    dfs("JFK")
    
    # Reverse the itinerary to get the correct order
    return itinerary[::-1]
```

**Time Complexity:** O(E * log(E)) - We need to build the graph and sort the destinations, which takes O(E * log(E)) time, where E is the number of edges (tickets), and then perform a DFS, which takes O(E) time.
**Space Complexity:** O(E) - We need to store the graph and the itinerary.

### 3. Alternative Solution - Iterative Hierholzer's Algorithm

Use an iterative version of Hierholzer's Algorithm to find the Eulerian path.

```python
import heapq
from collections import defaultdict

def findItinerary(tickets):
    # Build the graph
    graph = defaultdict(list)
    for from_airport, to_airport in tickets:
        heapq.heappush(graph[from_airport], to_airport)
    
    # Iterative Hierholzer's Algorithm
    stack = ["JFK"]
    itinerary = []
    
    while stack:
        while graph[stack[-1]]:
            stack.append(heapq.heappop(graph[stack[-1]]))
        itinerary.append(stack.pop())
    
    # Reverse the itinerary to get the correct order
    return itinerary[::-1]
```

**Time Complexity:** O(E * log(E)) - We need to build the graph, which takes O(E * log(E)) time due to the heap operations, where E is the number of edges (tickets), and then perform an iterative DFS, which takes O(E) time.
**Space Complexity:** O(E) - We need to store the graph, the stack, and the itinerary.

## Solution Choice and Explanation

The Hierholzer's Algorithm solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(E * log(E)) time complexity, which is optimal for this problem, and the space complexity is O(E).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding an Eulerian path in a directed graph.

The key insight of this approach is to use Hierholzer's Algorithm to find the Eulerian path. Hierholzer's Algorithm works by starting from a vertex and following edges until we get stuck. Then, we backtrack and add the vertices to the result in reverse order. This ensures that we use all the edges exactly once and end up with a valid itinerary.

For example, let's trace through the algorithm for the first example:
```
tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
```

1. Build the graph:
   - graph = {"MUC": ["LHR"], "JFK": ["MUC"], "SFO": ["SJC"], "LHR": ["SFO"]}

2. Hierholzer's Algorithm:
   - Start DFS from "JFK":
     - Visit "MUC":
       - Visit "LHR":
         - Visit "SFO":
           - Visit "SJC":
             - No more destinations, add "SJC" to itinerary: itinerary = ["SJC"]
           - Add "SFO" to itinerary: itinerary = ["SJC", "SFO"]
         - Add "LHR" to itinerary: itinerary = ["SJC", "SFO", "LHR"]
       - Add "MUC" to itinerary: itinerary = ["SJC", "SFO", "LHR", "MUC"]
     - Add "JFK" to itinerary: itinerary = ["SJC", "SFO", "LHR", "MUC", "JFK"]

3. Reverse the itinerary: ["JFK", "MUC", "LHR", "SFO", "SJC"]

4. Final result: ["JFK", "MUC", "LHR", "SFO", "SJC"]

For the second example:
```
tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
```

1. Build the graph:
   - graph = {"JFK": ["ATL", "SFO"], "SFO": ["ATL"], "ATL": ["JFK", "SFO"]}

2. Hierholzer's Algorithm:
   - Start DFS from "JFK":
     - Visit "ATL" (smallest lexical order):
       - Visit "JFK":
         - Visit "SFO":
           - Visit "ATL":
             - Visit "SFO":
               - No more destinations, add "SFO" to itinerary: itinerary = ["SFO"]
             - Add "ATL" to itinerary: itinerary = ["SFO", "ATL"]
           - Add "SFO" to itinerary: itinerary = ["SFO", "ATL", "SFO"]
         - Add "JFK" to itinerary: itinerary = ["SFO", "ATL", "SFO", "JFK"]
       - Add "ATL" to itinerary: itinerary = ["SFO", "ATL", "SFO", "JFK", "ATL"]
     - Add "JFK" to itinerary: itinerary = ["SFO", "ATL", "SFO", "JFK", "ATL", "JFK"]

3. Reverse the itinerary: ["JFK", "ATL", "JFK", "SFO", "ATL", "SFO"]

4. Final result: ["JFK", "ATL", "JFK", "SFO", "ATL", "SFO"]

The Hierholzer's Algorithm with Sorting solution (Solution 2) is also efficient but may be less efficient than using a heap for maintaining the lexical order. The Iterative Hierholzer's Algorithm solution (Solution 3) is useful for avoiding stack overflow in cases with a large number of tickets.

In an interview, I would first mention the Hierholzer's Algorithm solution as the most efficient approach for this problem, and then discuss the Hierholzer's Algorithm with Sorting and Iterative Hierholzer's Algorithm solutions as alternatives if asked for different approaches.
