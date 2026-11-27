"""Compare direct binary recursion with formal series, using integer arithmetic."""
from functools import cache
from math import comb

N = 14
one = [1] + [0]*N

def mul(a, b):
    return [sum(a[i]*b[j-i] for i in range(j+1)) for j in range(N+1)]

def geometric(a):
    assert a[0] == 0
    v = one.copy()
    for j in range(1, N+1):
        v[j] = sum(a[i]*v[j-i] for i in range(1, j+1))
    return v

def scale(a, k):
    return [v*k for v in a]

def shift(a):
    return [0]+a[:-1]

def check(p, q):
    @cache
    def b(k):
        if k == 0:
            return 1
        j = k//2
        if k%2:
            return b(j)
        return p*b(j)+q*b(j-(j & -j))

    t = [0]*(N+1)
    for j in range(1, N+1):
        t[j] = (j == 1) + q*mul(t,geometric(scale(t,p)))[j-1]
    predicted = mul(geometric(t), geometric(shift(geometric(scale(t,p)))))
    actual = [sum(b(k) for k in range(1<<j)) for j in range(N+1)]
    assert actual == predicted, (p,q)
    catalan = [comb(2*j,j)//(j+1) * (p*q)**j for j in range(N+1)]
    conv = mul(geometric(scale(shift(catalan),p)),
               geometric(scale(shift(catalan),q)))
    assert [b((4**j-1)//3) for j in range(N+1)] == [1]+conv[:-1]
    return actual[:6]

if __name__ == '__main__':
    for p,q in [(2,1),(2,2),(3,1),(3,3),(2,3),(1,0),(0,4)]:
        print((p,q),check(p,q))
