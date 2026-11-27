"""Count perfect matchings of the original king-neighbor board by backtracking."""

from functools import cache


def matchings(width, height, ordinary):
    mask = (1 << (width * height)) - 1

    @cache
    def visit(remaining, left):
        if not remaining:
            return int(left == 0)
        v = (remaining & -remaining).bit_length() - 1
        x, y = v % width, v // width
        total = 0
        for dx, dy in ((1, 0), (-1, 1), (0, 1), (1, 1)):
            xx, yy = x + dx, y + dy
            if not (0 <= xx < width and yy < height):
                continue
            cost = int(dx == 0 or dy == 0)
            bit = 1 << (width*yy + xx)
            if remaining & bit and cost <= left:
                total += visit(remaining ^ (1 << v) ^ bit, left-cost)
        return total

    return visit(mask, ordinary)


if __name__ == "__main__":
    for m in range(1, 6):
        for n in range(1, 6):
            assert matchings(2*m, 2*n, 0) == 1
            assert matchings(2*m, 2*n, 2) == m*n*(m+n+2)//2
    print("Checked both coefficients on all 25 rectangles through 10 x 10.")
