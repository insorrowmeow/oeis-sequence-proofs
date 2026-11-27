"""Exhaustively evaluate all labeled triangle floor triples in a finite range."""


def formula(n):
    return (n*n - 4*n + (6, -3, 4, 3, 0, -5)[n % 6]) // 3


def check(n):
    triples = [(u, v, n-u-v) for u in range(1, n) for v in range(1, n-u)
               if len({u, v, n-u-v}) == 3]
    floor_sums = range(n-2, n+1)
    best = 0
    for total in floor_sums:
        # The exclusions and unrestricted set are symmetric in the three vertices.
        for a in range(total//3+1):
            for b in range(a, (total-a)//2+1):
                c = total-a-b
                if total == n and a == 0:
                    continue  # All angles must then be positive integers.
                count = sum(u < n-a and v < n-b and w < n-c for u, v, w in triples)
                best = max(best, count)
    a, b, c = (n-2)//3, (n-1)//3, n//3
    balanced = sum(u < n-a and v < n-b and w < n-c for u, v, w in triples)
    assert best == balanced == formula(n), (n, best, balanced, formula(n))


if __name__ == "__main__":
    for denominator in range(3, 61):
        check(denominator)
    assert formula(180) == 10562
    print("All floor triples agree for n=3..60; a(180)=10562.")
