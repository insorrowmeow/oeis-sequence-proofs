"""Offline independent checks for the Rule 67 and Rule 150 notes. Standard Python."""

from fractions import Fraction


def rule67_rows(last):
    background = 0
    exceptions = {0}
    for n in range(last + 1):
        cell = lambda i: background ^ (i in exceptions)
        yield [cell(i) for i in range(-n, n + 1)]
        new_background = (67 >> (7 * background)) & 1
        exceptions = {
            i for i in range(-n - 1, n + 2)
            if (67 >> (4*cell(i-1) + 2*cell(i) + cell(i+1))) & 1 != new_background
        }
        background = new_background


def check67():
    rows = list(rule67_rows(160))
    for b in (2, 3, 10, 16):
        values = [sum(v*b**j for j, v in enumerate(reversed(row))) for row in rows]
        for n in range(4, len(rows)):
            m = (n-4)//2
            factor = b**(2+3*m)
            if n % 2 == 0:
                expected = factor*(b**4+b**2+b+1)
            else:
                expected = (b**(11+4*m)-1)//(b-1) - factor*(b**5+b**4+b**3+b**2+1)
            assert values[n] == expected
        q = (1, -(1+b**3+b**4), b**3+b**4+b**7, -b**7)
        numerator = [sum(q[j]*values[n-2*j] for j in range(4) if 2*j<=n)
                     for n in range(len(rows))]
        assert all(c == 0 for c in numerator[10:])
        if b == 2:
            assert values[3] == 97
            assert 2*4**3-Fraction(61*8**(3//2),16)-1 == Fraction(193,2)
            assert numerator[:10] == [1,4,-15,-3,-6,-14,-172,-28,192,-64]
        if b == 10:
            assert numerator[:10] == [1,100,-9991,-99,-88910,-9990,-10901100,-99900,11000000,-1000000]
    print("Rule 67: rows 0..160 in four bases and both OEIS numerators verified")


def shift(x, k, w):
    k %= w
    return ((x << k) & ((1 << w)-1)) | (x >> (w-k))


def evolve150(w, t):
    # Frobenius: T^(2^j) has displacements -2^j, 0, 2^j.
    x = 1
    k = 1
    while t:
        if t & 1:
            x = shift(x, -k, w) ^ x ^ shift(x, k, w)
        t >>= 1
        k = 2*k % w
    return x


def prime_factors(n):
    p = 2
    while p*p <= n:
        if n%p == 0:
            yield p
            while n%p == 0:
                n //= p
        p += 1
    if n > 1:
        yield n


def exact_period(w, d):
    # A linear endomorphism of a w-dimensional space is bijective on its
    # stable image by step w, since strict image-dimension drops cannot persist.
    start = evolve150(w, w)
    return (start == evolve150(w, w+d)
            and all(start != evolve150(w, w+d//p) for p in prime_factors(d)))


def check150():
    reverse_exceptions = []
    for w in range(3, 10001):
        m = w//(w & -w)
        fixed = exact_period(w, w)
        assert fixed == (m >= 7 and (m & (m+1)) == 0)
        carryless = w ^ (w << 1) ^ (w << 3)
        assert not fixed or carryless == 7*w
        if not fixed and carryless == 7*w:
            reverse_exceptions.append(w)
    assert reverse_exceptions[0] == 455
    assert exact_period(455, 4095)
    # Separate implementation: literally apply the one-cell shift at each step.
    state = 1
    seen = {}
    while state not in seen:
        seen[state] = len(seen)
        state = shift(state, -1, 455) ^ state ^ shift(state, 1, 455)
    assert len(seen) - seen[state] == 4095
    print("Rule 150: widths 3..10000 verified; first reverse exception 455, period 4095")


if __name__ == "__main__":
    check67()
    check150()
