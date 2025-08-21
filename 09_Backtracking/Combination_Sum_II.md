# Combination Sum II

## Problem Statement

Given a collection of candidate numbers (`candidates`) and a target number (`target`), find all unique combinations in `candidates` where the candidate numbers sum to `target`.

Each number in `candidates` may only be used once in the combination.

**Note:** The solution set must not contain duplicate combinations.

**Example 1:**
```
Input: candidates = [10,1,2,7,6,1,5], target = 8
Output: 
[
[1,1,6],
[1,2,5],
[1,7],
[2,6]
]
```

**Example 2:**
```
Input: candidates = [2,5,2,1,2], target = 5
Output: 
[
[1,2,2],
[5]
]
```

**Constraints:**
- `1 <= candidates.length <= 100`
- `1 <= candidates[i] <= 50`
- `1 <= target <= 30`

## Concept Overview

This problem is an extension of the Combination Sum problem, but with the added complexity that each number can only be used once and the input may contain duplicates. The key insight is to sort the array first and then use backtracking to generate all possible combinations, skipping duplicate elements at the same level of recursion to avoid duplicate combinations.

## Solutions

### 1. Best Optimized Solution - Backtracking with Sorting

Sort the array first and then use backtracking to generate all possible combinations, skipping duplicate elements at the same level of recursion.

```python
def combinationSum2(candidates, target):
    # Sort the array to handle duplicates
    candidates.sort()
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
            # Skip duplicates at the same level of recursion
            if i > start and candidates[i] == candidates[i-1]:
                continue
            
            # If the current candidate is greater than the remaining sum, we can break
            # because all subsequent candidates will also be greater (since the array is sorted)
            if candidates[i] > remaining:
                break
            
            # Include the current candidate
            current.append(candidates[i])
            
            # Recursively generate combinations with the current candidate included
            # Note that we pass i+1 because each number can only be used once
            backtrack(i + 1, current, remaining - candidates[i])
            
            # Exclude the current candidate (backtrack)
            current.pop()
    
    backtrack(0, [], target)
    return result
```

**Time Complexity:** O(2^n) where n is the number of candidates. In the worst case, we may need to explore all possible combinations, which is 2^n. The sorting step takes O(n log n) time, which is dominated by the backtracking step.
**Space Complexity:** O(n) for the recursion stack and to store each combination.

### 2. Alternative Solution - Iterative

Use an iterative approach to generate all possible combinations, handling duplicates by keeping track of the starting index for each new element.

```python
def combinationSum2(candidates, target):
    # Sort the array to handle duplicates
    candidates.sort()
    result = []
    
    def dfs(start, path, remaining):
        if remaining == 0:
            result.append(path)
            return
        
        for i in range(start, len(candidates)):
            # Skip duplicates at the same level of recursion
            if i > start and candidates[i] == candidates[i-1]:
                continue
            
            # If the current candidate is greater than the remaining sum, we can break
            if candidates[i] > remaining:
                break
            
            # Include the current candidate and recursively generate combinations
            dfs(i + 1, path + [candidates[i]], remaining - candidates[i])
    
    dfs(0, [], target)
    return result
```

**Time Complexity:** O(2^n) where n is the number of candidates. In the worst case, we may need to explore all possible combinations, which is 2^n. The sorting step takes O(n log n) time, which is dominated by the DFS step.
**Space Complexity:** O(n) for the recursion stack and to store each combination.

### 3. Alternative Solution - Dynamic Programming

Use dynamic programming to find all combinations that sum to the target.

```python
def combinationSum2(candidates, target):
    # Sort the array to handle duplicates
    candidates.sort()
    
    # dp[i] will store all combinations that sum to i
    dp = [[] for _ in range(target + 1)]
    
    # Base case: empty combination sums to 0
    dp[0] = [[]]
    
    # For each candidate, update the dp array
    for i, candidate in enumerate(candidates):
        # Skip duplicates
        if i > 0 and candidates[i] == candidates[i-1]:
            # Only update the combinations that were added in the previous iteration
            for j in range(target, candidate - 1, -1):
                for combo in dp[j - candidate]:
                    if combo and combo[-1] == candidates[i-1]:
                        dp[j].append(combo + [candidate])
        else:
            # Update the dp array from right to left to avoid using the same element multiple times
            for j in range(target, candidate - 1, -1):
                for combo in dp[j - candidate]:
                    dp[j].append(combo + [candidate])
    
    return dp[target]
```

