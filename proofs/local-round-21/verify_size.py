"""Exact finite checks and illustrative floating-point values. Standard library only."""
from fractions import Fraction
from itertools import combinations
from math import exp, fsum, isqrt, log, pi, prod


def prime_list(count):
    limit = max(32, 2 * count)
    while True:
        sieve = bytearray([1]) * (limit + 1)
        for k in range(2, isqrt(limit) + 1):
            if sieve[k]:
                sieve[k*k::k] = bytes((limit-k*k)//k + 1)
        primes = [j for j in range(2, limit + 1) if sieve[j]]
        if len(primes) >= count:
            return primes[:count]
        limit *= 2


def partitions_with_size(size, ceiling):
    if size == 0:
        yield ()
    for first in range(1, min(size, ceiling) + 1):
        for rest in partitions_with_size(size-first, first):
            yield (first, *rest)


def exact_checks(primes):
    zero = Fraction(0)
    for n in range(1, 19):
        q = [Fraction(1, p) for p in primes[:n]]
        coeff = [Fraction(1)] + [zero] * n
        for j, weight in enumerate(q, 1):
            for s in range(j, n+1):
                coeff[s] += weight * coeff[s-j]
        for s in range(n+1):
            literal = sum((Fraction(1, prod(primes[j-1] for j in part))
                           for part in partitions_with_size(s, n)), zero)
            assert literal == coeff[s]
        total = prod(1/(1-x) for x in q)
        # Probability distribution, with state n+1 denoting all overflows.
        dist = [Fraction(1)] + [zero] * (n+1)
        for j, weight in enumerate(q, 1):
            new = [zero] * (n+2)
            for s in range(n+1):
                r = (n-s)//j + 1
                for k in range(r):
                    new[s+k*j] += dist[s] * (1-weight) * weight**k
                new[-1] += dist[s] * weight**r
            new[-1] += dist[-1]
            dist = new
        assert sum(dist) == 1
        assert total * dist[-1] == total - sum(coeff)
        full_triangle = sum((Fraction(1, i*j) for i in range(1, n+1)
                             for j in range(n-i+1, n+1)), zero)
        assert full_triangle == sum(Fraction(1, k*k) for k in range(1, n+1))
        for b in range(1, n):
            def pairs(s):
                return sum((q[i-1]*q[j-1] for i, j in combinations(range(b+1, s+1), 2)
                            if i+j>s), zero)
            lam = sum(q[b:], zero)
            assert (1-lam)*pairs(n) <= dist[-1]
            for t in range(1, n-b):
                N = n-t
                upper = (pairs(N) + sum(q[N:]) + sum(x*x for x in q[b:])
                         + lam**3/6 + sum((i*q[i-1]/(1-q[i-1]) for i in range(1, b+1)), zero)/t)
                assert dist[-1] <= upper
    print("Exact partition, normalized overflow, pair bounds and triangle checks passed for n=1..18.")


def large_examples(primes):
    # If F(z) is the size generating series, zF'(z)/F(z) has coefficients
    # kernel[s] = sum_{j|s} j * q_j^(s/j). Recover F recursively.
    limit = len(primes)
    kernel = [0.0] * (limit + 1)
    for j, p in enumerate(primes, 1):
        term = j / p
        for s in range(j, limit+1, j):
            kernel[s] += term
            term /= p
            if term == 0.0:
                break
    coeff = [1.0]
    product = 1.0
    for n in range(1, limit+1):
        coeff.append(fsum(kernel[n-j]*coeff[j] for j in range(n))/n)
        product *= primes[n-1]/(primes[n-1]-1)
        if n in (64, 256, 1024, limit):
            print(f"n={n:5d}   log(n)*(Cmax-Csize)={log(n)*(product-fsum(coeff)):.8f}")
    print(f"Asymptotic limit {exp(0.5772156649015329)*pi**2/12:.8f}")


if __name__ == "__main__":
    p = prime_list(4096)
    exact_checks(p)
    large_examples(p)
