"""Rank-four abstract matroids with two disjoint affine geometries and matched spreads."""
from fractions import Fraction
from itertools import combinations, product


def affine(a, q):
    points=q**a
    directions=(points-1)//(q-1)
    lines=(points//q)*directions
    planes=(points//(q*q))*directions*((q**(a-1)-1)//(q-1))//(q+1)
    return points,directions,lines,planes


def flags(a,q,b,r,c):
    x,dirs1,l1,h1=affine(a,q)
    y,dirs2,l2,h2=affine(b,r)
    assert 0 <= c <= min(dirs1,dirs2)
    n=x+y
    lines=l1+l2+x*y
    f12=q*l1+r*l2+2*x*y
    types = [
        (h1,q*q,q*(q+1),q*q*(q+1)),
        (h2,r*r,r*(r+1),r*r*(r+1)),
        (c*(x//q)*(y//r),q+r,q*r+2,2*q*r+q+r),
        ((dirs1-c)*(x//q)*y,q+1,q+1,3*q),
        ((dirs2-c)*(y//r)*x,r+1,r+1,3*r),
    ]
    h=sum(row[0] for row in types)
    f13,f23,f123=[sum(row[0]*row[i] for row in types) for i in (1,2,3)]
    return n,lines,h,f12,f13,f23,f123


if __name__=='__main__':
    sides=list(product(range(2,9),(2,3,4,5,7,8,9,11,13,17,23,29,37,47,59,83,127)))
    count=0
    closest=None
    for i,(a,q) in enumerate(sides):
        for b,r in sides[i:]:
            dirs=min(affine(a,q)[1],affine(b,r)[1])
            for c in (0,dirs):
                n,l,h,u,v,w,s=flags(a,q,b,r,c)
                A=s-u-v-w+n+l+h-1
                B=v+w-n-l-2*h+2
                E=u-n-l+1
                D=l-1
                ratio=Fraction(B*E,A*D)
                if closest is None or ratio<closest[0]:
                    closest=ratio,(a,q,b,r,c)
                assert ratio>1
                count+=1
    print("Combinations:",len(sides)*(len(sides)+1)//2,"endpoint checks:",count)
    print("Min ratio:",closest[0], "approx:",float(closest[0]), "at:",closest[1])
