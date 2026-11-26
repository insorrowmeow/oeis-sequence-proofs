"""Find semiprime counterexamples to Zhi-Wei Sun's OEIS A279821 list."""
from math import comb, prod


def central(k):
    return sum(comb(k, 2*j)*comb(2*j, j) for j in range(k//2 + 1))


def prime_divisors(n):
    divisor = 2
    while divisor*divisor <= n:
        if n % divisor == 0:
            yield divisor
            while n % divisor == 0:
                n //= divisor
        divisor += 1 if divisor == 2 else 2
    if n > 1:
        yield n


def digits(n, base):
    while n:
        n, digit = divmod(n, base)
        yield digit


def central_mod(n, prime):
    return prod(central(d) % prime for d in digits(n, prime)) % prime


for a in range(2, 32):
    if list(prime_divisors(a)) != [a]:
        continue
    # For n = a*b with primes a < b, the digit rule at b requires b | T(a)-1.
    for b in prime_divisors(central(a) - 1):
        if b > a and central_mod(b, a) == 1:
            n = a*b
            assert central_mod(n, b) == central_mod(n, a) == 1
            print(f"n = {a} * {b} = {n}")
            print(f"T({a}) - 1 = {(central(a)-1)//b} * {b}")
            print(f"Digits of {b} in base {a} (low to high): {list(digits(b,a))}")
