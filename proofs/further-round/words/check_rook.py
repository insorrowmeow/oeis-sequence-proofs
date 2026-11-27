"""Direct enumeration of all visitation orders against the published recurrences."""

from functools import cache
from itertools import permutations
from math import comb, factorial


@cache
def first(n):
    if n == 0:
        return 1
    return (1 + n.bit_count()) * first(n // 2)


@cache
def second(n):
    if n == 0:
        return 1
    if n % 2:
        return second(n // 2)
    u = n // 2
    low = u & -u
    return second(u) + second(u - low) + second(n - low)


def submasks(mask):
    part = mask
    while True:
        yield part
        if part == 0:
            break
        part = (part - 1) & mask


def enumerate_tours(width):
    # hist[mask][q] counts orders whose rightward departures occur exactly at
    # mask, and whose endpoint is q. Cell 0 is leftmost, width-1 rightmost.
    hist = [[0] * width for _ in range(1 << (width-1))]
    bits = [1 << i for i in reversed(range(width-1))] + [0]
    for word in permutations(range(width)):
        ascents = sum(bits[i] for i, j in zip(word, word[1:]) if i < j)
        hist[ascents][word[-1]] += 1
    for n in range(1 << (width-1)):
        assert sum(hist[n]) == second(n)
        assert sum(sum(hist[r]) for r in submasks(n)) == first(n)
        assert sum((-1)**(n.bit_count()-r.bit_count()) * first(r)
                   for r in submasks(n)) == second(n)
        if width == 1 or not n & bits[0]:
            continue
        cut = n ^ bits[0]
        for q in range(width):
            measured1 = sum(hist[r][q] for r in submasks(n))
            measured2 = hist[n & ~bits[q]][q]
            if q == 0 or q == width-1:
                assert (measured1, measured2) == (first(cut), second(cut))
            else:
                assert measured1 == first(cut | bits[q])
                assert measured2 == second(cut | bits[q]) + second(cut & ~bits[q])


if __name__ == "__main__":
    for width in range(1, 10):
        enumerate_tours(width)
    for n in range(512):
        for m in range(8):
            assert first((2*n+1) << m) == sum(
                comb(m+1, k) * first(n << k) for k in range(m+2))
    print(f"{sum(factorial(k) for k in range(1,10)):,} visitation orders, widths 1..9.")
    print("Both transform identities and both endpoint formulas verified for n=0..255 "
          "(endpoint formulas apply for n>0).")
    print("4,096 independent binomial-sum checks.")
