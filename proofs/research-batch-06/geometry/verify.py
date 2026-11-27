"""Independent finite checks for A334386, A334581 and A308359."""

from collections import defaultdict
from itertools import combinations
from math import comb


def triangles(side):
    points = [
        (a, b, c, side - a - b - c)
        for a in range(side + 1)
        for b in range(side - a + 1)
        for c in range(side - a - b + 1)
    ]
    masks = [sum(1 << i for i in range(4) if point[i] == 0) for point in points]
    neighbor_sets = [defaultdict(set) for point in points]
    for i, j in combinations(range(len(points)), 2):
        length = sum((a - b) ** 2 for a, b in zip(points[i], points[j]))
        neighbor_sets[i][length].add(j)
    all_triangles = touching = 0
    for i, by_length in enumerate(neighbor_sets):
        for length, neighbors in by_length.items():
            for j in neighbors:
                for k in neighbors & neighbor_sets[j].get(length, set()):
                    all_triangles += 1
                    touching += (masks[i] | masks[j] | masks[k]) == 15
    return all_triangles, touching


def normalize(shape):
    left = min(x for x, y in shape)
    bottom = min(y for x, y in shape)
    return frozenset((x-left, y-bottom) for x, y in shape)


def check_polyominoes():
    shapes = {frozenset({(0, 0)})}
    cardinalities = [1, 2, 6, 19, 63, 216, 760, 2725, 9910, 36446]
    for n, expected_total in enumerate(cardinalities, 1):
        assert len(shapes) == expected_total
        if n >= 5:
            near = sum(max(x for x, _ in item) + 1 == n-2 for item in shapes)
            assert near == 8*n*n-51*n+86
            print(f"A308359 area {n}: {near}")
        if n < len(cardinalities):
            larger = set()
            for shape in shapes:
                for x, y in shape:
                    for cell in [(x-1,y), (x+1,y), (x,y-1), (x,y+1)]:
                        if cell not in shape:
                            larger.add(normalize(shape | {cell}))
            shapes = larger


def check_triangles():
    touching_reference = [0, 4, 8, 12, 16, 32, 36, 28, 32, 60, 100, 80]
    for n, expected in enumerate(touching_reference, 1):
        side = n-1
        total, touching = triangles(side)
        assert touching == expected
        assert (touching - 4*side) % 12 == 0
        fixed_orbits, remainder = divmod(comb(side+3, 3) - (side//3+1), 3)
        assert remainder == 0 and (total - 4*fixed_orbits) % 12 == 0
        print(f"A334386 n={n}: {touching}; A334581: {total}")


if __name__ == "__main__":
    check_triangles()
    check_polyominoes()
