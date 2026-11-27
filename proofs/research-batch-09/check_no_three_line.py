"""Compute A236266 by marking future lattice points on each forbidden line."""

from math import gcd


def prefix(length):
    forbidden = [set() for _ in range(length)]
    values = []
    for j in range(length):
        y = 0
        while y in forbidden[j]:
            y += 1
        values.append(y)
        for i in range(j):
            dx, dy = j - i, y - values[i]
            scale = gcd(dx, dy)
            dx, dy = dx // scale, dy // scale
            height = y
            for k in range(j + dx, length, dx):
                height += dy
                if height < 0:
                    break
                forbidden[k].add(height)
    return values


if __name__ == "__main__":
    values = prefix(1000)
    print([(n, y) for n, y in enumerate(values) if 4 * y > 5 * n])
