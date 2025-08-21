# Implement Trie (Prefix Tree)

## Problem Statement

A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.

Implement the Trie class:

- `Trie()` Initializes the trie object.
- `void insert(String word)` Inserts the string `word` into the trie.
- `boolean search(String word)` Returns `true` if the string `word` is in the trie (i.e., was inserted before), and `false` otherwise.
- `boolean startsWith(String prefix)` Returns `true` if there is a previously inserted string `word` that has the prefix `prefix`, and `false` otherwise.

**Example 1:**
```
Input
["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
[[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
Output
[null, null, true, false, true, null, true]

Explanation
Trie trie = new Trie();
trie.insert("apple");
trie.search("apple");   // return True
trie.search("app");     // return False
trie.startsWith("app"); // return True
trie.insert("app");
trie.search("app");     // return True
```

**Constraints:**
- `1 <= word.length, prefix.length <= 2000`
- `word` and `prefix` consist only of lowercase English letters.
- At most `3 * 10^4` calls in total will be made to `insert`, `search`, and `startsWith`.

## Concept Overview

This problem tests your understanding of the trie data structure. The key insight is to implement a trie node that contains:
1. A map or array of child nodes (one for each possible character)
2. A boolean flag to indicate if the node represents the end of a word

## Solutions

### 1. Best Optimized Solution - Array-Based Trie

Use an array of child nodes for each trie node, where each index corresponds to a lowercase English letter.

```python
class Trie:
    def __init__(self):
        # Initialize the trie
        self.children = [None] * 26  # Array of child nodes (one for each lowercase letter)
        self.is_end_of_word = False  # Flag to indicate if the node represents the end of a word
    
    def insert(self, word: str) -> None:
        # Insert the word into the trie
        node = self
        for char in word:
            index = ord(char) - ord('a')  # Convert the character to an index (0-25)
            if not node.children[index]:
                node.children[index] = Trie()  # Create a new node if the child doesn't exist
            node = node.children[index]  # Move to the child node
        node.is_end_of_word = True  # Mark the end of the word
    
    def search(self, word: str) -> bool:
        # Search for the word in the trie
        node = self
        for char in word:
            index = ord(char) - ord('a')  # Convert the character to an index (0-25)
            if not node.children[index]:
                return False  # The character doesn't exist in the trie
            node = node.children[index]  # Move to the child node
        return node.is_end_of_word  # Return true if the node represents the end of a word
    
    def startsWith(self, prefix: str) -> bool:
        # Check if there is a word in the trie that starts with the given prefix
        node = self
        for char in prefix:
            index = ord(char) - ord('a')  # Convert the character to an index (0-25)
            if not node.children[index]:
                return False  # The character doesn't exist in the trie
            node = node.children[index]  # Move to the child node
        return True  # The prefix exists in the trie
```

**Time Complexity:**
- `insert`: O(m) - We process each character in the word once.
- `search`: O(m) - We process each character in the word once.
- `startsWith`: O(m) - We process each character in the prefix once.
where m is the length of the word or prefix.

**Space Complexity:** O(n * 26) - Each node can have up to 26 children (one for each lowercase letter), and we need to store n nodes, where n is the total number of characters in all inserted words.

### 2. Alternative Solution - Map-Based Trie

Use a dictionary (hash map) of child nodes for each trie node, where each key is a character.

```python
class Trie:
    def __init__(self):
        # Initialize the trie
        self.children = {}  # Dictionary of child nodes (key: character, value: node)
        self.is_end_of_word = False  # Flag to indicate if the node represents the end of a word
    
    def insert(self, word: str) -> None:
        # Insert the word into the trie
        node = self
        for char in word:
            if char not in node.children:
                node.children[char] = Trie()  # Create a new node if the child doesn't exist
            node = node.children[char]  # Move to the child node
        node.is_end_of_word = True  # Mark the end of the word
    
    def search(self, word: str) -> bool:
        # Search for the word in the trie
        node = self
        for char in word:
            if char not in node.children:
                return False  # The character doesn't exist in the trie
            node = node.children[char]  # Move to the child node
        return node.is_end_of_word  # Return true if the node represents the end of a word
    
    def startsWith(self, prefix: str) -> bool:
        # Check if there is a word in the trie that starts with the given prefix
        node = self
        for char in prefix:
            if char not in node.children:
                return False  # The character doesn't exist in the trie
            node = node.children[char]  # Move to the child node
        return True  # The prefix exists in the trie
```

**Time Complexity:**
- `insert`: O(m) - We process each character in the word once.
- `search`: O(m) - We process each character in the word once.
- `startsWith`: O(m) - We process each character in the prefix once.
where m is the length of the word or prefix.

**Space Complexity:** O(n) - We need to store n nodes, where n is the total number of characters in all inserted words.

### 3. Alternative Solution - Simplified Trie

