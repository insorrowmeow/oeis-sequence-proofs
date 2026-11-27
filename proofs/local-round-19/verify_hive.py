"""Independent direct enumeration of the two labelled 3-cycles example."""

from itertools import combinations_with_replacement, product
from math import factorial
from fractions import Fraction


def has_two_three_cycles(permutation):
    remaining = set(range(6))
    lengths = []
    while remaining:
        vertex = next(iter(remaining))
        length = 0
        while vertex in remaining:
            remaining.remove(vertex)
            vertex = permutation[vertex]
            length += 1
        lengths.append(length)
    return lengths == [3, 3]


def connected(smaller, larger):
    neighbors = [set() for _ in range(6)]
    for a, b in zip(smaller, larger):
        neighbors[a].add(b)
        neighbors[b].add(a)
    seen = {0}
    pending = [0]
    while pending:
        for neighbor in neighbors[pending.pop()]:
            if neighbor not in seen:
                seen.add(neighbor)
                pending.append(neighbor)
    return len(seen) == 6


def enumerate_counts():
    counts = [0] * 32
    word_count = 0
    for larger in combinations_with_replacement(range(1, 6), 6):
        mask = sum(1 << (b - 1) for b in set(larger))
        for smaller in product(*(range(b) for b in larger)):
            word_count += 1
            permutation = list(range(6))
            for a, b in zip(smaller, larger):
                permutation[a], permutation[b] = permutation[b], permutation[a]
            if has_two_three_cycles(permutation) and connected(smaller, larger):
                counts[mask] += 1
    return word_count, counts


if __name__ == "__main__":
    total, counts = enumerate_counts()
    expected = [360,120,312,72,696,200,520,120,1752,520,1352,312,2856,696,1752,360]
    assert total == 246730
    assert counts == [0] * 16 + expected
    # Each admissible word has 2! assignments of distinct labels to its
    # two equal-sized cycles. The definition includes the factor 1/6!.
    normalization = Fraction(factorial(2), factorial(6))
    print(f"{total} words inspected, {sum(counts)} admissible, H=(t6/{1/normalization})Q")
    print(f"Q coefficients by binary mask (t2, t3, t4, t5): {counts[16:]}")
