"""Independent integer cofactor check for OEIS A401537 (Python standard library)."""


def bareiss(matrix):
    a = [row.copy() for row in matrix]
    last = 1
    for k in range(len(a) - 1):
        pivot = a[k][k]
        assert pivot > 0  # positive definite cofactor at the four evaluation points
        for i in range(k + 1, len(a)):
            for j in range(k + 1, len(a)):
                num = pivot * a[i][j] - a[i][k] * a[k][j]
                a[i][j], rem = divmod(num, last)
                assert rem == 0
        last = pivot
    return a[-1][-1]


def cofactor(n, weight):
    a = [[0] * (3 * n) for _ in range(3 * n)]

    def edge(u, v, w):
        a[u][u] += w
        a[v][v] += w
        a[u][v] -= w
        a[v][u] -= w

    for row in range(3):
        for col in range(n):
            v = n * row + col
            edge(v, n * ((row + 1) % 3) + col, 1)
            if col + 1 < n:
                edge(v, v + 1, 1)
        edge(n * row + n - 1, n * (2 - row), weight)
    return bareiss([row[1:] for row in a[1:]])


def coefficients(n, previous, current):
    difference = current - previous
    product, rem = divmod(4 * (difference**2 - 1), 3)
    assert rem == 0
    trace = 4 * current * difference
    base = 3 * current**2
    return (base, (n - 1) * base + trace, (n - 1) * trace + product,
            (n - 1) * product)


if __name__ == '__main__':
    a, b = 0, 1
    for n in range(1, 21):
        cs = coefficients(n, a, b)
        for w in range(4):
            assert cofactor(n, w) == sum(c * w**j for j, c in enumerate(cs))
        assert (cs[1] > cs[2]) == (n <= 15) and cs[1] != cs[2]
        if n in (8, 15, 16):
            print(n, 'c1 =', cs[1], 'c2 =', cs[2])
        a, b = b, 5 * b - a
    print('All four coefficients checked independently for 1 <= n <= 20.')
