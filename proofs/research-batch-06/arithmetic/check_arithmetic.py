"""Independent finite checks for A036284 and A210456, using only Python."""

from math import isqrt


def binary_multiplicity(poly, factor):
    count = 0
    while poly:
        quotient, value = 0, poly
        while value and value.bit_length() >= factor.bit_length():
            shift = value.bit_length() - factor.bit_length()
            quotient |= 1 << shift
            value ^= factor << shift
        if value:
            break
        poly = quotient
        count += 1
    return count


def mask_multiplicities(n):
    modulus = 2 ** (n + 1)
    a, b, mask = 0, 1, 0
    for k in range(3 * 2**n):
        mask |= (a >> n) << k
        a, b = b, (a + b) % modulus
    return binary_multiplicity(mask, 0b11), binary_multiplicity(mask, 0b111)


def pow_x(exponent, n, modulus):
    """Binary exponentiation modulo X^n - (1 + ... + X^(n-1))."""
    def product(a, b):
        c = [0] * (2*n-1)
        for i, u in enumerate(a):
            for j, v in enumerate(b):
                c[i+j] += u*v
        for k in range(2*n-2, n-1, -1):
            coeff = c[k] % modulus
            for i in range(k-n, k):
                c[i] += coeff
        return [z % modulus for z in c[:n]]

    result = [1] + [0] * (n-1)
    x = [0, 1] + [0] * (n-2)
    while exponent:
        if exponent % 2:
            result = product(result, x)
        x = product(x, x)
        exponent //= 2
    return result


def prime_divisors(n):
    for d in range(2, isqrt(n) + 1):
        if n % d == 0:
            yield d
            while n % d == 0:
                n //= d
    if n > 1:
        yield n


def assert_exact_period(n, modulus, expected):
    one = [1] + [0] * (n-1)
    assert pow_x(expected, n, modulus) == one
    for p in prime_divisors(expected):
        assert pow_x(expected // p, n, modulus) != one


if __name__ == "__main__":
    for n in range(1, 12):
        linear, quadratic = mask_multiplicities(n)
        d = 2 ** (n-1) - 1
        expected_linear = 2**n-1 if n <= 3 else 2**(n-1)
        assert linear == expected_linear and quadratic == d
        print(f"bit column {n}: factor multiplicities {linear}, {quadratic}")
    for k in range(1, 6):
        q = 3**k
        for n, base in ((q-1, q*q-1), (q, q*q+q+1)):
            assert_exact_period(n, 3, base)
            assert_exact_period(n, 9, 3*base)
            print(f"order {n}: exact periods mod 3 and mod 9 are {base}, {3*base}")
