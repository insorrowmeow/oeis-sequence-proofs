"""Check the fixed-popcount result using the OEIS odd/even recurrence."""
from math import factorial

def check(limit):
    b = [1]
    for k in range(1, 1 << limit):
        h = k // 2
        b.append(b[h] if k % 2 else b[h] + b[h - (h & -h)])
    for n in range(limit + 1):
        totals = [0] * (n + 1)
        for k in range(1 << n):
            totals[k.bit_count()] += b[k] ** 2
        numerator = factorial(2*n+1) * factorial(n+1)
        for p, total in enumerate(totals):
            denominator = (factorial(2*p+1) * factorial(2*(n-p)+1)
                           * factorial(p+1) * factorial(n-p+1))
            assert total * denominator == numerator, (n, p, total)
        if n == 4:
            print("n=4:", totals)
    print("Verified each bit count for n=0 through", limit)

if __name__ == "__main__":
    check(18)
