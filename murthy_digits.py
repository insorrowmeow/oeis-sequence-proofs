"""Construct a witness for the nonzero terms of OEIS A113572 / A113573."""

import argparse
from itertools import product
from math import isqrt


def position_sieve(n):
    prime = bytearray([1]) * (n + 1)
    prime[0:2] = b"\x00\x00"
    for p in range(2, isqrt(n) + 1):
        if prime[p]:
            for multiple in range(p * p, n + 1, p):
                prime[multiple] = 0
    return prime


def remainder(digits, modulus):
    result = 0
    for digit in digits:
        result = (10 * result + digit) % modulus
    return result


def witness(n):
    """Return a valid decimal digit string, or None for a forced zero."""
    if n < 1:
        raise ValueError("n must be positive")
    if n % 5 == 0:
        return "12245" if n == 5 else None

    prime = position_sieve(n)
    digits = [1] + [2 if prime[i] else 8 for i in range(2, n + 1)]
    even_part = n & -n
    exponent = even_part.bit_length() - 1
    odd_part = n // even_part

    # Determine the lowest exponent digits by lifting one binary place at a time.
    parity_residue = remainder(digits, even_part)
    weight = 1
    for j in range(exponent):
        if (parity_residue >> j) & 1:
            digits[n - 1 - j] += 1
            parity_residue = (parity_residue + weight) % even_part
        weight = weight * 10 % even_part

    # Determine which of the remaining digits to increase. A parent points
    # to a previously attained residue, so no place can be used twice.
    start = remainder(digits, odd_part)
    if start:
        reachable = {start}
        parents = {}
        weight = pow(10, exponent, odd_part)
        for j in range(exponent, n - 1):
            new = {
                (r + weight) % odd_part: (r, j)
                for r in reachable
                if (r + weight) % odd_part not in reachable
            }
            parents.update(new)
            reachable.update(new)
            if 0 in reachable:
                break
            weight = weight * 10 % odd_part
        current = 0
        while current != start:
            current, j = parents[current]
            digits[n - 1 - j] += 1
    return "".join(map(str, digits))


def allowed(i):
    if i == 1:
        return (1,)
    is_prime = all(i % d for d in range(2, isqrt(i) + 1))
    return (2, 3, 5, 7) if is_prime else (4, 6, 8, 9)


def validate(n, word):
    assert len(word) == n
    digits = [int(ch) for ch in word]
    assert all(d in allowed(i) for i, d in enumerate(digits, start=1))
    assert remainder(digits, n) == 0


def checks():
    # Unfiltered brute-force enumeration for the first eight positions.
    for n in range(1, 9):
        exists = any(
            remainder(digits, n) == 0
            for digits in product(*(allowed(i) for i in range(1, n + 1)))
        )
        assert (witness(n) is not None) == exists
    indices = list(range(1, 1001)) + [10001, 10005, 10007, 10008, 16384, 19683]
    for n in indices:
        word = witness(n)
        if word is None:
            assert n % 5 == 0 and n > 5
        else:
            validate(n, word)
    print(f"Passed independent digit and modulus checks for {len(indices)} indices.")
    print("Agreed with unrestricted brute force through n=8.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("n", nargs="?", type=int)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if args.check:
        checks()
    elif args.n is not None:
        print(witness(args.n) or "0")
    else:
        parser.error("supply n or --check")
