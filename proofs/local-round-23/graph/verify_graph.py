"""Independent breadth-first-search and exhaustive covering check for the 15-vertex graph."""
from collections import deque
from itertools import product


def graph_with_tail(t):
    # Backbone 0,...,t+3, with t-1 additional copies of vertex 1.
    graph = [set() for _ in range(2 * t + 3)]

    def add_edge(u, v):
        graph[u].add(v)
        graph[v].add(u)

    for i in range(t + 3):
        add_edge(i, i + 1)
    for extra in range(t + 4, len(graph)):
        add_edge(0, extra)
        add_edge(2, extra)
    return graph


def distances(graph, source):
    dist = {source: 0}
    queue = deque([source])
    while queue:
        v = queue.popleft()
        for w in graph[v]:
            if w not in dist:
                dist[w] = dist[v] + 1
                queue.append(w)
    assert len(dist) == len(graph)
    return [dist[v] for v in range(len(graph))]


def main():
    graph = graph_with_tail(6)
    n = len(graph)
    dist = [distances(graph, v) for v in range(n)]
    degree = sorted(map(len, graph), reverse=True)
    slater = next(k for k in range(1, n + 1) if k + sum(degree[:k]) >= n)
    assert (n, slater, max(map(max, dist))) == (15, 2, 9)

    def covered(sources):
        return {v for v in range(n)
                if any(dist[w][v] <= len(sources) - i - 1 for i, w in enumerate(sources))}

    upper = (2, 7, 9, 5)
    assert len(covered(upper)) == n
    assert all(dist[upper[i]][upper[j]] >= j - i for j in range(4) for i in range(j))
    tested = 0
    best = 0
    for sources in product(range(n), repeat=3):
        size = len(covered(sources))
        assert size < n
        best = max(best, size)
        tested += 1
    print(f"{n} vertices, degrees {degree}, diameter 9, Slater number {slater}")
    print(f"{tested} three-center schedules checked; maximum coverage {best}/{n}")
    print(f"Four sources {upper} burn all vertices; burning number = 4")


if __name__ == "__main__":
    main()
