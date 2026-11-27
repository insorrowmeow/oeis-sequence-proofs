"""Cross-check the determinant by elimination and the automaton by placing triangles."""
from fractions import Fraction
from math import factorial, gcd, prod
from pathlib import Path
from argparse import ArgumentParser


def determinant(matrix):
    """These rational matrices are positive definite and have positive pivots."""
    ans = 1
    for k, row in enumerate(matrix):
        ans *= row[k]
        for other in matrix[k+1:]:
            scale = other[k] / row[k]
            for j in range(k+1, len(row)):
                other[j] -= scale * row[j]
    return ans


def numerator(step, n):
    v = prod(factorial(k) for k in range(1, n+1))
    smooth = 1
    while (g := gcd(step, v)) > 1:
        smooth *= g
        v //= g
    return step**(n*(n+1)) * smooth**2


def counts(length):
    values = [1]
    for n in range(1, length):
        if n%2:
            count = 3*values[n//2]
        elif n%4 == 0:
            count = values[n//2]
        elif n%8 == 2:
            t = n//8
            count = 3*values[4*t] + 4*values[2*t]
        else:
            t = n//8
            count = 3*values[4*t+2] + 4*values[2*t]
        values.append(count)
    return values


def simulate(length):
    cells = {(0,0)}
    for n in range(length):
        yield len(cells)
        after = set()
        sign = 1 if n%2 == 0 else -1
        for i,j in cells:
            after.symmetric_difference_update(((i,j),(i+sign,j),(i,j+sign)))
        cells = after


if __name__ == "__main__":
    if not __debug__:
        raise SystemExit("Run without -O to verify assertions.")
    parser = ArgumentParser()
    parser.add_argument("--a275667", type=Path)
    args = parser.parse_args()
    checked = 0
    for step in range(1, 13):
        for offset in range(1, 13):
            if gcd(step,offset) != 1:
                continue
            for n in range(9):
                mat = [[Fraction(1,offset+step*(i+j)) for j in range(n+1)]
                       for i in range(n+1)]
                assert determinant(mat).numerator == numerator(step,n)
                checked += 1
    assert list(simulate(201)) == counts(201)
    print(f"{checked} exact determinants; direct cellular simulation at times 0..200.")
    if args.a275667:
        rows = [tuple(map(int, line.split())) for line in args.a275667.read_text().splitlines()
                if line.strip() and not line.lstrip().startswith("#")]
        assert list(enumerate(counts(len(rows)))) == rows
        print(f"{len(rows)} entries match the published A275667 table.")
