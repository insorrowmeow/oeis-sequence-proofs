"""Independent numerical checks for the exact-period theorem for A300326."""

from math import isqrt


def literal_digit_sum(base, modulus):
    value = 0
    for digit in range(base - 1, -1, -1):
        value = (value * base + digit) % modulus
    return value


def digit_sum_mod(base, prime):
    a = base % prime
    if a == 0:
        return 0
    if a == 1:
        return (base * (base - 1) // 2) % prime
    return (a * ((a - 2) * pow(a, base, prime) + 1)
            * pow((a - 1)**2, -1, prime)) % prime


def shortest_block(word):
    """Shortest repeating block whose repetitions exactly tile word (KMP)."""
    borders = [0] * len(word)
    for i in range(1, len(word)):
        j = borders[i - 1]
        while j and word[j] != word[i]:
            j = borders[j - 1]
        if word[j] == word[i]:
            j += 1
        borders[i] = j
    k = len(word) - borders[-1]
    return k if len(word) % k == 0 else len(word)


def prime_list(limit):
    return [p for p in range(2, limit + 1)
            if all(p % d for d in range(2, isqrt(p) + 1))]


def check(limit=101):
    primes = prime_list(limit)
    for p in primes:
        period = 8 if p == 2 else 9 if p == 3 else p * (p - 1)
        acc, word = 0, []
        for base in range(1, 2 * period + 2):
            increment = digit_sum_mod(base, p)
            if base <= 120 or p <= 7:
                assert increment == literal_digit_sum(base, p)
            acc = (acc + increment) % p
            word.append(acc)
        assert word[:period] == word[period:2*period]
        assert shortest_block(word[:2*period]) == period
        assert word[period - 4:period + 1] == [1, 1, 0, 0, 0]
        assert word[:6] == [x % p for x in (0, 2, 23, 251, 3181, 47971)]
    print(f"Verified least periods and tails for all {len(primes)} primes <= {limit}.")
    print("Compared modular formula with direct evaluation of the digit string.")


if __name__ == "__main__":
    check()
