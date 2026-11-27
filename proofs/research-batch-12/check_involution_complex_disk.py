"""Certify a complex disk containing just the first two poles. Python standard library."""

from fractions import Fraction
from math import gcd, lcm


def trim(p):
    p = list(p)
    while p and p[-1] == 0:
        p.pop()
    return p


def add(p, q):
    out = [0] * max(len(p), len(q))
    for i, c in enumerate(p):
        out[i] += c
    for i, c in enumerate(q):
        out[i] += c
    return trim(out)


def scale(p, a):
    return trim([c * a for c in p])


def mul(p, q):
    out = [0] * (len(p) + len(q))
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i + j] += a * b
    return trim(out)


def primitive(p):
    """Clear denominators and positive content, preserving every sign."""
    if not p:
        return []
    den = lcm(*(x.denominator for x in p))
    a = [int(x * den) for x in p]
    content = gcd(*a)
    return [x // content for x in a]


def remainder(p, q):
    """Positive multiple of the exact rational remainder."""
    q = scale(q, 1 if q[-1] > 0 else -1)
    while len(p) >= len(q):
        term = [0] * (len(p) - len(q)) + scale(q, -p[-1])
        p = primitive(add(scale(p, q[-1]), term))
    return p


def endpoint_variations(chain, x):
    values = [sum(c * x**i for i, c in enumerate(p)) for p in chain]
    signs = [v > 0 for v in values if v]
    return sum(a != b for a, b in zip(signs, signs[1:]))


def sturm_variations(p):
    derivative = [i * p[i] for i in range(1, len(p))]
    chain = [primitive(p), primitive(derivative)]
    while True:
        rem = remainder(chain[-2], chain[-1])
        if not rem:
            break
        chain.append(scale(rem, -1))
    return endpoint_variations(chain, -1), endpoint_variations(chain, 1)


def abs_square_on_circle(p):
    """|p(exp(i theta))|^2 as a polynomial in cos(theta), for real p."""
    out = [sum(a * a for a in p)]
    previous, current = [1], [0, 1]
    for h in range(1, len(p)):
        correlation = sum(a * b for a, b in zip(p, p[h:]))
        out = add(out, scale(current, 2 * correlation))
        previous, current = current, add([0] + scale(current, 2), scale(previous, -1))
    return out


def schur_count(p):
    """Count open unit-disk roots, assuming no boundary roots; see the note."""
    p = primitive(p)
    if len(p) == 1:
        return 0
    a, b = p[0], p[-1]
    assert abs(a) != abs(b)
    reduced = add(scale(p, b), scale(p[::-1], -a))
    assert reduced[0] == 0 and len(reduced) == len(p)
    k = schur_count(reduced[1:])
    return 1 + k if abs(b) > abs(a) else len(p) - 2 - k


def head_determinants(depth):
    d = [[1], [1, -1, -1]]
    for i in range(1, depth):
        b = add([1, 0, -2, 0, 1], [0] * (2 * i + 1) + [-1, 0, -1])
        d.append(add(mul(b, d[-1]), [0] * (4 * i + 2) + scale(d[-2], -1)))
    return d[-2], d[-1]


if __name__ == "__main__":
    radius = Fraction(7, 10)
    depth = 4
    gap = (1 - radius**2)**2 - (1 + radius**2) * radius**(2 * depth + 1)
    gap -= 2 * radius**(2 * depth + 3)
    assert gap > 0
    d3, d4 = head_determinants(depth)
    p3, p4 = ([a * radius**i for i, a in enumerate(d)] for d in (d3, d4))
    bound = add(scale(abs_square_on_circle(p4), gap**2),
                scale(abs_square_on_circle(p3), -radius**(8 * depth + 4)))
    assert sum(bound) > 0
    assert sum(a * (-1)**i for i, a in enumerate(bound)) > 0
    left, right = sturm_variations(bound)
    assert left == right
    zeros = schur_count(p4)
    assert zeros == 2
    print(f"tail gap = {gap}; positivity polynomial degree = {len(bound) - 1}")
    print(f"Sturm variations at -1 and 1 = {left}, {right}")
    print(f"head determinant degree = {len(d4) - 1}; zeros inside |s| < 7/10 = {zeros}")
