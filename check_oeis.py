"""Compare the published b-file with the literal minimum in A340138."""
from pathlib import Path
import sys


def check(path):
    seen = set()
    last = 0
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        data = line.partition("#")[0].split()
        if not data:
            continue
        index, value = map(int, data)
        assert index == len(seen) + 1
        if index == 1:
            assert value == 0
        else:
            root = str(1 + (last - 1) % 9 if last else 0)
            candidate = 1
            while candidate in seen or root not in str(candidate):
                candidate += 1
            assert candidate == value, (index, candidate, value)
        seen.add(value)
        last = value
    assert len(seen) >= 10000
    print(f"All {len(seen)} published terms agree with the literal greedy rule.")


if __name__ == "__main__":
    check(Path(sys.argv[1]))
