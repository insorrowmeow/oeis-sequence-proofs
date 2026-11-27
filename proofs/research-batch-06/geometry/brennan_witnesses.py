"""Exhaustively bound the possible least missing primes in Brennan's two sequences."""

from argparse import ArgumentParser
from math import gcd, isqrt


def check_initial(shift):
    seen = set() if shift == 1 else {2, 3}
    terms = []
    while not {2, 3, 5, 7, 11}.issubset(seen):
        products = {1}
        for p in seen:
            products |= {a * p for a in products}
        for product in sorted(products):
            candidate = product + shift
            if candidate < 2:
                continue
            unknown = {p for p in range(2, candidate + 1) if candidate % p == 0
                       and all(p % i for i in range(2, isqrt(p) + 1))} - seen
            if unknown:
                assert len(unknown) == 1
                next_prime = unknown.pop()
                seen.add(next_prime)
                terms.append((product, next_prime))
                break
    print(f"Initial steps for shift {shift:+}: {terms}")


def run(bound):
    check_initial(1)
    check_initial(-1)
    prime = bytearray(b"\x01") * (bound + 1)
    prime[:2] = b"\x00\x00"
    squarefree = bytearray(b"\x01") * (bound + 1)
    for p in range(2, isqrt(bound) + 1):
        if prime[p]:
            square = p * p
            prime[square::p] = bytes((bound - square) // p + 1)
            squarefree[square::square] = bytes(bound // square)

    count = 0
    worst = {1: (0, 0), -1: (0, 0)}
    missing = []
    for q in range(11, bound + 1, 2):
        if not prime[q]:
            continue
        count += 1
        pending = {1, -1}
        for x in range(2, q):
            if not squarefree[x]:
                continue
            inv = pow(x, -1, q)
            for sign in tuple(pending):
                y = inv if sign == 1 else q - inv
                if squarefree[y] and gcd(x, y) == 1:
                    assert 1 < x*y < q*q - 1 and (x*y - sign) % q == 0
                    pending.remove(sign)
                    if x > worst[sign][0]:
                        worst[sign] = (x, q)
            if not pending:
                break
        else:
            missing.append((q, sorted(pending)))
    print(f"Checked {count} primes in [11, {bound}]. Missing witnesses: {missing}")
    print(f"Largest first x, and first q attaining it: {worst}")


if __name__ == "__main__":
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("bound", type=int, nargs="?", default=10_000_000)
    run(parser.parse_args().bound)
