"""Independent finite checks for the critical-modulus theorem. Standard library only."""

from collections import Counter
from functools import cache
from itertools import combinations, combinations_with_replacement


@cache
def root_box(s, bits):
    """Adjacent dyadics bracketing the positive zero of x**s+x-1."""
    scale = 1 << bits
    lo, hi = 0, scale
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if mid**s + mid * scale ** (s - 1) < scale**s:
            lo = mid
        else:
            hi = mid
    return lo, hi, scale


@cache
def powers(s, bits):
    lo, hi, scale = root_box(s, bits)
    degree = 3 * s
    return tuple((lo**k * scale ** (degree - k), hi**k * scale ** (degree - k))
                 for k in range(degree + 1))


def sign(s, a, u, v):
    """Certified sign of J, using outward bounds and integer arithmetic."""
    if not (2 <= s and 1 <= a <= s and 1 <= u < v <= 2 * s):
        raise ValueError("parameters outside the theorem")
    if (u, v) == (a, a + s):
        return 0
    bits = 8
    while True:
        p, q, t = (powers(s, bits)[k] for k in (a + s, u + s, v))
        if 2 * p[0] > q[1] + t[1]:
            return 1
        if 2 * p[1] < q[0] + t[0]:
            return -1
        bits *= 2


def partitions(n):
    """All (nonempty, weakly increasing) partitions of perimeter n."""
    for largest in range(1, n + 1):
        for lower in combinations_with_replacement(range(1, largest + 1), n - largest):
            yield (*lower, largest)


def coefficients(s, a, u, v, stop):
    h, ell = [], []
    for n in range(stop + 1):
        def prev(seq, offset):
            return seq[n - offset] if n >= offset else 0
        h.append((n == a) + prev(h, 1) + prev(h, s))
        ell.append((n == u) - (n == u + 1) + (n == v)
                   + 2 * prev(ell, 1) - prev(ell, 2) + prev(ell, 2 * s))
    return h, ell


def check_enumeration(max_s=8, stop=14):
    total = 0
    for s in range(2, max_s + 1):
        pairs = list(combinations(range(1, 2 * s + 1), 2))
        hh, ll = Counter(), Counter()
        for n in range(1, stop + 1):
            for part in partitions(n):
                if all(y - x >= s - 1 for x, y in zip(part, part[1:])):
                    for a in range(1, min(s, part[0]) + 1):
                        hh[n, a] += 1
                residues = sorted({(x - 1) % (2 * s) + 1 for x in part})
                if len(residues) == 2:
                    ll[n, *residues] += 1
                elif len(residues) == 1:
                    r = residues[0]
                    for j in range(1, 2 * s + 1):
                        if j != r:
                            ll[n, min(r, j), max(r, j)] += 1
        for a in range(1, s + 1):
            for u, v in pairs:
                h, ell = coefficients(s, a, u, v, stop)
                assert h == [hh[n, a] for n in range(stop + 1)]
                assert ell == [ll[n, u, v] for n in range(stop + 1)]
                total += 1
    return total


def check_signs(max_s=20):
    counts = Counter()
    mixed = Counter()
    for s in range(2, max_s + 1):
        for a in range(1, s + 1):
            for u, v in combinations(range(1, 2 * s + 1), 2):
                direction = sign(s, a, u, v)
                counts[direction] += 1
                if u == a and v == a + s:
                    assert direction == 0
                elif u >= a and v >= a + s:
                    assert direction == 1
                elif u <= a and v <= a + s:
                    assert direction == -1
                else:
                    assert direction != 0
                    mixed[direction] += 1
    return counts, mixed


if __name__ == "__main__":
    print("Literal enumeration agrees with both GFs up to n=14, parameter tuples:",
          check_enumeration())
    counts, mixed = check_signs()
    print("Exact signs for s=2,...,20:", dict(sorted(counts.items())))
    print("Strictly mixed parameters:", dict(sorted(mixed.items())))
    for a in range(1, 5):
        for u, v in combinations(range(1, 9), 2):
            if (u - a) * (v - a - 4) < 0:
                h, ell = coefficients(4, a, u, v, 100)
                print(f"s=4 a={a} u={u} v={v} sign={sign(4,a,u,v):+d} D(100)={h[-1]-ell[-1]}")
