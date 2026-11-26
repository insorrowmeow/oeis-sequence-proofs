"""Verify the A376453 counterexample using Python's standard library."""
from bisect import bisect_right
from itertools import count
from math import isqrt


def place_values(limit):
    """OEIS A002620, starting with the positive values 1, 2, 4, 6, ..."""
    for j in count(2):
        value = j * j // 4
        if value > limit:
            break
        yield value


def greedy_expansion(n, places):
    terms = []
    while n:
        largest = places[bisect_right(places, n) - 1]
        terms.append(largest)
        n -= largest
    return terms


def initial_digits(limit):
    """Between successive place values p and q, digit(p+r) = digit(r)."""
    digits = bytearray(limit + 1)
    digits[1] = 1
    for j in count(3):
        start = j*j // 4
        if start > limit:
            break
        stop = min((j+1)*(j+1) // 4, limit+1)
        digits[start:stop] = digits[:stop-start]
    return digits


def main():
    a, b = 104_080_799, 104_080_805
    places = list(place_values(b))
    expected = [1, 0, 0, 0, 0, 0, 1]
    for n, digit in zip(range(a, b+1), expected):
        terms = greedy_expansion(n, places)
        assert (terms[-1] == 1) == bool(digit)
        print(f"{n}: " + " + ".join(map(str, terms)) + f"  (units digit {digit})")

    digits = initial_digits(b)
    # Compare the block algorithm with direct greedy division on an initial
    # segment and on the witness, including its intermediate nonmembers.
    for n in range(1, 15001):
        assert digits[n] == (greedy_expansion(n, places)[-1] == 1)
    assert list(digits[a:b+1]) == expected
    assert digits.find(bytes(5)) == a+1  # Any gap >5 contains five consecutive zeros.
    position = digits.count(1, 0, a+1)
    print(f"First gap above five: b({position})={a}, b({position+1})={b}.")

    left, right = 1, 3
    for gap in range(2, 10):
        assert right-left == gap
        # This second greedy evaluator uses the square/pronic description
        # and can check the very large lifted examples directly.
        for n in range(left, right+1):
            r = n
            while r > 1:
                k = isqrt(r)
                r -= k*(k+1) if k*(k+1) <= r else k*k
            assert r == (n in (left, right))
        print(f"gap {gap}: {left}, {right}")
        left, right = right*(right-1)+left, right*right+1


if __name__ == "__main__":
    if not __debug__:
        raise SystemExit("Run without -O so assertions are checked.")
    main()
