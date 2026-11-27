"""Finite independent check of the criterion and the indicated drop."""
from itertools import accumulate, combinations_with_replacement


def ordinary_product(lengths):
    poly = [1]
    for length in lengths:
        new = [0] * (len(poly) + length - 1)
        for i, value in enumerate(poly):
            for k in range(i, i + length):
                new[k] += value
        poly = new
    return poly


def check_family(lengths, r, largest_b):
    poly = ordinary_product(lengths)
    floor_sum = sum(a // r for a in lengths)
    residues = sorted(a % r for a in lengths)
    count = 0
    spaced = []
    for b in range(1, largest_b + 1):
        start = r * (b - 1)
        spaced.extend([0] * (start + len(poly) - len(spaced)))
        for j, value in enumerate(poly, start):
            spaced[j] += value
        center = (len(spaced) - 1) // 2
        left = spaced[:center + 1]
        unimodal = spaced == spaced[::-1] and left == list(accumulate(left, max))
        predicted = 0 in residues or b <= floor_sum + 1
        if unimodal != predicted:
            raise ValueError(("criterion", lengths, r, b, spaced))
        if not predicted:
            if len(lengths) <= 3:
                s1, s2, s3 = [1] * (3 - len(lengths)) + residues
                t = max(s3, s1 + s2 - 1)
                j = r * floor_sum + t
                drop = min(t - s3 + 1, r - s3)
            else:
                j = r * floor_sum + 1
                drop = 1
            if j > center or spaced[j-1] - spaced[j] != drop:
                raise ValueError(("drop", lengths, r, b, j, drop, spaced))
        count += 1
    return count


if __name__ == "__main__":
    checks = 0
    for k in range(1, 4):
        for lengths in combinations_with_replacement(range(1, 19), k):
            for r in range(2, 12):
                checks += check_family(lengths, r, 12)
    for k in range(4, 8):
        for lengths in combinations_with_replacement(range(1, 8), k):
            checks += check_family(lengths, 2, 15)
    print(f"All {checks} polynomial coefficient checks passed.")
