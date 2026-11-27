"""Independent exact checks for the handwritten A377000 proofs. Python 3."""
from math import comb


def row(base, length):
    """Count words by final digit. A word of length one starts above zero."""
    v = [0] + [1] * (base - 1)
    totals = []
    for _ in range(length):
        totals.append(sum(v))
        v = [a + b for a, b in zip([0] + v[:-1], v[1:] + [0])]
    return totals


def operators(dim, length):
    """Malešević's original rule on operation labels, i -> j."""
    ending = [1] * dim
    totals = []
    for _ in range(length):
        totals.append(sum(ending))
        ending = [
            sum(ending[i - 1] for i in range(1, dim + 1)
                if j == i + 1 or i + j == dim + 1)
            for j in range(1, dim + 1)
        ]
    return totals


def a182555(limit):
    """Formal coefficients of (3 - 4x - sqrt(1 - 4x^2))/(2(1-2x)^2)."""
    sqrt = [1]
    coeff = []
    for k in range(limit + 1):
        if k:
            convolution = sum(sqrt[j] * sqrt[k - j] for j in range(1, k))
            rhs = -4 if k == 2 else 0
            assert (rhs - convolution) % 2 == 0
            sqrt.append((rhs - convolution) // 2)
        numerator = (3 if k == 0 else -4 if k == 1 else 0) - sqrt[k]
        assert numerator % 2 == 0
        value = numerator // 2
        if k >= 1:
            value += 4 * coeff[k - 1]
        if k >= 2:
            value -= 4 * coeff[k - 2]
        coeff.append(value)
    return coeff


def triangle_max(k):
    """The top entry is a binomially weighted sum; sort weights by size."""
    weights = sorted(comb(k, j) for j in range(k + 1))
    twice = sum(weight * (2*j - k) for j, weight in enumerate(weights))
    assert twice % 2 == 0
    return twice // 2


def verify():
    for q in range(2, 33, 2):
        assert row(q, 80) == operators(q - 1, 80)
    print("Operator-label counts agree for even bases 2 through 32 at lengths 1..80.")
    recurrences = {
        6: [1, 2, -1], 7: [0, 4, 0, -2], 8: [1, 3, -2, -1],
        9: [0, 5, 0, -5], 10: [1, 4, -3, -3, 1], 11: [0, 6, 0, -9, 0, 2],
        12: [1, 5, -4, -6, 3, 1],
    }
    for q, coefficients in recurrences.items():
        values = row(q, 400)
        for i in range(len(coefficients), len(values)):
            assert values[i] == sum(c * values[i-j] for j, c in enumerate(coefficients, 1))
    print("All seven recurrences displayed in A377000 hold through length 400.")
    diagonal = a182555(100)
    assert diagonal[:8] == [1, 2, 5, 12, 29, 68, 158, 360]
    for k in range(1, 101):
        for offset in range(8):
            q = k + offset
            if q >= 2:
                assert row(q, k)[-1] == diagonal[k] + (offset - 2) * 2**(k-1)
        if k >= 2:
            assert row(k, k)[-1] == triangle_max(k)
    print("Diagonal coefficients, seven neighboring diagonals and triangle maxima agree through k=100.")


if __name__ == "__main__":
    if not __debug__:
        raise SystemExit("Use Python without -O to enable assertions.")
    verify()
