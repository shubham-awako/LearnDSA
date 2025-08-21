# Course Schedule II

## Problem Statement

There are a total of `numCourses` courses you have to take, labeled from `0` to `numCourses - 1`. You are given an array `prerequisites` where `prerequisites[i] = [ai, bi]` indicates that you must take course `bi` first if you want to take course `ai`.

For example, the pair `[0, 1]` indicates that to take course `0` you have to first take course `1`.

Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

**Example 1:**
```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: [0,1]
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
```

**Example 2:**
```
Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
Output: [0,1,2,3] or [0,2,1,3]
Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
```

**Example 3:**
```
Input: numCourses = 1, prerequisites = []
Output: [0]
```

**Constraints:**
- `1 <= numCourses <= 2000`
- `0 <= prerequisites.length <= numCourses * (numCourses - 1)`
- `prerequisites[i].length == 2`
- `0 <= ai, bi < numCourses`
- `ai != bi`
- All the pairs `[ai, bi]` are distinct.

## Concept Overview

This problem is an extension of the "Course Schedule" problem, where instead of just determining if it's possible to finish all courses, we need to find a valid ordering of courses. The key insight is to perform a topological sort on the directed graph representing the courses and prerequisites.

## Solutions

### 1. Best Optimized Solution - DFS Topological Sort

Use Depth-First Search to perform a topological sort of the graph.

```python
def findOrder(numCourses, prerequisites):
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(numCourses)]
    for course, prereq in prerequisites:
        graph[prereq].append(course)
    
    # 0 = unvisited, 1 = visiting, 2 = visited
    visited = [0] * numCourses
    result = []
    
    def dfs(course):
        # If the course is being visited, there is a cycle
        if visited[course] == 1:
            return False
        
        # If the course has already been visited, it's safe
        if visited[course] == 2:
            return True
        
        # Mark the course as being visited
        visited[course] = 1
        
        # Visit all next courses
        for next_course in graph[course]:
            if not dfs(next_course):
                return False
        
        # Mark the course as visited
        visited[course] = 2
        
        # Add the course to the result
        result.append(course)
        
        return True
    
    # Check each course
    for course in range(numCourses):
        if not dfs(course):
            return []
    
    # Reverse the result to get the correct order
    return result[::-1]
```

**Time Complexity:** O(V + E) - We visit each vertex (course) and edge (prerequisite) once, where V is the number of courses and E is the number of prerequisites.
**Space Complexity:** O(V + E) - We store the graph as an adjacency list, the visited array, and the result array.

### 2. Alternative Solution - BFS Topological Sort (Kahn's Algorithm)

Use Breadth-First Search to perform a topological sort of the graph.

```python
from collections import deque

def findOrder(numCourses, prerequisites):
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(numCourses)]
    in_degree = [0] * numCourses
    
    for course, prereq in prerequisites:
        graph[prereq].append(course)
        in_degree[course] += 1
    
    # Add all courses with no prerequisites to the queue
    queue = deque([course for course in range(numCourses) if in_degree[course] == 0])
    result = []
    
    # Process the queue
    while queue:
        course = queue.popleft()
        result.append(course)
        
        # Reduce the in-degree of all courses that have this course as a prerequisite
        for next_course in graph[course]:
            in_degree[next_course] -= 1
            
            # If the course has no more prerequisites, add it to the queue
            if in_degree[next_course] == 0:
                queue.append(next_course)
    
    # If all courses can be taken, return the result
    return result if len(result) == numCourses else []
```

**Time Complexity:** O(V + E) - We visit each vertex (course) and edge (prerequisite) once, where V is the number of courses and E is the number of prerequisites.
**Space Complexity:** O(V + E) - We store the graph as an adjacency list, the in-degree array, the queue, and the result array.

### 3. Alternative Solution - DFS with Post-order Traversal

Use Depth-First Search with post-order traversal to perform a topological sort of the graph.

```python
def findOrder(numCourses, prerequisites):
    # Build the adjacency list representation of the graph
    graph = [[] for _ in range(numCourses)]
    for course, prereq in prerequisites:
        graph[prereq].append(course)
    
    # Set to keep track of courses in the current path
    path = set()
    # Set to keep track of visited courses
    visited = set()
    # List to store the result
    result = []
    
    def dfs(course):
        # If the course is in the current path, there is a cycle
        if course in path:
            return False
        
        # If the course has already been visited, it's safe
        if course in visited:
            return True
        
        # Add the course to the current path
        path.add(course)
        
        # Visit all next courses
        for next_course in graph[course]:
            if not dfs(next_course):
                return False
        
        # Remove the course from the current path
        path.remove(course)
        
        # Mark the course as visited
        visited.add(course)
        
        # Add the course to the result
        result.append(course)
        
        return True
    
    # Check each course
    for course in range(numCourses):
        if course not in visited:
            if not dfs(course):
                return []
    
    # Reverse the result to get the correct order
    return result[::-1]
```

**Time Complexity:** O(V + E) - We visit each vertex (course) and edge (prerequisite) once, where V is the number of courses and E is the number of prerequisites.
**Space Complexity:** O(V + E) - We store the graph as an adjacency list, the path set, the visited set, and the result array.

## Solution Choice and Explanation

The BFS Topological Sort (Kahn's Algorithm) solution (Solution 2) is the best approach for this problem because:

1. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

2. **Efficiency**: It achieves O(V + E) time complexity, which is optimal for this problem, and the space complexity is O(V + E).

3. **Intuitiveness**: It naturally maps to the concept of taking courses in order, starting with those that have no prerequisites.

The key insight of this approach is to use BFS to perform a topological sort of the graph. We start by adding all courses with no prerequisites to the queue. Then, we process each course in the queue, removing it from the prerequisites of other courses. When a course has no more prerequisites, we add it to the queue. If we can process all courses, we have a valid ordering.

For example, let's trace through the algorithm for the second example:
```
numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
```

1. Build the adjacency list representation of the graph:
   - graph[0] = [1, 2]
   - graph[1] = [3]
   - graph[2] = [3]
   - graph[3] = []
   - in_degree = [0, 1, 1, 2]

2. Add all courses with no prerequisites to the queue:
   - queue = [0]
   - result = []

3. Process the queue:
   - Dequeue 0:
     - result = [0]
     - Reduce the in-degree of courses 1 and 2:
       - in_degree = [0, 0, 0, 2]
       - Add courses 1 and 2 to the queue: queue = [1, 2]
   - Dequeue 1:
     - result = [0, 1]
     - Reduce the in-degree of course 3:
       - in_degree = [0, 0, 0, 1]
   - Dequeue 2:
     - result = [0, 1, 2]
     - Reduce the in-degree of course 3:
       - in_degree = [0, 0, 0, 0]
       - Add course 3 to the queue: queue = [3]
   - Dequeue 3:
     - result = [0, 1, 2, 3]

4. Final result: [0, 1, 2, 3]

The DFS Topological Sort solution (Solution 1) is also efficient and may be preferred in some cases, especially when the graph is sparse. The DFS with Post-order Traversal solution (Solution 3) is similar to Solution 1 but uses sets instead of an array for visited tracking.

In an interview, I would first mention the BFS Topological Sort solution as the most intuitive approach for this problem, and then discuss the DFS Topological Sort and DFS with Post-order Traversal solutions as alternatives if asked for different approaches.