Use a simplified trie structure where each node is represented as a dictionary.

```python
class Trie:
    def __init__(self):
        # Initialize the trie as a dictionary
        self.trie = {}
    
    def insert(self, word: str) -> None:
        # Insert the word into the trie
        node = self.trie
        for char in word:
            if char not in node:
                node[char] = {}  # Create a new node if the child doesn't exist
            node = node[char]  # Move to the child node
        node['$'] = True  # Mark the end of the word with a special character
    
    def search(self, word: str) -> bool:
        # Search for the word in the trie
        node = self.trie
        for char in word:
            if char not in node:
                return False  # The character doesn't exist in the trie
            node = node[char]  # Move to the child node
        return '$' in node  # Return true if the node represents the end of a word
    
    def startsWith(self, prefix: str) -> bool:
        # Check if there is a word in the trie that starts with the given prefix
        node = self.trie
        for char in prefix:
            if char not in node:
                return False  # The character doesn't exist in the trie
            node = node[char]  # Move to the child node
        return True  # The prefix exists in the trie
```

**Time Complexity:**
- `insert`: O(m) - We process each character in the word once.
- `search`: O(m) - We process each character in the word once.
- `startsWith`: O(m) - We process each character in the prefix once.
where m is the length of the word or prefix.

**Space Complexity:** O(n) - We need to store n nodes, where n is the total number of characters in all inserted words.

## Solution Choice and Explanation

The map-based trie solution (Solution 2) is the best approach for this problem because:

1. **Space Efficiency**: It uses less space than the array-based solution when the character set is large or sparse, as it only stores nodes for characters that are actually used.

2. **Flexibility**: It can easily handle different character sets (not just lowercase English letters) without modifying the code.

3. **Readability**: It's more intuitive and easier to understand than the array-based solution.

The key insight of this approach is to use a dictionary (hash map) to store child nodes for each trie node, where each key is a character. This allows us to efficiently insert, search, and check for prefixes in the trie.

For example, let's trace through the operations in the example:
1. `trie.insert("apple")`:
   - Start at the root node: {}
   - Process 'a': Create a new node at children['a'] = {}
   - Process 'p': Create a new node at children['a']['p'] = {}
   - Process 'p': Create a new node at children['a']['p']['p'] = {}
   - Process 'l': Create a new node at children['a']['p']['p']['l'] = {}
   - Process 'e': Create a new node at children['a']['p']['p']['l']['e'] = {}
   - Mark the end of the word: children['a']['p']['p']['l']['e'].is_end_of_word = True
   - Trie structure: {'a': {'p': {'p': {'l': {'e': {'is_end_of_word': True}}}}}}

2. `trie.search("apple")`:
   - Start at the root node
   - Process 'a': Move to children['a']
   - Process 'p': Move to children['a']['p']
   - Process 'p': Move to children['a']['p']['p']
   - Process 'l': Move to children['a']['p']['p']['l']
   - Process 'e': Move to children['a']['p']['p']['l']['e']
   - Check if the node represents the end of a word: children['a']['p']['p']['l']['e'].is_end_of_word = True
   - Return True

3. `trie.search("app")`:
   - Start at the root node
   - Process 'a': Move to children['a']
   - Process 'p': Move to children['a']['p']
   - Process 'p': Move to children['a']['p']['p']
   - Check if the node represents the end of a word: children['a']['p']['p'].is_end_of_word = False
   - Return False

4. `trie.startsWith("app")`:
   - Start at the root node
   - Process 'a': Move to children['a']
   - Process 'p': Move to children['a']['p']
   - Process 'p': Move to children['a']['p']['p']
   - The prefix exists in the trie
   - Return True

5. `trie.insert("app")`:
   - Start at the root node
   - Process 'a': Move to children['a']
   - Process 'p': Move to children['a']['p']
   - Process 'p': Move to children['a']['p']['p']
   - Mark the end of the word: children['a']['p']['p'].is_end_of_word = True
   - Trie structure: {'a': {'p': {'p': {'is_end_of_word': True, 'l': {'e': {'is_end_of_word': True}}}}}}

6. `trie.search("app")`:
   - Start at the root node
   - Process 'a': Move to children['a']
   - Process 'p': Move to children['a']['p']
   - Process 'p': Move to children['a']['p']['p']
   - Check if the node represents the end of a word: children['a']['p']['p'].is_end_of_word = True
   - Return True

The array-based trie solution (Solution 1) is more efficient when the character set is small and dense (e.g., only lowercase English letters), as it provides constant-time access to child nodes. However, it uses more space when the character set is large or sparse.

The simplified trie solution (Solution 3) is more concise but less object-oriented, making it harder to extend with additional functionality.

In an interview, I would first mention the map-based trie solution as the most flexible and readable approach, and then discuss the array-based solution as an optimization for specific cases.
