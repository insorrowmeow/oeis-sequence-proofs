from math import gcd, isqrt, pi


def values(indices):
    radius = isqrt(4 * max(indices)) + 4
    points = sorted(
        (a * a + b * b, b, a)
        for a in range(1, radius + 1)
        for b in range(a + 1)
        if a * a + b * b <= radius * radius
    )
    for n in indices:
        norm, b, a = points[n - 1]
        limit = isqrt(norm - 1)
        direct = 0
        for x in range(-limit, limit + 1):
            ymax = isqrt(norm - 1 - x * x)
            direct += sum(gcd(x - a, y - b) == 1 for y in range(-ymax, ymax + 1))
        by_mobius = 0
        cutoff = isqrt(4 * norm)
        mu = [0, 1] + [0] * (cutoff - 1)
        for d in range(1, cutoff + 1):
            for j in range(d + d, cutoff + 1, d):
                mu[j] -= mu[d]
            if not mu[d]:
                continue
            in_residue_class = 0
            for x in range(-limit + ((a + limit) % d), limit + 1, d):
                ymax = isqrt(norm - 1 - x * x)
                in_residue_class += (ymax - b) // d - (-ymax - 1 - b) // d
            by_mobius += mu[d] * in_residue_class
        assert direct == by_mobius
        print(f'{n:>7}  ({a},{b})  {norm:>6}  {direct:>7}  {direct / n:.6f}')


def hex_values(indices):
    path = [(0, 0)]
    ring = 0
    while len(path) <= max(indices):
        ring += 1
        x, y = 1, 1 - ring
        path.append((x, y))
        for dx, dy, steps in ((1, 1, ring - 1), (0, 1, ring),
                              (-1, 0, ring), (-1, -1, ring),
                              (0, -1, ring), (1, 0, ring)):
            for _ in range(steps):
                x += dx
                y += dy
                path.append((x, y))
    assert len(set(path)) == len(path)
    assert path[9] == (2, 1)
    for n in indices:
        a, b = path[n]
        direct = sum(gcd(x - a, y - b) == 1 for x, y in path[:n])
        print(f'{n:>7} ({a},{b}) {direct:>7} {direct/n:.6f}')


if __name__ == '__main__':
    print('n z N(z) visible visible/n')
    values([1, 7, 100, 1000, 10000, 100000])
    print(f'48/pi^2 = {48 / pi**2:.6f}')
    print('n hex_point visible visible/n')
    hex_values([1, 9, 100, 1000, 10000, 100000])
    print(f'6/pi^2 = {6 / pi**2:.6f}')
