# Top K Frequent Elements

## Problem Statement

Given an integer array `nums` and an integer `k`, return the `k` most frequent elements. You may return the answer in any order.

**Example 1:**
```
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
```

**Example 2:**
```
Input: nums = [1], k = 1
Output: [1]
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-10^4 <= nums[i] <= 10^4`
- `k` is in the range `[1, the number of unique elements in the array]`.
- It is guaranteed that the answer is unique.

**Follow up:** Your algorithm's time complexity must be better than O(n log n), where n is the array's size.

## Concept Overview

This problem asks us to find the k elements that appear most frequently in an array. The key insight is to efficiently count element frequencies and then select the top k elements based on those frequencies.

## Solutions

### 1. Brute Force Approach - Sorting

Count the frequency of each element, then sort by frequency and take the top k elements.

```python
def topKFrequent(nums, k):
    # Count frequencies
    freq_map = {}
    for num in nums:
        freq_map[num] = freq_map.get(num, 0) + 1
    
    # Sort by frequency
    sorted_items = sorted(freq_map.items(), key=lambda x: x[1], reverse=True)
    
    # Take top k elements
    return [item[0] for item in sorted_items[:k]]
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(n) - For storing the frequency map.

### 2. Improved Solution - Min Heap

Use a min heap of size k to keep track of the k most frequent elements.

```python
import heapq

def topKFrequent(nums, k):
    # Count frequencies
    freq_map = {}
    for num in nums:
        freq_map[num] = freq_map.get(num, 0) + 1
    
    # Use a min heap to keep track of k most frequent elements
    min_heap = []
    for num, freq in freq_map.items():
        # Push the element to the heap
        heapq.heappush(min_heap, (freq, num))
        
        # If heap size exceeds k, remove the smallest frequency element
        if len(min_heap) > k:
            heapq.heappop(min_heap)
    
    # Extract the elements from the heap
    result = [item[1] for item in min_heap]
    
    return result
```

**Time Complexity:** O(n log k) - We iterate through n elements and perform log k operations for heap operations.
**Space Complexity:** O(n + k) - O(n) for the frequency map and O(k) for the heap.

### 3. Best Optimized Solution - Bucket Sort

Use bucket sort to group elements by their frequencies, then collect the k most frequent elements.

```python
def topKFrequent(nums, k):
    # Count frequencies
    freq_map = {}
    for num in nums:
        freq_map[num] = freq_map.get(num, 0) + 1
    
    # Create buckets for each frequency
    buckets = [[] for _ in range(len(nums) + 1)]
    for num, freq in freq_map.items():
        buckets[freq].append(num)
    
    # Collect the k most frequent elements
    result = []
    for i in range(len(buckets) - 1, -1, -1):
        for num in buckets[i]:
            result.append(num)
            if len(result) == k:
                return result
    
    return result  # This line should not be reached given the problem constraints
```

**Time Complexity:** O(n) - We iterate through the array once to count frequencies and once to collect the result.
**Space Complexity:** O(n) - For storing the frequency map and buckets.

### 4. Alternative Solution - Quick Select

Use the quick select algorithm to find the k most frequent elements.

```python
def topKFrequent(nums, k):
    # Count frequencies
    freq_map = {}
    for num in nums:
        freq_map[num] = freq_map.get(num, 0) + 1
    
    # Convert to list of (num, freq) pairs
    unique_nums = list(freq_map.keys())
    
    # Quick select to find the k most frequent elements
    def quick_select(left, right, k_smallest):
        if left == right:
            return [unique_nums[left]]
        
        pivot_index = partition(left, right)
        
        if pivot_index == k_smallest:
            return unique_nums[left:pivot_index + 1]
        elif pivot_index < k_smallest:
            return quick_select(pivot_index + 1, right, k_smallest)
        else:
            return quick_select(left, pivot_index - 1, k_smallest)
    
    def partition(left, right):
        pivot_freq = freq_map[unique_nums[right]]
        i = left
        
        for j in range(left, right):
            if freq_map[unique_nums[j]] >= pivot_freq:
                unique_nums[i], unique_nums[j] = unique_nums[j], unique_nums[i]
                i += 1
        
        unique_nums[i], unique_nums[right] = unique_nums[right], unique_nums[i]
        return i
    
    n = len(unique_nums)
    return quick_select(0, n - 1, n - k)
```

**Time Complexity:** 
- Average case: O(n)
- Worst case: O(n²) - This occurs when the pivot is always the smallest or largest element.

**Space Complexity:** O(n) - For storing the frequency map.

## Solution Choice and Explanation

The bucket sort solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is better than the required O(n log n) and better than the heap solution's O(n log k).

2. **Simple Implementation**: It's straightforward to implement and understand compared to the quick select approach.

3. **Stable Performance**: Unlike quick select, it doesn't have a worst-case scenario where performance degrades to O(n²).

The bucket sort approach works by using the frequency as an index into an array of buckets. Each bucket contains all elements with that frequency. Since the maximum frequency can't exceed the length of the array, we can create at most n+1 buckets. We then iterate through the buckets from highest frequency to lowest, collecting elements until we have k elements.

The heap solution (Solution 2) is also a good approach with O(n log k) time complexity, which is better than O(n log n) for small values of k. It's a good alternative when k is small compared to n.

The quick select solution (Solution 4) has an average-case time complexity of O(n) but can degrade to O(n²) in the worst case. It's more complex to implement correctly.

In an interview, I would first mention the heap solution for its simplicity and then optimize to the bucket sort solution for better time complexity.
