"""Verify the valuation from coefficients of the original geometric powers."""


def times_geometric(coefficients, width):
    result = []
    window = 0
    for i in range(len(coefficients) + width - 1):
        if i < len(coefficients):
            window += coefficients[i]
        if i >= width:
            window -= coefficients[i - width]
        result.append(window)
    return result


def valuation2(n):
    assert n > 0
    return (n & -n).bit_length() - 1


def main():
    checks = 0
    for width in [1, 2, 4, 8, 16, 32, 64, 128]:
        row = [1]
        for exponent in range(101):
            if exponent % 2 == 0:
                degree = (width - 1) * (exponent // 2)
                assert valuation2(row[degree]) == degree.bit_count()
                checks += 1
            if exponent < 100:
                row = times_geometric(row, width)
    for width in range(1, 257):
        twice = times_geometric([1] * width, width)
        holds = valuation2(twice[width - 1]) == (width - 1).bit_count()
        assert holds == (width.bit_count() == 1)
    print(f"{checks} central coefficients matched; width criterion checked through 256.")


if __name__ == "__main__":
    main()
