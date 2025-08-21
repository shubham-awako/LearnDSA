# 03. Sliding Window

## Concept Overview

The Sliding Window technique is a computational pattern that aims to reduce the use of nested loops in algorithms. It's particularly useful for problems that involve arrays or strings where we need to find a subarray or substring that satisfies certain conditions.

### Key Concepts
- **Fixed-Size Window**: The window size remains constant throughout the algorithm
- **Variable-Size Window**: The window size can grow or shrink based on certain conditions
- **Window Boundaries**: Defined by two pointers (start and end)
- **Window State**: Information about the current window (e.g., sum, frequency of elements)

### Common Applications
- Finding subarrays/substrings of a specific length that satisfy certain conditions
- Finding the longest/shortest subarray/substring that satisfies certain conditions
- Calculating maximum/minimum sum of a subarray of a specific length
- Finding anagrams or permutations in a string

### Advantages
- Reduces time complexity from O(n²) to O(n) for many problems
- Avoids redundant calculations by reusing the result from the previous window
- Efficiently processes large datasets with minimal space overhead

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Contains Duplicate II | Easy | [Solution](./Contains_Duplicate_II.md) |
| 2 | Best Time to Buy And Sell Stock | Easy | [Solution](./Best_Time_to_Buy_And_Sell_Stock.md) |
| 3 | Longest Substring Without Repeating Characters | Medium | [Solution](./Longest_Substring_Without_Repeating_Characters.md) |
| 4 | Longest Repeating Character Replacement | Medium | [Solution](./Longest_Repeating_Character_Replacement.md) |
| 5 | Permutation In String | Medium | [Solution](./Permutation_In_String.md) |
| 6 | Minimum Size Subarray Sum | Medium | [Solution](./Minimum_Size_Subarray_Sum.md) |
| 7 | Find K Closest Elements | Medium | [Solution](./Find_K_Closest_Elements.md) |
| 8 | Minimum Window Substring | Hard | [Solution](./Minimum_Window_Substring.md) |
| 9 | Sliding Window Maximum | Hard | [Solution](./Sliding_Window_Maximum.md) |
