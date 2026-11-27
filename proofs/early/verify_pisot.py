"""Exact certificates for the conjectures in OEIS A048582 and A020748.

Use Python 3 without -O. Only built-in rational and integer arithmetic is used.
Characteristic polynomials and numerators are written in descending order.
"""
from fractions import Fraction as F
from math import comb


CASES = [
    ("A048582", "ceil", [4, 9, 21, 49, 115, 270, 634],
     [1, -3, 2, -1, -1, 2, -1, 1], [4, -3, 2, 0, -3, 1, -2],
     [(2349, 0), (1000, 0), (-919, 0), (316, 847), (316, -847),
      (-32, 752), (-32, -752)], F(1, 5)),
    ("A020748", "floor", [4, 10, 25, 62, 153, 377],
     [1, -3, 1, 1, 0, -2, 2], [4, -2, -1, 1, 2, -3],
     [(2461, 0), (1000, 0), (541, 759), (541, -759),
      (-772, 583), (-772, -583)], F(-1, 4)),
]

RADIUS = F(1, 500)
INNER = F(49, 50)
BOUND = 10**9
PREFIX = 2000


def add(a, b):
    return a[0] + b[0], a[1] + b[1]


def mul(a, b):
    return a[0]*b[0] - a[1]*b[1], a[0]*b[1] + a[1]*b[0]


def taylor_term(p, k, z):
    """p^(k)(z)/k! in Gaussian rationals, via Horner's rule."""
    degree = len(p) - 1
    value = (0, 0)
    for i, coeff in enumerate(p[:degree-k+1]):
        value = add(mul(value, z), (coeff*comb(degree-i, k), 0))
    return value


def disk_proof(p, centers):
    degree = len(p) - 1
    assert p[0] == 1 and len(centers) == degree
    for i, center in enumerate(centers):
        taylor = [taylor_term(p, k, center) for k in range(degree+1)]
        # On the boundary, the linear Taylor term dominates the rest.
        lower = max(map(abs, taylor[1]))*RADIUS
        upper = sum((abs(x) + abs(y))*RADIUS**k
                    for k, (x, y) in enumerate(taylor) if k != 1)
        assert lower > upper
        # Pairwise root distances exceed 1/4, even after allowing both radii.
        for other in centers[:i]:
            assert max(abs(center[j]-other[j]) for j in (0, 1)) > F(1, 4) + 2*RADIUS
        if i >= 2:
            assert sum(x*x for x in center) < (INNER-RADIUS)**2
    assert centers[1] == (1, 0) and sum(p) == 0 and centers[0][1] == 0
    return centers[0][0] - RADIUS, centers[0][0] + RADIUS


def real_bounds(p, lo, hi):
    """Interval for a real polynomial on [lo,hi] with lo positive."""
    degree = len(p)-1
    pairs = [(c*lo**(degree-i), c*hi**(degree-i)) for i, c in enumerate(p)]
    return sum(min(pair) for pair in pairs), sum(max(pair) for pair in pairs)


def verify(row):
    name, rounding, start, p, numerator, raw_centers, constant = row
    degree = len(p)-1
    sign = 1 if rounding == 'ceil' else -1
    centers = [(F(a, 1000), F(b, 1000)) for a,b in raw_centers]
    lo, hi = disk_proof(p, centers)
    assert 2 < lo < hi < 3
    # Laurent expansion of N(z)/P(z) at infinity starts with b0/z.
    assert numerator == [sum(p[j]*start[k-j] for j in range(k+1))
                         for k in range(degree)]
    derivative = [c*(degree-i) for i, c in enumerate(p[:-1])]
    assert constant == F(sum(numerator), sum(derivative))
    nlo, _ = real_bounds(numerator, lo, hi)
    dlo, dhi = real_bounds(derivative, lo, hi)
    assert nlo > dhi >= dlo > 0  # A = C_r > 1.
    assert F(1, 5) < sign*constant*(lo-1)**2
    assert sign*constant*(hi-1)**2 < F(4, 5)
    # All |roots|<3, and |P'(root)|>(1/4)^(degree-1).
    assert sum(abs(c)*3**(degree-1-i) for i,c in enumerate(numerator))*4**(degree-1) < BOUND
    # Error in signed delta/(A*r^n) from dominant/inner pairs and remaining pairs.
    assert (degree-2)*BOUND*16*INNER**PREFIX + F(comb(degree-1, 2)*BOUND**2*36, 2**PREFIX) < F(1, 20)
    assert F((degree-1)*BOUND, 2**PREFIX) < F(1, 20)
    b = start[:]
    while len(b) < PREFIX + 2:
        b.append(-sum(p[j]*b[-j] for j in range(1, degree+1)))
    for n in range(PREFIX):
        delta = sign*(b[n]*b[n+2] - b[n+1]**2)
        assert 0 <= delta < b[n]
    print(f"{name}: isolated {degree} roots, unit residue {constant},"
          f" all margins and {PREFIX} initial inequalities verified")


if __name__ == '__main__':
    if not __debug__:
        raise SystemExit("Run without -O so certificate assertions are checked.")
    for case in CASES:
        verify(case)
