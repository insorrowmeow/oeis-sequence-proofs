"""Locate simple poles, then certify the intervals by exact inertia and a tail bound."""

from fractions import Fraction
from itertools import count


def coefficients(s, i):
    q = s * s
    diagonal = (1 - q - s if i == 0 else
                (1 - q)**2 - s * q**i * (1 + q))
    return diagonal, -s * q**(i+1)


def negative_count_approx(s, depth=48):
    pivot, edge = coefficients(s, 0)
    negative = int(pivot < 0)
    for i in range(1, depth):
        b, e = coefficients(s, i)
        pivot = b - edge**2 / pivot
        negative += pivot < 0
        edge = e
    return negative


def negative_count_exact(s, depth):
    # Eliminate the head from the first row to row depth-1 (LDL).
    pivot, edge = coefficients(s, 0)
    negative = 0
    for i in range(1, depth):
        assert pivot
        negative += pivot < 0
        b, e = coefficients(s, i)
        pivot = b - edge**2 / pivot
        edge = e

    # Tail starts at depth. Its lower form bound follows from 2|ab|≤a²+b².
    b, e = coefficients(s, depth)
    lower_bound = b - 2 * abs(e)
    if lower_bound <= 0:
        return None
    # The true last pivot is between these two endpoints, inclusive.
    lowest = pivot - edge**2 / lower_bound
    if lowest > 0:
        return negative
    if pivot < 0:
        return negative + 1
    return None


def locate(k):
    lo, hi = 0.0, 0.88
    assert negative_count_approx(hi) >= k
    for _ in range(43):
        mid = (lo + hi) / 2
        if negative_count_approx(mid) < k:
            lo = mid
        else:
            hi = mid
    # Floating-point estimates select candidate endpoints only.
    den = 10**8
    left = Fraction(int(lo*den)-1, den)
    right = left + Fraction(3, den)
    for depth in count(12, 4):
        if depth > 100:
            raise ArithmeticError('Insufficient head depth for this bracket.')
        if (negative_count_exact(left, depth) == k-1
                and negative_count_exact(right, depth) == k):
            return left, right, depth


if __name__ == '__main__':
    for k in range(1, 5):
        lo, hi, depth = locate(k)
        # 1/x=s+1/s decreases in this range.
        print(f'{k}: {lo} < s < {hi}, certified head size {depth}; '
              f'1/x approximately {(float(lo + 1/lo + hi + 1/hi)/2):.8f}')
