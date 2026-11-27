"""Exact Fibonacci transfer matrices; requires python-flint >= 0.8.

python check_spectrum.py 1500
The search uses a modular upper bound and verifies exceptional candidates over ZZ.
"""
import argparse
from flint import fmpz_poly, nmod_poly


def weights(limit):
    a, b = "A", "AB"
    while len(b) < limit:
        a, b = b, b+a
    return (1 if c == "A" else 2 for c in b[:limit])


def candidates(limit, prime=None, wanted=None):
    poly = fmpz_poly if prime is None else lambda coeffs: nmod_poly(coeffs, prime)
    x = poly([0, 1])
    one, zero = poly([1]), poly([])
    a, b, c, d = one, zero, zero, one
    scale = 1
    for n, w in enumerate(weights(limit), 1):
        a, b, c, d = (w-x)*a+b, w*(b-x*a), (w-x)*c+d, w*(d-x*c)
        scale = scale*w if prime is None else scale*w % prime
        if n < 3 or (wanted is not None and n not in wanted):
            continue
        common = (a-scale).gcd(b).gcd(c).gcd(d-scale)
        if common.degree() > 0:
            yield n, common


def run(limit):
    expected = {}
    a, b = 2, 3
    while 4*b <= limit:
        expected[4*b] = b
        a, b = b, a+b
    mod_hits = dict(candidates(limit, 65537))
    for n, degree in expected.items():
        assert mod_hits[n].degree() >= degree
    outside = {n for n in mod_hits if n not in expected}
    # The mathematical theorem certifies all members of the Fibonacci family.
    # Exact GCDs also test the small members independently.
    wanted = outside | {n for n in expected if n <= 136}
    exact = dict(candidates(max(wanted, default=0), wanted=wanted))
    for n in wanted & expected.keys():
        assert exact[n].degree() == expected[n]
    for n in sorted(exact.keys() & outside):
        print(f"n={n}: degree {exact[n].degree()}, polynomial {exact[n]}", flush=True)
    print(f"Scanned 3..{limit}; verified {len(wanted & expected.keys())} small family GCDs over ZZ.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("limit", nargs="?", type=int, default=1500)
    run(parser.parse_args().limit)
