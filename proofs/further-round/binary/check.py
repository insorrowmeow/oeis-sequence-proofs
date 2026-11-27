"""Exhaust the carry certificates in the Gray-code and carryless-product proofs."""
from itertools import product


def gray(x):
    return x ^ (x >> 1)


def gray_states():
    def term(x, y):
        return gray(gray(x) + gray(y))

    x, y = 1, 1
    for _ in range(11):
        x = term(x, y)
        y = term(y, x)
    assert (x, y) == (4072, 2505)
    pending = [(x >> 2, y >> 2)]
    seen = set(pending)
    for u, v in pending:
        assert 978 <= u < 1024 and 544 <= v < 640
        for c, d in product(range(2), repeat=2):
            w = gray(gray(u) + gray(v) + c)
            nxt = (w >> 1, gray(gray(v) + gray(w) + d) >> 1)
            if nxt not in seen:
                seen.add(nxt)
                pending.append(nxt)
    assert len(seen) == 140
    assert all((3//2, gray(1+3+c)//2) == (1, 3) for c in (0, 1))


def carry_step(state, s, m, b):
    if state is not None:
        c, h = state
        u, v = c+s*b, h ^ (m*b)
        if u%2 == v%2:
            return u//2, v//2
    return None


def carry_states():
    def accepts(state):
        return state is not None and state[0] == state[1]

    initial = ((0, 0), (0, 0))
    queue, seen = [initial], {initial}
    for left, right in queue:
        assert accepts(left) == accepts(right)
        for b in (0, 1):
            nxt = carry_step(left, 7, 11, b), carry_step(right, 5, 13, b)
            if nxt not in seen:
                seen.add(nxt)
                queue.append(nxt)
    assert len(seen) == 15


if __name__ == "__main__":
    if not __debug__:
        raise SystemExit("Run without -O to verify assertions.")
    gray_states()
    carry_states()
    print("Gray prefix certificate: 140 states and 560 transitions. Twin prefix closed.")
    print("Carryless multiplier equivalence: all 15 states and 30 transitions verified.")
