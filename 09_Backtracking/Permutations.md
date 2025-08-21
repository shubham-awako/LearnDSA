# Permutations

## Problem Statement

Given an array `nums` of distinct integers, return all the possible permutations. You can return the answer in any order.

**Example 1:**
```
Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
```

**Example 2:**
```
Input: nums = [0,1]
Output: [[0,1],[1,0]]
```

**Example 3:**
```
Input: nums = [1]
Output: [[1]]
```

**Constraints:**
- `1 <= nums.length <= 6`
- `-10 <= nums[i] <= 10`
- All the integers of `nums` are unique.

## Concept Overview

This problem tests your understanding of backtracking and generating all possible permutations. The key insight is to use a recursive approach to build all possible permutations by trying each unused element at each position.

## Solutions

### 1. Best Optimized Solution - Backtracking

Use backtracking to generate all possible permutations.

```python
def permute(nums):
    result = []
    
    def backtrack(current, remaining):
        # If there are no remaining elements, we've found a valid permutation
        if not remaining:
            result.append(current[:])
            return
        
        # Try each remaining element as the next element in the permutation
        for i in range(len(remaining)):
            # Include the current element
            current.append(remaining[i])
            
            # Recursively generate permutations with the current element included
            backtrack(current, remaining[:i] + remaining[i+1:])
            
            # Exclude the current element (backtrack)
            current.pop()
    
    backtrack([], nums)
    return result
```

**Time Complexity:** O(n * n!) where n is the length of the input array. This is because there are n! permutations, and it takes O(n) time to copy each permutation.
**Space Complexity:** O(n) for the recursion stack and to store each permutation.

### 2. Alternative Solution - Backtracking with Swap

Use backtracking with swapping to generate all possible permutations.

```python
def permute(nums):
    result = []
    
    def backtrack(start):
        # If we've reached the end of the array, we've found a valid permutation
        if start == len(nums):
            result.append(nums[:])
            return
        
        # Try each element as the next element in the permutation
        for i in range(start, len(nums)):
            # Swap the current element with the element at the start position
            nums[start], nums[i] = nums[i], nums[start]
            
            # Recursively generate permutations with the current element fixed
            backtrack(start + 1)
            
            # Swap back (backtrack)
            nums[start], nums[i] = nums[i], nums[start]
    
    backtrack(0)
    return result
```

**Time Complexity:** O(n * n!) where n is the length of the input array. This is because there are n! permutations, and it takes O(n) time to copy each permutation.
**Space Complexity:** O(n) for the recursion stack and to store each permutation.

### 3. Alternative Solution - Iterative

Use an iterative approach to generate all possible permutations.

```python
def permute(nums):
    # Start with an empty permutation
    result = [[]]
    
    for num in nums:
        new_result = []
        
        # For each existing permutation, insert the current number at each possible position
        for perm in result:
            for i in range(len(perm) + 1):
                # Insert the current number at position i
                new_perm = perm[:i] + [num] + perm[i:]
                new_result.append(new_perm)
        
        result = new_result
    
    return result
```

**Time Complexity:** O(n * n!) where n is the length of the input array. This is because there are n! permutations, and it takes O(n) time to copy each permutation.
**Space Complexity:** O(n * n!) to store all permutations.

## Solution Choice and Explanation

The backtracking with swap solution (Solution 2) is the best approach for this problem because:

1. **Efficiency**: It avoids creating new arrays for the remaining elements in each recursive call, which makes it more efficient than the basic backtracking solution.

2. **Clarity**: It clearly expresses the recursive nature of the problem and is easy to understand.

3. **Space Efficiency**: It uses less space than the iterative solution because it only keeps track of the current permutation during the recursion.

The key insight of this approach is to use backtracking with swapping to generate all possible permutations. We use a recursive function `backtrack(start)` that:
1. Checks if we've reached the end of the array, in which case we've found a valid permutation.
2. Tries each element as the next element in the permutation by swapping it with the element at the start position.
3. Recursively generates permutations with the current element fixed.
4. Swaps back (backtracking) to try other permutations.

