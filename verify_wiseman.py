"""Reproduce the finite checks for the binary-run and Stolarsky identities.

Run with Python 3.8 or later. Only integer arithmetic is used.
"""

from math import isqrt
from bisect import bisect_right


def compositions(value):
    """Return the run and anti-run compositions in increasing bit-position order."""
    positions = [i for i in range(value.bit_length()) if (value >> i) & 1]
    if not positions:
        return (), ()
    runs = [1]
    anti = [1]
    for low, high in zip(positions, positions[1:]):
        if high == low + 1:
            runs[-1] += 1
            anti.append(1)
        else:
            runs.append(1)
            anti[-1] += 1
    return tuple(runs), tuple(anti)


def first_occurrences(limit):
    run_rows = {}
    anti_rows = {}
    for value in range(limit):
        run, anti = compositions(value)
        run_rows.setdefault(run, value)
        anti_rows.setdefault(anti, value)
    return list(run_rows.values()), list(anti_rows.values())


def stolarsky_digits(n):
    """Direct inverse recurrence as implemented in the OEIS entries."""
    digits = []
    while n > 1:
        root_floor = isqrt(5 * n * n)
        parent = (root_floor - n + 1) // 2        # nearest integer to n / phi
        recovered = (isqrt(5 * parent * parent) + parent + 1) // 2
        if recovered == n:
            digits.append(1)
            n = parent
        else:
            digits.append(0)
            n = (3 * n - root_floor - 1) // 2 + 1  # floor(n / phi^2) + 1
    return digits[::-1]


def representatives(max_digits):
    """All canonical words in numeric order; the empty word represents zero."""
    yield 0
    shorter, current = [], [1]
    for digit_count in range(1, max_digits + 1):
        yield from current
        first = [(1 << digit_count) + word for word in shorter]
        second = [(1 << digit_count) + word for word in current]
        shorter, current = current, first + second


def following_no_double_zero(current):
    # Independent literal numeric search suffices for the direct carry check.
    candidate = current + 1
    while "00" in bin(candidate)[2:]:
        candidate += 1
    return candidate


def standard_composition_rank(parts):
    rank = 0
    cumulative_size = 0
    for size in reversed(parts):
        cumulative_size += size
        rank += 1 << (cumulative_size - 1)
    return rank


def wythoff_words(limit):
    """Construct Kimberling's words at the original lower/upper Beatty indices."""
    words = [None] * (limit + 1)
    words[1:3] = ["0", "1"]
    for k in range(1, limit + 1):
        assert words[k] is not None
        m = k + 1
        lower = (m + isqrt(5 * m * m)) // 2
        upper = lower + m
        if lower <= limit:
            assert words[lower] is None
            words[lower] = "0" + words[k]
        if upper <= limit:
            assert words[upper] is None
            words[upper] = "1" + words[k]
    return words


def maximal_fibonacci_bits(k, fibonacci):
    remaining = k
    greedy_word = []
    for i in range(bisect_right(fibonacci, k) - 1, 1, -1):
        if fibonacci[i] <= remaining:
            remaining -= fibonacci[i]
            greedy_word.append("1")
        else:
            greedy_word.append("0")
    word = "".join(greedy_word)
    while "100" in word:
        word = word.replace("100", "011").lstrip("0")
    return word


def main():
    brute_digits = 17
    limit = 1 << brute_digits
    run_minima, anti_minima = first_occurrences(limit)
    canonical = list(representatives(brute_digits))
    assert run_minima == canonical == anti_minima
    print(f"Direct duplicate removal for {limit} integers: {len(canonical)} rows.")

    previous = 0
    for row, word in enumerate(canonical[1:], start=1):
        run, _ = compositions(word)
        successor = following_no_double_zero(previous)
        assert word == 2 * previous + 1
        assert run[0] == (previous ^ successor).bit_length(), row
        previous = successor
    print(f"A083368 checked from n=1 through n={len(canonical)-1}.")

    runs, anti = compositions(0)
    assert not stolarsky_digits(1) and not runs and not anti
    assert len(anti) == 0
    assert sum(anti) == 0 and len(runs) - 1 == -1  # Both scalar OEIS entries give 1.
    word_limit = 100_000
    wythoff = wythoff_words(word_limit)
    fibonacci = [0, 1]
    while fibonacci[-1] < 200_000:
        fibonacci.append(fibonacci[-1] + fibonacci[-2])
    kurkov = [0, 1]
    for n, word in enumerate(representatives(24), start=1):
        if n == 1:
            continue
        runs, anti = compositions(word)
        digits = stolarsky_digits(n)
        assert len(anti) == digits.count(1), n
        assert len(runs) - 1 == digits.count(0), n
        assert sum(anti) == sum(runs) == len(digits), n
        j = n - 1
        if j >= 2:
            d = bisect_right(fibonacci, j) - 2
            parent = j - fibonacci[d]
            parent_d = bisect_right(fibonacci, parent) - 2
            kurkov.append(2 * kurkov[parent] + (d - parent_d) % 2)
        assert standard_composition_rank(anti) == kurkov[j], j
        k = n - 2
        if 1 <= k <= word_limit:
            assert wythoff[k].count("0") == digits.count(1) - 1, k
            assert wythoff[k].count("1") == digits.count(0), k
            assert maximal_fibonacci_bits(k, fibonacci).count("0") == digits.count(0), k
    print(f"All three Stolarsky identities checked for 2 <= n <= {n}.")
    print("n=1: A200649 agrees; A200648 and A200650 have the stated exceptions.")
    print(f"A348366 checked through j={len(kurkov)-1}; A341259 and A117479 through k={word_limit}.")


if __name__ == "__main__":
    main()
