"""Exact interval checks for the all-index proof for floor-Pisot A020750."""
from fractions import Fraction as F


def interval(x,y=None):
    return F(x), F(x if y is None else y)


def add(x,y):
    return x[0]+y[0], x[1]+y[1]


def mul(x,y):
    products = [a*b for a in x for b in y]
    return min(products), max(products)


def ratio(x,y):
    assert y[0]*y[1] > 0
    return mul(x,(1/y[1],1/y[0]))


def eval_poly(poly,x):
    ans=interval(0)
    for c in reversed(poly):
        ans=add(mul(ans,x),interval(c))
    return ans


def squared_modulus(poly,t):
    # z*conjugate(z)=1 and t=z+1/z.
    traces=[interval(2),t]
    for _ in range(2,len(poly)):
        traces.append(add(mul(t,traces[-1]),mul(interval(-1),traces[-2])))
    ans=interval(sum(c*c for c in poly))
    for d in range(1,len(poly)):
        ans=add(ans,mul(interval(sum(a*b for a,b in zip(poly,poly[d:]))),traces[d]))
    return ans


def check():
    P=[-1,2,0,0,-2,1]
    der=[i*c for i,c in enumerate(P) if i]
    num=[3,-4,-2,-1,5]
    r=interval('1.72208380','1.72208381')
    t=interval('-1.30277564','-1.30277563')
    # Opposite signs and the explicit factorization give the two relevant roots.
    for poly,bounds in [(P,r),([-3,-1,1],t)]:
        assert eval_poly(poly,interval(bounds[0]))[0]*eval_poly(poly,interval(bounds[1]))[0] < 0
    s=ratio(interval(1),r)
    A=ratio(eval_poly(num,r),eval_poly(der,r))
    C=ratio(eval_poly(num,s),eval_poly(der,s))
    B=ratio(eval_poly(num,interval(1)),eval_poly(der,interval(1)))
    Z2=ratio(squared_modulus(num,t),squared_modulus(der,t))
    assert 5 < A[0] <= A[1] < 6 and 0 < C[0] <= C[1] < 1
    assert B == interval(-1) and 0 < Z2[0] <= Z2[1] < F(31,1000)**2
    dist2=add(add(mul(r,r),interval(1)),mul(interval(-1),mul(r,t)))
    assert 2*F(31,1000)*dist2[1] < F(39,100)
    assert F(1,2) < (r[0]-1)**2 <= (r[1]-1)**2 < F(54,100)
    # Seven small pair terms in the determinant and four small terms in b_n.
    assert 7*36*16/(5*r[0]**30) < F(1,100)
    assert 4/(5*r[0]**30) < F(1,100)
    a=[5,9,16,28,49]
    while len(a)<32:
        a.append(2*a[-1]-2*a[-4]+a[-5])
    assert all(0 <= a[i+1]**2-a[i]*a[i+2] < a[i] for i in range(30))
    print("A020750: root brackets, residues, oscillation bounds, tail and prefix verified.")


if __name__=='__main__':
    check()
