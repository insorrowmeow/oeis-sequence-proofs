"""Generate both sequences literally, then compare their published prefixes."""

from itertools import count, islice


SPIRAL = (
    0, 10, 20, 30, 40, 50, 60, 70, 80, 18, 100, 12, 2, 23, 102, 90,
    49, 104, 101, 103, 16, 105, 106, 107, 78, 8, 81, 1, 21, 22, 24,
    25, 26, 29, 19, 9, 39, 91, 14, 11, 13, 15, 17, 31, 41, 51, 71,
    87, 28, 38, 48, 108, 61, 112, 27, 32, 34, 42, 52, 62, 69, 59, 79,
    89, 83, 93, 94, 109, 110, 111, 113,
)
TWO_BACK = (
    0, 1, 10, 11, 100, 101, 102, 12, 20, 21, 22, 112, 120, 103, 13,
    30, 31, 33, 113, 123, 23, 32, 122, 121, 110, 104, 14, 40, 41, 44,
    114, 124, 24, 42, 142, 125, 15, 25, 51, 52, 55, 152, 105, 50,
    106, 56, 16, 61, 66, 116, 126, 26, 62, 162, 127, 17, 27, 71, 72, 77,
)


def positions():
    x, y = 0, 0
    dx, dy = 1, 0
    yield x, y
    for length in count(1):
        for _ in range(2):
            for _ in range(length):
                x, y = x + dx, y + dy
                yield x, y
            dx, dy = -dy, dx


def choose(used, neighbors):
    digits = [set(str(n)) for n in neighbors]
    for candidate in count(0):
        if candidate not in used and all(d.intersection(str(candidate)) for d in digits):
            return candidate


def spiral(terms):
    used = set()
    board = {}
    for x, y in islice(positions(), terms):
        neighbors = [
            board[x + dx, y + dy] for dx in (-1, 0, 1) for dy in (-1, 0, 1)
            if (x + dx, y + dy) in board
        ]
        val = choose(used, neighbors)
        used.add(val)
        board[x, y] = val
        yield val


def two_back(terms, distinct_positions=False):
    values = [0, 1]
    used = set(values)
    while len(values) < terms:
        if distinct_positions:
            left, right = (str(n) for n in values[-2:])
            for val in count(10):
                if val in used:
                    continue
                digits = str(val)
                if any(i != j and a in left and b in right
                       for i, a in enumerate(digits) for j, b in enumerate(digits)):
                    break
        else:
            val = choose(used, values[-2:])
        values.append(val)
        used.add(val)
    return tuple(values)


if __name__ == "__main__":
    assert tuple(spiral(len(SPIRAL))) == SPIRAL
    assert two_back(5) == (0, 1, 10, 11, 12)
    assert TWO_BACK[4] == 100
    assert two_back(len(TWO_BACK), distinct_positions=True) == TWO_BACK
    print(f"A358048: {len(SPIRAL)} terms matched. A303605: "
          f"{len(TWO_BACK)} terms matched with distinct positions; mismatch at n=5 with reuse.")
