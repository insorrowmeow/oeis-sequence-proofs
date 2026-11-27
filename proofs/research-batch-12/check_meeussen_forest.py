"""Compare whole polynomial rows from the ODE and from Fayers' recursion."""

from collections import Counter
from functools import cache
from math import comb


@cache
def fayers(parts):
    if not parts:
        return 1
    row, col = max(enumerate(parts, 1), key=lambda pair: sum(pair))
    lower = parts[row:]
    right = tuple(x-col for x in parts if x > col)
    return comb(row+col, col) * fayers(lower) * fayers(right)


def shapes(bound, maximum):
    yield ()
    for part in range(1, min(bound, maximum)+1):
        for smaller in shapes(bound-1, part):
            yield (part, *smaller)


def ode_row(rows):
    n = len(rows)-1
    result = Counter()
    for a in range(n+1):
        for b in range(n-a+1):
            c = n-a-b
            factor = comb(n, a)*comb(n-a, b)
            for i, vi in rows[a].items():
                for j, vj in rows[b].items():
                    for k, vk in rows[c].items():
                        result[i+j+k+c] += factor*vi*vj*vk
    return result


if __name__ == '__main__':
    rows = [Counter({0: 1})]
    for n in range(1, 13):
        row = ode_row(rows)
        sums = Counter()
        for shape in shapes(n-1, n-1):
            sums[comb(n, 2)-sum(shape)] += fayers(shape)
        assert sums == row, n
        rows.append(row)
    print('All coefficients agree for 0 <= N <= 12.')
