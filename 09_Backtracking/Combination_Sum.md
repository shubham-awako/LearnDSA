# Combination Sum

## Problem Statement

Given an array of distinct integers `candidates` and a target integer `target`, return a list of all unique combinations of `candidates` where the chosen numbers sum to `target`. You may return the combinations in any order.

The same number may be chosen from `candidates` an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.

It is guaranteed that the number of unique combinations that sum up to `target` is less than `150` combinations for the given input.

**Example 1:**
```
Input: candidates = [2,3,6,7], target = 7
Output: [[2,2,3],[7]]
Explanation:
2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
7 is a candidate, and 7 = 7.
These are the only two combinations.
```

**Example 2:**
```
Input: candidates = [2,3,5], target = 8
Output: [[2,2,2,2],[2,3,3],[3,5]]
```

**Example 3:**
```
Input: candidates = [2], target = 1
Output: []
```

**Constraints:**
- `1 <= candidates.length <= 30`
- `1 <= candidates[i] <= 200`
- All elements of `candidates` are distinct.
- `1 <= target <= 500`

## Concept Overview

This problem tests your understanding of backtracking and generating all possible combinations that satisfy a constraint. The key insight is to use a recursive approach to build all possible combinations by making decisions for each element: either include it in the current combination (possibly multiple times) or exclude it.

## Solutions

### 1. Best Optimized Solution - Backtracking

Use backtracking to generate all possible combinations that sum to the target.

```python
def combinationSum(candidates, target):
    result = []
    
    def backtrack(start, current, remaining):
        # If the remaining sum is 0, we've found a valid combination
        if remaining == 0:
            result.append(current[:])
            return
        
        # If the remaining sum is negative, this path is invalid
        if remaining < 0:
            return
        
        # Try to include each candidate in the combination
        for i in range(start, len(candidates)):
            # Include the current candidate
            current.append(candidates[i])
            
            # Recursively generate combinations with the current candidate included
            # Note that we pass i instead of i+1 because we can reuse the same element
            backtrack(i, current, remaining - candidates[i])
            
            # Exclude the current candidate (backtrack)
            current.pop()
    
    backtrack(0, [], target)
    return result
```

**Time Complexity:** O(N^(T/M)) where N is the number of candidates, T is the target value, and M is the minimum value among the candidates. This is because in the worst case, we have T/M levels in the recursion tree, and at each level, we have N choices.
**Space Complexity:** O(T/M) for the recursion stack, where T is the target value and M is the minimum value among the candidates.

### 2. Alternative Solution - Backtracking with Sorting

Sort the candidates first to potentially prune the search space earlier.

```python
def combinationSum(candidates, target):
    # Sort the candidates to potentially prune the search space earlier
    candidates.sort()
    result = []
    
    def backtrack(start, current, remaining):
        # If the remaining sum is 0, we've found a valid combination
        if remaining == 0:
            result.append(current[:])
            return
        
        # Try to include each candidate in the combination
        for i in range(start, len(candidates)):
            # If the current candidate is greater than the remaining sum, we can break
            # because all subsequent candidates will also be greater (since the array is sorted)
            if candidates[i] > remaining:
                break
            
            # Include the current candidate
            current.append(candidates[i])
            
            # Recursively generate combinations with the current candidate included
            # Note that we pass i instead of i+1 because we can reuse the same element
            backtrack(i, current, remaining - candidates[i])
            
            # Exclude the current candidate (backtrack)
            current.pop()
    
    backtrack(0, [], target)
    return result
```

**Time Complexity:** O(N^(T/M)) where N is the number of candidates, T is the target value, and M is the minimum value among the candidates. The sorting step takes O(N log N) time, which is dominated by the backtracking step.
**Space Complexity:** O(T/M) for the recursion stack, where T is the target value and M is the minimum value among the candidates.

### 3. Alternative Solution - Dynamic Programming

Use dynamic programming to find all combinations that sum to the target.

```python
def combinationSum(candidates, target):
    # dp[i] will store all combinations that sum to i
    dp = [[] for _ in range(target + 1)]
    
    # Base case: empty combination sums to 0
    dp[0] = [[]]
    
    # For each candidate, update the dp array
    for candidate in candidates:
        for i in range(candidate, target + 1):
            # For each combination that sums to i - candidate,
            # we can add the current candidate to get a combination that sums to i
            for combo in dp[i - candidate]:
                dp[i].append(combo + [candidate])
    
    return dp[target]
```

**Time Complexity:** O(N * T * K) where N is the number of candidates, T is the target value, and K is the average length of the combinations. This is because for each candidate and each value from 1 to target, we may need to create new combinations by appending the candidate to existing combinations.
**Space Complexity:** O(T * K) where T is the target value and K is the average length of the combinations. This is the space required to store all combinations in the dp array.

## Solution Choice and Explanation

The backtracking with sorting solution (Solution 2) is the best approach for this problem because:

1. **Efficiency**: Sorting the candidates allows us to prune the search space earlier by breaking the loop when the current candidate is greater than the remaining sum.

2. **Clarity**: It clearly expresses the recursive nature of the problem and is easy to understand.

