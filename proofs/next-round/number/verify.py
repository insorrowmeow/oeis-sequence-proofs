"""Integer/rational induction certificates. Run as python verify.py, without -O."""
from fractions import Fraction
from math import comb


CASES = {
    'A022019 (Israel definition)': ((2, 32), (16, 1, -8), 'alternating'),
    'A022027': ((2, 16), (8, 0, -4), 'strict_down'),
    'A022028': ((2, 32), (16, 0, -8), 'strict_down'),
    'A022031': ((4, 17), (4, 1, 0, -1, -1, -1, -1), 'strict_down'),
    'A022032': ((5, 26), (5, 1, 0, -1, -1, -1, -1), 'strict_down'),
    'A018917': ((3, 5), (1, 1, 0, -1), 'strict_down'),
    'A021004': ((4, 10), (2, 1, 1, -1, 0, -1), 'nearest_down'),
    'A021008': ((5, 11), (3, -2, 0, 1), 'nearest_down'),
}


def shortest_rule(values):
    """Berlekamp--Massey over Q. We verify the result independently below."""
    c, old = [Fraction(1)], [Fraction(1)]
    degree, shift, pivot = 0, 1, Fraction(1)
    for n in range(len(values)):
        error = sum(c[i]*values[n-i] for i in range(degree+1))
        if not error:
            shift += 1
            continue
        save = c[:]
        c.extend([0]*max(0, len(old)+shift-len(c)))
        for j, v in enumerate(old):
            c[j+shift] -= v*error/pivot
        if 2*degree <= n:
            degree, old, pivot, shift = n+1-degree, save, error, 1
        else:
            shift += 1
    result = [-v for v in c[1:degree+1]]
    assert result and all(v.denominator == 1 for v in result)
    return [int(v) for v in result]


def stride_rule(rule, stride):
    """Newton sums yield the characteristic polynomial for every stride."""
    d = len(rule)
    powers = [d]
    for k in range(1, stride*d+1):
        s = sum(rule[j-1]*powers[k-j] for j in range(1, min(d+1,k)))
        powers.append(s + (k*rule[k-1] if k<=d else 0))
    coeffs = [1]
    for k in range(1, d+1):
        total = sum(coeffs[j]*powers[(k-j)*stride] for j in range(k))
        assert total % k == 0
        coeffs.append(-total//k)
    return [-v for v in coeffs[1:]]


def positive_tail(values, dim):
    rule = shortest_rule(values[:2*dim+2])
    d = len(rule)
    # The residual is a linear observable on a state of dimension dim.
    assert d <= dim and all(
        values[n+d] == sum(c*values[n+d-j-1] for j,c in enumerate(rule))
        for n in range(dim))
    start = 80
    for stride in (1,2,4,8,16,32,64,128):
        rs = stride_rule(rule, stride)
        lo, hi = max(1,3*rs[0]//4), (5*rs[0]+3)//4
        if hi < lo:
            continue
        lower = upper = Fraction(rs[0])
        for j, c in enumerate(rs[1:], 1):
            x, y = Fraction(c, lo**j), Fraction(c, hi**j)
            lower += min(x,y)
            upper += max(x,y)
        if not lo <= lower <= upper <= hi:
            continue
        assert 0 < min(values[start:start+stride])
        assert all(0 < lo*values[n] <= values[n+stride] <= hi*values[n]
                   for n in range(start,start+stride*(d-1)))
        return start, stride, d
    raise ArithmeticError('No invariant ratio interval found')


def verify(name, seeds, rule, kind):
    d = len(rule)
    dim = d+comb(d,2)
    a = list(seeds)
    def next_term(x,y):
        if kind=='nearest_down':
            return (2*y*y+x-1)//(2*x)
        if kind=='alternating' and len(a)%2==0:
            return y*y//x+1
        return (y*y-1)//x
    while len(a) < d:
        a.append(next_term(*a[-2:]))
    initial = a[:]
    while len(a) <= 83+128*dim:
        a.append(sum(c*a[-1-j] for j,c in enumerate(rule)))
    delta = [x*z-y*y for x,y,z in zip(a,a[1:],a[2:])]
    if kind=='strict_down':
        margins = [[-v for v in delta], [x+v for x,v in zip(a,delta)]]
    elif kind=='alternating':
        signed = [(-1)**n*v for n,v in enumerate(delta)]
        margins = [signed, [x-v for x,v in zip(a,signed)]]
    else:
        margins = [[x-2*v for x,v in zip(a,delta)], [x+2*v for x,v in zip(a,delta)]]
    # Upper endpoint is excluded for a tie rounded down, lower is included.
    assert min(margins[0][:80]) > 0 and min(margins[1][:80]) >= 0
    certs = [positive_tail(v,dim) for v in margins]
    numerator = [a[k]-sum(rule[j-1]*a[k-j] for j in range(1,k+1))
                 for k in range(d)]
    print(name, 'seeds', initial, 'gf numerator', numerator, 'tail certificates', certs)


if __name__ == '__main__':
    if not __debug__:
        raise SystemExit('Please run without -O')
    for key, row in CASES.items():
        verify(key,*row)
