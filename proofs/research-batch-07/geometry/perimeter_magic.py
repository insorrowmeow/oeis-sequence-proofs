"""Exact rational generating function for the perimeter-magic squares of A380962."""

from collections import Counter
from fractions import Fraction
from math import gcd


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def sub(a, b):
    return (a[0] - b[0], a[1] - b[1])


def times(k, a):
    return (k * a[0], k * a[1])


def evaluate(a, ray):
    return a[0] * ray[0] + a[1] * ray[1]


def contributions(ray):
    """Return coefficient, slope-dependent weight and remaining denominator powers."""
    zero, u, v = (0, 0), (1, 0), (0, 1)
    uv = add(u, v)
    sides = (zero, u, v, uv)
    value = lambda a: evaluate(a, ray)
    def distinct(forms):
        return {value(f): f for f in forms}

    forbidden_a = distinct(sub(j, i) for j in sides for i in (zero, u))
    forbidden_b = distinct(sub(j, i) for j in sides for i in (zero, v))
    forbidden_d = distinct(sub(j, i) for j in (zero, v) for i in (zero, u))
    yield 1, uv, (1, 1, 1)
    for family in (forbidden_a, forbidden_b, forbidden_d):
        for f in family.values():
            absolute = f if value(f) >= 0 else times(-1, f)
            yield -1, add(uv, absolute), (1, 2)

    def intersection(a, b):
        smallest = min((zero, a, b), key=value)
        return sub(add(uv, add(a, b)), times(3, smallest))

    for a in forbidden_a.values():
        for b in forbidden_b.values():
            # Subtract the triple intersection if the difference also collides.
            if value(sub(a, b)) not in forbidden_d:
                yield 1, intersection(a, b), (3,)
    for a in forbidden_a.values():
        for d in forbidden_d.values():
            yield 1, intersection(a, sub(a, d)), (3,)
    for b in forbidden_b.values():
        for d in forbidden_d.values():
            yield 1, intersection(add(b, d), b), (3,)


def rational_terms():
    # Includes every wall i*u+j*v=0 with |i|,|j|<=4 and 0<u<v.
    rays = sorted(((i,j) for j in range(1,5) for i in range(j+1) if gcd(i,j)==1),
                  key=lambda v: Fraction(v[0],v[1]))
    terms = Counter()
    for left, right in zip(rays, rays[1:]):
        assert abs(left[0]*right[1] - left[1]*right[0]) == 1
        for c, form, denominator in contributions(add(left, right)):
            a, b = evaluate(form, left), evaluate(form, right)
            assert min(a, b) > 0
            terms[3+a+b, tuple(sorted((*denominator,a,b)))] += c
    for ray in rays[1:-1]:
        for c, form, denominator in contributions(ray):
            a = evaluate(form, ray)
            assert a > 0
            terms[3+a, tuple(sorted((*denominator,a)))] += c
    return {term: c for term, c in terms.items() if c}


def trim(p):
    while p and p[-1] == 0:
        p.pop()
    return p


def multiply(p, q):
    r = [0] * (len(p)+len(q)-1)
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            r[i+j] += x*y
    return trim(r)


def divide_exact(p, q):
    assert q and q[-1] in (-1, 1)
    rem = p.copy()
    quotient = [0] * max(0, len(p)-len(q)+1)
    while len(rem) >= len(q):
        shift, coeff = len(rem)-len(q), rem[-1]//q[-1]
        quotient[shift] = coeff
        for i, y in enumerate(q):
            rem[i+shift] -= coeff*y
        trim(rem)
    assert not rem, "inexact polynomial division"
    return quotient


def verify():
    terms = rational_terms()
    required = Counter()
    for _, denominator in terms:
        required |= Counter(denominator)
    common = [1]
    for k, m in required.items():
        for _ in range(m):
            common = multiply(common, [1]+[0]*(k-1)+[-1])
    numerator = []
    for (shift, denominator), c in terms.items():
        piece = common
        for k in denominator:
            piece = divide_exact(piece, [1]+[0]*(k-1)+[-1])
        numerator.extend([0]*max(0, len(piece)+shift-len(numerator)))
        for j, v in enumerate(piece):
            numerator[shift+j] += c*v
    # 1 minus the lag polynomial conjectured by R. J. Mathar in A380962.
    target = [1,2,3,2,0,-3,-6,-8,-9,-7,-3,4,10,15,16,14,8,0,
              -8,-14,-16,-15,-10,-4,3,7,9,8,6,3,0,-2,-3,-2,-1]
    result = divide_exact(multiply(trim(numerator),target),common)
    print("Nonzero summands:",len(terms))
    print("Numerator of the target generating function:",result)
    return result, target


if __name__ == "__main__":
    verify()
