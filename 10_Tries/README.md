# 10. Tries

## Concept Overview

A trie (pronounced as "try") is a tree-like data structure used to store a dynamic set of strings, where the keys are usually strings. Unlike a binary search tree, no node in the tree stores the key associated with that node; instead, its position in the tree defines the key with which it is associated. All the descendants of a node have a common prefix of the string associated with that node, and the root is associated with the empty string.

### Key Concepts
- **Prefix Tree**: A trie is also known as a prefix tree because it can be used to find all strings with a common prefix.
- **Node Structure**: Each node in a trie typically contains:
  - An array or map of child nodes (one for each possible character)
  - A boolean flag to indicate if the node represents the end of a word
- **Path**: The path from the root to a node represents a string.
- **Prefix Sharing**: Tries are memory-efficient for storing strings with common prefixes.
- **Search Complexity**: The time complexity for searching a string of length m is O(m), regardless of the number of strings in the trie.

### Common Operations
- **Insertion**: O(m) - Insert a string of length m into the trie.
- **Search**: O(m) - Search for a string of length m in the trie.
- **Prefix Search**: O(m) - Find all strings with a given prefix of length m.
- **Deletion**: O(m) - Delete a string of length m from the trie.

### Common Techniques
- **Character-by-Character Processing**: Process strings character by character when inserting or searching.
- **Path Compression**: Merge nodes with only one child to save space.
- **Word Frequency Counting**: Store frequency information at nodes to count occurrences of words.
- **Autocomplete**: Use tries to implement autocomplete functionality by finding all strings with a given prefix.

### Advantages
- **Fast Lookups**: O(m) time complexity for lookups, where m is the length of the key.
- **Prefix Matching**: Efficient for prefix-based operations like autocomplete.
- **Space Efficiency**: Memory-efficient for storing strings with common prefixes.

### Disadvantages
- **Memory Usage**: Can be memory-intensive for storing a large number of strings with few common prefixes.
- **Complexity**: More complex to implement than simpler data structures like hash tables.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Implement Trie (Prefix Tree) | Medium | [Solution](./01_Implement_Trie.md) |
| 2 | Design Add and Search Words Data Structure | Medium | [Solution](./02_Design_Add_and_Search_Words_Data_Structure.md) |
| 3 | Word Search II | Hard | [Solution](./03_Word_Search_II.md) |
