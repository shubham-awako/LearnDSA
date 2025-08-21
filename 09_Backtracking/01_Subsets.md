# Subsets

## Problem Statement

Given an integer array `nums` of unique elements, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.

**Example 1:**
```
Input: nums = [1,2,3]
Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
```

**Example 2:**
```
Input: nums = [0]
Output: [[],[0]]
```

**Constraints:**
- `1 <= nums.length <= 10`
- `-10 <= nums[i] <= 10`
- All the numbers of `nums` are unique.

## Concept Overview

This problem tests your understanding of backtracking and generating all possible combinations. The key insight is to use a recursive approach to build all possible subsets by making decisions for each element: either include it in the current subset or exclude it.

## Solutions

### 1. Best Optimized Solution - Backtracking

Use backtracking to generate all possible subsets.

```python
def subsets(nums):
    result = []
    
    def backtrack(start, current):
        # Add the current subset to the result
        result.append(current[:])
        
        # Try to include each remaining element in the subset
        for i in range(start, len(nums)):
            # Include the current element
            current.append(nums[i])
            
            # Recursively generate subsets with the current element included
            backtrack(i + 1, current)
            
            # Exclude the current element (backtrack)
            current.pop()
    
    backtrack(0, [])
    return result
```

**Time Complexity:** O(n * 2^n) - There are 2^n possible subsets, and it takes O(n) time to copy each subset.
**Space Complexity:** O(n) - The recursion stack can go up to n levels deep, and we need O(n) space to store each subset.

### 2. Alternative Solution - Iterative

Use an iterative approach to generate all possible subsets.

```python
def subsets(nums):
    result = [[]]
    
    for num in nums:
        # For each existing subset, create a new subset by adding the current element
        result += [subset + [num] for subset in result]
    
    return result
```

**Time Complexity:** O(n * 2^n) - There are 2^n possible subsets, and it takes O(n) time to copy each subset.
**Space Complexity:** O(n * 2^n) - We store all subsets, each of which can have up to n elements.

### 3. Alternative Solution - Bit Manipulation

Use bit manipulation to generate all possible subsets.

```python
def subsets(nums):
    n = len(nums)
    result = []
    
    # There are 2^n possible subsets
    for i in range(1 << n):
        subset = []
        
        # Check each bit of i
        for j in range(n):
            # If the jth bit is set, include the jth element
            if i & (1 << j):
                subset.append(nums[j])
        
        result.append(subset)
    
    return result
```

**Time Complexity:** O(n * 2^n) - There are 2^n possible subsets, and it takes O(n) time to generate each subset.
**Space Complexity:** O(n * 2^n) - We store all subsets, each of which can have up to n elements.

## Solution Choice and Explanation

The backtracking solution (Solution 1) is the best approach for this problem because:

1. **Clarity**: It clearly expresses the recursive nature of the problem and is easy to understand.

2. **Space Efficiency**: It uses less space than the iterative solution because it only keeps track of the current subset during the recursion.

3. **Flexibility**: It can be easily extended to handle more complex constraints or variations of the problem.

The key insight of this approach is to use backtracking to generate all possible subsets by making decisions for each element: either include it in the current subset or exclude it. We use a recursive function `backtrack(start, current)` that:
1. Adds the current subset to the result.
2. Tries to include each remaining element in the subset.
3. Recursively generates subsets with the current element included.
4. Excludes the current element (backtracking) to try other combinations.

For example, let's trace through the algorithm for nums = [1, 2, 3]:
1. Start with an empty subset: []
2. Add it to the result: [[]]
3. Try to include 1:
   - Current subset: [1]
   - Add it to the result: [[], [1]]
   - Try to include 2:
     - Current subset: [1, 2]
     - Add it to the result: [[], [1], [1, 2]]
     - Try to include 3:
       - Current subset: [1, 2, 3]
       - Add it to the result: [[], [1], [1, 2], [1, 2, 3]]
       - No more elements to include, backtrack.
     - Exclude 3, backtrack.
   - Exclude 2, backtrack.
   - Try to include 3:
     - Current subset: [1, 3]
     - Add it to the result: [[], [1], [1, 2], [1, 2, 3], [1, 3]]
     - No more elements to include, backtrack.
   - Exclude 3, backtrack.
4. Exclude 1, backtrack.
5. Try to include 2:
   - Current subset: [2]
   - Add it to the result: [[], [1], [1, 2], [1, 2, 3], [1, 3], [2]]
   - Try to include 3:
     - Current subset: [2, 3]
     - Add it to the result: [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3]]
     - No more elements to include, backtrack.
   - Exclude 3, backtrack.
6. Exclude 2, backtrack.
7. Try to include 3:
   - Current subset: [3]
   - Add it to the result: [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]
   - No more elements to include, backtrack.
8. Exclude 3, backtrack.
9. No more elements to include, we're done.
10. Final result: [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]

The iterative solution (Solution 2) is also efficient but less intuitive. The bit manipulation solution (Solution 3) is elegant but may be less readable for those unfamiliar with bit manipulation.

In an interview, I would first mention the backtracking solution as the most intuitive approach for this problem, and then mention the iterative and bit manipulation solutions as alternatives if asked for different approaches.
