"""Two exact counts for shifted Ferrers shapes. Run with Python 3.8+."""

from itertools import combinations
from math import comb


def rank_profile(shape):
    """Insert parts in decreasing order, checking the flag in their row."""
    length, largest = len(shape), shape[0]
    # Encode a polynomial in base 2**width. Every coefficient counts subsets,
    # and the sum of all admissible subset counts is below that base.
    width = sum(comb(largest, j) for j in range(length + 1)).bit_length()
    by_count = [1] + [0] * length
    for value in range(largest, 0, -1):
        for used in range(length - 1, -1, -1):
            if value <= shape[used]:
                by_count[used + 1] += by_count[used] << (width * value)
    total = sum(by_count)
    mask = (1 << width) - 1
    return [(total >> (width * rank)) & mask for rank in range(sum(shape) + 1)]


def split_profile(shape):
    """Enumerate high sets explicitly and count low ranks by an array DP."""
    b, m = len(shape), shape[-1]
    limit = sum(shape)
    by_count = [[0] * (limit + 1) for _ in range(b + 1)]
    by_count[0][0] = 1
    for value in range(1, m + 1):
        for j in range(min(b, value), 0, -1):
            for rank in range(value, min(limit, j * value) + 1):
                by_count[j][rank] += by_count[j - 1][rank - value]
    loose = [list(by_count[0])]
    for row in by_count[1:]:
        loose.append([a + c for a, c in zip(loose[-1], row)])
    result = [0] * (limit + 1)
    upper = range(shape[0], m, -1)
    for h in range(min(b, len(upper)) + 1):
        for high in combinations(upper, h):
            if any(x > bound for x, bound in zip(high, shape)):
                continue
            offset = sum(high)
            for rank, count in enumerate(loose[b - h][:limit - offset + 1], offset):
                result[rank] += count
    return result


def peaks_and_valley(counts):
    peak = max(counts)
    peaks = [rank for rank, count in enumerate(counts) if count == peak]
    fell = False
    for k in range(1, len(counts)):
        if counts[k] > counts[k - 1] and fell:
            return peaks, k
        fell = fell or counts[k] < counts[k - 1]
    return peaks, None


if __name__ == "__main__":
    for shape in [(14, 13, 11, 10, 9), (44, 42, 40, 38),
                  (80, 77, 76, 74, 72), (65, 63, 62, 60, 59, 57),
                  (74, 73, 72, 70, 69, 68, 67, 66)]:
        profile = rank_profile(shape)
        if profile != split_profile(shape):
            raise ArithmeticError(f"High/low decomposition disagrees for {shape}")
        modes, valley = peaks_and_valley(profile)
        print(f"{shape}: {len(profile)} ranks, modes {modes}, height {max(profile)}, "
              f"first rise after a fall {valley}")
