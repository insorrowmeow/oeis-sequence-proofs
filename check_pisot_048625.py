"""Independent exact checks of A048625 and its conjectured continued fraction."""


def pisot(count):
    seq = [4, 6]
    while len(seq) < count:
        x, y = seq[-2:]
        quotient, remainder = divmod(y * y, x)
        seq.append(quotient + (2 * remainder > x))
    return seq[:count]


def narayana(count):
    seq = [1, 1, 1]
    while len(seq) < count:
        seq.append(seq[-1] + seq[-3])
    return seq[:count]


def invert_series(seq):
    assert seq[0] == 1
    inverse = [1]
    for degree in range(1, len(seq)):
        inverse.append(-sum(seq[j] * inverse[degree-j] for j in range(1, degree+1)))
    return inverse


def truncated_fraction(depth):
    # Include the first coefficient beyond the range of exact agreement.
    degree = depth + 1
    series = [1] + [0] * degree
    for k in reversed(range(depth)):
        inv = invert_series(series)
        series = [1] + [-(2*k+1)*inv[j-1] for j in range(1, degree+1)]
        series[1] += 2*k+3
        for j in range(3, degree+1):
            series[j] -= inv[j-3]
        if degree >= 3:
            series[3] += 1
    return series


def main():
    count = 3000
    values = pisot(count)
    assert values == narayana(count+5)[5:]
    ties = [i for i, (a, b) in enumerate(zip(values, values[1:]))
            if 2 * ((b*b) % a) == a]
    assert ties == [1]
    leading_error = -2
    for depth in range(41):
        truncation = truncated_fraction(depth)
        true_series = [1] + [2*t for t in narayana(depth+1)]
        assert truncation[:-1] == true_series[:-1]
        assert truncation[-1] - true_series[-1] == leading_error
        leading_error *= 2*depth + 1
    print('A048625: 3000 exact terms matched; only tie at n=1.')
    print('Continued fraction: depths 0 through 40 and first differing coefficients checked.')


if __name__ == '__main__':
    main()