**Time Complexity:** O(n * target * k) where n is the number of candidates, target is the target value, and k is the average length of the combinations. This is because for each candidate and each value from 1 to target, we may need to create new combinations by appending the candidate to existing combinations.
**Space Complexity:** O(target * k) where target is the target value and k is the average length of the combinations. This is the space required to store all combinations in the dp array.

## Solution Choice and Explanation

The backtracking with sorting solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It avoids generating duplicate combinations by skipping duplicate elements at the same level of recursion.

2. **Pruning**: It prunes the search space by breaking the loop when the current candidate is greater than the remaining sum.

3. **Clarity**: It clearly expresses the recursive nature of the problem and is easy to understand.

The key insight of this approach is to sort the array first and then use backtracking to generate all possible combinations, skipping duplicate elements at the same level of recursion to avoid duplicate combinations. We use a recursive function `backtrack(start, current, remaining)` that:
1. Checks if the remaining sum is 0, in which case we've found a valid combination.
2. Tries to include each candidate in the combination, starting from the given index and skipping duplicates.
3. Recursively generates combinations with the current candidate included.
4. Excludes the current candidate (backtracking) to try other combinations.

By sorting the candidates first, we can break the loop early when the current candidate is greater than the remaining sum, which can significantly prune the search space.

For example, let's trace through the algorithm for candidates = [10, 1, 2, 7, 6, 1, 5] and target = 8:
1. Sort the candidates: [1, 1, 2, 5, 6, 7, 10]
2. Start with an empty combination: []
3. Try to include 1:
   - Current combination: [1]
   - Remaining sum: 7
   - Try to include 1:
     - Current combination: [1, 1]
     - Remaining sum: 6
     - Try to include 2:
       - Current combination: [1, 1, 2]
       - Remaining sum: 4
       - Try to include 5:
         - Current combination: [1, 1, 2, 5]
         - Remaining sum: -1
         - This is invalid, backtrack.
       - Exclude 5, backtrack.
       - Try to include 6:
         - Current combination: [1, 1, 2, 6]
         - Remaining sum: -2
         - This is invalid, backtrack.
       - Exclude 6, backtrack.
       - Try to include 7:
         - Current combination: [1, 1, 2, 7]
         - Remaining sum: -3
         - This is invalid, backtrack.
       - Exclude 7, backtrack.
       - Try to include 10:
         - Current combination: [1, 1, 2, 10]
         - Remaining sum: -6
         - This is invalid, backtrack.
       - Exclude 10, backtrack.
     - Exclude 2, backtrack.
     - Try to include 5:
       - Current combination: [1, 1, 5]
       - Remaining sum: 1
       - Try to include 6:
         - Current combination: [1, 1, 5, 6]
         - Remaining sum: -5
         - This is invalid, backtrack.
       - Exclude 6, backtrack.
       - Try to include 7:
         - Current combination: [1, 1, 5, 7]
         - Remaining sum: -6
         - This is invalid, backtrack.
       - Exclude 7, backtrack.
       - Try to include 10:
         - Current combination: [1, 1, 5, 10]
         - Remaining sum: -9
         - This is invalid, backtrack.
       - Exclude 10, backtrack.
     - Exclude 5, backtrack.
     - Try to include 6:
       - Current combination: [1, 1, 6]
       - Remaining sum: 0
       - This is a valid combination, add it to the result: [[1, 1, 6]]
       - Backtrack.
     - Exclude 6, backtrack.
     - Try to include 7:
       - Current combination: [1, 1, 7]
       - Remaining sum: -1
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10:
       - Current combination: [1, 1, 10]
       - Remaining sum: -4
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 1, backtrack.
4. Try to include the second 1:
   - This is a duplicate at the same level of recursion, so skip it.
