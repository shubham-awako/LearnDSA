# Course Schedule

## Problem Statement

There are a total of `numCourses` courses you have to take, labeled from `0` to `numCourses - 1`. You are given an array `prerequisites` where `prerequisites[i] = [ai, bi]` indicates that you must take course `bi` first if you want to take course `ai`.

For example, the pair `[0, 1]` indicates that to take course `0` you have to first take course `1`.

Return `true` if you can finish all courses. Otherwise, return `false`.

**Example 1:**
```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0. So it is possible.
```

**Example 2:**
```
Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
```

**Constraints:**
- `1 <= numCourses <= 2000`
- `0 <= prerequisites.length <= 5000`
- `prerequisites[i].length == 2`
- `0 <= ai, bi < numCourses`
- All the pairs `prerequisites[i]` are unique.

## Concept Overview

This problem tests your understanding of graph theory, particularly cycle detection in a directed graph. The key insight is to represent the courses and prerequisites as a directed graph, where each course is a node and each prerequisite is a directed edge. If there is a cycle in this graph, it means there is a circular dependency among the courses, which makes it impossible to complete all courses.

## Solutions

### 1. Best Optimized Solution - DFS Cycle Detection

Use Depth-First Search to detect cycles in the directed graph.

```python
def canFinish(numCourses, prerequisites):
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(numCourses)]
    for course, prereq in prerequisites:
        graph[course].append(prereq)
    
    # 0 = unvisited, 1 = visiting, 2 = visited
    visited = [0] * numCourses
    
    def dfs(course):
        # If the course is being visited, there is a cycle
        if visited[course] == 1:
            return False
        
        # If the course has already been visited, it's safe
        if visited[course] == 2:
            return True
        
        # Mark the course as being visited
        visited[course] = 1
        
        # Visit all prerequisites
        for prereq in graph[course]:
            if not dfs(prereq):
                return False
        
        # Mark the course as visited
        visited[course] = 2
        
        return True
    
    # Check each course
    for course in range(numCourses):
        if not dfs(course):
            return False
    
    return True
```

**Time Complexity:** O(V + E) - We visit each vertex (course) and edge (prerequisite) once, where V is the number of courses and E is the number of prerequisites.
**Space Complexity:** O(V + E) - We store the graph as an adjacency list and the visited array.

### 2. Alternative Solution - BFS Topological Sort (Kahn's Algorithm)

Use Breadth-First Search to perform a topological sort of the graph.

```python
from collections import deque

def canFinish(numCourses, prerequisites):
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(numCourses)]
    in_degree = [0] * numCourses
    
    for course, prereq in prerequisites:
        graph[prereq].append(course)
        in_degree[course] += 1
    
    # Add all courses with no prerequisites to the queue
    queue = deque([course for course in range(numCourses) if in_degree[course] == 0])
    
    # Count the number of courses that can be taken
    count = 0
    
    # Process the queue
    while queue:
        course = queue.popleft()
        count += 1
        
        # Reduce the in-degree of all courses that have this course as a prerequisite
        for next_course in graph[course]:
            in_degree[next_course] -= 1
            
            # If the course has no more prerequisites, add it to the queue
            if in_degree[next_course] == 0:
                queue.append(next_course)
    
    # If all courses can be taken, return True
    return count == numCourses
```

**Time Complexity:** O(V + E) - We visit each vertex (course) and edge (prerequisite) once, where V is the number of courses and E is the number of prerequisites.
**Space Complexity:** O(V + E) - We store the graph as an adjacency list, the in-degree array, and the queue.

### 3. Alternative Solution - Union-Find

Use the Union-Find (Disjoint Set) data structure to detect cycles in the graph.

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])  # Path compression
        return self.parent[x]
    
    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)
        
        if root_x == root_y:
            return False
        
        # Union by rank
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1
        
        return True

def canFinish(numCourses, prerequisites):
    uf = UnionFind(numCourses)
    
    # Check for cycles
    for course, prereq in prerequisites:
        # If the course and its prerequisite are already in the same set, there is a cycle
        if uf.find(course) == uf.find(prereq):
            return False
        
        # Union the course and its prerequisite
        uf.union(course, prereq)
    
    return True
```

**Time Complexity:** O(E * α(V)) - We perform Union-Find operations for each edge, where α is the inverse Ackermann function, which is nearly constant.
**Space Complexity:** O(V) - We need to store the parent and rank arrays for the Union-Find data structure.

## Solution Choice and Explanation

The DFS Cycle Detection solution (Solution 1) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(V + E) time complexity, which is optimal for this problem, and the space complexity is O(V + E).

3. **Intuitiveness**: It naturally maps to the concept of detecting cycles in a directed graph.

The key insight of this approach is to use DFS to detect cycles in the directed graph. We mark each course as "visiting" when we start exploring it and as "visited" when we've finished exploring all its prerequisites. If we encounter a course that is already marked as "visiting", it means there is a cycle in the graph, which makes it impossible to complete all courses.

For example, let's trace through the algorithm for the second example:
```
numCourses = 2, prerequisites = [[1,0],[0,1]]
```

1. Build the adjacency list representation of the graph:
   - graph[0] = [1]
   - graph[1] = [0]

2. DFS from course 0:
   - Mark course 0 as visiting
   - Visit course 1:
     - Mark course 1 as visiting
     - Visit course 0:
       - Course 0 is already marked as visiting, so there is a cycle
       - Return False
     - Return False
   - Return False

3. Final result: False

The BFS Topological Sort solution (Solution 2) is also efficient and may be preferred in some cases, as it more explicitly checks if all courses can be taken. The Union-Find solution (Solution 3) is less intuitive for this problem and may not work correctly for all cases, as it doesn't handle directed edges properly.

In an interview, I would first mention the DFS Cycle Detection solution as the most intuitive approach for this problem, and then discuss the BFS Topological Sort solution as an alternative if asked for a different approach.
