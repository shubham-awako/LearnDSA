# Sliding Window Maximum

## Problem Statement

You are given an array of integers `nums`, there is a sliding window of size `k` which is moving from the very left of the array to the very right. You can only see the `k` numbers in the window. Each time the sliding window moves right by one position.

Return the max sliding window.

**Example 1:**
```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation: 
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
```

**Example 2:**
```
Input: nums = [1], k = 1
Output: [1]
```

**Constraints:**
- `1 <= nums.length <= 10^5`
- `-10^4 <= nums[i] <= 10^4`
- `1 <= k <= nums.length`

## Concept Overview

This problem asks us to find the maximum element in each sliding window of size k. The key insight is to use a data structure that allows us to efficiently track the maximum element in the current window.

## Solutions

### 1. Brute Force Approach

Find the maximum element in each window by iterating through all elements in the window.

```python
def maxSlidingWindow(nums, k):
    n = len(nums)
    result = []
    
    for i in range(n - k + 1):
        max_val = max(nums[i:i+k])
        result.append(max_val)
    
    return result
```

**Time Complexity:** O(n*k) - For each of the n-k+1 windows, we find the maximum element in O(k) time.
**Space Complexity:** O(n-k+1) - For storing the result.

### 2. Improved Solution - Heap

Use a max heap to efficiently find the maximum element in each window.

```python
import heapq

def maxSlidingWindow(nums, k):
    n = len(nums)
    result = []
    
    # Use a max heap to track the maximum element in the window
    # Store (value, index) pairs to handle removal of elements outside the window
    heap = [(-nums[i], i) for i in range(k)]
    heapq.heapify(heap)
    
    # Add the maximum of the first window to the result
    result.append(-heap[0][0])
    
    for i in range(k, n):
        # Add the new element to the heap
        heapq.heappush(heap, (-nums[i], i))
        
        # Remove elements that are outside the current window
        while heap and heap[0][1] <= i - k:
            heapq.heappop(heap)
        
        # Add the maximum of the current window to the result
        result.append(-heap[0][0])
    
    return result
```

**Time Complexity:** O(n log k) - We perform n heap operations, each taking O(log k) time.
**Space Complexity:** O(k) - For storing the heap.

### 3. Best Optimized Solution - Deque

Use a deque to efficiently track the maximum element in each window.

```python
from collections import deque

def maxSlidingWindow(nums, k):
    n = len(nums)
    result = []
    
    # Use a deque to store indices of elements in the current window
    # The deque is maintained such that elements are in decreasing order
    dq = deque()
    
    for i in range(n):
        # Remove elements that are outside the current window
        while dq and dq[0] < i - k + 1:
            dq.popleft()
        
        # Remove elements that are smaller than the current element
        # These elements can never be the maximum in the current or future windows
        while dq and nums[dq[-1]] < nums[i]:
            dq.pop()
        
        # Add the current element to the deque
        dq.append(i)
        
        # Add the maximum of the current window to the result
        if i >= k - 1:
            result.append(nums[dq[0]])
    
    return result
```

**Time Complexity:** O(n) - Each element is processed at most twice (once when added to the deque and once when removed).
**Space Complexity:** O(k) - The deque can have at most k elements.

### 4. Alternative Solution - Dynamic Programming

Use dynamic programming to efficiently find the maximum element in each window.

```python
def maxSlidingWindow(nums, k):
    n = len(nums)
    if n == 0 or k == 0:
        return []
    
    # left[i] is the maximum of elements in the range [i - (i % k), i]
    left = [0] * n
    # right[i] is the maximum of elements in the range [i, min(i + k - 1 - (i % k), n - 1)]
    right = [0] * n
    
    # Fill the left and right arrays
    for i in range(n):
        # For the first element in each block, there's no previous element
        if i % k == 0:
            left[i] = nums[i]
        else:
            left[i] = max(left[i - 1], nums[i])
        
        # Calculate the corresponding position from the right
        j = n - 1 - i
        # For the last element in each block, there's no next element
        if (j + 1) % k == 0 or j == n - 1:
            right[j] = nums[j]
        else:
            right[j] = max(right[j + 1], nums[j])
    
    result = []
    for i in range(n - k + 1):
        # The maximum in the window [i, i+k-1] is the maximum of the rightmost element
        # in the left block and the leftmost element in the right block
        result.append(max(right[i], left[i + k - 1]))
    
    return result
```

**Time Complexity:** O(n) - We process each element a constant number of times.
**Space Complexity:** O(n) - For storing the left and right arrays.

## Solution Choice and Explanation

The deque solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

2. **Efficient Data Structure**: It uses a deque to efficiently track the maximum element in each window.

3. **Single Pass**: It processes the array in a single pass, making it more efficient than the heap approach.

The key insight of this approach is to use a deque to store the indices of elements in the current window, with the elements arranged in decreasing order. This allows us to efficiently find the maximum element (at the front of the deque) and remove elements that are no longer in the window or can never be the maximum in future windows.

For example, with nums = [1,3,-1,-3,5,3,6,7] and k = 3:
- For i = 0, dq = [0], result = [].
- For i = 1, dq = [1] (1 is removed because 3 > 1), result = [].
- For i = 2, dq = [1, 2] (-1 is added because -1 < 3), result = [3] (3 is the maximum in the first window).
- For i = 3, dq = [1, 2, 3] (-3 is added because -3 < -1), result = [3, 3] (3 is still the maximum in the second window).
- For i = 4, dq = [4] (1, 2, 3 are all removed because 5 > all of them), result = [3, 3, 5] (5 is the maximum in the third window).
- And so on...

The heap approach (Solution 2) is also efficient but has a higher time complexity of O(n log k). The dynamic programming approach (Solution 4) is elegant but uses more space. The brute force approach (Solution 1) is inefficient with O(n*k) time complexity.

In an interview, I would first mention the deque approach as the optimal solution that achieves O(n) time complexity with efficient window management.
