"""Exhaust all partitions, up to color names, with n colors and local cap 2."""

from math import comb


def enumerate_partitions(n):
    full = (1 << n) - 1
    pending = sorted(range(1, full), key=lambda s: (-s.bit_count(), s))
    classes = [[full]]
    supports = [full]
    best = None
    count = 0

    def search(i, occupied, defects):
        nonlocal best, count
        # A new color must touch a point outside all existing non-full colors.
        if n - len(classes) > n - occupied.bit_count():
            return
        if i == len(pending):
            if len(classes) == n:
                best = defects if best is None else min(best, defects)
                count += 1
            return
        s = pending[i]
        for c in range(len(classes)):
            if c and s & (occupied ^ supports[c]):
                continue
            extra = sum(not (s & t) for t in classes[c])
            old = supports[c]
            supports[c] |= s
            classes[c].append(s)
            search(i + 1, occupied | s if c else occupied, defects + extra)
            classes[c].pop()
            supports[c] = old
        if len(classes) < n and not (s & occupied):
            classes.append([s])
            supports.append(s)
            search(i + 1, occupied | s, defects)
            supports.pop()
            classes.pop()

    search(0, 0, 0)
    return count, best


def formula(n):
    disjoint_nonempty = (3**n - 2 ** (n + 1) + 1) // 2
    disjoint_large = disjoint_nonempty - n * (2 ** (n - 1) - 1) + comb(n, 2)
    return disjoint_large - 2 ** (n - 2) + n


if __name__ == "__main__":
    for n in range(3, 8):
        count, best = enumerate_partitions(n)
        assert best == formula(n)
        print(f"n={n}  partitions={count}  minimum={best}")
