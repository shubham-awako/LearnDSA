# Remove Element

## Problem Statement

Given an integer array `nums` and an integer `val`, remove all occurrences of `val` in `nums` in-place. The order of the elements may be changed. Then return the number of elements in `nums` which are not equal to `val`.

Consider the number of elements in `nums` which are not equal to `val` be `k`, to get accepted, you need to do the following things:

- Change the array `nums` such that the first `k` elements of `nums` contain the elements which are not equal to `val`. The remaining elements of `nums` are not important as well as the size of `nums`.
- Return `k`.

**Custom Judge:**

The judge will test your solution with the following code:
```
int[] nums = [...]; // Input array
int val = ...; // Value to remove
int[] expectedNums = [...]; // The expected answer with correct length.
                           // It is sorted with no values equaling val.

int k = removeElement(nums, val); // Calls your implementation

assert k == expectedNums.length;
sort(nums, 0, k); // Sort the first k elements of nums
for (int i = 0; i < actualLength; i++) {
    assert nums[i] == expectedNums[i];
}
```

If all assertions pass, then your solution will be accepted.

**Example 1:**
```
Input: nums = [3,2,2,3], val = 3
Output: 2, nums = [2,2,_,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 2.
It does not matter what you leave beyond the returned k (hence they are underscores).
```

**Example 2:**
```
Input: nums = [0,1,2,2,3,0,4,2], val = 2
Output: 5, nums = [0,1,4,0,3,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.
Note that the five elements can be returned in any order.
It does not matter what you leave beyond the returned k (hence they are underscores).
```

**Constraints:**
- `0 <= nums.length <= 100`
- `0 <= nums[i] <= 50`
- `0 <= val <= 100`

## Concept Overview

This problem tests your ability to modify an array in-place while removing specific elements. The key insight is to maintain a pointer to the position where the next non-target element should be placed.

## Solutions

### 1. Brute Force Approach - Create a New Array

Create a new array without the target value, then copy it back to the original array.

```python
def removeElement(nums, val):
    # Create a new array without the target value
    filtered = [num for num in nums if num != val]
    
    # Copy filtered elements back to the original array
    for i in range(len(filtered)):
        nums[i] = filtered[i]
    
    return len(filtered)
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We create a new array.

### 2. Improved Solution - Two Pointers (Same Direction)

Use two pointers: one to iterate through the array and another to keep track of where to place the next non-target element.

```python
def removeElement(nums, val):
    k = 0  # Position to place the next non-target element
    
    for i in range(len(nums)):
        if nums[i] != val:
            nums[k] = nums[i]
            k += 1
    
    return k
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We modify the array in-place.

### 3. Best Optimized Solution - Two Pointers (Opposite Directions)

Use two pointers from opposite ends of the array to minimize the number of operations when there are many instances of the target value.

```python
def removeElement(nums, val):
    left = 0
    right = len(nums) - 1
    
    while left <= right:
        if nums[left] == val:
            nums[left] = nums[right]
            right -= 1
        else:
            left += 1
    
    return left
```

**Time Complexity:** O(n) - In the worst case, we still need to check each element.
**Space Complexity:** O(1) - We modify the array in-place.

## Solution Choice and Explanation

The two-pointer approach with opposite directions (Solution 3) is the best solution for this problem because:

1. **Optimal Space Complexity**: It achieves O(1) space complexity by modifying the array in-place.

2. **Efficient Operations**: It minimizes the number of operations by swapping elements from the end of the array when a target value is found, which is particularly efficient when there are many instances of the target value.

3. **Early Termination**: It can terminate early when the left and right pointers meet, without necessarily examining every element.

The two-pointer approach with same direction (Solution 2) is also a good solution with O(1) space complexity, but it may perform more operations than necessary when there are many instances of the target value.

The brute force approach (Solution 1) is simple but uses O(n) extra space, which is not optimal for this problem that specifically asks for an in-place solution.

In an interview, I would first mention the two-pointer approach with same direction for its simplicity, then optimize to the opposite direction approach for better efficiency in certain cases. I would also explain the trade-offs between the two approaches.
