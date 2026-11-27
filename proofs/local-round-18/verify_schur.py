"""Check full principal Schur specializations using the hook-content formula."""

from collections import Counter
from math import comb


def multiply_binomial(poly, step):
    product = poly + [0] * step
    for i, value in enumerate(poly):
        product[i + step] -= value
    return product


def divide_binomial(poly, step):
    """Exact division by 1-q^step, including a check of the remainder."""
    degree = len(poly) - 1 - step
    if degree < 0:
        raise ValueError("divisor has greater degree than dividend")
    quotient = []
    for i in range(degree + 1):
        earlier = quotient[i - step] if i >= step else 0
        quotient.append(poly[i] + earlier)
    if multiply_binomial(quotient, step) != poly:
        raise ValueError("inexact division")
    return quotient


def hook_content(rows, variables):
    heights = [sum(length > j for length in rows) for j in range(rows[0])]
    factors = Counter()
    for i, width in enumerate(rows):
        for j in range(width):
            hook = width - j + heights[j] - i - 1
            factors[variables + j - i] += 1
            factors[hook] -= 1
    poly = [1]
    for step, power in factors.items():
        for _ in range(power):
            poly = multiply_binomial(poly, step)
    for step, power in factors.items():
        for _ in range(-power):
            poly = divide_binomial(poly, step)
    return sum(i * width for i, width in enumerate(rows)), poly


if __name__ == "__main__":
    for n in range(6, 33):
        rows = [n + 2] + [n] * (n - 1)
        shift, coefficients = hook_content(rows, n)
        expected = [1 + min(t, 2 * n - 2 - t) // 2 for t in range(2 * n - 1)]
        if shift != n * comb(n, 2) or coefficients != expected:
            raise AssertionError((n, shift, coefficients))
        if n == 7:
            print(f"N={n}, shift={shift}, coefficients={coefficients}")
    print("All 27 full polynomials agree for N=6,...,32.")