5. Try to include 2:
   - Current combination: [2]
   - Remaining sum: 6
   - Try to include 5:
     - Current combination: [2, 5]
     - Remaining sum: 1
     - Try to include 6:
       - Current combination: [2, 5, 6]
       - Remaining sum: -5
       - This is invalid, backtrack.
     - Exclude 6, backtrack.
     - Try to include 7:
       - Current combination: [2, 5, 7]
       - Remaining sum: -6
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10:
       - Current combination: [2, 5, 10]
       - Remaining sum: -9
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 5, backtrack.
   - Try to include 6:
     - Current combination: [2, 6]
     - Remaining sum: 0
     - This is a valid combination, add it to the result: [[1, 1, 6], [2, 6]]
     - Backtrack.
   - Exclude 6, backtrack.
   - Try to include 7:
     - Current combination: [2, 7]
     - Remaining sum: -1
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
   - Try to include 10:
     - Current combination: [2, 10]
     - Remaining sum: -4
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
6. Try to include 5:
   - Current combination: [5]
   - Remaining sum: 3
   - Try to include 6:
     - Current combination: [5, 6]
     - Remaining sum: -3
     - This is invalid, backtrack.
   - Exclude 6, backtrack.
   - Try to include 7:
     - Current combination: [5, 7]
     - Remaining sum: -4
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
   - Try to include 10:
     - Current combination: [5, 10]
     - Remaining sum: -7
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
7. Try to include 6:
   - Current combination: [6]
   - Remaining sum: 2
   - Try to include 7:
     - Current combination: [6, 7]
     - Remaining sum: -5
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
   - Try to include 10:
     - Current combination: [6, 10]
     - Remaining sum: -8
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
8. Try to include 7:
   - Current combination: [7]
   - Remaining sum: 1
   - Try to include 10:
     - Current combination: [7, 10]
     - Remaining sum: -9
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
9. Try to include 10:
   - Current combination: [10]
   - Remaining sum: -2
   - This is invalid, backtrack.
10. No more elements to include, we're done.
11. Final result: [[1, 1, 6], [2, 6]]

Wait, that doesn't match the expected output. Let me trace through the algorithm again for candidates = [10, 1, 2, 7, 6, 1, 5] and target = 8:
1. Sort the candidates: [1, 1, 2, 5, 6, 7, 10]
2. Start with an empty combination: []
3. Try to include 1 (index 0):
   - Current combination: [1]
   - Remaining sum: 7
   - Try to include 1 (index 1):
     - Current combination: [1, 1]
     - Remaining sum: 6
     - Try to include 2 (index 2):
       - Current combination: [1, 1, 2]
       - Remaining sum: 4
       - Try to include 5 (index 3):
         - Current combination: [1, 1, 2, 5]
         - Remaining sum: -1
         - This is invalid, backtrack.
       - Exclude 5, backtrack.
       - Try to include 6 (index 4):
         - Current combination: [1, 1, 2, 6]
         - Remaining sum: -2
         - This is invalid, backtrack.
       - Exclude 6, backtrack.
       - Try to include 7 (index 5):
         - Current combination: [1, 1, 2, 7]
         - Remaining sum: -3
         - This is invalid, backtrack.
       - Exclude 7, backtrack.
       - Try to include 10 (index 6):
         - Current combination: [1, 1, 2, 10]
         - Remaining sum: -6
         - This is invalid, backtrack.
       - Exclude 10, backtrack.
     - Exclude 2, backtrack.
     - Try to include 5 (index 3):
       - Current combination: [1, 1, 5]
       - Remaining sum: 1
       - Try to include 6 (index 4):
         - Current combination: [1, 1, 5, 6]
         - Remaining sum: -5
         - This is invalid, backtrack.
       - Exclude 6, backtrack.
       - Try to include 7 (index 5):
         - Current combination: [1, 1, 5, 7]
         - Remaining sum: -6
         - This is invalid, backtrack.
       - Exclude 7, backtrack.
       - Try to include 10 (index 6):
         - Current combination: [1, 1, 5, 10]
         - Remaining sum: -9
         - This is invalid, backtrack.
       - Exclude 10, backtrack.
     - Exclude 5, backtrack.
     - Try to include 6 (index 4):
       - Current combination: [1, 1, 6]
       - Remaining sum: 0
       - This is a valid combination, add it to the result: [[1, 1, 6]]
       - Backtrack.
     - Exclude 6, backtrack.
     - Try to include 7 (index 5):
       - Current combination: [1, 1, 7]
       - Remaining sum: -1
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10 (index 6):
       - Current combination: [1, 1, 10]
       - Remaining sum: -4
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 1, backtrack.
   - Try to include 2 (index 2):
     - Current combination: [1, 2]
     - Remaining sum: 5
     - Try to include 5 (index 3):
       - Current combination: [1, 2, 5]
       - Remaining sum: 0
       - This is a valid combination, add it to the result: [[1, 1, 6], [1, 2, 5]]
       - Backtrack.
     - Exclude 5, backtrack.
     - Try to include 6 (index 4):
       - Current combination: [1, 2, 6]
       - Remaining sum: -1
       - This is invalid, backtrack.
     - Exclude 6, backtrack.
     - Try to include 7 (index 5):
       - Current combination: [1, 2, 7]
       - Remaining sum: -2
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10 (index 6):
       - Current combination: [1, 2, 10]
       - Remaining sum: -5
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 2, backtrack.
   - Try to include 5 (index 3):
     - Current combination: [1, 5]
     - Remaining sum: 2
     - Try to include 6 (index 4):
       - Current combination: [1, 5, 6]
       - Remaining sum: -4
       - This is invalid, backtrack.
     - Exclude 6, backtrack.
     - Try to include 7 (index 5):
       - Current combination: [1, 5, 7]
       - Remaining sum: -5
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10 (index 6):
       - Current combination: [1, 5, 10]
       - Remaining sum: -8
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 5, backtrack.
   - Try to include 6 (index 4):
     - Current combination: [1, 6]
     - Remaining sum: 1
     - Try to include 7 (index 5):
       - Current combination: [1, 6, 7]
       - Remaining sum: -6
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10 (index 6):
       - Current combination: [1, 6, 10]
       - Remaining sum: -9
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 6, backtrack.
   - Try to include 7 (index 5):
     - Current combination: [1, 7]
     - Remaining sum: 0
     - This is a valid combination, add it to the result: [[1, 1, 6], [1, 2, 5], [1, 7]]
     - Backtrack.
   - Exclude 7, backtrack.
   - Try to include 10 (index 6):
     - Current combination: [1, 10]
     - Remaining sum: -3
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
4. Try to include the second 1 (index 1):
   - This is a duplicate at the same level of recursion, so skip it.
