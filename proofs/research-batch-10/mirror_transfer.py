"""Exact transfer proof for the five fixed-width claims of A400778."""
from collections import Counter
from functools import cache
from itertools import product


def invert(perm):
    result = [0] * len(perm)
    for i, j in enumerate(perm):
        result[j] = i
    return tuple(result)


@cache
def cell(n, row, first, state):
    count = len(state)
    west, north, east, south = range(count, count + 4)
    clockwise = [north, east, south, west]
    successors = list(state) + clockwise
    if row % 2:
        successors = list(state) + [south, west, north, east]
    seams = []
    if not first:
        seams.append((row, west))
    if row:
        seams.append((count-1, north))
    frontier = list(range(row)) + [east]
    if not first:
        frontier.extend(range(row+1,n))
    if row+1 < n:
        frontier.append(south)
    position = {port:i for i, port in enumerate(frontier)}
    results = []
    for switches in product(range(2), repeat=len(seams)):
        perm = successors.copy()
        for switch,(a,b) in zip(switches,seams):
            if switch:
                perm[a],perm[b] = perm[b],perm[a]
        # Delete retired ports. A whole cycle that vanished is now sealed.
        traced = set()
        reduced = []
        for i in frontier:
            j = perm[i]
            while j not in position:
                traced.add(j)
                j = perm[j]
            reduced.append(position[j])
        if len(traced) + len(frontier) == len(perm):
            results.append(tuple(reduced))
    return results


def strip(n, vector, first=False):
    for row in range(n):
        updated = Counter()
        for state, weight in vector.items():
            for next_state in cell(n, row, first, state):
                updated[next_state] += weight
        vector = updated
    return Counter({invert(p):w for p,w in vector.items()})


def one_cycle(perm):
    j = perm[0]
    size = 1
    while j:
        size += 1
        j = perm[j]
    return size == len(perm)


CLAIMS = {
    2: (2,[4]), 3: (3,[16,-16]), 4: (4,[64,-512]),
    5: (6,[256,-11776,65536,-65536]),
    6: (6,[1024,-237568,12582912,-150994944]),
}


def prove(n):
    import math
    first, coefficients = CLAIMS[n]
    v = strip(n, {():1}, first=True)
    values = []
    for k in range(1, first + math.factorial(n)):
        values.append(sum(w for p,w in v.items() if one_cycle(p)))
        if k >= first:
            assert values[-1] == sum(c*values[-2-i] for i,c in enumerate(coefficients))
        if k + 1 < first + math.factorial(n):
            v = strip(n, v)
    print(n, values[:5], math.factorial(n), flush=True)


if __name__ == "__main__":
    for width in CLAIMS:
        prove(width)
