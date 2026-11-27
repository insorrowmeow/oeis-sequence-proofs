"""Compare the ranked formulas with square witnesses, palindromes and Quet's sieve."""

from bisect import bisect_left


def explicit(n):
    index = n + 1
    length = index.bit_length() - 1
    half = 1 << (length - 1)
    prefix = half + index % half
    v = (prefix & -prefix).bit_length() - 1
    z = prefix >> v
    m = length + v + (index >= 3 * half)
    difference = prefix << ((2 * index // 3).bit_length() + 2)
    return difference, (1 << m) + z, (1 << m) - z, prefix


def main():
    count = 300
    cutoff = explicit(count)[0]
    observed = []
    # For each odd y and dyadic sum 2*t, the unique candidate is x=2*t-y.
    # Its smallest possible positive difference is 4*t, attained at y=t-1.
    t = 2
    while 4 * t <= cutoff:
        for y in range(t - 1, 0, -2):
            x = 2 * t - y
            difference = x * x - y * y
            if difference > cutoff:
                break
            observed.append((difference, x, y))
        t *= 2
    observed.sort()
    assert len(observed) == count
    prefixes = []
    candidate = 1
    while len(prefixes) < count:
        digits = bin(candidate)[2:]
        if digits == digits[::-1]:
            prefixes.append(int(digits[: (len(digits) + 1) // 2], 2))
        candidate += 2
    for n, (triple, prefix) in enumerate(zip(observed, prefixes), 1):
        assert explicit(n) == (*triple, prefix), n

    # Direct simulation of A120241, where each term is a rank among unused
    # positive integers. Only the first count inverse terms are required.
    steps = max(x // 2 for _, x, _ in observed)
    used = []
    inverse = {}
    for step in range(1, steps + 1):
        k = step - (1 << (step.bit_length() - 1)) + 1
        lo, hi = k, k + len(used)
        while lo < hi:
            mid = (lo + hi) // 2
            if mid - bisect_left(used, mid + 1) < k:
                lo = mid + 1
            else:
                hi = mid
        used.insert(bisect_left(used, lo), lo)
        if lo <= count:
            inverse[lo] = step
    assert all(inverse[n] == x // 2 for n, (_, x, _) in enumerate(observed, 1))
    print(f"{count} square differences, palindrome prefixes and inverse ranks agree")


if __name__ == "__main__":
    main()
