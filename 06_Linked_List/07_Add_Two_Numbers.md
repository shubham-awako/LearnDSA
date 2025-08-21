# Add Two Numbers

## Problem Statement

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Example 1:**
```
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807.
```

**Example 2:**
```
Input: l1 = [0], l2 = [0]
Output: [0]
```

**Example 3:**
```
Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
Output: [8,9,9,9,0,0,0,1]
```

**Constraints:**
- The number of nodes in each linked list is in the range `[1, 100]`.
- `0 <= Node.val <= 9`
- It is guaranteed that the list represents a number that does not have leading zeros.

## Concept Overview

This problem tests your understanding of linked list manipulation and arithmetic operations. The key insight is to traverse both lists simultaneously, adding the digits and handling the carry.

## Solutions

### 1. Best Optimized Solution - Iterative Approach

Iterate through both lists, adding the digits and handling the carry.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def addTwoNumbers(l1, l2):
    dummy = ListNode(0)
    curr = dummy
    carry = 0
    
    while l1 or l2 or carry:
        # Get the values of the current nodes (or 0 if the list has ended)
        x = l1.val if l1 else 0
        y = l2.val if l2 else 0
        
        # Calculate the sum and the carry
        total = x + y + carry
        carry = total // 10
        digit = total % 10
        
        # Create a new node for the result
        curr.next = ListNode(digit)
        curr = curr.next
        
        # Move to the next nodes in the input lists
        if l1:
            l1 = l1.next
        if l2:
            l2 = l2.next
    
    return dummy.next
```

**Time Complexity:** O(max(n, m)) - We iterate through both lists once, where n and m are the lengths of l1 and l2.
**Space Complexity:** O(max(n, m)) - The result list can have at most max(n, m) + 1 nodes.

### 2. Recursive Approach

Use recursion to add the two numbers.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def addTwoNumbers(l1, l2, carry=0):
    # Base case: both lists are empty and there's no carry
    if not l1 and not l2 and not carry:
        return None
    
    # Get the values of the current nodes (or 0 if the list has ended)
    x = l1.val if l1 else 0
    y = l2.val if l2 else 0
    
    # Calculate the sum and the carry
    total = x + y + carry
    carry = total // 10
    digit = total % 10
    
    # Create a new node for the result
    result = ListNode(digit)
    
    # Recursively add the next nodes
    result.next = addTwoNumbers(l1.next if l1 else None, l2.next if l2 else None, carry)
    
    return result
```

**Time Complexity:** O(max(n, m)) - We process each node once.
**Space Complexity:** O(max(n, m)) - The recursion stack can go up to max(n, m) levels deep.

### 3. Alternative Solution - Convert to Integers

Convert the linked lists to integers, add them, and then convert the result back to a linked list.

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

def addTwoNumbers(l1, l2):
    # Convert l1 to an integer
    num1 = 0
    multiplier = 1
    while l1:
        num1 += l1.val * multiplier
        multiplier *= 10
        l1 = l1.next
    
    # Convert l2 to an integer
    num2 = 0
    multiplier = 1
    while l2:
        num2 += l2.val * multiplier
        multiplier *= 10
        l2 = l2.next
    
    # Add the two numbers
    total = num1 + num2
    
    # Convert the result back to a linked list
    dummy = ListNode(0)
    curr = dummy
    
    # Handle the case where total is 0
    if total == 0:
        return ListNode(0)
    
    while total > 0:
        digit = total % 10
        curr.next = ListNode(digit)
        curr = curr.next
        total //= 10
    
    return dummy.next
```

**Time Complexity:** O(max(n, m)) - We iterate through both lists once.
**Space Complexity:** O(max(n, m)) - The result list can have at most max(n, m) + 1 nodes.

**Note:** This solution may not work for very large numbers due to integer overflow.

## Solution Choice and Explanation

The iterative approach (Solution 1) is the best solution for this problem because:

1. **Optimal Time Complexity**: It achieves O(max(n, m)) time complexity, which is optimal for this problem.

2. **Optimal Space Complexity**: It uses O(max(n, m)) space for the result list, which is the minimum required.

3. **Simplicity**: It's straightforward to implement and understand.

4. **Robustness**: It handles all cases correctly, including when the lists have different lengths or when there's a carry at the end.

The key insight of this approach is to traverse both lists simultaneously, adding the digits and handling the carry. We use a dummy node to simplify the edge case of adding the first node, and we continue the loop as long as there are nodes in either list or there's a carry.

For example, let's add l1 = [2,4,3] and l2 = [5,6,4]:
1. Initialize: dummy = 0, curr = dummy, carry = 0
2. First iteration: x = 2, y = 5, total = 7, carry = 0, digit = 7, curr.next = 7, curr = 7, l1 = 4, l2 = 6
3. Second iteration: x = 4, y = 6, total = 10, carry = 1, digit = 0, curr.next = 0, curr = 0, l1 = 3, l2 = 4
4. Third iteration: x = 3, y = 4, total = 8, carry = 0, digit = 8, curr.next = 8, curr = 8, l1 = None, l2 = None
5. Loop ends, return dummy.next = [7,0,8]

The recursive approach (Solution 2) is also efficient but uses O(max(n, m)) extra space for the recursion stack. The alternative solution (Solution 3) is simple but may not work for very large numbers due to integer overflow.

In an interview, I would first mention the iterative approach as the most efficient and robust solution for this problem.