5. Try to include 2 (index 2):
   - Current combination: [2]
   - Remaining sum: 6
   - Try to include 5 (index 3):
     - Current combination: [2, 5]
     - Remaining sum: 1
     - Try to include 6 (index 4):
       - Current combination: [2, 5, 6]
       - Remaining sum: -5
       - This is invalid, backtrack.
     - Exclude 6, backtrack.
     - Try to include 7 (index 5):
       - Current combination: [2, 5, 7]
       - Remaining sum: -6
       - This is invalid, backtrack.
     - Exclude 7, backtrack.
     - Try to include 10 (index 6):
       - Current combination: [2, 5, 10]
       - Remaining sum: -9
       - This is invalid, backtrack.
     - Exclude 10, backtrack.
   - Exclude 5, backtrack.
   - Try to include 6 (index 4):
     - Current combination: [2, 6]
     - Remaining sum: 0
     - This is a valid combination, add it to the result: [[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]
     - Backtrack.
   - Exclude 6, backtrack.
   - Try to include 7 (index 5):
     - Current combination: [2, 7]
     - Remaining sum: -1
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
   - Try to include 10 (index 6):
     - Current combination: [2, 10]
     - Remaining sum: -4
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
6. Try to include 5 (index 3):
   - Current combination: [5]
   - Remaining sum: 3
   - Try to include 6 (index 4):
     - Current combination: [5, 6]
     - Remaining sum: -3
     - This is invalid, backtrack.
   - Exclude 6, backtrack.
   - Try to include 7 (index 5):
     - Current combination: [5, 7]
     - Remaining sum: -4
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
   - Try to include 10 (index 6):
     - Current combination: [5, 10]
     - Remaining sum: -7
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
7. Try to include 6 (index 4):
   - Current combination: [6]
   - Remaining sum: 2
   - Try to include 7 (index 5):
     - Current combination: [6, 7]
     - Remaining sum: -5
     - This is invalid, backtrack.
   - Exclude 7, backtrack.
   - Try to include 10 (index 6):
     - Current combination: [6, 10]
     - Remaining sum: -8
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
8. Try to include 7 (index 5):
   - Current combination: [7]
   - Remaining sum: 1
   - Try to include 10 (index 6):
     - Current combination: [7, 10]
     - Remaining sum: -9
     - This is invalid, backtrack.
   - Exclude 10, backtrack.
9. Try to include 10 (index 6):
   - Current combination: [10]
   - Remaining sum: -2
   - This is invalid, backtrack.
10. No more elements to include, we're done.
11. Final result: [[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]

That matches the expected output.

The iterative solution (Solution 2) is also efficient but less intuitive. The dynamic programming solution (Solution 3) is more complex and uses more space.

In an interview, I would first mention the backtracking with sorting solution as the most efficient approach for this problem, and then mention the iterative and dynamic programming solutions as alternatives if asked for different approaches.
