# 09. Backtracking

## Concept Overview

Backtracking is an algorithmic technique for solving problems recursively by trying to build a solution incrementally, one piece at a time, removing those solutions that fail to satisfy the constraints of the problem at any point of time (by time, here, is referred to the time elapsed till reaching any level of the search tree).

### Key Concepts
- **State Space Tree**: A tree representing all possible states of the problem.
- **Depth-First Search (DFS)**: Backtracking typically uses DFS to explore the state space tree.
- **Pruning**: The process of eliminating branches of the state space tree that cannot lead to a valid solution.
- **Constraint Satisfaction**: Ensuring that the current partial solution satisfies all constraints of the problem.
- **Candidate Solution**: A potential solution that may or may not be complete.
- **Complete Solution**: A candidate solution that satisfies all constraints and is a valid solution to the problem.

### Common Techniques
- **Decision Tree**: Visualizing the problem as a tree where each node represents a decision.
- **Recursive DFS**: Using recursion to explore the state space tree in a depth-first manner.
- **Constraint Propagation**: Using constraints to reduce the search space.
- **Pruning**: Eliminating branches of the state space tree that cannot lead to a valid solution.
- **Memoization**: Storing the results of already solved subproblems to avoid redundant computation.

### Common Applications
- **Combinatorial Problems**: Generating all possible combinations or permutations.
- **Constraint Satisfaction Problems**: Solving problems with specific constraints, like Sudoku or N-Queens.
- **Path Finding**: Finding paths in a graph or maze.
- **Optimization Problems**: Finding the optimal solution among many possible solutions.

### Advantages
- **Complete Search**: Backtracking ensures that all possible solutions are explored.
- **Memory Efficiency**: Only the current path is stored, not the entire state space.
- **Pruning**: Eliminating branches that cannot lead to a valid solution reduces the search space.

### Disadvantages
- **Exponential Time Complexity**: In the worst case, backtracking may explore the entire state space, which can be exponential.
- **Not Always Optimal**: Backtracking finds a valid solution, not necessarily the optimal one (unless the problem is designed to find the optimal solution).

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Subsets | Medium | [Solution](./01_Subsets.md) |
| 2 | Combination Sum | Medium | [Solution](./02_Combination_Sum.md) |
| 3 | Permutations | Medium | [Solution](./03_Permutations.md) |
| 4 | Subsets II | Medium | [Solution](./04_Subsets_II.md) |
| 5 | Combination Sum II | Medium | [Solution](./05_Combination_Sum_II.md) |
| 6 | Word Search | Medium | [Solution](./06_Word_Search.md) |
| 7 | Palindrome Partitioning | Medium | [Solution](./07_Palindrome_Partitioning.md) |
| 8 | Letter Combinations of a Phone Number | Medium | [Solution](./08_Letter_Combinations_of_a_Phone_Number.md) |
| 9 | N-Queens | Hard | [Solution](./09_N_Queens.md) |
