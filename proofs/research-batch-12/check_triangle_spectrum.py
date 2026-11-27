"""Verify finite graph witnesses for the A400369 triangle-spectrum proof."""

from itertools import combinations
from math import comb


# order, triangles, number of edges in the deleted star, path and matching
EXCEPTIONS = (
    (11, 116, 0, 6, 0),
    (12, 164, 0, 5, 1),
    (13, 217, 4, 3, 0),
    (17, 558, 5, 4, 0),
    (21, 1130, 0, 10, 1),
    (23, 1533, 5, 5, 2),
)


def two_extra_vertices(order):
    """All triangle counts obtained from a clique and two extra vertices."""
    clique = order - 2
    counts = set()
    for a in range(clique + 1):
        for b in range(a + 1):
            separate = comb(clique, 3) + comb(a, 2) + comb(b, 2)
            counts.add(separate)
            overlap_min = max(0, a + b - clique)
            counts.update(range(separate + overlap_min, separate + b + 1))
    return counts


def forest_complement(order, star, path, matching):
    """Build the edge set and count triangles directly over triples."""
    removed = set()
    next_vertex = 0
    if star:
        removed.update((0, leaf) for leaf in range(1, star + 1))
        next_vertex = star + 1
    if path:
        removed.update((i, i + 1) for i in range(next_vertex, next_vertex + path))
        next_vertex += path + 1
    for _ in range(matching):
        removed.add((next_vertex, next_vertex + 1))
        next_vertex += 2
    assert next_vertex <= order
    edges = set(combinations(range(order), 2)) - removed
    return sum(
        (x, y) in edges and (x, z) in edges and (y, z) in edges
        for x, y, z in combinations(range(order), 3)
    )


def main():
    missing = set()
    for order in range(4, 75):
        band = set(range(comb(order - 2, 3), comb(order - 1, 3) + 1))
        missing.update((order, count) for count in band - two_extra_vertices(order))
    assert missing == {(order, count) for order, count, *_ in EXCEPTIONS}
    for order, count, star, path, matching in EXCEPTIONS:
        assert forest_complement(order, star, path, matching) == count
    print("All 71 bands for orders 4 through 74 are covered.")
    print("The six exceptional graphs pass direct triangle enumeration.")


if __name__ == "__main__":
    main()
