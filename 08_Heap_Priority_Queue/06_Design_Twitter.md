# Design Twitter

## Problem Statement

Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and is able to see the 10 most recent tweets in the user's news feed.

Implement the `Twitter` class:

- `Twitter()` Initializes your twitter object.
- `void postTweet(int userId, int tweetId)` Composes a new tweet with ID `tweetId` by the user `userId`. Each call to this function will be made with a unique `tweetId`.
- `List<Integer> getNewsFeed(int userId)` Retrieves the 10 most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user themself. Tweets must be ordered from most recent to least recent.
- `void follow(int followerId, int followeeId)` The user with ID `followerId` started following the user with ID `followeeId`.
- `void unfollow(int followerId, int followeeId)` The user with ID `followerId` started unfollowing the user with ID `followeeId`.

**Example 1:**
```
Input
["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
[[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
Output
[null, null, [5], null, null, [6, 5], null, [5]]

Explanation
Twitter twitter = new Twitter();
twitter.postTweet(1, 5); // User 1 posts a new tweet (id = 5).
twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
twitter.follow(1, 2);    // User 1 follows user 2.
twitter.postTweet(2, 6); // User 2 posts a new tweet (id = 6).
twitter.getNewsFeed(1);  // User 1's news feed should return a list with 2 tweet ids -> [6, 5]. Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
twitter.unfollow(1, 2);  // User 1 unfollows user 2.
twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5], since user 1 is no longer following user 2.
```

**Constraints:**
- `1 <= userId, followerId, followeeId <= 500`
- `0 <= tweetId <= 10^4`
- All the tweets have unique IDs.
- At most `3 * 10^4` calls will be made to `postTweet`, `getNewsFeed`, `follow`, and `unfollow`.

## Concept Overview

This problem tests your understanding of data structures, particularly hash maps and heaps. The key insight is to use a hash map to store the tweets of each user and another hash map to store the followees of each user. Then, use a heap to efficiently find the 10 most recent tweets in the user's news feed.

## Solutions

### 1. Best Optimized Solution - Hash Maps and Heap

Use hash maps to store tweets and followees, and a heap to find the most recent tweets.

```python
import heapq
from collections import defaultdict

class Twitter:
    def __init__(self):
        # Initialize the Twitter object
        self.time = 0  # Timestamp for tweets
        self.tweets = defaultdict(list)  # userId -> list of (time, tweetId)
        self.followees = defaultdict(set)  # userId -> set of followeeIds
        
        # Each user follows themselves
        for i in range(1, 501):
            self.followees[i].add(i)

    def postTweet(self, userId, tweetId):
        # Compose a new tweet with ID tweetId by the user userId
        self.time += 1
        self.tweets[userId].append((-self.time, tweetId))  # Use negative time for max-heap

    def getNewsFeed(self, userId):
        # Retrieve the 10 most recent tweet IDs in the user's news feed
        max_heap = []
        
        # Add tweets from the user and their followees to the heap
        for followeeId in self.followees[userId]:
            for time, tweetId in self.tweets[followeeId]:
                heapq.heappush(max_heap, (time, tweetId))
                
                # Keep only the 10 most recent tweets
                if len(max_heap) > 10:
                    heapq.heappop(max_heap)
        
        # Extract the tweet IDs from the heap in reverse order (most recent first)
        result = []
        while max_heap:
            result.append(heapq.heappop(max_heap)[1])
        
        return result[::-1]

    def follow(self, followerId, followeeId):
        # User followerId starts following user followeeId
        self.followees[followerId].add(followeeId)

    def unfollow(self, followerId, followeeId):
        # User followerId stops following user followeeId
        if followerId != followeeId:  # A user cannot unfollow themselves
            self.followees[followerId].discard(followeeId)
```

**Time Complexity:**
- `postTweet`: O(1) - We append the tweet to the user's tweet list.
- `getNewsFeed`: O(n log 10) - We process n tweets and maintain a heap of size 10, where n is the total number of tweets from the user and their followees.
- `follow`: O(1) - We add the followee to the user's followee set.
- `unfollow`: O(1) - We remove the followee from the user's followee set.

**Space Complexity:** O(n) - We store all tweets and followee relationships.

### 2. Alternative Solution - K-way Merge

Use a k-way merge algorithm to find the 10 most recent tweets.

```python
from collections import defaultdict
import heapq

class Twitter:
    def __init__(self):
        # Initialize the Twitter object
        self.time = 0  # Timestamp for tweets
        self.tweets = defaultdict(list)  # userId -> list of (time, tweetId)
        self.followees = defaultdict(set)  # userId -> set of followeeIds
        
        # Each user follows themselves
        for i in range(1, 501):
            self.followees[i].add(i)

    def postTweet(self, userId, tweetId):
        # Compose a new tweet with ID tweetId by the user userId
        self.time += 1
        self.tweets[userId].append((self.time, tweetId))

    def getNewsFeed(self, userId):
        # Retrieve the 10 most recent tweet IDs in the user's news feed
        result = []
        
        # Get the tweets from the user and their followees
        all_tweets = []
        for followeeId in self.followees[userId]:
            all_tweets.extend(self.tweets[followeeId])
        
        # Sort the tweets by time in descending order
        all_tweets.sort(reverse=True)
        
        # Return the 10 most recent tweets
        return [tweetId for _, tweetId in all_tweets[:10]]

    def follow(self, followerId, followeeId):
        # User followerId starts following user followeeId
        self.followees[followerId].add(followeeId)

    def unfollow(self, followerId, followeeId):
        # User followerId stops following user followeeId
        if followerId != followeeId:  # A user cannot unfollow themselves
            self.followees[followerId].discard(followeeId)
```

