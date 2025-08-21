# Online Stock Span

## Problem Statement

Design an algorithm that collects daily price quotes for some stock and returns the span of that stock's price for the current day.

The span of the stock's price today is defined as the maximum number of consecutive days (starting from today and going backward) for which the stock price was less than or equal to today's price.

- For example, if the price of a stock over the next 7 days were `[100,80,60,70,60,75,85]`, then the stock spans would be `[1,1,1,2,1,4,6]`.

Implement the `StockSpanner` class:
- `StockSpanner()` Initializes the object of the class.
- `int next(int price)` Returns the span of the stock's price given that today's price is `price`.

**Example 1:**
```
Input
["StockSpanner", "next", "next", "next", "next", "next", "next", "next"]
[[], [100], [80], [60], [70], [60], [75], [85]]
Output
[null, 1, 1, 1, 2, 1, 4, 6]

Explanation
StockSpanner stockSpanner = new StockSpanner();
stockSpanner.next(100); // return 1
stockSpanner.next(80);  // return 1
stockSpanner.next(60);  // return 1
stockSpanner.next(70);  // return 2
stockSpanner.next(60);  // return 1
stockSpanner.next(75);  // return 4
stockSpanner.next(85);  // return 6
```

**Constraints:**
- `1 <= price <= 10^5`
- At most `10^4` calls will be made to `next`.

## Concept Overview

This problem tests your understanding of stack operations for finding the span of stock prices. The key insight is to use a stack to keep track of prices and their spans.

## Solutions

### 1. Brute Force Approach

For each price, scan backward to find the span.

```python
class StockSpanner:
    def __init__(self):
        self.prices = []

    def next(self, price):
        self.prices.append(price)
        span = 0
        
        for i in range(len(self.prices) - 1, -1, -1):
            if self.prices[i] <= price:
                span += 1
            else:
                break
        
        return span
```

**Time Complexity:** O(n) per call to `next`, where n is the number of prices seen so far.
**Space Complexity:** O(n) - For storing all prices.

### 2. Best Optimized Solution - Stack

Use a stack to keep track of prices and their spans.

```python
class StockSpanner:
    def __init__(self):
        self.stack = []  # Stack of (price, span) pairs

    def next(self, price):
        span = 1  # Start with a span of 1 for the current day
        
        # Pop elements from the stack while the current price is greater than or equal to the price at the top of the stack
        while self.stack and price >= self.stack[-1][0]:
            _, prev_span = self.stack.pop()
            span += prev_span
        
        # Push the current price and its span onto the stack
        self.stack.append((price, span))
        
        return span
```

**Time Complexity:** Amortized O(1) per call to `next`. Each price is pushed and popped at most once.
**Space Complexity:** O(n) - In the worst case, the stack can have all prices.

### 3. Alternative Solution - Monotonic Stack with Indices

Use a monotonic stack to keep track of indices of prices.

```python
class StockSpanner:
    def __init__(self):
        self.prices = []
        self.stack = []  # Stack of indices

    def next(self, price):
        self.prices.append(price)
        current_idx = len(self.prices) - 1
        
        # Pop indices from the stack while the current price is greater than or equal to the price at those indices
        while self.stack and price >= self.prices[self.stack[-1]]:
            self.stack.pop()
        
        # Calculate the span
        if not self.stack:
            span = current_idx + 1
        else:
            span = current_idx - self.stack[-1]
        
        # Push the current index onto the stack
        self.stack.append(current_idx)
        
        return span
```

**Time Complexity:** Amortized O(1) per call to `next`. Each index is pushed and popped at most once.
**Space Complexity:** O(n) - For storing all prices and the stack.

## Solution Choice and Explanation

The stack solution (Solution 2) is the best approach for this problem because:

1. **Optimal Time Complexity**: It achieves amortized O(1) time complexity per call to `next`, which is optimal for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Efficient Space Usage**: It only stores the necessary information in the stack, rather than all prices.

The key insight of this approach is to use a stack to keep track of prices and their spans. For each price:
- We pop elements from the stack while the current price is greater than or equal to the price at the top of the stack.
- For each popped element, we add its span to the current span.
- Then, we push the current price and its span onto the stack.

This approach works because if a price is popped from the stack, it means it's less than or equal to the current price, so its span can be added to the current span.

For example, let's simulate the example [100,80,60,70,60,75,85]:
1. For price 100: stack = [(100, 1)], return 1
2. For price 80: 80 < 100, so stack = [(100, 1), (80, 1)], return 1
3. For price 60: 60 < 80, so stack = [(100, 1), (80, 1), (60, 1)], return 1
4. For price 70: 70 > 60, so pop (60, 1) from the stack and add its span to the current span: 1 + 1 = 2. stack = [(100, 1), (80, 1), (70, 2)], return 2
5. For price 60: 60 < 70, so stack = [(100, 1), (80, 1), (70, 2), (60, 1)], return 1
6. For price 75: 75 > 60, 75 > 70, 75 < 80, so pop (60, 1) and (70, 2) from the stack and add their spans to the current span: 1 + 1 + 2 = 4. stack = [(100, 1), (80, 1), (75, 4)], return 4
7. For price 85: 85 > 75, 85 > 80, 85 < 100, so pop (75, 4) and (80, 1) from the stack and add their spans to the current span: 1 + 4 + 1 = 6. stack = [(100, 1), (85, 6)], return 6

The monotonic stack with indices approach (Solution 3) is also efficient but more complex. The brute force approach (Solution 1) is inefficient with O(n) time complexity per call to `next`.

In an interview, I would first mention the stack approach as the most natural and efficient solution for this problem.
