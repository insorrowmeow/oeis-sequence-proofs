"""Independent finite audit of A050128 generated directly from its rule."""
import argparse


def check(limit):
    # Index 0 is the sentinel forbidden in the recurrence.
    seen = {0: 0, 1: 1}
    last = 1
    for i in range(2, 4 * limit + 6):
        half = last // 2
        last = 2 * i if half in seen else half
        assert 0 < last <= 2 * i and last not in seen
        seen[last] = i
    examples = []
    conjectural_exceptions = []
    for n in range(2, limit + 1):
        i = seen[n]
        assert i <= 4 * n + 5
        assert (2 * i == n or i in (n + 1, 2*n + 2, 2*n + 3,
                                    4*n + 3, 4*n + 4, 4*n + 5))
        if i == 4 * n + 5 and len(examples) < 5:
            examples.append((n, i))
        if i == 4 * n + 4:
            conjectural_exceptions.append((n, i))
    print(f"All positive n through {limit:,} occurred by 4n+5.")
    print("First examples attaining 4n+5:", examples)
    print("Additional 4n+4 positions:", conjectural_exceptions[:10])


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=250_000)
    check(parser.parse_args().limit)
