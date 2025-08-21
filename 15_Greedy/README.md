# 15. Greedy

## Concept Overview

Greedy algorithms build up a solution piece by piece, always choosing the next piece that offers the most immediate benefit. This approach works well for optimization problems where local optimal choices lead to a global optimal solution.

### Key Characteristics
- Makes locally optimal choices at each step
- Never reconsiders previous choices
- Simple and efficient implementation
- Often used for optimization problems

### When to Use Greedy Algorithms
- When the problem has "optimal substructure" (optimal solution contains optimal solutions to subproblems)
- When the problem has the "greedy choice property" (locally optimal choices lead to a globally optimal solution)
- When you need an approximate solution to an NP-hard problem

### Common Greedy Techniques
- Sorting input data to create order
- Selecting the best option at each step
- Using priority queues to efficiently find the next best choice
- Maintaining running totals or counters

### Advantages
- Simple to implement
- Usually efficient (often O(n log n) due to sorting)
- Works well for many optimization problems

### Disadvantages
- Doesn't always yield the optimal solution
- Can be difficult to prove correctness
- May require insight to recognize when a greedy approach will work

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Maximum Subarray | Medium | [Solution](./01_Maximum_Subarray.md) |
| 2 | Jump Game | Medium | [Solution](./02_Jump_Game.md) |
| 3 | Jump Game II | Medium | [Solution](./03_Jump_Game_II.md) |
| 4 | Gas Station | Medium | [Solution](./04_Gas_Station.md) |
| 5 | Hand of Straights | Medium | [Solution](./05_Hand_of_Straights.md) |
| 6 | Merge Triplets to Form Target Triplet | Medium | [Solution](./06_Merge_Triplets_to_Form_Target_Triplet.md) |
| 7 | Partition Labels | Medium | [Solution](./07_Partition_Labels.md) |
| 8 | Valid Parenthesis String | Medium | [Solution](./08_Valid_Parenthesis_String.md) |