# Sort an Array

## Problem Statement

Given an array of integers `nums`, sort the array in ascending order and return it.

You must solve it without using any built-in functions in O(n log n) time complexity and with the smallest space complexity possible.

**Example 1:**
```
Input: nums = [5,2,3,1]
Output: [1,2,3,5]
Explanation: After sorting the array, the positions of some numbers are not changed (for example, 2 and 3), while the positions of other numbers are changed (for example, 1 and 5).
```

**Example 2:**
```
Input: nums = [5,1,1,2,0,0]
Output: [0,0,1,1,2,5]
Explanation: Note that the values of nums are not necessairly unique.
```

**Constraints:**
- `1 <= nums.length <= 5 * 10^4`
- `-5 * 10^4 <= nums[i] <= 5 * 10^4`

## Concept Overview

This problem tests your understanding of sorting algorithms. The key requirement is to implement a sorting algorithm with O(n log n) time complexity without using built-in functions.

## Solutions

### 1. Brute Force Approach - Bubble Sort

Repeatedly step through the list, compare adjacent elements, and swap them if they are in the wrong order.

```python
def sortArray(nums):
    n = len(nums)
    for i in range(n):
        for j in range(0, n - i - 1):
            if nums[j] > nums[j + 1]:
                nums[j], nums[j + 1] = nums[j + 1], nums[j]
    return nums
```

**Time Complexity:** O(n²) - Not optimal for this problem.
**Space Complexity:** O(1) - In-place sorting.

### 2. Improved Solution - Merge Sort

Divide the array into two halves, sort each half, and then merge them.

```python
def sortArray(nums):
    if len(nums) <= 1:
        return nums
    
    # Divide the array into two halves
    mid = len(nums) // 2
    left = sortArray(nums[:mid])
    right = sortArray(nums[mid:])
    
    # Merge the sorted halves
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    
    # Merge elements in sorted order
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    
    # Add remaining elements
    result.extend(left[i:])
    result.extend(right[j:])
    
    return result
```

**Time Complexity:** O(n log n) - Optimal for comparison-based sorting.
**Space Complexity:** O(n) - Additional space for the merged arrays.

### 3. Best Optimized Solution - Quick Sort

Choose a pivot element and partition the array around it, then recursively sort the subarrays.

```python
def sortArray(nums):
    if len(nums) <= 1:
        return nums
    
    return quickSort(nums, 0, len(nums) - 1)

def quickSort(nums, low, high):
    if low < high:
        # Partition the array and get the pivot index
        pivot_index = partition(nums, low, high)
        
        # Recursively sort the subarrays
        quickSort(nums, low, pivot_index - 1)
        quickSort(nums, pivot_index + 1, high)
    
    return nums

def partition(nums, low, high):
    # Choose the rightmost element as pivot
    pivot = nums[high]
    
    # Index of smaller element
    i = low - 1
    
    for j in range(low, high):
        # If current element is smaller than or equal to pivot
        if nums[j] <= pivot:
            i += 1
            nums[i], nums[j] = nums[j], nums[i]
    
    # Place pivot in its correct position
    nums[i + 1], nums[high] = nums[high], nums[i + 1]
    
    return i + 1
```

**Time Complexity:** 
- Average case: O(n log n)
- Worst case: O(n²) - This occurs when the pivot is always the smallest or largest element.

**Space Complexity:** 
- Average case: O(log n) - Stack space for recursion.
- Worst case: O(n) - When the recursion depth is n.

### 4. Alternative Solution - Heap Sort

Build a max heap from the array, then repeatedly extract the maximum element and rebuild the heap.

```python
def sortArray(nums):
    n = len(nums)
    
    # Build a max heap
    for i in range(n // 2 - 1, -1, -1):
        heapify(nums, n, i)
    
    # Extract elements from the heap one by one
    for i in range(n - 1, 0, -1):
        nums[0], nums[i] = nums[i], nums[0]  # Swap
        heapify(nums, i, 0)
    
    return nums

def heapify(nums, n, i):
    largest = i
    left = 2 * i + 1
    right = 2 * i + 2
    
    # Check if left child exists and is greater than root
    if left < n and nums[left] > nums[largest]:
        largest = left
    
    # Check if right child exists and is greater than largest so far
    if right < n and nums[right] > nums[largest]:
        largest = right
    
    # Change root if needed
    if largest != i:
        nums[i], nums[largest] = nums[largest], nums[i]  # Swap
        heapify(nums, n, largest)  # Heapify the affected subtree
```

**Time Complexity:** O(n log n) - Building the heap takes O(n) time, and extracting each element takes O(log n) time.
**Space Complexity:** O(1) - In-place sorting.

## Solution Choice and Explanation

For this problem, the best solution depends on the specific requirements and constraints:

1. **If space complexity is the highest priority**: Heap Sort (Solution 4) is the best choice as it sorts in-place with O(1) extra space while maintaining O(n log n) time complexity.

2. **If average-case performance and simplicity are priorities**: Quick Sort (Solution 3) is a good choice with O(n log n) average-case time complexity and O(log n) space complexity for recursion stack.

3. **If worst-case performance guarantee is needed**: Merge Sort (Solution 2) is the best choice with guaranteed O(n log n) time complexity, though it requires O(n) extra space.

Given the problem's requirement of O(n log n) time complexity and the smallest possible space complexity, Heap Sort is the optimal solution. It achieves O(n log n) time complexity in all cases and uses O(1) extra space.

Quick Sort is also a strong contender, especially with optimizations like choosing a good pivot (e.g., median-of-three) to avoid the worst-case scenario. However, its worst-case space complexity is O(n) due to recursion.

Bubble Sort is not suitable for this problem as it has O(n²) time complexity, which doesn't meet the requirement.

In an interview, I would discuss the trade-offs between these sorting algorithms and implement Heap Sort as the solution that best meets the given constraints.
