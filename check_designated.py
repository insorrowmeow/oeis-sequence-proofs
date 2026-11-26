"""Check the counting model for A385001 independently on small rows."""
from collections import Counter
from math import prod


def partitions(total, smallest=1):
    if total == 0:
        yield ()
    for part in range(smallest, total + 1):
        for tail in partitions(total - part, part):
            yield (part,) + tail


def counts_by_size(limit):
    rows = [Counter() for _ in range(limit + 1)]
    rows[0][0] = 1
    for size in range(1, limit + 1):
        for total in range(limit, size - 1, -1):
            for multiplicity in range(1, total // size + 1):
                for k, ways in rows[total - multiplicity * size].items():
                    rows[total][k + 1] += ways * multiplicity
    return rows


def main():
    rows = counts_by_size(32)
    for n, row in enumerate(rows):
        expected = Counter()
        for partition in partitions(n):
            counts = Counter(partition)
            expected[len(counts)] += prod(counts.values())
        assert row == expected, (n, row, expected)
    assert dict(rows[6]) == {1: 12, 2: 15, 3: 1}
    print("All columns of rows 0 through 32 agree with direct enumeration.")


if __name__ == "__main__":
    main()
