"""Outward bounds for the A400734 density, using only integer arithmetic."""
from math import isqrt


def local_root_count(p):
    neg = 1 if p % 4 == 1 else -1
    two = 1 if p % 8 in (1, 7) else -1
    three = neg * (1 if p % 3 == 1 else -1)
    five = {0: 0, 1: 1, 4: 1, 2: -1, 3: -1}[p % 5]
    seven = neg * (0 if p == 7 else 1 if p % 7 in (1, 2, 4) else -1)
    characters = (1, two, three, 1, five, two * three, seven)
    return sum(2 + (1 + neg) * ch for d, ch in enumerate(characters, 1) if d % p)


def interval(cutoff, scale):
    prime = bytearray([1]) * (cutoff + 1)
    for p in range(2, isqrt(cutoff) + 1):
        if prime[p]:
            prime[p*p::p] = bytes((cutoff-p*p)//p+1)
    lo = 7*scale//27
    hi = (7*scale+26)//27
    for p in range(5, cutoff+1):
        if prime[p]:
            den = p*(p+1)
            num = den-local_root_count(p)
            lo = lo*num//den
            hi = (hi*num+den-1)//den
    return lo*(cutoff+1-28)//(cutoff+1), hi


if __name__ == "__main__":
    scale = 10**20
    print(interval(5_000_000, scale), 'divided by', scale)
