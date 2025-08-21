# Hand of Straights

## Problem Statement

Alice has some number of cards and she wants to rearrange the cards into groups so that each group is of size `groupSize`, and consists of `groupSize` consecutive cards.

Given an integer array `hand` where `hand[i]` is the value written on the `i`th card and an integer `groupSize`, return `true` if she can rearrange the cards, or `false` otherwise.

**Example 1:**
```
Input: hand = [1,2,3,6,2,3,4,7,8], groupSize = 3
Output: true
Explanation: Alice's hand can be rearranged as [1,2,3],[2,3,4],[6,7,8]
```

**Example 2:**
```
Input: hand = [1,2,3,4,5], groupSize = 4
Output: false
Explanation: Alice's hand can't be rearranged into groups of 4.
```

**Constraints:**
- `1 <= hand.length <= 10^4`
- `0 <= hand[i] <= 10^9`
- `1 <= groupSize <= hand.length`

## Concept Overview

This problem can be solved using a greedy approach. The key insight is to sort the cards and then try to form groups of consecutive cards starting from the smallest card.

## Solutions

### 1. Best Optimized Solution - Greedy Approach with Counter

Use a greedy approach with a counter to determine if the cards can be rearranged.

```python
from collections import Counter

def isNStraightHand(hand, groupSize):
    # If the number of cards is not divisible by groupSize, return False
    if len(hand) % groupSize != 0:
        return False
    
    # Count the occurrences of each card
    counter = Counter(hand)
    
    # Sort the cards
    cards = sorted(counter.keys())
    
    # Try to form groups of consecutive cards
    for card in cards:
        # If the card is no longer in the counter, skip it
        if counter[card] == 0:
            continue
        
        # The number of groups we need to form with this card
        count = counter[card]
        
        # Try to form 'count' groups starting with this card
        for i in range(groupSize):
            # If the next card is not in the counter or its count is less than 'count',
            # we can't form the groups
            if counter[card + i] < count:
                return False
            
            # Reduce the count of the next card
            counter[card + i] -= count
    
    return True
```

**Time Complexity:** O(n log n) - We need to sort the cards, which takes O(n log n) time.
**Space Complexity:** O(n) - We use a counter to store the occurrences of each card.

### 2. Alternative Solution - Greedy Approach with Priority Queue

Use a greedy approach with a priority queue to determine if the cards can be rearranged.

```python
import heapq
from collections import Counter

def isNStraightHand(hand, groupSize):
    # If the number of cards is not divisible by groupSize, return False
    if len(hand) % groupSize != 0:
        return False
    
    # Count the occurrences of each card
    counter = Counter(hand)
    
    # Create a min-heap of the cards
    min_heap = list(counter.keys())
    heapq.heapify(min_heap)
    
    # Try to form groups of consecutive cards
    while min_heap:
        # Get the smallest card
        smallest = min_heap[0]
        
        # Try to form a group starting with the smallest card
        for i in range(smallest, smallest + groupSize):
            # If the next card is not in the counter, we can't form the group
            if i not in counter:
                return False
            
            # Reduce the count of the next card
            counter[i] -= 1
            
            # If the count becomes 0, remove the card from the counter
            if counter[i] == 0:
                # If the card we're removing is not the smallest, we can't form the group
                if i != min_heap[0]:
                    return False
                
                heapq.heappop(min_heap)
    
    return True
```

**Time Complexity:** O(n log n) - We need to create a min-heap of the cards, which takes O(n log n) time.
**Space Complexity:** O(n) - We use a counter and a min-heap to store the cards.

### 3. Alternative Solution - Greedy Approach with Sorting

Use a greedy approach with sorting to determine if the cards can be rearranged.

```python
def isNStraightHand(hand, groupSize):
    # If the number of cards is not divisible by groupSize, return False
    if len(hand) % groupSize != 0:
        return False
    
    # Sort the cards
    hand.sort()
    
    # Try to form groups of consecutive cards
    while hand:
        # Get the smallest card
        smallest = hand[0]
        
        # Try to form a group starting with the smallest card
        for i in range(groupSize):
            # If the next card is not in the hand, we can't form the group
            if smallest + i not in hand:
                return False
            
            # Remove the next card from the hand
            hand.remove(smallest + i)
    
    return True
```

**Time Complexity:** O(n^2) - We need to sort the cards, which takes O(n log n) time, and then for each card, we need to check if it's in the hand and remove it, which takes O(n) time.
**Space Complexity:** O(1) - We only use a constant amount of extra space.

## Solution Choice and Explanation

The Greedy Approach with Counter solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log n) time complexity, which is optimal for this problem, and the space complexity is O(n).

2. **Simplicity**: It's the most straightforward and elegant solution, requiring only a few lines of code.

3. **Intuitiveness**: It naturally maps to the concept of forming groups of consecutive cards.

The key insight of this approach is to sort the cards and then try to form groups of consecutive cards starting from the smallest card. We use a counter to keep track of the occurrences of each card and reduce the count as we form groups.

For example, let's trace through the algorithm for hand = [1, 2, 3, 6, 2, 3, 4, 7, 8] and groupSize = 3:

1. Check if the number of cards is divisible by groupSize:
   - len(hand) = 9
   - 9 % 3 = 0, so continue

2. Count the occurrences of each card:
   - counter = {1: 1, 2: 2, 3: 2, 4: 1, 6: 1, 7: 1, 8: 1}

3. Sort the cards:
   - cards = [1, 2, 3, 4, 6, 7, 8]

4. Try to form groups of consecutive cards:
   - card = 1:
     - count = counter[1] = 1
     - Check if we can form 1 group starting with 1:
       - counter[1] = 1 >= count = 1, so continue
       - counter[2] = 2 >= count = 1, so continue
       - counter[3] = 2 >= count = 1, so continue
       - Reduce the counts: counter = {1: 0, 2: 1, 3: 1, 4: 1, 6: 1, 7: 1, 8: 1}
   - card = 2:
     - count = counter[2] = 1
     - Check if we can form 1 group starting with 2:
       - counter[2] = 1 >= count = 1, so continue
       - counter[3] = 1 >= count = 1, so continue
       - counter[4] = 1 >= count = 1, so continue
       - Reduce the counts: counter = {1: 0, 2: 0, 3: 0, 4: 0, 6: 1, 7: 1, 8: 1}
   - card = 6:
     - count = counter[6] = 1
     - Check if we can form 1 group starting with 6:
       - counter[6] = 1 >= count = 1, so continue
       - counter[7] = 1 >= count = 1, so continue
       - counter[8] = 1 >= count = 1, so continue
       - Reduce the counts: counter = {1: 0, 2: 0, 3: 0, 4: 0, 6: 0, 7: 0, 8: 0}

5. All cards have been used, so return True

For hand = [1, 2, 3, 4, 5] and groupSize = 4:

1. Check if the number of cards is divisible by groupSize:
   - len(hand) = 5
   - 5 % 4 = 1 != 0, so return False

The Greedy Approach with Priority Queue solution (Solution 2) is also efficient but may be more complex. The Greedy Approach with Sorting solution (Solution 3) is less efficient but may be a good starting point for understanding the problem.

In an interview, I would first mention the Greedy Approach with Counter solution as the most efficient approach for this problem, and then discuss the Greedy Approach with Priority Queue and Greedy Approach with Sorting solutions as alternatives if asked for different approaches.
