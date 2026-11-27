"""Independent exact checks of the two formulas, without network dependencies."""

from bisect import bisect_right
from functools import cache
from math import isqrt


def lower(n):
    return (n + isqrt(5 * n * n)) // 2


def upper(n):
    return lower(n) + n


def wythoff_words(limit):
    words = {0: ""}
    for i in range(limit + 1):
        word = words[i]
        for child, letter in ((lower(i + 1), "0"), (upper(i + 1), "1")):
            if child <= limit:
                assert child not in words
                words[child] = letter + word
    return words


def word_position(word):
    position = 0
    for digit in reversed(word):
        position = (upper if digit == "1" else lower)(position + 1)
    return position


def balanced_sequence(count):
    terms = []
    n = 1
    while len(terms) < count:
        word = format(n, "b")
        trimmed = word.rstrip("0")
        if len(word) - len(trimmed) == trimmed.count("0"):
            terms.append(n)
        n += 1
    return [None, *terms]


def tree_label(address, fib):
    label = 1
    for bit in format(address, "b")[1:]:
        t = bisect_right(fib, label) - 1
        label += fib[t + int(bit)]
    return label


def tree_from_post(address):
    """Exact transcription of the low-bit-first update in the posted question."""
    x = y = 0
    for bit in reversed(format(address, "b")):
        x, y = y + 1, x + y
        if bit == "1":
            x, y = y, x + y
    return y


def check(limit=10000):
    terms = balanced_sequence(limit + 2)
    fib = [0, 1]
    while fib[-1] <= (limit + 2) ** 3:
        fib.append(fib[-1] + fib[-2])
    words = wythoff_words(limit)
    inversion = str.maketrans("01", "10")

    def length(j):
        return bisect_right(fib, j) - 2

    @cache
    def k(j):
        if j <= 1:
            return j
        r = length(j)
        h = j - fib[r]
        return 2 * k(h) + (r - length(h)) % 2

    for n in range(1, limit + 1):
        c = terms[n + 2]
        reverse = int(format(c, "b")[::-1], 2)
        address = (reverse - 1) // 2
        other = word_position(words[n].translate(inversion))
        assert tree_label(address, fib) - 1 == other, n
        assert tree_from_post(address) - 1 == other, n
        assert address == k(n + 1), n

    # Independent generation of A247648 by scanning ordinary integers.
    j = 0
    for raw in range(1, terms[-1], 2):
        word = format(raw, "b")
        if "00" in word:
            continue
        j += 1
        decoded = word.replace("01", "0")
        odd = terms[j + 1] // (terms[j + 1] & -terms[j + 1])
        assert odd == int(decoded + "1", 2), j
        reversed_index = sum(fib[i] for i, digit in enumerate(word, 1) if digit == "1")
        assert k(reversed_index) == int(decoded, 2), j
        if j >= 2:
            h = j - fib[length(j)]
            parent = terms[h + 1]
            g = int(j > 2 * h)
            assert terms[j + 1] == (1 << g) * (parent + ((2 - g) << (parent.bit_length() - 1))), j
        if j == limit + 1:
            break
    assert j == limit + 1
    for m in range(2, len(fib)):
        if fib[m] >= len(terms):
            break
        assert terms[fib[m]] == 2 ** (m - 1) - 1
    print(f"Both complement-position identities agree at n=1..{limit}.")
    print(f"Balanced-word and reversed-index identities agree at j=1..{j}.")
    print(f"Balanced-number recurrence agrees at j=2..{j}.")


if __name__ == "__main__":
    check()
