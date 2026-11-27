"""Enumerate staggered, base-contiguous domino towers, independently of the GFs."""

from collections import Counter
from itertools import combinations
from math import comb


def diagonal(excess, heights):
    # The row is stored relative to its leftmost brick. Multiplicities retain
    # the different horizontal offsets of the next row relative to this row.
    current = Counter({
        (extra, tuple(range(extra+1))): 1 for extra in range(excess+1)
    })
    for _ in range(heights):
        yield sum(count for (used, row), count in current.items() if used == excess)
        following = Counter()
        for (used, row), count in current.items():
            sites = sorted(set(row) | {x+1 for x in row})
            for k in range(1, min(len(sites), 1+excess-used)+1):
                for subset in combinations(sites, k):
                    normalized = tuple(x-subset[0] for x in subset)
                    following[used+k-1, normalized] += count
        current = following


def numerator(d, terms):
    return [
        sum(comb(d+1,j)*(-2)**j*terms[k-j] for j in range(min(k,d+1)+1))
        for k in range(len(terms))
    ]


if __name__ == "__main__":
    targets = [[1], [1,0,-1], [1,1,-6,2,5], [1,4,-20,8,33,-4,-33]]
    for d in range(7):
        terms = list(diagonal(d,2*d+10))
        poly = numerator(d, terms)
        assert all(x == 0 for x in poly[2*d+1:])
        if d < len(targets):
            assert poly[:2*d+1] == targets[d]
        print(f"d={d}: numerator = {poly[:2*d+1]}")
