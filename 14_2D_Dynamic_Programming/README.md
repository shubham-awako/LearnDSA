# 14. 2D Dynamic Programming

## Concept Overview

2D Dynamic Programming extends the concept of 1D Dynamic Programming to problems that require a two-dimensional state. In these problems, the optimal solution depends on two parameters or dimensions, and we use a 2D table to store and compute the results of subproblems.

### Key Concepts
- **2D State**: The state in 2D DP is represented by two parameters, often corresponding to two different aspects of the problem.
- **2D DP Table**: A two-dimensional array used to store the results of subproblems, where each cell (i, j) represents the solution to a specific subproblem.
- **State Transitions**: The rules that define how to compute the value of a cell in the DP table based on the values of other cells.
- **Base Cases**: The initial values in the DP table that are known without computation.
- **Optimal Substructure**: The property that the optimal solution to the problem can be constructed from optimal solutions to its subproblems.
- **Overlapping Subproblems**: The property that the same subproblems are solved multiple times, making memoization or tabulation beneficial.

### Common Patterns
- **Grid Problems**: Problems involving a 2D grid where the state is often represented by the coordinates (i, j).
- **String Matching and Editing**: Problems involving operations on two strings, where the state is often represented by the indices of the two strings.
- **Knapsack Variations**: Problems involving selecting items with multiple constraints, where the state is often represented by the item index and the remaining capacity.
- **Interval Problems**: Problems involving intervals, where the state is often represented by the start and end indices of the interval.
- **Game Theory**: Problems involving two players taking turns, where the state is often represented by the game state and the player's turn.

### Common Applications
- **Longest Common Subsequence**: Finding the longest subsequence common to two sequences.
- **Edit Distance**: Finding the minimum number of operations required to transform one string into another.
- **Matrix Chain Multiplication**: Finding the most efficient way to multiply a chain of matrices.
- **Optimal Binary Search Tree**: Constructing a binary search tree with the minimum expected search cost.
- **Traveling Salesman Problem**: Finding the shortest possible route that visits each city exactly once and returns to the origin city.
- **Knapsack Problem with Multiple Constraints**: Selecting items to maximize value subject to multiple constraints.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Unique Paths | Medium | [Solution](./Unique_Paths.md) |
| 2 | Longest Common Subsequence | Medium | [Solution](./Longest_Common_Subsequence.md) |
| 3 | Best Time to Buy and Sell Stock with Cooldown | Medium | [Solution](./Best_Time_to_Buy_and_Sell_Stock_with_Cooldown.md) |
| 4 | Coin Change II | Medium | [Solution](./Coin_Change_II.md) |
| 5 | Target Sum | Medium | [Solution](./Target_Sum.md) |
| 6 | Interleaving String | Medium | [Solution](./Interleaving_String.md) |
| 7 | Longest Increasing Path in a Matrix | Hard | [Solution](./Longest_Increasing_Path_in_a_Matrix.md) |
| 8 | Distinct Subsequences | Hard | [Solution](./Distinct_Subsequences.md) |
| 9 | Edit Distance | Hard | [Solution](./Edit_Distance.md) |
| 10 | Burst Balloons | Hard | [Solution](./Burst_Balloons.md) |
| 11 | Regular Expression Matching | Hard | [Solution](./Regular_Expression_Matching.md) |