For example, let's trace through the algorithm for nums = [1, 2, 3]:
1. Start with nums = [1, 2, 3]
2. Call backtrack(0)
   - Try 1 at position 0: Swap 1 and 1, nums = [1, 2, 3]
     - Call backtrack(1)
       - Try 2 at position 1: Swap 2 and 2, nums = [1, 2, 3]
         - Call backtrack(2)
           - Try 3 at position 2: Swap 3 and 3, nums = [1, 2, 3]
             - Call backtrack(3)
               - We've reached the end of the array, so add [1, 2, 3] to the result.
             - Swap back 3 and 3, nums = [1, 2, 3]
         - Swap back 2 and 2, nums = [1, 2, 3]
       - Try 3 at position 1: Swap 2 and 3, nums = [1, 3, 2]
         - Call backtrack(2)
           - Try 2 at position 2: Swap 2 and 2, nums = [1, 3, 2]
             - Call backtrack(3)
               - We've reached the end of the array, so add [1, 3, 2] to the result.
             - Swap back 2 and 2, nums = [1, 3, 2]
         - Swap back 2 and 3, nums = [1, 2, 3]
     - Swap back 1 and 1, nums = [1, 2, 3]
   - Try 2 at position 0: Swap 1 and 2, nums = [2, 1, 3]
     - Call backtrack(1)
       - Try 1 at position 1: Swap 1 and 1, nums = [2, 1, 3]
         - Call backtrack(2)
           - Try 3 at position 2: Swap 3 and 3, nums = [2, 1, 3]
             - Call backtrack(3)
               - We've reached the end of the array, so add [2, 1, 3] to the result.
             - Swap back 3 and 3, nums = [2, 1, 3]
         - Swap back 1 and 1, nums = [2, 1, 3]
       - Try 3 at position 1: Swap 1 and 3, nums = [2, 3, 1]
         - Call backtrack(2)
           - Try 1 at position 2: Swap 1 and 1, nums = [2, 3, 1]
             - Call backtrack(3)
               - We've reached the end of the array, so add [2, 3, 1] to the result.
             - Swap back 1 and 1, nums = [2, 3, 1]
         - Swap back 1 and 3, nums = [2, 1, 3]
     - Swap back 1 and 2, nums = [1, 2, 3]
   - Try 3 at position 0: Swap 1 and 3, nums = [3, 2, 1]
     - Call backtrack(1)
       - Try 2 at position 1: Swap 2 and 2, nums = [3, 2, 1]
         - Call backtrack(2)
           - Try 1 at position 2: Swap 1 and 1, nums = [3, 2, 1]
             - Call backtrack(3)
               - We've reached the end of the array, so add [3, 2, 1] to the result.
             - Swap back 1 and 1, nums = [3, 2, 1]
         - Swap back 2 and 2, nums = [3, 2, 1]
       - Try 1 at position 1: Swap 2 and 1, nums = [3, 1, 2]
         - Call backtrack(2)
           - Try 2 at position 2: Swap 2 and 2, nums = [3, 1, 2]
             - Call backtrack(3)
               - We've reached the end of the array, so add [3, 1, 2] to the result.
             - Swap back 2 and 2, nums = [3, 1, 2]
         - Swap back 2 and 1, nums = [3, 2, 1]
     - Swap back 1 and 3, nums = [1, 2, 3]
3. Final result: [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]

The basic backtracking solution (Solution 1) is also efficient but creates new arrays for the remaining elements in each recursive call. The iterative solution (Solution 3) is less intuitive and uses more space.

In an interview, I would first mention the backtracking with swap solution as the most efficient approach for this problem, and then mention the basic backtracking and iterative solutions as alternatives if asked for different approaches.
