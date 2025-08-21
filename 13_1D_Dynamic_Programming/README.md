# 13. 1D Dynamic Programming

## Concept Overview

Dynamic Programming (DP) is a technique for solving problems by breaking them down into simpler subproblems. It is applicable when the problem has overlapping subproblems and optimal substructure. 1D Dynamic Programming specifically refers to problems where the state can be represented using a single parameter or a one-dimensional array.

### Key Concepts
- **Overlapping Subproblems**: The problem can be broken down into subproblems which are reused multiple times.
- **Optimal Substructure**: The optimal solution to the problem can be constructed from optimal solutions of its subproblems.
- **Memoization**: A top-down approach where we store the results of subproblems in a table (usually an array or a dictionary) to avoid redundant calculations.
- **Tabulation**: A bottom-up approach where we build a table from the bottom up, solving smaller subproblems first and using their solutions to solve larger ones.
- **State**: The set of parameters that uniquely identify a subproblem.
- **Transition**: The process of moving from one state to another, which represents how the solution to a subproblem is calculated from the solutions to smaller subproblems.
- **Base Case**: The simplest subproblem that can be solved directly without breaking it down further.

### Common Patterns
- **Linear DP**: Problems where the state depends on a single parameter, often an index or a position.
- **Fibonacci-like Problems**: Problems where the solution at each step depends on the solutions at one or more previous steps.
- **Kadane's Algorithm**: A technique for finding the maximum subarray sum in a one-dimensional array.
- **Coin Change and Knapsack Problems**: Problems involving selecting items to maximize or minimize a value, subject to constraints.
- **Longest Increasing Subsequence (LIS)**: Finding the length of the longest subsequence of a given sequence such that all elements of the subsequence are sorted in increasing order.

### Common Applications
- **Optimization Problems**: Finding the maximum or minimum value of a function.
- **Counting Problems**: Counting the number of ways to achieve a certain state.
- **Decision Problems**: Determining if a certain state is achievable.
- **Path Finding Problems**: Finding the optimal path in a graph or grid.
- **Resource Allocation Problems**: Allocating resources to maximize or minimize a value.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Climbing Stairs | Easy | [Solution](./Climbing_Stairs.md) |
| 2 | Min Cost Climbing Stairs | Easy | [Solution](./Min_Cost_Climbing_Stairs.md) |
| 3 | House Robber | Medium | [Solution](./House_Robber.md) |
| 4 | House Robber II | Medium | [Solution](./House_Robber_II.md) |
| 5 | Longest Palindromic Substring | Medium | [Solution](./Longest_Palindromic_Substring.md) |
| 6 | Palindromic Substrings | Medium | [Solution](./Palindromic_Substrings.md) |
| 7 | Decode Ways | Medium | [Solution](./Decode_Ways.md) |
| 8 | Coin Change | Medium | [Solution](./Coin_Change.md) |
| 9 | Maximum Product Subarray | Medium | [Solution](./Maximum_Product_Subarray.md) |
| 10 | Word Break | Medium | [Solution](./Word_Break.md) |
| 11 | Longest Increasing Subsequence | Medium | [Solution](./Longest_Increasing_Subsequence.md) |
| 12 | Partition Equal Subset Sum | Medium | [Solution](./Partition_Equal_Subset_Sum.md) |
