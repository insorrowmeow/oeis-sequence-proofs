"""Independent finite checks for A342235 and A365383. Requires Python 3."""
from math import gcd
from functools import reduce


def valid(x, y, z):
    return (x % 2, y % 2, z % 2) not in ((0, 0, 0), (1, 1, 1))


def distance(x, y, z):
    return abs(x-1) + abs(y) + abs(z) + 2 * (x != 1 and y == z == 0)


def verify_tetrastix(radius):
    layer = {(1, 0, 0)}
    visited = set(layer)
    for n in range(radius + 1):
        expected = 1 if n == 0 else 12 if n == 2 else 3*n*n + 2 - n % 2
        assert len(layer) == expected
        assert all(distance(*point) == n for point in layer)
        if n == radius:
            break
        next_layer = set()
        for x, y, z in layer:
            for point in ((x-1,y,z), (x+1,y,z), (x,y-1,z),
                          (x,y+1,z), (x,y,z-1), (x,y,z+1)):
                if point not in visited and valid(*point):
                    next_layer.add(point)
        visited.update(next_layer)
        layer = next_layer
    print(f"A342235: all {len(visited)} vertices in the ball of radius {radius} agree.")


def partitions(n, limit):
    if n == 0:
        yield ()
    for largest in range(1, min(n, limit) + 1):
        for rest in partitions(n - largest, largest):
            yield (largest, *rest)


def onset(n):
    m = n // 2
    if n < 3:
        return 0
    if n % 2:
        return m * (m-1)
    if m % 2:
        return (m-3) * (m+1)
    return m * (m-2)


def verify_partitions(max_row):
    for n in range(1, max_row + 1):
        last = onset(n) + 2*n
        count = [0] * (last + 1)
        by_gcd = [0] * (n + 1)
        for parts in partitions(n, n):
            reachable = 1  # A bit at position k means k is representable.
            for p in set(parts):
                step = p
                while step <= last:
                    reachable |= reachable << step
                    step *= 2
            by_gcd[reduce(gcd, parts)] += 1
            for k in range(last + 1):
                count[k] += (reachable >> k) & 1
        changes = [k for k in range(last-n+1) if count[k] != count[k+n]]
        assert max(changes, default=-1) + 1 == onset(n)
        for k in range(onset(n), last + 1):
            assert count[k] == sum(by_gcd[d] for d in range(1, n+1) if k % d == 0)
    print(f"A365383: direct partition/coin counts confirm period and first columns through n={max_row}.")


if __name__ == "__main__":
    if not __debug__:
        raise SystemExit("Run without -O so that the certificate assertions are enabled.")
    verify_tetrastix(40)
    verify_partitions(28)
