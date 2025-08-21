# Detect Squares

## Problem Statement

You are given a stream of points on the X-Y plane. Design an algorithm that:

1. Adds new points from the stream into a data structure. **Duplicate** points are allowed and should be treated as different points.
2. Given a query point, counts the number of ways to choose three points from the data structure such that the three points and the query point form an **axis-aligned square** with **positive area**.

An **axis-aligned square** is a square whose edges are all the same length and are either parallel or perpendicular to the x-axis and y-axis.

Implement the `DetectSquares` class:

- `DetectSquares()` Initializes the object with an empty data structure.
- `void add(int[] point)` Adds a new point `point = [x, y]` to the data structure.
- `int count(int[] point)` Counts the number of ways to form **axis-aligned squares** with point `point = [x, y]` as described above.

**Example 1:**
```
Input
["DetectSquares", "add", "add", "add", "count", "count", "add", "count"]
[[], [[3, 10]], [[11, 2]], [[3, 2]], [[11, 10]], [[14, 8]], [[11, 2]], [[11, 10]]]
Output
[null, null, null, null, 1, 0, null, 2]

Explanation
DetectSquares detectSquares = new DetectSquares();
detectSquares.add([3, 10]);
detectSquares.add([11, 2]);
detectSquares.add([3, 2]);
detectSquares.count([11, 10]); // return 1. You can choose:
                               //   - The first, second, and third points
detectSquares.count([14, 8]);  // return 0. The query point cannot form a square with any points in the data structure.
detectSquares.add([11, 2]);    // Adding duplicate points is allowed.
detectSquares.count([11, 10]); // return 2. You can choose:
                               //   - The first, second, and third points
                               //   - The first, third, and fourth points
```

**Constraints:**
- `point.length == 2`
- `0 <= x, y <= 1000`
- At most `3000` calls in total will be made to `add` and `count`.

## Concept Overview

This problem involves designing a data structure to efficiently count the number of axis-aligned squares that can be formed with a given query point. The key insight is to use a hash map to store the points and efficiently find potential square corners.

## Solutions

### 1. Best Optimized Solution - Using Hash Map and Counter

Use a hash map to store the points and a counter to keep track of the number of occurrences of each point.

```python
from collections import defaultdict, Counter

class DetectSquares:
    def __init__(self):
        # Dictionary to store points by their x-coordinate
        self.points_by_x = defaultdict(Counter)
        # Counter to keep track of the number of occurrences of each point
        self.point_count = Counter()
    
    def add(self, point):
        x, y = point
        self.points_by_x[x][y] += 1
        self.point_count[(x, y)] += 1
    
    def count(self, point):
        x, y = point
        result = 0
        
        # Iterate through all points with the same x-coordinate
        for y2, count in self.points_by_x[x].items():
            if y2 == y:
                continue
            
            # Calculate the side length of the square
            side_length = abs(y2 - y)
            
            # Check for points that could form a square
            for x_offset in [-side_length, side_length]:
                x3 = x + x_offset
                y3 = y
                x4 = x3
                y4 = y2
                
                # Count the number of ways to form a square
                result += self.point_count[(x3, y3)] * self.point_count[(x4, y4)] * count
        
        return result
```

**Time Complexity:**
- `add(point)`: O(1) - Adding a point to the hash map and counter takes constant time.
- `count(point)`: O(n) - In the worst case, we need to check all points with the same x-coordinate as the query point, which could be O(n) where n is the number of points.

**Space Complexity:** O(n) - We store all points in the hash map and counter.

### 2. Alternative Solution - Using Coordinate Pairs

Use a list to store all points and check all possible combinations of points to form a square.

```python
class DetectSquares:
    def __init__(self):
        # List to store all points
        self.points = []
    
    def add(self, point):
        self.points.append(tuple(point))
    
    def count(self, point):
        x1, y1 = point
        result = 0
        
        for x2, y2 in self.points:
            # Skip points that are not diagonal to the query point
            if x1 == x2 or y1 == y2 or abs(x1 - x2) != abs(y1 - y2):
                continue
            
            # Check if the other two points exist to form a square
            if (x1, y2) in self.points and (x2, y1) in self.points:
                # Count the number of ways to form a square
                count1 = self.points.count((x1, y2))
                count2 = self.points.count((x2, y1))
                result += count1 * count2
        
        return result
```

