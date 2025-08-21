# 05. Binary Search

## Concept Overview

Binary search is a divide-and-conquer algorithm that efficiently finds the position of a target value within a sorted array. The algorithm works by repeatedly dividing the search interval in half until the target is found or the interval is empty.

### Key Concepts
- **Sorted Data**: Binary search requires the data to be sorted
- **Divide and Conquer**: The search space is halved in each step
- **Time Complexity**: O(log n) - significantly faster than linear search for large datasets
- **Space Complexity**: O(1) for iterative implementation, O(log n) for recursive implementation due to the call stack

### Common Applications
- Finding an element in a sorted array
- Finding the insertion position for a new element in a sorted array
- Searching in rotated sorted arrays
- Finding the boundary in a boolean array (first true or last false)
- Optimizing solutions for problems with a monotonic property

### Binary Search Template
```python
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    
    while left <= right:
        mid = left + (right - left) // 2  # Avoid integer overflow
        
        if arr[mid] == target:
            return mid  # Target found
        elif arr[mid] < target:
            left = mid + 1  # Search in the right half
        else:
            right = mid - 1  # Search in the left half
    
    return -1  # Target not found
```

### Variations
- **Lower Bound**: Find the first element greater than or equal to the target
- **Upper Bound**: Find the first element greater than the target
- **Binary Search on Answer**: When the answer itself has a monotonic property

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Binary Search | Easy | [Solution](./01_Binary_Search.md) |
| 2 | Search Insert Position | Easy | [Solution](./02_Search_Insert_Position.md) |
| 3 | Guess Number Higher Or Lower | Easy | [Solution](./03_Guess_Number_Higher_Or_Lower.md) |
| 4 | Sqrt(x) | Easy | [Solution](./04_Sqrt.md) |
| 5 | Search a 2D Matrix | Medium | [Solution](./05_Search_a_2D_Matrix.md) |
| 6 | Koko Eating Bananas | Medium | [Solution](./06_Koko_Eating_Bananas.md) |
| 7 | Capacity to Ship Packages Within D Days | Medium | [Solution](./07_Capacity_to_Ship_Packages_Within_D_Days.md) |
| 8 | Find Minimum In Rotated Sorted Array | Medium | [Solution](./08_Find_Minimum_In_Rotated_Sorted_Array.md) |
| 9 | Search In Rotated Sorted Array | Medium | [Solution](./09_Search_In_Rotated_Sorted_Array.md) |
| 10 | Search In Rotated Sorted Array II | Medium | [Solution](./10_Search_In_Rotated_Sorted_Array_II.md) |
| 11 | Time Based Key Value Store | Medium | [Solution](./11_Time_Based_Key_Value_Store.md) |
| 12 | Split Array Largest Sum | Hard | [Solution](./12_Split_Array_Largest_Sum.md) |
| 13 | Median of Two Sorted Arrays | Hard | [Solution](./13_Median_of_Two_Sorted_Arrays.md) |
| 14 | Find in Mountain Array | Hard | [Solution](./14_Find_in_Mountain_Array.md) |
