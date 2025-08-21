# Design Add and Search Words Data Structure

## Problem Statement

Design a data structure that supports adding new words and finding if a string matches any previously added string.

Implement the `WordDictionary` class:

- `WordDictionary()` Initializes the object.
- `void addWord(word)` Adds `word` to the data structure, it can be matched later.
- `bool search(word)` Returns `true` if there is any string in the data structure that matches `word` or `false` otherwise. `word` may contain dots `'.'` where dots can be matched with any letter.

**Example:**
```
Input
["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
[[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
Output
[null,null,null,null,false,true,true,true]

Explanation
WordDictionary wordDictionary = new WordDictionary();
wordDictionary.addWord("bad");
wordDictionary.addWord("dad");
wordDictionary.addWord("mad");
wordDictionary.search("pad"); // return False
wordDictionary.search("bad"); // return True
wordDictionary.search(".ad"); // return True
wordDictionary.search("b.."); // return True
```

**Constraints:**
- `1 <= word.length <= 25`
- `word` in `addWord` consists of lowercase English letters.
- `word` in `search` consists of lowercase English letters or dots `'.'`.
- There will be at most `3 * 10^4` calls in total to `addWord` and `search`.

## Concept Overview

This problem is an extension of the Trie (Prefix Tree) data structure, with the added complexity of handling wildcard characters (dots) during search. The key insight is to implement a trie with a modified search function that can handle wildcard characters by exploring all possible paths when a dot is encountered.

## Solutions

### 1. Best Optimized Solution - Trie with Recursive Search

Use a trie data structure with a recursive search function to handle wildcard characters.

```python
class TrieNode:
    def __init__(self):
        self.children = {}  # Dictionary of child nodes (key: character, value: node)
        self.is_end_of_word = False  # Flag to indicate if the node represents the end of a word

class WordDictionary:
    def __init__(self):
        # Initialize the trie with a root node
        self.root = TrieNode()

    def addWord(self, word: str) -> None:
        # Add a word to the trie
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end_of_word = True

    def search(self, word: str) -> bool:
        # Search for a word in the trie, with support for wildcard characters
        def dfs(node, index):
            # If we've reached the end of the word, check if the node represents the end of a word
            if index == len(word):
                return node.is_end_of_word
            
            # Get the current character
            char = word[index]
            
            # If the character is a dot, try all possible children
            if char == '.':
                for child in node.children.values():
                    if dfs(child, index + 1):
                        return True
                return False
            
            # If the character is not a dot, check if it exists in the children
            if char not in node.children:
                return False
            
            # Recursively search the next character
            return dfs(node.children[char], index + 1)
        
        return dfs(self.root, 0)
```

**Time Complexity:**
- `addWord`: O(m) - We process each character in the word once.
- `search`: O(m * 26^d) - In the worst case, we need to explore all possible paths for each dot, where m is the length of the word and d is the number of dots.

**Space Complexity:** O(n) - We need to store n nodes, where n is the total number of characters in all added words.

### 2. Alternative Solution - Trie with Iterative Search

Use a trie data structure with an iterative search function to handle wildcard characters.

```python
class TrieNode:
    def __init__(self):
        self.children = {}  # Dictionary of child nodes (key: character, value: node)
        self.is_end_of_word = False  # Flag to indicate if the node represents the end of a word

class WordDictionary:
    def __init__(self):
        # Initialize the trie with a root node
        self.root = TrieNode()

    def addWord(self, word: str) -> None:
        # Add a word to the trie
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end_of_word = True

    def search(self, word: str) -> bool:
        # Search for a word in the trie, with support for wildcard characters
        # Use a stack to perform iterative DFS
        stack = [(self.root, 0)]
        
        while stack:
            node, index = stack.pop()
            
            # If we've reached the end of the word, check if the node represents the end of a word
            if index == len(word):
                if node.is_end_of_word:
                    return True
                continue
            
            # Get the current character
            char = word[index]
            
            # If the character is a dot, try all possible children
            if char == '.':
                for child in node.children.values():
                    stack.append((child, index + 1))
            # If the character is not a dot, check if it exists in the children
            elif char in node.children:
                stack.append((node.children[char], index + 1))
        
        return False
```

**Time Complexity:**
- `addWord`: O(m) - We process each character in the word once.
- `search`: O(m * 26^d) - In the worst case, we need to explore all possible paths for each dot, where m is the length of the word and d is the number of dots.

**Space Complexity:** O(n) - We need to store n nodes, where n is the total number of characters in all added words.