**Time Complexity:**
- `add(point)`: O(1) - Adding a point to the list takes constant time.
- `count(point)`: O(n^2) - We need to check all pairs of points, which takes O(n^2) time in the worst case.

**Space Complexity:** O(n) - We store all points in the list.

### 3. Alternative Solution - Using Two Hash Maps

Use two hash maps to store points by their x and y coordinates.

```python
from collections import defaultdict

class DetectSquares:
    def __init__(self):
        # Dictionary to store points by their x-coordinate
        self.points_by_x = defaultdict(list)
        # Dictionary to store points by their y-coordinate
        self.points_by_y = defaultdict(list)
        # Counter to keep track of the number of occurrences of each point
        self.point_count = defaultdict(int)
    
    def add(self, point):
        x, y = point
        self.points_by_x[x].append(y)
        self.points_by_y[y].append(x)
        self.point_count[(x, y)] += 1
    
    def count(self, point):
        x1, y1 = point
        result = 0
        
        # Iterate through all points with the same x-coordinate
        for y2 in self.points_by_x[x1]:
            if y2 == y1:
                continue
            
            # Calculate the side length of the square
            side_length = abs(y2 - y1)
            
            # Check for points that could form a square
            for x_offset in [-side_length, side_length]:
                x3 = x1 + x_offset
                y3 = y1
                x4 = x3
                y4 = y2
                
                # Count the number of ways to form a square
                result += self.point_count[(x3, y3)] * self.point_count[(x4, y4)] * self.point_count[(x1, y2)]
        
        return result
```

**Time Complexity:**
- `add(point)`: O(1) - Adding a point to the hash maps takes constant time.
- `count(point)`: O(n) - In the worst case, we need to check all points with the same x-coordinate as the query point, which could be O(n) where n is the number of points.

**Space Complexity:** O(n) - We store all points in the hash maps.

## Solution Choice and Explanation

The Using Hash Map and Counter solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(1) time complexity for the `add` operation and O(n) time complexity for the `count` operation, which is optimal for this problem.

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of finding axis-aligned squares.

The key insight of this approach is to use a hash map to store the points by their x-coordinate and a counter to keep track of the number of occurrences of each point. This allows us to efficiently find potential square corners by iterating through all points with the same x-coordinate as the query point.

For example, let's trace through the algorithm for the example in the problem statement:

1. Initialize `points_by_x = {}`, `point_count = {}`

2. Add [3, 10]:
   - `points_by_x[3][10] = 1`
   - `point_count[(3, 10)] = 1`

3. Add [11, 2]:
   - `points_by_x[11][2] = 1`
   - `point_count[(11, 2)] = 1`

4. Add [3, 2]:
   - `points_by_x[3][2] = 1`
   - `point_count[(3, 2)] = 1`

5. Count [11, 10]:
   - x1 = 11, y1 = 10
   - Iterate through all points with x-coordinate 11:
     - y2 = 2, count = 1
     - side_length = |2 - 10| = 8
     - Check for points at (11 - 8, 10) = (3, 10) and (3, 2):
       - `point_count[(3, 10)] = 1`, `point_count[(3, 2)] = 1`
       - result += 1 * 1 * 1 = 1
   - Return result = 1

6. Count [14, 8]:
   - x1 = 14, y1 = 8
   - No points with x-coordinate 14, so return 0

7. Add [11, 2]:
   - `points_by_x[11][2] = 2`
   - `point_count[(11, 2)] = 2`

8. Count [11, 10]:
   - x1 = 11, y1 = 10
   - Iterate through all points with x-coordinate 11:
     - y2 = 2, count = 2
     - side_length = |2 - 10| = 8
     - Check for points at (11 - 8, 10) = (3, 10) and (3, 2):
       - `point_count[(3, 10)] = 1`, `point_count[(3, 2)] = 1`
       - result += 1 * 1 * 2 = 2
   - Return result = 2

The Using Coordinate Pairs solution (Solution 2) is less efficient for the `count` operation, with a time complexity of O(n^2). The Using Two Hash Maps solution (Solution 3) is also efficient but may be more complex than necessary.

In an interview, I would first mention the Using Hash Map and Counter solution as the most efficient approach for this problem, and then discuss the Using Coordinate Pairs and Using Two Hash Maps solutions as alternatives if asked for different approaches.
