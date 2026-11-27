"""Compare planted ordered forests with Voloshyn's differential recursion (3.21)."""
import argparse
from collections import Counter
from math import comb


def tree_rows(limit):
    # Keys are (sum of root labels, total number of marked vertices).
    forests = [Counter({(0, 0): 1})]
    planted = [Counter()]
    for size in range(1, limit + 1):
        tree = Counter()
        for (child_labels, marks), count in forests[size - 1].items():
            for label in range(2, child_labels + 2):
                tree[label, marks] += count
            tree[child_labels + 2, marks + 1] += count
        planted.append(tree)
        forest = Counter()
        for first_size in range(1, size + 1):
            for (label, marks), first_count in planted[first_size].items():
                for (other_labels, other_marks), rest_count in forests[size - first_size].items():
                    forest[label + other_labels, marks + other_marks] += first_count * rest_count
        forests.append(forest)
        # A forced maximal root adds one mark; the statistic in (3.55) subtracts two.
        row = [0] * size
        for (_, marks), count in forest.items():
            assert 1 <= marks <= size
            row[marks - 1] += count
        yield row


def differentiate(numerator, power):
    """Numerator of (N(u)/(1+u)^power)' over (1+u)^(power+1)."""
    derivative = [0] * len(numerator)
    for i, coeff in enumerate(numerator):
        if i:
            derivative[i - 1] += i * coeff
        derivative[i] += (i - power) * coeff
    return derivative


def differential_rows(limit):
    numerator = [0, 1]
    power = 1
    for size in range(1, limit + 1):
        for _ in range(3):
            numerator = differentiate(numerator, power)
            power += 1
        divisor = size * (size + 1) * (2 * size + 1)
        assert all(coeff % divisor == 0 for coeff in numerator)
        numerator = [0] + [coeff // divisor for coeff in numerator]
        while numerator[-1] == 0:
            numerator.pop()
        assert len(numerator) == size + 1
        yield [(-1) ** i * coeff for i, coeff in enumerate(numerator[1:])]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--through", type=int, default=20)
    args = parser.parse_args()
    if args.through < 1:
        parser.error("--through must be positive")
    for size, (tree, gww) in enumerate(zip(tree_rows(args.through),
                                         differential_rows(args.through)), start=1):
        if tree != gww:
            raise ValueError(f"Row {size} differs: tree={tree} and GWW={gww}")
        expected_total = 2**size * comb(3 * size, size) // ((size + 1) * (2 * size + 1))
        assert sum(tree) == expected_total
    print(f"Verified every coefficient for 1 <= s <= {args.through}.")
    print(f"Last row counts {sum(tree)} trees across {len(tree)} statistic classes.")


if __name__ == "__main__":
    main()
