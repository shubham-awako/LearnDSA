# 12. Advanced Graphs

## Concept Overview

Advanced graph algorithms build upon the basic graph traversal techniques (DFS, BFS) to solve more complex problems. These algorithms are essential for solving optimization problems, finding shortest paths, detecting negative cycles, and more.

### Key Concepts
- **Shortest Path Algorithms**: Algorithms to find the shortest path between nodes in a graph.
  - **Dijkstra's Algorithm**: Finds the shortest path from a source vertex to all other vertices in a weighted graph with non-negative weights.
  - **Bellman-Ford Algorithm**: Finds the shortest path from a source vertex to all other vertices in a weighted graph, even with negative weights (but no negative cycles).
  - **Floyd-Warshall Algorithm**: Finds the shortest paths between all pairs of vertices in a weighted graph.
- **Minimum Spanning Tree (MST)**: A subset of the edges of a connected, edge-weighted graph that connects all vertices together without any cycles and with the minimum possible total edge weight.
  - **Kruskal's Algorithm**: Builds an MST by adding edges in order of increasing weight, skipping edges that would create a cycle.
  - **Prim's Algorithm**: Builds an MST by starting from a vertex and adding the minimum weight edge that connects a vertex in the tree to a vertex outside the tree.
- **Network Flow**: Algorithms to find the maximum flow in a flow network.
  - **Ford-Fulkerson Algorithm**: Finds the maximum flow in a flow network.
  - **Edmonds-Karp Algorithm**: An implementation of Ford-Fulkerson that uses BFS to find augmenting paths.
  - **Dinic's Algorithm**: An efficient algorithm for computing the maximum flow in a flow network.
- **Strongly Connected Components (SCC)**: Maximal subgraphs where every vertex is reachable from every other vertex.
  - **Kosaraju's Algorithm**: Finds all SCCs in a directed graph.
  - **Tarjan's Algorithm**: Finds all SCCs in a directed graph with a single DFS.
- **Topological Sort**: An ordering of the vertices in a directed acyclic graph (DAG) such that for every directed edge (u, v), vertex u comes before vertex v in the ordering.
- **Bipartite Graph**: A graph whose vertices can be divided into two disjoint sets such that every edge connects vertices from different sets.
- **Eulerian Path and Circuit**: A path that visits every edge exactly once. A circuit is a path that starts and ends at the same vertex.
- **Hamiltonian Path and Circuit**: A path that visits every vertex exactly once. A circuit is a path that starts and ends at the same vertex.

### Common Applications
- **Shortest Path**: Navigation systems, network routing protocols.
- **Minimum Spanning Tree**: Network design, clustering algorithms.
- **Network Flow**: Transportation networks, bipartite matching.
- **Strongly Connected Components**: Social network analysis, compiler optimization.
- **Topological Sort**: Task scheduling, dependency resolution.
- **Bipartite Graph**: Matching problems, resource allocation.
- **Eulerian Path and Circuit**: Circuit design, puzzle solving.
- **Hamiltonian Path and Circuit**: Traveling salesman problem, DNA sequencing.

## Problems

| # | Problem | Difficulty | Solution Link |
|---|---------|------------|---------------|
| 1 | Min Cost to Connect All Points | Medium | [Solution](./Min_Cost_to_Connect_All_Points.md) |
| 2 | Network Delay Time | Medium | [Solution](./Network_Delay_Time.md) |
| 3 | Swim in Rising Water | Hard | [Solution](./Swim_in_Rising_Water.md) |
| 4 | Alien Dictionary | Hard | [Solution](./Alien_Dictionary.md) |
| 5 | Reconstruct Itinerary | Hard | [Solution](./Reconstruct_Itinerary.md) |
| 6 | Cheapest Flights Within K Stops | Medium | [Solution](./Cheapest_Flights_Within_K_Stops.md) |
