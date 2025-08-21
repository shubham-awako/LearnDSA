# Find K Closest Elements

## Problem Statement

Given a sorted integer array `arr`, two integers `k` and `x`, return the `k` closest integers to `x` in the array. The result should also be sorted in ascending order.

An integer `a` is closer to `x` than an integer `b` if:
- `|a - x| < |b - x|`, or
- `|a - x| == |b - x|` and `a < b`

**Example 1:**
```
Input: arr = [1,2,3,4,5], k = 4, x = 3
Output: [1,2,3,4]
```

**Example 2:**
```
Input: arr = [1,2,3,4,5], k = 4, x = -1
Output: [1,2,3,4]
```

**Constraints:**
- `1 <= k <= arr.length`
- `1 <= arr.length <= 10^4`
- `arr` is sorted in ascending order.
- `-10^4 <= arr[i], x <= 10^4`

## Concept Overview

This problem asks us to find the k closest elements to a given value x in a sorted array. The key insight is to use a sliding window or binary search approach to efficiently find these elements.

## Solutions

### 1. Brute Force Approach - Sort by Distance

Sort the array based on the distance to x and take the first k elements.

```python
def findClosestElements(arr, k, x):
    # Sort the array based on the distance to x
    sorted_arr = sorted(arr, key=lambda a: (abs(a - x), a))
    
    # Take the first k elements and sort them
    return sorted(sorted_arr[:k])
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(n) - We create a new sorted array.

### 2. Improved Solution - Binary Search + Two Pointers

Use binary search to find the closest element to x, then use two pointers to expand outward.

```python
def findClosestElements(arr, k, x):
    n = len(arr)
    
    # Binary search to find the closest element to x
    left, right = 0, n - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == x:
            break
        elif arr[mid] < x:
            left = mid + 1
        else:
            right = mid - 1
    
    # If we didn't find x, left and right are adjacent with right < x < left
    if left > right:
        mid = right
    
    # Use two pointers to expand outward
    left, right = mid, mid + 1
    while right - left - 1 < k:
        if left < 0:
            right += 1
        elif right >= n:
            left -= 1
        elif abs(arr[left] - x) <= abs(arr[right] - x):
            left -= 1
        else:
            right += 1
    
    return arr[left + 1:right]
```

**Time Complexity:** O(log n + k) - Binary search takes O(log n) time, and expanding the window takes O(k) time.
**Space Complexity:** O(k) - We return an array of size k.

### 3. Best Optimized Solution - Binary Search on the Left Boundary

Use binary search to find the left boundary of the k closest elements.

```python
def findClosestElements(arr, k, x):
    n = len(arr)
    
    # Binary search to find the left boundary of the k closest elements
    left, right = 0, n - k
    while left < right:
        mid = (left + right) // 2
        
        # Compare the distance from x to arr[mid] and arr[mid+k]
        if x - arr[mid] > arr[mid + k] - x:
            left = mid + 1
        else:
            right = mid
    
    return arr[left:left + k]
```

**Time Complexity:** O(log(n-k)) - Binary search on the left boundary.
**Space Complexity:** O(k) - We return an array of size k.

### 4. Alternative Solution - Sliding Window

Use a sliding window of size k to find the k closest elements.

```python
def findClosestElements(arr, k, x):
    n = len(arr)
    
    # If x is smaller than the smallest element, return the first k elements
    if x <= arr[0]:
        return arr[:k]
    
    # If x is larger than the largest element, return the last k elements
    if x >= arr[-1]:
        return arr[n-k:]
    
    # Initialize the window to the first k elements
    left, right = 0, k - 1
    
    # Slide the window to the right if it improves the result
    while right < n - 1:
        if abs(arr[left] - x) <= abs(arr[right + 1] - x):
            break
        left += 1
        right += 1
    
    return arr[left:right + 1]
```

**Time Complexity:** O(n) - In the worst case, we slide the window through the entire array.
**Space Complexity:** O(k) - We return an array of size k.

## Solution Choice and Explanation

The binary search on the left boundary solution (Solution 3) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log(n-k)) time complexity, which is better than the O(n log n) of the brute force approach and the O(n) of the sliding window approach.

2. **Elegant Algorithm**: It directly finds the left boundary of the k closest elements using binary search, without the need for additional processing.

3. **Leverages Array Properties**: It takes advantage of the fact that the array is sorted.

The key insight of this approach is to use binary search to find the left boundary of the k closest elements. We compare the distance from x to the elements at the current boundary (arr[mid] and arr[mid+k]). If x is closer to arr[mid+k], we move the left boundary to the right; otherwise, we move the right boundary to the left.

For example, with arr = [1,2,3,4,5], k = 4, x = 3:
- We start with left = 0, right = 1 (n - k = 5 - 4 = 1).
- mid = 0, we compare |3 - 1| = 2 and |3 - 5| = 2. Since they're equal, we prefer the smaller element (1), so we set right = 0.
- left = 0, right = 0, we exit the loop and return arr[0:0+4] = [1,2,3,4].

The binary search + two pointers approach (Solution 2) is also efficient but more complex. The sliding window approach (Solution 4) is simpler but has a higher time complexity of O(n). The brute force approach (Solution 1) is inefficient with O(n log n) time complexity.

In an interview, I would first mention the binary search on the left boundary approach as the optimal solution that achieves O(log(n-k)) time complexity. I would also explain the insight behind comparing the distances at the current boundary.
