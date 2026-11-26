"""Certify examples of the stronger congruence in OEIS A308482, for c=7*3^h."""
from fractions import Fraction


def digits(n, base):
    result = []
    while n:
        n, digit = divmod(n, base)
        result.append(digit)
    return result


def valuation(n, prime):
    if not n:
        raise ValueError("the valuation of zero is infinite")
    exponent = 0
    while n % prime == 0:
        n //= prime
        exponent += 1
    return exponent


def sufficient_certificate(h):
    n = 7 * 3**h - 1
    # Each correction modulo 49 touches at most two neighbouring base-7 digits.
    if digits(n, 7).count(3) < 3:
        return False

    # Expand ((x-1)^2 + 3*x)^n. Terms from index 2*h onward vanish mod 3^(2*h).
    # Divide its remaining signed terms by (-1)^n * binomial(2*n,n).
    term = total = Fraction(1)
    for j in range(1, 2*h):
        term *= Fraction(-3*(n-j+1)**2, 2*j*(2*n-2*j+1))
        total += term
    if not total:
        return True

    # Legendre's formula for v_3(binomial(2*n,n)).
    binomial_valuation = 0
    power = 3
    while power <= 2*n:
        binomial_valuation += (2*n)//power - 2*(n//power)
        power *= 3
    return (binomial_valuation + valuation(total.numerator, 3)
            - valuation(total.denominator, 3) >= 2*h)


if __name__ == "__main__":
    confirmed = [h for h in range(1, 61) if sufficient_certificate(h)]
    for h in confirmed:
        print(f"h={h:2}   c={7*3**h}")
    print(f"Certified {len(confirmed)} distinct composites beyond 189.")
