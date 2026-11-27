"""Independent check of the weighted determinant against optical ray tracing."""
from collections import Counter
from itertools import product


def optical_counts(n, k):
    # Each vertex below is the diagonal segment joining two adjacent side
    # midpoints in one cell. Index the quadrants NW, NE, SE, SW cyclically.
    boundary, seams = [], []
    for r, c in product(range(n), range(k)):
        base = 4*(r*k+c)
        nw, ne, se, sw = range(base, base+4)
        if not r:
            boundary.append((nw, ne))
        if not c:
            boundary.append((nw, sw))
        if r+1 == n:
            boundary.append((se, sw))
        else:
            seams.append((sw, se, nw+4*k, ne+4*k))
        if c+1 == k:
            boundary.append((ne, se))
        else:
            seams.append((ne, se, nw+4, sw+4))
    counts = Counter()
    for bits in range(1 << len(seams)):
        p = list(range(4*n*k))

        def root(v):
            while p[v] != v:
                v = p[v]
            return v

        def join(v, w):
            p[root(v)] = root(w)

        for v, w in boundary:
            join(v, w)
        for j, (a, b, c, d) in enumerate(seams):
            if bits >> j & 1:
                join(a, b)
                join(c, d)
            else:
                join(a, d)
                join(b, c)
        if sum(i == v for i, v in enumerate(p)) == 1:
            counts[bits.bit_count()] += 1
    return counts


def determinant(a):
    if not a:
        return 1
    # At positive integer t the path matrix here has positive leading minors.
    previous = 1
    for i in range(len(a)-1):
        pivot = a[i][i]
        assert pivot
        for j in range(i+1, len(a)):
            for k in range(i+1, len(a)):
                num = a[j][k]*pivot - a[j][i]*a[i][k]
                assert num % previous == 0
                a[j][k] = num // previous
        previous = pivot
    return a[-1][-1]


def predicted(n, k, t):
    cells = list(product(range(n-1), range(k-1)))
    a = [[0]*len(cells) for _ in cells]
    for i, (r, c) in enumerate(cells):
        a[i][i] = 4*t
        for j, (u, v) in enumerate(cells):
            if abs(r-u)+abs(c-v) == 1:
                high = ((r+c) % 2 == 0) == (r == u)
                a[i][j] = -t-1 if high else 1-t
    return determinant(a)


if __name__ == "__main__":
    for n, k in [(1,4), (2,5), (3,3), (3,4)]:
        counts = optical_counts(n, k)
        b = (n-1)*(k-1)
        assert max(counts) <= b
        for t in range(1, b+2):
            assert sum(c*t**m for m, c in counts.items()) == predicted(n, k, t)
        print((n,k), sorted(counts.items()))
