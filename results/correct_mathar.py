"""Check the polynomial certificate for the corrected A103769 recurrence."""
from fractions import Fraction


def plus(*polys):
    result = [sum(row[k] for row in polys if k < len(row))
              for k in range(max(map(len, polys)))]
    while result and result[-1] == 0:
        result.pop()
    return result


def scale(c, row):
    return plus([c*a for a in row])


def times(a, b):
    return plus(*([[0]*i + scale(c,b) for i,c in enumerate(a)] or [[]]))


def derivative(a):
    return [i*x for i,x in enumerate(a) if i]


def divide(a, b):
    quot = []
    while len(a) >= len(b):
        term = [0]*(len(a)-len(b)) + [Fraction(a[-1],b[-1])]
        quot = plus(quot,term)
        a = plus(a,scale(-1,times(b,term)))
    assert not a
    return quot


# Coefficients as polynomials in t=z+1/z.
P, W, T, D = [1,1,1], [2,1], [0,1], [-4,0,1]
B = times(D,derivative(P))


def euler(h):
    # theta((z-1/z) h(t)) where theta=z*d/dz.
    return plus(times(T,h),times(D,derivative(h)))


def Q(coeffs):
    q = []
    for c in coeffs:
        q = plus(times(q,P),[c])
    return times(W,q)


# Write Q = n^2*q2+n*q1+q0 (the leading multiplier is 4n(2n+1)).
q2 = Q([8,-122,615,-1152,567])
q1 = Q([4,114,-1569,4680,-2835])
q0 = Q([0,-40,1038,-4752,3402])
h1 = divide(q2,B)
h0 = divide(plus(q1,scale(-1,times(P,euler(h1))),scale(3,times(B,h1))),B)
assert plus(times(P,euler(h0)),scale(-3,times(B,h0))) == q0
print("H1 coefficients in ascending powers of t:", list(map(str,h1)))
print("H0 coefficients in ascending powers of t:", list(map(str,h0)))
print("All three polynomial identities hold.")