**Time Complexity:**
- `postTweet`: O(1) - We append the tweet to the user's tweet list.
- `getNewsFeed`: O(n log n) - We sort all tweets by time, where n is the total number of tweets from the user and their followees.
- `follow`: O(1) - We add the followee to the user's followee set.
- `unfollow`: O(1) - We remove the followee from the user's followee set.

**Space Complexity:** O(n) - We store all tweets and followee relationships.

### 3. Alternative Solution - Optimized K-way Merge

Use a more efficient k-way merge algorithm to find the 10 most recent tweets.

```python
from collections import defaultdict
import heapq

class Twitter:
    def __init__(self):
        # Initialize the Twitter object
        self.time = 0  # Timestamp for tweets
        self.tweets = defaultdict(list)  # userId -> list of (time, tweetId)
        self.followees = defaultdict(set)  # userId -> set of followeeIds
        
        # Each user follows themselves
        for i in range(1, 501):
            self.followees[i].add(i)

    def postTweet(self, userId, tweetId):
        # Compose a new tweet with ID tweetId by the user userId
        self.time += 1
        self.tweets[userId].append((self.time, tweetId))

    def getNewsFeed(self, userId):
        # Retrieve the 10 most recent tweet IDs in the user's news feed
        result = []
        
        # Use a max-heap for k-way merge
        max_heap = []
        
        # Add the most recent tweet from each followee to the heap
        for followeeId in self.followees[userId]:
            if self.tweets[followeeId]:
                # Add (time, tweetId, followeeId, index) to the heap
                time, tweetId = self.tweets[followeeId][-1]
                heapq.heappush(max_heap, (-time, tweetId, followeeId, len(self.tweets[followeeId]) - 1))
        
        # Get the 10 most recent tweets
        while max_heap and len(result) < 10:
            neg_time, tweetId, followeeId, index = heapq.heappop(max_heap)
            result.append(tweetId)
            
            # Add the next tweet from the same followee to the heap
            if index > 0:
                time, tweetId = self.tweets[followeeId][index - 1]
                heapq.heappush(max_heap, (-time, tweetId, followeeId, index - 1))
        
        return result

    def follow(self, followerId, followeeId):
        # User followerId starts following user followeeId
        self.followees[followerId].add(followeeId)

    def unfollow(self, followerId, followeeId):
        # User followerId stops following user followeeId
        if followerId != followeeId:  # A user cannot unfollow themselves
            self.followees[followerId].discard(followeeId)
```

**Time Complexity:**
- `postTweet`: O(1) - We append the tweet to the user's tweet list.
- `getNewsFeed`: O(k log k + 10 log k) - We add k tweets to the heap, where k is the number of followees, and then extract at most 10 tweets.
- `follow`: O(1) - We add the followee to the user's followee set.
- `unfollow`: O(1) - We remove the followee from the user's followee set.

**Space Complexity:** O(n) - We store all tweets and followee relationships.

## Solution Choice and Explanation

The hash maps and heap solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It achieves O(n log 10) time complexity for the `getNewsFeed` operation, which is efficient for this problem.

2. **Simplicity**: It's straightforward to implement and understand.

3. **Correctness**: It correctly handles all the required operations.

The key insight of this approach is to use hash maps to store tweets and followees, and a heap to efficiently find the 10 most recent tweets in the user's news feed. We use a max-heap (implemented as a min-heap with negative timestamps) to keep track of the most recent tweets.

For the `getNewsFeed` operation, we add all tweets from the user and their followees to the heap, keeping only the 10 most recent tweets. Then, we extract the tweet IDs from the heap in reverse order to get the most recent tweets first.

For example, let's trace through the example:
1. `postTweet(1, 5)`: User 1 posts a tweet with ID 5 at time 1.
   - tweets = {1: [(-1, 5)]}
   - followees = {1: {1}}
2. `getNewsFeed(1)`: Get the news feed for User 1.
   - Add tweets from User 1 to the heap: heap = [(-1, 5)]
   - Extract the tweet IDs: result = [5]
3. `follow(1, 2)`: User 1 follows User 2.
   - followees = {1: {1, 2}}
4. `postTweet(2, 6)`: User 2 posts a tweet with ID 6 at time 2.
   - tweets = {1: [(-1, 5)], 2: [(-2, 6)]}
5. `getNewsFeed(1)`: Get the news feed for User 1.
   - Add tweets from User 1 and User 2 to the heap: heap = [(-2, 6), (-1, 5)]
   - Extract the tweet IDs: result = [6, 5]
6. `unfollow(1, 2)`: User 1 unfollows User 2.
   - followees = {1: {1}}
7. `getNewsFeed(1)`: Get the news feed for User 1.
   - Add tweets from User 1 to the heap: heap = [(-1, 5)]
   - Extract the tweet IDs: result = [5]

The alternative solutions (Solutions 2 and 3) are also correct but less efficient for the `getNewsFeed` operation. Solution 2 sorts all tweets, which takes O(n log n) time, and Solution 3 uses a more complex k-way merge algorithm.

In an interview, I would first mention the hash maps and heap solution as the most efficient approach for this problem.
