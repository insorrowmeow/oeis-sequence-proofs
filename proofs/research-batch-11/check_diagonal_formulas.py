"""Cross-check the literal MO 495883 sum and coefficient normalization against M."""

from fractions import Fraction as Q
from math import comb, factorial, prod


def triangle(limit):
    rows = [[1]]
    for i in range(1, limit + 1):
        row = rows[-1]
        rows.append([1] + [sum(row[k] * rows[k][j] for k in range(j, i))
                           for j in range(i)])
    return rows


def polynomials(limit):
    rows = [[1]]
    for i in range(limit):
        cs = rows[-1]
        rows.append([4**i * a - b for a, b in zip(cs + [0], [0] + cs)])
    return rows


def literal(rows, coefficients, m, n):
    result = Q(0)
    for i in range((m + 1) // 2):
        r = coefficients[i]
        left = sum(c * 2**(n * (m - 2*i + 2*j)) for j, c in enumerate(r))
        right = sum(c * rows[k+m][k] * Q(2)**(-k * (m - 2*i + 2))
                    for k, c in enumerate(r))
        result += (left * right * Q(2)**(-i*(i-3)) /
                   prod(4**h-1 for h in range(1, i+1)))
    return result


def check_normalization(rows, limit):
    # Columns of (M-I)^i applied to e_0, converted from binomial to monomial basis.
    column = [1] + [0]*limit
    basis = [Q(1)]
    monomials = [[Q(0)]*(limit+1) for _ in range(limit+1)]
    for i in range(limit+1):
        for m in range(i, limit+1):
            for k, c in enumerate(basis):
                monomials[m][k] += column[m]*c
        column = [sum(rows[m][h]*column[h] for h in range(m)) for m in range(limit+1)]
        basis = [(a-i*b)/(i+1) for a, b in zip([Q(0)]+basis, basis+[Q(0)])]
    for m in range(1, limit+1):
        for k in range(m+1):
            c = monomials[m][k]
            if (m-k) % 2 or k == 0:
                assert c == 0
                continue
            p = (-1)**((m-k)//2) * c * factorial(m) / 2**comb(k, 2)
            assert p.denominator == 1 and p > 0
            if k == m:
                assert p == 1


if __name__ == '__main__':
    rows = triangle(72)
    coefficients = polynomials(24)
    for m in range(1, 49):
        for n in (0, 1, 4, 8, 19, 24):
            assert literal(rows, coefficients, m, n) == rows[n+m][n]
    check_normalization(rows, 45)
    print('288 direct triple sums matched; coefficient normalization verified through m=45.')
