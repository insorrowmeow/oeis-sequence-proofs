"""Certify the digon counts bracketing a plateau by rational angle comparisons."""
from fractions import Fraction as Q


def atan_bounds(d):
    # Alternating series for arctan(1/d), truncated after an even number of terms.
    lo = sum(Q((-1)**k, (2*k+1)*d**(2*k+1)) for k in range(12))
    return lo, lo + Q(1, 25*d**25)


def digons(n):
    a, b = atan_bounds(5)
    c, d = atan_bounds(239)
    lo, hi = 16*a-4*d, 16*b-4*c  # Machin's formula
    points = []
    for t in range(n):
        for color in (0, 1):
            s = t/(2*hi) + Q(color, 2)
            z = t/(2*lo) + Q(color, 2)
            j = s//1
            assert j == z//1
            coeff = color-2*j
            endpoints = [t + coeff*x for x in (lo, hi)]
            points.append((min(endpoints), max(endpoints), color))
    points.sort()
    assert all(p[1] < q[0] for p, q in zip(points, points[1:]))
    return sum(p[2] != points[i-1][2] for i, p in enumerate(points))//2


if __name__ == "__main__":
    for n in (332, 333, 688, 689):
        print(n, digons(n))
