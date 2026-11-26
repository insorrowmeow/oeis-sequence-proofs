"""Verify the A308482 witness directly from trinomial coefficients modulo prime powers."""
from math import comb


def central_mod(n, p, exponent):
    """Sum n! / (j! j! (n-2j)!) modulo p**exponent; divide only by units."""
    modulus = p**exponent
    prime_powers = [p**i for i in range(exponent)]

    def split(x):
        v = 0
        while x % p == 0:
            v += 1
            x //= p
        return v, x

    term_unit, term_valuation, total = 1, 0, 1
    for j in range(1, n//2+1):
        a, u = split(n-2*j+2)
        b, v = split(n-2*j+1)
        d, w = split(j)
        term_valuation += a+b-2*d
        assert term_valuation >= 0
        term_unit = term_unit*u*v*pow(w*w, -1, modulus) % modulus
        if term_valuation < exponent:
            total = (total+term_unit*prime_powers[term_valuation]) % modulus
    return total


def direct(n):
    return sum(comb(n,j)*comb(n-j,j) for j in range(n//2+1))


if __name__ == '__main__':
    for p,e in ((3,24),(7,6)):
        for n in range(80):
            assert central_mod(n,p,e) == direct(n) % p**e
    c = 413343
    assert c == 3**10*7
    for p,e,need in ((3,24,20),(7,6,2)):
        r = central_mod(c-1,p,e)
        print(f"T({c-1}) mod {p}^{e} = {r}; required T mod {p}^{need} = {r%p**need}")
        assert r % p**need == 0
        v = 0
        while v < e and r % p**(v+1) == 0:
            v += 1
        print(f"Valuation at {p} {'=' if v < e else '>='} {v}")
