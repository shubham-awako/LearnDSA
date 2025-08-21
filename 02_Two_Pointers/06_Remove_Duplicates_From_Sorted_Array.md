# Remove Duplicates From Sorted Array

## Problem Statement

Given an integer array `nums` sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same. Then return the number of unique elements in `nums`.

Consider the number of unique elements of `nums` to be `k`, to get accepted, you need to do the following things:

- Change the array `nums` such that the first `k` elements of `nums` contain the unique elements in the order they were present in `nums` initially. The remaining elements of `nums` are not important as well as the size of `nums`.
- Return `k`.

**Custom Judge:**

The judge will test your solution with the following code:
```
int[] nums = [...]; // Input array
int[] expectedNums = [...]; // The expected answer with correct length

int k = removeDuplicates(nums); // Calls your implementation

assert k == expectedNums.length;
for (int i = 0; i < k; i++) {
    assert nums[i] == expectedNums[i];
}
```

If all assertions pass, then your solution will be accepted.

**Example 1:**
```
Input: nums = [1,1,2]
Output: 2, nums = [1,2,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
```

**Example 2:**
```
Input: nums = [0,0,1,1,1,2,2,3,3,4]
Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
```

**Constraints:**
- `1 <= nums.length <= 3 * 10^4`
- `-100 <= nums[i] <= 100`
- `nums` is sorted in non-decreasing order.

## Concept Overview

This problem tests your ability to modify an array in-place to remove duplicates. The key insight is to use a two-pointer approach to keep track of the position for the next unique element.

## Solutions

### 1. Brute Force Approach - Using Extra Space

Create a new array with unique elements, then copy it back to the original array.

```python
def removeDuplicates(nums):
    if not nums:
        return 0
    
    # Create a list of unique elements
    unique = []
    for num in nums:
        if not unique or num != unique[-1]:
            unique.append(num)
    
    # Copy unique elements back to nums
    for i in range(len(unique)):
        nums[i] = unique[i]
    
    return len(unique)
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(n) - We create a new array of potentially the same length.

### 2. Best Optimized Solution - Two Pointers

Use two pointers: one to iterate through the array and another to keep track of the position for the next unique element.

```python
def removeDuplicates(nums):
    if not nums:
        return 0
    
    # Position for the next unique element
    k = 1
    
    # Iterate through the array starting from the second element
    for i in range(1, len(nums)):
        if nums[i] != nums[i - 1]:
            nums[k] = nums[i]
            k += 1
    
    return k
```

**Time Complexity:** O(n) - We iterate through the array once.
**Space Complexity:** O(1) - We use only a few pointers regardless of input size.

### 3. Alternative Solution - Using Set

Convert the array to a set to remove duplicates, then sort and copy back to the original array.

```python
def removeDuplicates(nums):
    if not nums:
        return 0
    
    # Create a sorted set of unique elements
    unique = sorted(set(nums))
    
    # Copy unique elements back to nums
    for i in range(len(unique)):
        nums[i] = unique[i]
    
    return len(unique)
```

**Time Complexity:** O(n log n) - Dominated by the sorting operation.
**Space Complexity:** O(n) - We create a set of potentially the same length.

## Solution Choice and Explanation

The two-pointer solution (Solution 2) is the best approach for this problem because:

1. **In-Place Modification**: It directly modifies the array without using extra space.

2. **Optimal Space Complexity**: It uses O(1) extra space, which is better than the O(n) space used by the other approaches.

3. **Optimal Time Complexity**: It achieves O(n) time complexity, which is optimal for this problem.

4. **Leverages Array Properties**: It takes advantage of the fact that the array is already sorted.

The key insight of this approach is to use two pointers: one to iterate through the array and another to keep track of the position for the next unique element. When we encounter a new unique element, we place it at the position indicated by the second pointer and increment the pointer.

For example, in the array [0,0,1,1,1,2,2,3,3,4]:
- We start with k = 1 (assuming the first element is unique).
- When we encounter 1 (which is different from the previous element 0), we place it at position k = 1 and increment k to 2.
- When we encounter 2 (which is different from the previous element 1), we place it at position k = 2 and increment k to 3.
- And so on...

The brute force approach (Solution 1) and the set approach (Solution 3) both use O(n) extra space, which doesn't meet the in-place requirement of the problem.

In an interview, I would first mention the two-pointer approach as the optimal solution that minimizes both time and space complexity. I would also explain how it leverages the sorted property of the array to efficiently remove duplicates in-place.
