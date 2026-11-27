"""Exact finite checks for the Stanley–Zanello centered differences.

Run with Python 3.9+. The classifications below are for the tested widths.
The asymptotic assertion is proved in the accompanying manuscript.
"""

from functools import lru_cache


@lru_cache(maxsize=None)
def rectangle(height, width):
    """Coefficient counts by removing a column of maximum height."""
    if height == 0 or width == 0:
        return (1,)
    no_full_column = rectangle(height - 1, width)
    full_column = rectangle(height, width - 1)
    counts = list(no_full_column) + [0] * (height * width + 1 - len(no_full_column))
    for rank, value in enumerate(full_column, height):
        counts[rank] += value
    return tuple(counts)


def product_formula(height, width):
    """Independent count by exact division of the Gaussian numerator."""
    degree = height * width
    counts = [1] + [0] * degree
    for i in range(1, height + 1):
        for rank in range(degree, width + i - 1, -1):
            counts[rank] -= counts[rank - width - i]
        for rank in range(i, degree + 1):
            counts[rank] += counts[rank - i]
    return tuple(counts)


def check(k, width, small_height, small_width):
    degree = k * width
    shift = (degree - small_height * small_width) // 2
    values = list(rectangle(k, width))
    for i, value in enumerate(rectangle(small_height, small_width), shift):
        values[i] -= value
    if values != values[::-1]:
        raise ArithmeticError("Reflection symmetry failed")
    if shift == 1 and width >= 2 and values[:3] != [1, 0, 1]:
        raise ArithmeticError("Exceptional prefix failed")
    half = degree // 2
    unimodal = values[0] >= 0 and all(values[i - 1] <= values[i] for i in range(1, half + 1))
    strict = all(values[i - 1] < values[i] for i in range(k - 1, half + 1))
    interior_rises = all(values[i - 1] <= values[i] for i in range(2, half + 1))
    return shift, unimodal, strict, interior_rises


if __name__ == "__main__":
    for h, w in [(1, 0), (3, 38), (8, 28), (9, 56), (12, 60)]:
        if rectangle(h, w) != product_formula(h, w):
            raise ArithmeticError(f"Independent rectangle counts disagree at {(h, w)}")
    for k in range(5, 13):
        checked = 0
        exceptional = 0
        last_other_failure = None
        last_strict_failure = None
        last_interior_failure = None
        for width in range(2, 61):
            d = k - 2
            for small_width in range(k * width // d + 1):
                if (k * width - d * small_width) % 2:
                    continue
                shift, ok, strict, interior_rises = check(k, width, d, small_width)
                checked += 1
                if shift == 1:
                    exceptional += 1
                    if not interior_rises:
                        last_interior_failure = width
                elif not ok:
                    last_other_failure = width
                elif not strict:
                    last_strict_failure = width
        print(f"k={k}, widths 2..60: {checked} differences, {exceptional} unit shifts, "
              f"last width with another failure {last_other_failure}, "
              f"last width with unimodality but without the strict rise {last_strict_failure}, "
              f"last unit-shift width with a further decline before center {last_interior_failure}")
