"""Exact lower bounds for unimodality in the uniform labelled graph model.

The bad events and their probability bounds are derived in PROOF.md.
Run with Python 3.8+ and no additional packages.
"""

from fractions import Fraction
from math import comb


def relative_variance(n, r):
    """Var(X_r) / E[X_r]^2 for independent r-set counts at p = 1/2."""
    denominator = comb(n, r)
    weighted_overlap = sum(
        comb(r, j) * comb(n - r, r - j) * (2 ** comb(j, 2) - 1)
        for j in range(2, r + 1)
    )
    return Fraction(weighted_overlap, denominator)


def failure_bound(n, cutoff):
    """Chebyshev on the initial segment and Markov on forbidden pairs."""
    epsilon = Fraction(1, 6)
    assert (1 - epsilon) ** 2 > Fraction(1, 2) * (1 + epsilon) ** 2
    center = sum(relative_variance(n, r) for r in range(2, cutoff + 1))
    center /= epsilon**2
    absent_edges = comb(cutoff, 2) + cutoff**2
    tail = Fraction(comb(n, cutoff) * comb(n - cutoff, cutoff), 2**absent_edges)
    return center + tail


if __name__ == "__main__":
    for n, cutoff in [(1024, 11), (4096, 14), (65536, 19), (1048576, 25)]:
        bound = failure_bound(n, cutoff)
        # Round the probability of failure upwards, using integer arithmetic.
        millionths = (10**6 * bound.numerator + bound.denominator - 1) // bound.denominator
        print(f"n={n}, cutoff={cutoff}, failure probability <= {millionths}/1000000")
