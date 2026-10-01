---
title: Dynamic Programming
date_created: 2026-10-01T12:43:43
date: 2026-10-01T12:43:45
author: Sushant Vema
tags:
  - programming
  - algorithms
publish: true
---

Dynamic Programming (aka DP) is a technique developed by American mathematician
[Richard Bellman](https://en.wikipedia.org/wiki/Richard_Bellman) in the early
1950s.

The core idea behind DP is as follows:

> **Simplifying a complicated problem by breaking it down into simpler
> sub-problems in a recursive manner.**

In computer science, if a problem can be optimally solved by splitting it up
into sub-problems and then recursively finding the optimal solutions to these
sub-problems, it is said to have **optimal substructure**.

The relationship between the value of the larger problem and the values of the
sub-problems is called the **Bellman equation.**

For our purposes we are going to set aside the definition of DP in the
mathematical optimization sense (simplifying a decision problem by breaking it
down into sequence of decision steps over time) as well as ignoring all other
application areas for now other than computer science.

For a computer science problem to be solvable with DP, it must have optimal
substructure and **overlapping sub-problems**. If it can be solved by combining
optimal solutions to _non-overlapping sub-problems_, the strategy is called
**divide-and-conquer**.

> [!NOTE]
> This is why [Merge Sort](https://github.com/sushantvema/algorithms/blob/master/sorting/merge_sort.md) and [Quick Sort](https://github.com/sushantvema/algorithms/blob/master/sorting/quick_sort.md) are not classified as DP algorithms.

Here's a simple example. Given a graph `G=(V,E)`, the shortest path `p` from a
vertex `u` to a vertex `v` exhibits optimal substructure:

- Take any intermediate vertex `w` on the shortest path `p`. If `p` is truly the
  shortest path, it can be split into `p_1` from `u` to `w` and `p_2` from `w` to
  `v` such that both of these sub-paths are the shortest paths between their
  corresponding vertices.
- Therefore, we can formulate the solution for finding shortest paths in a
  recursive manner (refer to algorithms like **Bellman-Ford** and **Floyd-Warshall** )

Another classic example is the recursive formulation for generating the
Fibonacci sequence: `F_i = F_(i-1) + F_(i-2)` with base case `F_1 = F_2 = 1`. In
the process of computing an arbitrary `F_i`, we solve the same subproblems over
and over again with naive recursion. Dynamic programming makes sure we solve
each subproblem only once.

## TODO

- More shortest path algorithms
- Memoization
- Top-down vs Bottom-up approaches
- Tower of Hanoi - games
- Links to my algorithms / WIP leetcode

## References

- [Wikipedia - Dynamic Programming](https://en.wikipedia.org/wiki/Dynamic_programming)
