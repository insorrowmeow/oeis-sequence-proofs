"""Rigorous fixed-point enclosure for the relative density in OEIS A401306."""

from fractions import Fraction
from math import isqrt


S = 10**18
B = 2_400_000
P = 600_000


def ceil_div(n, d):
    return (n + d - 1) // d


def positive_integers_without_square_factors(n, primes):
    allowed = bytearray(b"\1") * (n + 1)
    for p in primes:
        if p * p > n:
            break
        allowed[p * p :: p * p] = bytes(n // (p * p))
    return allowed


def primes_upto(n):
    flags = bytearray(b"\1") * (n + 1)
    flags[:2] = b"\0\0"
    for p in range(2, isqrt(n) + 1):
        if flags[p]:
            flags[p * p :: p] = bytes((n - p * p) // p + 1)
    return [i for i in range(2, n + 1) if flags[i]]


def main():
    primes = primes_upto(P)
    squarefree = positive_integers_without_square_factors(B, primes)
    cutoffs = (100, 300, 1000, 3000, 25000)
    tables = {}
    for cutoff in cutoffs:
        entries = []
        for p in primes:
            if p < 5:
                continue
            if p > cutoff:
                break
            if p % 4 == 3:
                # Cancellation between each opposite pair of shifts.
                entries.append((p, None, 0))
            else:
                squares = {a*a % p for a in range(1, p//2 + 1)}
                coefficient = 2 * (1 + (1 if 2 in squares else -1)
                                   + (1 if 3 in squares else -1))
                # Dense lookup for frequent small primes; modular powering for large ones.
                bits = bytes(int(a in squares) for a in range(p)) if p < 1100 else None
                entries.append((p, bits, coefficient))
        # Union bound for all omitted factors; sum beyond P is bounded by 12/P.
        loss = ceil_div(12*S, P) + sum(ceil_div(12*S, p*p) for p in primes if p > cutoff)
        tables[cutoff] = entries, loss

    mass_low = 0
    discount_low = 0
    for b in range(1, B + 1):
        if not squarefree[b]:
            continue
        cutoff = (25000 if b <= 30 else 3000 if b <= 500 else
                  1000 if b <= 3000 else 300 if b <= 20000 else 100)
        entries, loss = tables[cutoff]
        base = Fraction(1, 1 if b % 2 == 0 else 2)
        if b % 3:
            base *= Fraction(5, 9)
        base_low = S*base.numerator // base.denominator
        lo, hi = base_low, ceil_div(S*base.numerator, base.denominator)
        for p, bits, coefficient in entries:
            r = b % p
            if r == 0:
                continue
            roots = 6
            if coefficient:
                square = bits[r] if bits is not None else pow(r, (p-1)//2, p) == 1
                roots += coefficient if square else -coefficient
            pp = p*p
            lo = lo*(pp-roots)//pp
            hi = ceil_div(hi*(pp-roots), pp)
        lo = lo*(S-loss)//S
        weight_low = isqrt(S*S//(b**3))
        mass_low += weight_low*lo//S
        discount_low += weight_low*max(0, base_low-hi)//S

    # D = zeta(3/2)/zeta(3). Use decreasing-function integral bounds.
    n = 10000
    zeta15_upper = (sum(isqrt(S*S//(b**3)) + 1 for b in range(1, n+1))
                    + ceil_div(2*S, isqrt(n)))
    zeta3_lower = sum(S//(b**3) for b in range(1, n+1))
    D_upper = Fraction(zeta15_upper, zeta3_lower)
    # Under weights mu²(b)/b^(3/2), p divides b with probability 1/(1+p^(3/2)).
    prob2_upper = Fraction(S, S + isqrt(8*S*S))
    prob3_upper = Fraction(S, S + isqrt(27*S*S))
    base_mean_upper = (1 + prob2_upper)/2 * (5 + 4*prob3_upper)/9
    low = Fraction(mass_low, S) / D_upper
    high = base_mean_upper - Fraction(discount_low, S) / D_upper
    print("Outward-rounded bounds in millionths:",
          low.numerator*10**6 // low.denominator,
          ceil_div(high.numerator*10**6, high.denominator))
    assert Fraction(226, 1000) < low <= high < Fraction(227, 1000)


if __name__ == "__main__":
    main()
