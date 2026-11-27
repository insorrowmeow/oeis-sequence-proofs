"""Exact polynomial certificates for proposed coefficient recurrences. Python 3."""

from fractions import Fraction


def trim(p):
    p = list(p)
    while p and not p[-1]:
        p.pop()
    return p


def add(a, b):
    return trim([(a[i] if i < len(a) else 0) + (b[i] if i < len(b) else 0)
                 for i in range(max(len(a), len(b)))])


def scale(a, k):
    return trim(k * t for t in a)


def mul(a, b):
    p = [0] * (len(a) + len(b))
    for i, u in enumerate(a):
        for j, v in enumerate(b):
            p[i+j] += u*v
    return trim(p)


def deriv(p):
    return trim(i * p[i] for i in range(1, len(p)))


def quotient(a, b):
    q = []
    r = trim(a)
    while r and len(r) >= len(b):
        step = [0] * (len(r)-len(b)) + [Fraction(r[-1], b[-1])]
        q = add(q, step)
        r = add(r, scale(mul(b, step), -1))
    if r:
        raise ValueError(f"Polynomial division left remainder {r}")
    return q


def ode(D, Z):
    return add(scale(mul(D, deriv(Z)), 2), scale(mul(deriv(D), Z), -1))


def check(label, V, W, D, terms):
    # F = (V +/- sqrt(D))/W. The sign has no effect on the differential identity.
    xA = [0] + [s for s, _ in terms]
    B = [s*i + c for i, (s, c) in enumerate(terms)]
    denominator = scale(mul(D, W), 2)
    if mul(B, denominator) != mul(xA, ode(D, W)):
        raise ValueError(f"{label}: F coefficient does not match")
    rhs = quotient(mul(xA, ode(D, V)), denominator)
    if len(rhs) > len(terms)-1:
        raise ValueError(f"{label}: right-hand side survives at a recurrence index")
    print(label, 'right-hand side coefficients', [str(v) for v in rhs])


def trace_formula(t):
    # Row polynomial of A198379 evaluated at t.
    return [(1,1),(-3*t,0),(3*t*t,-3*t*t),
            (4*t-t**3, 2*t**3-14*t),
            (-4*t*t,14*t*t)]


if __name__ == "__main__":
    check("A173993", [-1,4,-2], [0,2,-8,6], mul([1,-2],[1,-2,-4,4]),
          [(1,1),(-8,-2),(19,-5),(0,-36),(-56,208),(68,-286),(-24,120)])
    check("A174013", [-1,3,1], [0,2,-2,-2], [1,-2,-1,6,5],
          [(1,1),(1,0),(-12,12),(9,-24),(36,-138),(-11,22),(-49,253),(-20,120)])
    check("A171416", [1,0,-1], [0,0,2], [1,0,-6,-4,1],
          [(1,2),(1,1),(-6,6),(-10,22),(-3,10),(1,-5)])
    for t in (-3,-1,0,1,2,3,17):
        check(f"triangle parameter {t}", [-1,t+2], [0,2,-2*t], [1,-2*t,t*t,4*t], trace_formula(t))
