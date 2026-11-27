"""Compare digit walks against a direct implementation or optional OEIS b-files."""

from argparse import ArgumentParser
from itertools import count, permutations
from pathlib import Path


def walk(seed):
    current = seed
    used = {current}
    first = {(d, p): p for d in "0123456789" for p in range(2)}
    while True:
        yield current
        parity = 1 - current % 2
        options = []
        for digit in set(str(current)):
            candidate = first[digit, parity]
            while candidate in used or digit not in str(candidate):
                candidate += 2
            first[digit, parity] = candidate
            options.append(candidate)
        current = min(options)
        used.add(current)


def direct(seed, length):
    current = seed
    used = {seed}
    yield seed
    for _ in range(1, length):
        digits = set(str(current))
        current = next(k for k in count(1 - current % 2, 2)
                       if k not in used and digits.intersection(str(k)))
        used.add(current)
        yield current


def check_table(path, seed):
    sequence = walk(seed)
    rows = 0
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.partition("#")[0].strip()
        if line:
            i, value = map(int, line.split())
            assert i == rows and next(sequence) == value, (i, value)
            rows += 1
    assert rows > 0
    return rows


if __name__ == "__main__":
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("--a318698", type=Path)
    parser.add_argument("--a318699", type=Path)
    args = parser.parse_args()
    for seed in (0, 1, 6, 101):
        sequence = walk(seed)
        assert all(next(sequence) == term for term in direct(seed, 500))
    print("Two implementations agree for 500 terms from each of four seeds.")
    for seed, path in enumerate((args.a318698, args.a318699)):
        if path:
            print(f"{path.name}: {check_table(path, seed)} terms match.")
    for n in range(2, 10):
        a = sum((p[0] - p[1]) % 2 == 0 for p in permutations(range(1, n+1)))
        b = sum(x % 2 == 0 and y % 2 == 1 for p in permutations(range(1, n))
                for x, y in zip(p, p[1:]))
        assert a == 2*b, (n, a, b)
    print("Both original permutation counts agree with Mathar's identity for n=2..9.")