3. **Space Efficiency**: It uses less space than the dynamic programming solution because it only keeps track of the current combination during the recursion.

The key insight of this approach is to use backtracking to generate all possible combinations that sum to the target by making decisions for each element: either include it in the current combination (possibly multiple times) or exclude it. We use a recursive function `backtrack(start, current, remaining)` that:
1. Checks if the remaining sum is 0, in which case we've found a valid combination.
2. Tries to include each candidate in the combination, starting from the given index.
3. Recursively generates combinations with the current candidate included.
4. Excludes the current candidate (backtracking) to try other combinations.

By sorting the candidates first, we can break the loop early when the current candidate is greater than the remaining sum, which can significantly prune the search space.

For example, let's trace through the algorithm for candidates = [2, 3, 6, 7] and target = 7:
1. Sort the candidates: [2, 3, 6, 7]
2. Start with an empty combination: []
3. Try to include 2:
   - Current combination: [2]
   - Remaining sum: 5
   - Try to include 2 again:
     - Current combination: [2, 2]
     - Remaining sum: 3
     - Try to include 2 again:
       - Current combination: [2, 2, 2]
       - Remaining sum: 1
       - Try to include 2 again:
         - Current combination: [2, 2, 2, 2]
         - Remaining sum: -1
         - This is invalid, backtrack.
       - Exclude 2, backtrack.
       - Try to include 3:
         - Current combination: [2, 2, 3]
         - Remaining sum: 0
         - This is a valid combination, add it to the result: [[2, 2, 3]]
         - Backtrack.
       - Exclude 3, backtrack.
       - Try to include 6:
         - Current combination: [2, 2, 6]
         - Remaining sum: -5
         - This is invalid, backtrack.
       - Exclude 6, backtrack.
       - Try to include 7:
         - Current combination: [2, 2, 7]
         - Remaining sum: -6
         - This is invalid, backtrack.
       - Exclude 7, backtrack.
     - Exclude 2, backtrack.
     - Try to include 3:
       - Current combination: [2, 3]
       - Remaining sum: 2
       - Try to include 2 again:
         - Current combination: [2, 3, 2]
         - Remaining sum: 0
         - This is a valid combination, but it's a permutation of [2, 2, 3] which we've already found, so we don't add it to the result.
         - Backtrack.
       - Exclude 2, backtrack.
       - Try to include 3:
         - Current combination: [2, 3, 3]
         - Remaining sum: -1
         - This is invalid, backtrack.
       - Exclude 3, backtrack.
       - Try to include 6:
         - Current combination: [2, 3, 6]
         - Remaining sum: -4
         - This is invalid, backtrack.
       - Exclude 6, backtrack.
       - Try to include 7:
         - Current combination: [2, 3, 7]
         - Remaining sum: -5
         - This is invalid, backtrack.
       - Exclude 7, backtrack.
     - Exclude 3, backtrack.
     - Try to include 6:
       - Current combination: [2, 6]
       - Remaining sum: -1
       - This is invalid, backtrack.
     - Exclude 6, backtrack.
     - Try to include 7:
       - Current combination: [2, 7]
       - Remaining sum: -2
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
   - Exclude 2, backtrack.
4. Try to include 3:
   - Current combination: [3]
   - Remaining sum: 4
   - Try to include 3 again:
     - Current combination: [3, 3]
     - Remaining sum: 1
     - Try to include 3 again:
       - Current combination: [3, 3, 3]
       - Remaining sum: -2
       - This is invalid, backtrack.
     - Exclude 3, backtrack.
     - Try to include 6:
       - Current combination: [3, 3, 6]
       - Remaining sum: -5
       - This is invalid, backtrack.
     - Exclude 6, backtrack.
     - Try to include 7:
       - Current combination: [3, 3, 7]
       - Remaining sum: -6
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
   - Exclude 3, backtrack.
   - Try to include 6:
     - Current combination: [3, 6]
     - Remaining sum: -2
     - This is invalid, backtrack.
   - Exclude 6, backtrack.
   - Try to include 7:
     - Current combination: [3, 7]
     - Remaining sum: -3
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
5. Try to include 6:
   - Current combination: [6]
   - Remaining sum: 1
   - Try to include 6 again:
     - Current combination: [6, 6]
     - Remaining sum: -5
     - This is invalid, backtrack.
   - Exclude 6, backtrack.
   - Try to include 7:
     - Current combination: [6, 7]
     - Remaining sum: -6
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
6. Try to include 7:
   - Current combination: [7]
   - Remaining sum: 0
   - This is a valid combination, add it to the result: [[2, 2, 3], [7]]
   - Backtrack.
7. Exclude 7, backtrack.
8. No more elements to include, we're done.
9. Final result: [[2, 2, 3], [7]]

The basic backtracking solution (Solution 1) is also efficient but may explore more invalid paths. The dynamic programming solution (Solution 3) is more complex and uses more space.

In an interview, I would first mention the backtracking with sorting solution as the most efficient approach for this problem, and then mention the basic backtracking and dynamic programming solutions as alternatives if asked for different approaches.
