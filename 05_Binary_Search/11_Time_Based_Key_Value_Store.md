# Time Based Key Value Store

## Problem Statement

Design a time-based key-value data structure that can store multiple values for the same key at different time stamps and retrieve the key's value at a certain timestamp.

Implement the `TimeMap` class:
- `TimeMap()` Initializes the object of the data structure.
- `void set(String key, String value, int timestamp)` Stores the key `key` with the value `value` at the given time `timestamp`.
- `String get(String key, int timestamp)` Returns a value such that `set` was called previously, with `timestamp_prev <= timestamp`. If there are multiple such values, it returns the value associated with the largest `timestamp_prev`. If there are no values, it returns `""`.

**Example 1:**
```
Input
["TimeMap", "set", "get", "get", "set", "get", "get"]
[[], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5]]
Output
[null, null, "bar", "bar", null, "bar2", "bar2"]

Explanation
TimeMap timeMap = new TimeMap();
timeMap.set("foo", "bar", 1);  // store the key "foo" and value "bar" along with timestamp = 1
timeMap.get("foo", 1);         // return "bar"
timeMap.get("foo", 3);         // return "bar", since there is no value corresponding to foo at timestamp 3 and timestamp 2, then the only value is at timestamp 1 is "bar".
timeMap.set("foo", "bar2", 4); // store the key "foo" and value "bar2" along with timestamp = 4
timeMap.get("foo", 4);         // return "bar2"
timeMap.get("foo", 5);         // return "bar2"
```

**Constraints:**
- `1 <= key.length, value.length <= 100`
- `key` and `value` consist of lowercase English letters and digits.
- `1 <= timestamp <= 10^7`
- All the timestamps `timestamp` of `set` are strictly increasing.
- At most `2 * 10^5` calls will be made to `set` and `get`.

## Concept Overview

This problem tests your understanding of binary search and hash maps. The key insight is to use a hash map to store key-value pairs, where each key maps to a list of (timestamp, value) pairs sorted by timestamp. Then, use binary search to efficiently find the value with the largest timestamp less than or equal to the given timestamp.

## Solutions

### 1. Brute Force Approach - Linear Search

Use a hash map to store key-value pairs, and perform a linear search to find the value with the largest timestamp less than or equal to the given timestamp.

```python
class TimeMap:
    def __init__(self):
        self.store = {}  # key -> list of (timestamp, value) pairs

    def set(self, key, value, timestamp):
        if key not in self.store:
            self.store[key] = []
        self.store[key].append((timestamp, value))

    def get(self, key, timestamp):
        if key not in self.store:
            return ""
        
        # Find the value with the largest timestamp less than or equal to the given timestamp
        result = ""
        for t, value in self.store[key]:
            if t <= timestamp:
                result = value
            else:
                break
        
        return result
```

**Time Complexity:**
- `set`: O(1) - Appending to a list takes constant time.
- `get`: O(n) - In the worst case, we need to scan all timestamp-value pairs for the key.

**Space Complexity:** O(n) - We store all key-value pairs.

### 2. Best Optimized Solution - Binary Search

Use a hash map to store key-value pairs, and use binary search to efficiently find the value with the largest timestamp less than or equal to the given timestamp.

```python
class TimeMap:
    def __init__(self):
        self.store = {}  # key -> list of (timestamp, value) pairs

    def set(self, key, value, timestamp):
        if key not in self.store:
            self.store[key] = []
        self.store[key].append((timestamp, value))
        # No need to sort as timestamps are strictly increasing

    def get(self, key, timestamp):
        if key not in self.store:
            return ""
        
        values = self.store[key]
        
        # Binary search to find the largest timestamp less than or equal to the given timestamp
        left, right = 0, len(values) - 1
        while left <= right:
            mid = left + (right - left) // 2
            if values[mid][0] <= timestamp:
                left = mid + 1
            else:
                right = mid - 1
        
        # If right is -1, no timestamp is less than or equal to the given timestamp
        if right == -1:
            return ""
        
        return values[right][1]
```

**Time Complexity:**
- `set`: O(1) - Appending to a list takes constant time.
- `get`: O(log n) - Binary search takes logarithmic time.

**Space Complexity:** O(n) - We store all key-value pairs.

### 3. Alternative Solution - Using Python's bisect Module

Use Python's built-in bisect module to perform binary search.

```python
import bisect

class TimeMap:
    def __init__(self):
        self.store = {}  # key -> list of (timestamp, value) pairs

    def set(self, key, value, timestamp):
        if key not in self.store:
            self.store[key] = []
        self.store[key].append((timestamp, value))
        # No need to sort as timestamps are strictly increasing

    def get(self, key, timestamp):
        if key not in self.store:
            return ""
        
        values = self.store[key]
        
        # Find the insertion point for timestamp
        idx = bisect.bisect_right(values, (timestamp, chr(127)))
        
        # If idx is 0, no timestamp is less than or equal to the given timestamp
        if idx == 0:
            return ""
        
        return values[idx - 1][1]
```

**Time Complexity:**
- `set`: O(1) - Appending to a list takes constant time.
- `get`: O(log n) - Binary search takes logarithmic time.

**Space Complexity:** O(n) - We store all key-value pairs.

## Solution Choice and Explanation

The binary search solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves O(log n) time complexity for the `get` operation, which is efficient for large datasets.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Efficiency**: It efficiently finds the value with the largest timestamp less than or equal to the given timestamp.

The key insight of this solution is to use a hash map to store key-value pairs, where each key maps to a list of (timestamp, value) pairs. Since the timestamps are strictly increasing, the list is already sorted by timestamp. Then, we use binary search to efficiently find the value with the largest timestamp less than or equal to the given timestamp.

For the `get` operation, we perform a binary search to find the largest timestamp less than or equal to the given timestamp. If no such timestamp exists, we return an empty string.

For example, let's consider the example from the problem statement:
1. `set("foo", "bar", 1)`: store = {"foo": [(1, "bar")]}
2. `get("foo", 1)`: Binary search finds timestamp 1, so return "bar"
3. `get("foo", 3)`: Binary search finds timestamp 1 (since it's the largest timestamp <= 3), so return "bar"
4. `set("foo", "bar2", 4)`: store = {"foo": [(1, "bar"), (4, "bar2")]}
5. `get("foo", 4)`: Binary search finds timestamp 4, so return "bar2"
6. `get("foo", 5)`: Binary search finds timestamp 4 (since it's the largest timestamp <= 5), so return "bar2"

The brute force approach (Solution 1) is simple but inefficient for large datasets with many timestamp-value pairs. The alternative solution using Python's bisect module (Solution 3) is also efficient and may be more concise, but it's important to understand the underlying binary search algorithm.

In an interview, I would first mention the binary search approach as the most efficient solution for this problem.
