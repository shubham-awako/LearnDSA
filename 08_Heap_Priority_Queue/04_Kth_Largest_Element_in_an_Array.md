# Kth Largest Element in an Array

## Problem Statement

Given an integer array `nums` and an integer `k`, return the `kth` largest element in the array.

Note that it is the `kth` largest element in the sorted order, not the `kth` distinct element.

You must solve it in O(n) time complexity.

**Example 1:**
```
Input: nums = [3,2,1,5,6,4], k = 2
Output: 5
```

**Example 2:**
```
Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
Output: 4
```

**Constraints:**
- `1 <= k <= nums.length <= 10^5`
- `-10^4 <= nums[i] <= 10^4`

## Concept Overview

This problem tests your understanding of heaps, priority queues, and the quick select algorithm. The key insight is to use a min-heap of size k or the quick select algorithm to efficiently find the kth largest element in the array.

## Solutions

### 1. Heap Solution - Min-Heap of Size K

Use a min-heap of size k to keep track of the k largest elements in the array.

```python
import heapq

def findKthLargest(nums, k):
    # Use a min-heap of size k to keep track of the k largest elements
    min_heap = []
    
    for num in nums:
        # If the heap has fewer than k elements, add the new element
        if len(min_heap) < k:
            heapq.heappush(min_heap, num)
        # If the new element is larger than the smallest element in the heap, replace it
        elif num > min_heap[0]:
            heapq.heappushpop(min_heap, num)
    
    # The smallest element in the heap is the kth largest element
    return min_heap[0]
```

**Time Complexity:** O(n log k) - We process n elements, and each heap operation takes O(log k) time.
**Space Complexity:** O(k) - We store at most k elements in the heap.

### 2. Best Optimized Solution - Quick Select

Use the quick select algorithm to find the kth largest element in the array.

```python
import random

def findKthLargest(nums, k):
    # Convert the problem to finding the (n-k+1)th smallest element
    k = len(nums) - k
    
    def partition(left, right, pivot_index):
        pivot = nums[pivot_index]
        # Move the pivot to the end
        nums[pivot_index], nums[right] = nums[right], nums[pivot_index]
        
        # Move all elements smaller than the pivot to the left
        store_index = left
        for i in range(left, right):
            if nums[i] <= pivot:
                nums[i], nums[store_index] = nums[store_index], nums[i]
                store_index += 1
        
        # Move the pivot to its final place
        nums[store_index], nums[right] = nums[right], nums[store_index]
        
        return store_index
    
    def quick_select(left, right):
        if left == right:
            return nums[left]
        
        # Choose a random pivot
        pivot_index = random.randint(left, right)
        
        # Partition the array around the pivot
        pivot_index = partition(left, right, pivot_index)
        
        # If the pivot is in the kth position, we're done
        if pivot_index == k:
            return nums[pivot_index]
        # If the pivot is after the kth position, search in the left subarray
        elif pivot_index > k:
            return quick_select(left, pivot_index - 1)
        # If the pivot is before the kth position, search in the right subarray
        else:
            return quick_select(pivot_index + 1, right)
    
    return quick_select(0, len(nums) - 1)
```

**Time Complexity:** O(n) on average - The quick select algorithm has an average-case time complexity of O(n).
**Space Complexity:** O(1) - We modify the input array in-place.

### 3. Alternative Solution - Sorting

Sort the array and return the kth largest element.

```python
def findKthLargest(nums, k):
    # Sort the array in descending order
    nums.sort(reverse=True)
    
    # Return the kth element
    return nums[k - 1]
```

**Time Complexity:** O(n log n) - Sorting the array takes O(n log n) time.
**Space Complexity:** O(1) - We modify the input array in-place.

## Solution Choice and Explanation

The quick select solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) average-case time complexity, which is optimal for this problem and satisfies the requirement to solve it in O(n) time.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is optimal for this problem.

3. **Efficiency**: It efficiently finds the kth largest element without sorting the entire array.

The key insight of this approach is to use the quick select algorithm, which is a selection algorithm to find the kth smallest element in an unordered list. We can adapt it to find the kth largest element by finding the (n-k+1)th smallest element.

The quick select algorithm works as follows:
1. Choose a random pivot element from the array.
2. Partition the array around the pivot, such that all elements less than the pivot are to the left, and all elements greater than the pivot are to the right.
3. If the pivot is in the kth position, we're done.
4. If the pivot is after the kth position, recursively search in the left subarray.
5. If the pivot is before the kth position, recursively search in the right subarray.

For example, let's find the 2nd largest element in the array [3,2,1,5,6,4]:
1. Convert to finding the (6-2+1)=5th smallest element.
2. Choose a random pivot, say 3.
3. Partition the array: [1,2,3,5,6,4]
4. The pivot 3 is at index 2, but we want the 5th smallest element, so we search in the right subarray [5,6,4].
5. Choose a random pivot, say 5.
6. Partition the array: [4,5,6]
7. The pivot 5 is at index 1 (index 3 in the original array), but we want the 5th smallest element, so we search in the right subarray [6].
8. There's only one element, so the 5th smallest element is 6.
9. But we want the 2nd largest element, which is 5.

Wait, I made an error. Let me recalculate:
1. Convert to finding the (6-2+1)=5th smallest element.
2. Choose a random pivot, say 3.
3. Partition the array: [1,2,3,4,5,6]
4. The pivot 3 is at index 2, but we want the 5th smallest element, so we search in the right subarray [4,5,6].
5. Choose a random pivot, say 5.
6. Partition the array: [4,5,6]
7. The pivot 5 is at index 1 (index 4 in the original array), which is the 5th smallest element.
8. So the 2nd largest element is 5.

The min-heap of size k solution (Solution 1) is also efficient, with a time complexity of O(n log k), but it doesn't meet the requirement to solve the problem in O(n) time. The sorting solution (Solution 3) is the simplest but has a time complexity of O(n log n).

In an interview, I would first mention the quick select solution as the most efficient approach for this problem, especially given the requirement to solve it in O(n) time. If asked for a simpler solution, I would mention the min-heap of size k solution.
