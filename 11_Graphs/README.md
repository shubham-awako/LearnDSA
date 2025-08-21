# 11. Graphs

## Concept Overview

A graph is a non-linear data structure consisting of nodes (vertices) and edges that connect these nodes. Graphs are used to represent networks of communication, data organization, computational devices, flow of computation, etc.

### Key Concepts
- **Vertex (Node)**: A fundamental unit of a graph, representing an entity.
- **Edge**: A connection between two vertices, representing a relationship between them.
- **Directed Graph**: A graph where edges have a direction (one-way relationship).
- **Undirected Graph**: A graph where edges have no direction (two-way relationship).
- **Weighted Graph**: A graph where edges have weights or costs associated with them.
- **Unweighted Graph**: A graph where edges have no weights or costs.
- **Path**: A sequence of vertices where each adjacent pair is connected by an edge.
- **Cycle**: A path that starts and ends at the same vertex.
- **Connected Graph**: A graph where there is a path between every pair of vertices.
- **Disconnected Graph**: A graph where there are vertices that cannot be reached from others.
- **Tree**: A connected graph with no cycles.
- **Bipartite Graph**: A graph whose vertices can be divided into two disjoint sets such that every edge connects vertices from different sets.
- **Complete Graph**: A graph where every vertex is connected to every other vertex.

### Common Representations
- **Adjacency Matrix**: A 2D array where `matrix[i][j]` represents the edge between vertices `i` and `j`.
- **Adjacency List**: A collection of lists or arrays where `list[i]` contains all the vertices adjacent to vertex `i`.
- **Edge List**: A list of edges, where each edge is represented as a pair of vertices.

### Common Algorithms
- **Depth-First Search (DFS)**: Explores as far as possible along each branch before backtracking.
- **Breadth-First Search (BFS)**: Explores all neighbors at the present depth before moving to nodes at the next depth level.
- **Dijkstra's Algorithm**: Finds the shortest path from a source vertex to all other vertices in a weighted graph with non-negative weights.
- **Bellman-Ford Algorithm**: Finds the shortest path from a source vertex to all other vertices in a weighted graph, even with negative weights (but no negative cycles).
- **Floyd-Warshall Algorithm**: Finds the shortest paths between all pairs of vertices in a weighted graph.
- **Kruskal's Algorithm**: Finds a minimum spanning tree for a connected weighted graph.
- **Prim's Algorithm**: Finds a minimum spanning tree for a connected weighted graph.
- **Topological Sort**: Orders the vertices of a directed acyclic graph (DAG) such that for every directed edge (u, v), vertex u comes before vertex v in the ordering.
- **Union-Find (Disjoint Set)**: Keeps track of a set of elements partitioned into disjoint subsets.

### Common Applications
- **Social Networks**: Representing relationships between people.
- **Web Pages**: Representing links between web pages.
- **Maps**: Representing roads connecting cities.
- **Computer Networks**: Representing connections between devices.
- **Recommendation Systems**: Representing relationships between users and items.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Number of Islands | Medium | [Solution](./01_Number_of_Islands.md) |
| 2 | Clone Graph | Medium | [Solution](./02_Clone_Graph.md) |
| 3 | Max Area of Island | Medium | [Solution](./03_Max_Area_of_Island.md) |
| 4 | Pacific Atlantic Water Flow | Medium | [Solution](./04_Pacific_Atlantic_Water_Flow.md) |
| 5 | Surrounded Regions | Medium | [Solution](./05_Surrounded_Regions.md) |
| 6 | Rotting Oranges | Medium | [Solution](./06_Rotting_Oranges.md) |
| 7 | Course Schedule | Medium | [Solution](./07_Course_Schedule.md) |
| 8 | Course Schedule II | Medium | [Solution](./08_Course_Schedule_II.md) |
| 9 | Redundant Connection | Medium | [Solution](./09_Redundant_Connection.md) |
| 10 | Word Ladder | Hard | [Solution](./10_Word_Ladder.md) |
| 11 | Graph Valid Tree | Medium | [Solution](./11_Graph_Valid_Tree.md) |
