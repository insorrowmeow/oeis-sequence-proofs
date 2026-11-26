"""Exact positivity certificates for empirical ceiling-Pisot recurrences.

No external packages. All bounds, fits and identity checks use rational
arithmetic. See proof.txt for the finite-dimensional justification.
"""
from fractions import Fraction as F
from math import comb


R3 = (2, -1, 1, -1)
R4 = (2, -1, 0, 1, -1)
S3 = (3, -3, 2, -1)
# OEIS, first two terms, signed recurrence, index from which it applies
targets = [
    ("A048590", 8, 9, R4, 6), ("A048592", 9, 10, R4, 6),
    ("A048591", 8, 10, R3, 4), ("A048587", 6, 10, S3, 4),
    ("A020736", 5, 8, S3, 4), ("A048580", 3, 10, (4,-2), 2),
    ("A048585", 6, 7, R3, 4), ("A048589", 7, 9, R3, 4),
]


def guess_recurrence(values):
    """Berlekamp--Massey over Q. The caller separately proves the identity."""
    c, b = [F(1)], [F(1)]
    k, shift, last = 0, 1, F(1)
    for n in range(len(values)):
        err = sum(c[i]*values[n-i] for i in range(k+1))
        if err == 0:
            shift += 1
            continue
        old = c[:]
        c.extend([F(0)]*max(0,len(b)+shift-len(c)))
        for j,a in enumerate(b):
            c[j+shift] -= err*a/last
        if 2*k <= n:
            k = n+1-k
            b, last, shift = old, err, 1
        else:
            shift += 1
    return tuple(-v for v in c[1:k+1])


def certificate(values, stride, begin, dim):
    terms = values[begin::stride][:2*dim+2]
    rule = guess_recurrence(terms)
    assert rule and len(rule) <= dim
    assert all(c.denominator == 1 for c in rule)
    rule = tuple(map(int,rule))
    degree = len(rule)
    # For each residue, the error of this proposed recurrence is a linear
    # observable on a state of dimension dim. Cayley--Hamilton suffices.
    for n in range(begin, begin+stride*dim):
        assert values[n+stride*degree] == sum(
            v*values[n+stride*(degree-i-1)] for i,v in enumerate(rule))
    if degree==1:
        ok = rule[0]>0 and min(values[begin:begin+stride])>0
        return (rule,rule[0],rule[0]) if ok else None
    # Ratios of consecutive terms along a fixed residue modulo stride.
    lo, hi = max(1,(3*rule[0])//4), (5*rule[0]+3)//4
    if hi < lo:
        return None
    lower = upper = F(rule[0])
    for i,c in enumerate(rule[1:],1):
        bounds = [F(c,lo**i),F(c,hi**i)]
        lower += min(bounds)
        upper += max(bounds)
    if lower < lo or upper > hi:
        return None
    for n in range(begin,begin+stride*(degree-1)):
        if not (0 < lo*values[n] <= values[n+stride] <= hi*values[n]):
            return None
    return rule,lo,hi


def verify(row):
    name,x,y,rule,start = row
    d = len(rule)
    dim = d + comb(d,2)
    begin = 80
    strides = (1,2,4,8,12,16,24,32,48)
    count = begin+(2*dim+4)*max(strides)+4
    a = [x,y]
    while len(a)<start:
        a.append(-(-a[-1]**2//a[-2]))
    for n in range(start,count):
        a.append(sum(c*a[n-1-i] for i,c in enumerate(rule)))
    delta = [a[n]*a[n+2]-a[n+1]**2 for n in range(count-2)]
    gap = [a[n]-v for n,v in enumerate(delta)]
    assert min(delta[:begin]) >= 0 and min(gap[:begin]) > 0
    assert min(a[:begin+2])>0 and begin>=start-d
    for label,values in [('delta',delta),('gap',gap)]:
        for stride in strides:
            cert = certificate(values,stride,begin,dim)
            if cert is not None:
                print(name,label, 'n0',begin,'stride',stride,'rule',cert[0],
                      'ratio interval',cert[1:])
                break
        else:
            raise ArithmeticError((name,label,'no invariant'))
    print(name, 'verified for every n >=', start)


if __name__ == '__main__':
    for row in targets:
        verify(row)
