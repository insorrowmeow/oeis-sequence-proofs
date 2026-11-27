"""Check finite inputs and the 2-adic local factor for A401548 independently."""
from fractions import Fraction
from itertools import product
from math import isqrt


def exceptional(n):
    while n and n % 4 == 0:
        n //= 4
    return n % 8 == 7


def check_residues():
    primitive = hits = 0
    for roots in product(range(16), repeat=4):
        if any(x % 2 for x in roots):
            primitive += 1
            hits += exceptional(sum(x*x for x in roots))
    assert (hits, primitive) == (9216, 61440)
    assert Fraction(hits, primitive) == Fraction(3, 20)


def greedy_roots(n):
    result = []
    while n:
        a = isqrt(n)
        result.append(a)
        n -= a*a
    return tuple(result)


def check_entries():
    size = 100000
    two = {a*a + b*b for a in range(isqrt(size)+1)
           for b in range(isqrt(size-a*a)+1)}
    total = 0
    for n in range(1, size+1):
        roots = greedy_roots(n)
        assert sum(a*a for a in roots) == n
        minimum = 1 if isqrt(n)**2 == n else 2 if n in two else 4 if exceptional(n) else 3
        total += len(roots) == minimum
        if n == 10000:
            assert total == 3560
    assert total == 26394


if __name__ == "__main__":
    check_residues()
    check_entries()
    print("All 16^4 quadruples checked. Optimal greedy counts to 10000 and 100000 match OEIS.")
