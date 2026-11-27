"""Exact independent enumeration of the two perimeter statistics."""
from fractions import Fraction
from itertools import combinations_with_replacement
from math import prod


PRIMES = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53)


def check():
    bound = len(PRIMES)
    weights = [Fraction(1, p) for p in PRIMES]
    coeff = [[Fraction(1)] + [Fraction(0)] * bound]
    for q in weights:
        previous = coeff[-1]
        row = [Fraction(1)]
        for length in range(1, bound + 1):
            row.append(previous[length] + q * row[-1])
        coeff.append(row)

    running = Fraction(0)
    for n in range(1, bound + 1):
        exact = Fraction(n == 1)  # per(empty) = 1
        count = 0
        for largest in range(1, n + 1):
            for tail in combinations_with_replacement(range(1, largest + 1), n - largest):
                exact += Fraction(1, PRIMES[largest-1] * prod(PRIMES[a-1] for a in tail))
                count += 1
        assert count == 2 ** (n-1)
        shell = sum(coeff[n-length][length] / PRIMES[n-length-1] for length in range(n))
        assert exact == shell + (n == 1)
        running += exact
        by_length = 1 + sum(coeff[n+1-length][length] for length in range(1, n+1))
        assert running == by_length
        products = [prod((1-q)**-1 for q in weights[:m]) for m in range(n+1)]
        gap = sum((products[m] - sum(coeff[m][:n-m+1])) / PRIMES[m-1]
                  for m in range(1, n+1))
        assert products[n] - running == gap
        if n in (1, 2, 5, 16):
            print(f"n={n:2}  nonempty={count:5}  n*W={float(n*exact):.9f}"
                  f"  Cmax-Cper={float(gap):.9f}")
    print(f"Exact rational checks passed for n=1..{bound}.")


if __name__ == "__main__":
    check()
