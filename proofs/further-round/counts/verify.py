"""Independent checks of rotation classes, polygon transfer matrices, and permanents."""
from itertools import permutations, product
from math import comb, factorial, gcd


def enumerate_polygon(sides, total):
    representatives = set()
    for corners in product(range(1, total - 1), repeat=sides):
        edges = [total - x - y for x, y in zip(corners, corners[1:] + corners[:1])]
        if min(edges) < 1:
            continue
        boundary = tuple(zip(corners, edges))
        representatives.add(min(boundary[i:] + boundary[:i] for i in range(sides)))
    return len(representatives)


def transfer_count(sides, total):
    size = total - 2
    m = [[int(i + j < size) for j in range(size)] for i in range(size)]
    power = [[int(i == j) for j in range(size)] for i in range(size)]
    traces = {}
    for d in range(1, sides + 1):
        power = [[sum(a*b for a, b in zip(row, col)) for col in zip(*m)] for row in power]
        traces[d] = sum(power[i][i] for i in range(size))
    return sum(traces[gcd(sides, s)] for s in range(sides)) // sides


def triangle(n):
    return sum((j*j + 3)//4 for j in range(n+1))


def square(n):
    return (n**4 + 6*n**3 + 17*n*n + 30*n + 21 + 3*(-1)**n)//24


def krauter(n):
    return sum((-2)**k * (2*n*comb(2*n-k, k)//(2*n-k))*factorial(n-k)
               for k in range(n+1))


def permanent(n, s, t):
    total = 0
    for sigma in permutations(range(n)):
        weight = 1
        for i, j in enumerate(sigma):
            if j == i:
                weight *= 1+s
            if j == (i+1) % n:
                weight *= 1+t
        total += weight
    return total


def check_ode(s, t):
    v = s*t
    a = [1, 1+s+t] + [permanent(n, s, t) for n in range(2, 8)]
    h = [1, -s-t, v]
    # Coefficients of z²G B' + (-1+z+2vz²+vz³-v²z⁴)B.
    residual = []
    for n, an in enumerate(a):
        b = a[:n+1][::-1] + [0]*4
        residual.append(-an + n*b[1] + 2*v*b[2] + v*(4-n)*b[3] - v*v*b[4])
    expected = [-1, 0, 3*v, 0, -3*v*v, 0, v**3, 0]
    assert [sum(h[j]*residual[i-j] for j in range(min(i, 2)+1))
            for i in range(len(a))] == expected


if __name__ == "__main__":
    if not __debug__:
        raise SystemExit("Run Python without -O.")
    for total in range(2, 13):
        assert enumerate_polygon(3, total) == triangle(total-2)
    for total in range(3, 12):
        assert enumerate_polygon(4, total) == square(total-3)
    for total in range(3, 7):
        for sides in range(3, 8):
            assert transfer_count(sides, total) == enumerate_polygon(sides, total)
    a = [1] + [krauter(n) for n in range(1, 101)]
    for n in range(2, 9):
        assert permanent(n, -2, -2) == a[n]
    for n in range(4, 101):
        assert ((2-n)*a[n] + (n*n-4*n+6)*a[n-1]
                + 2*(n*n-2*n+3)*a[n-2] + 8*(n-1)*a[n-3]) == 0
        if n >= 5:
            assert a[n]-n*a[n-1]-8*a[n-2]+4*(n-4)*a[n-3]+16*a[n-4] == 0
    for s, t in [(-2, -2), (-1, -1), (2, 3), (-3, 2), (0, 1)]:
        check_ode(s, t)
    print("Polygon orbits checked directly for triangles through sum 12 and squares through sum 11.")
    print("Transfer counts matched exhaustive orbits for 20 size/sum pairs.")
    print("Both A195422 recurrences matched Krauter's sum through n=100; true permanents checked through n=8.")
    print("The bivariate differential equation matched five weight choices to degree 7.")