### 3. Alternative Solution - Dictionary of Words by Length

Group words by length and use a brute-force approach for searching.

```python
from collections import defaultdict

class WordDictionary:
    def __init__(self):
        # Initialize a dictionary to store words by length
        self.words_by_length = defaultdict(list)

    def addWord(self, word: str) -> None:
        # Add a word to the dictionary
        self.words_by_length[len(word)].append(word)

    def search(self, word: str) -> bool:
        # Search for a word in the dictionary
        # If the word doesn't contain dots, check if it exists in the dictionary
        if '.' not in word:
            return word in self.words_by_length[len(word)]
        
        # If the word contains dots, check if it matches any word of the same length
        for candidate in self.words_by_length[len(word)]:
            match = True
            for i in range(len(word)):
                if word[i] != '.' and word[i] != candidate[i]:
                    match = False
                    break
            if match:
                return True
        
        return False
```

**Time Complexity:**
- `addWord`: O(1) - We simply append the word to a list.
- `search`: O(n * m) - In the worst case, we need to check all words of the same length, where n is the number of words of the same length and m is the length of the word.

**Space Complexity:** O(n * m) - We store all words, where n is the number of words and m is the average length of a word.

## Solution Choice and Explanation

The trie with recursive search solution (Solution 1) is the best approach for this problem because:

1. **Efficiency**: It efficiently handles the search operation, especially when there are many words with common prefixes.

2. **Elegance**: The recursive search function naturally handles the wildcard characters by exploring all possible paths when a dot is encountered.

3. **Space Efficiency**: The trie structure is memory-efficient for storing words with common prefixes.

The key insight of this approach is to use a trie data structure to store the words and implement a recursive search function that can handle wildcard characters. When a dot is encountered during the search, we explore all possible paths by recursively searching each child node.

For example, let's trace through the operations in the example:
1. `wordDictionary.addWord("bad")`:
   - Start at the root node
   - Process 'b': Create a new node at children['b']
   - Process 'a': Create a new node at children['b']['a']
   - Process 'd': Create a new node at children['b']['a']['d']
   - Mark the end of the word: children['b']['a']['d'].is_end_of_word = True

2. `wordDictionary.addWord("dad")`:
   - Start at the root node
   - Process 'd': Create a new node at children['d']
   - Process 'a': Create a new node at children['d']['a']
   - Process 'd': Create a new node at children['d']['a']['d']
   - Mark the end of the word: children['d']['a']['d'].is_end_of_word = True

3. `wordDictionary.addWord("mad")`:
   - Start at the root node
   - Process 'm': Create a new node at children['m']
   - Process 'a': Create a new node at children['m']['a']
   - Process 'd': Create a new node at children['m']['a']['d']
   - Mark the end of the word: children['m']['a']['d'].is_end_of_word = True

4. `wordDictionary.search("pad")`:
   - Start at the root node
   - Process 'p': 'p' is not in children, return False

5. `wordDictionary.search("bad")`:
   - Start at the root node
   - Process 'b': Move to children['b']
   - Process 'a': Move to children['b']['a']
   - Process 'd': Move to children['b']['a']['d']
   - Check if the node represents the end of a word: children['b']['a']['d'].is_end_of_word = True
   - Return True

6. `wordDictionary.search(".ad")`:
   - Start at the root node
   - Process '.': Try all children
     - Try 'b': Move to children['b']
       - Process 'a': Move to children['b']['a']
         - Process 'd': Move to children['b']['a']['d']
         - Check if the node represents the end of a word: children['b']['a']['d'].is_end_of_word = True
         - Return True
     - (No need to try other children since we found a match)

7. `wordDictionary.search("b..")`:
   - Start at the root node
   - Process 'b': Move to children['b']
   - Process '.': Try all children
     - Try 'a': Move to children['b']['a']
       - Process '.': Try all children
         - Try 'd': Move to children['b']['a']['d']
           - Check if the node represents the end of a word: children['b']['a']['d'].is_end_of_word = True
           - Return True
         - (No need to try other children since we found a match)
     - (No need to try other children since we found a match)

The trie with iterative search solution (Solution 2) is also efficient but may be harder to understand and implement correctly. The dictionary of words by length solution (Solution 3) is simpler but less efficient, especially when there are many words or when the words have common prefixes.

In an interview, I would first mention the trie with recursive search solution as the most elegant and efficient approach for this problem, and then discuss the iterative search and dictionary-based solutions as alternatives if asked for different approaches.
