"""Independent exact certificate for four six-row equal-area comparisons.

Run with Python 3, without optimization, e.g. python check_six_koh.py.
See Six-row-KOH.md for the reduction and verification argument.
"""
from collections import Counter
from itertools import combinations
from math import comb, gcd


def linear(poly, c, m):
    out = [0]*(len(poly)+1)
    for i, a in enumerate(poly):
        out[i] += a*c
        out[i+1] += a*m
    return out


def lerp5(nodes):
    # Outputs interpolation basis polynomials after multiplication by 5! period^5.
    basis = []
    for j in range(6):
        p = [(-1)**(5-j)*comb(5,j)]
        for h, n in enumerate(nodes):
            if h != j:
                p = linear(p,-n,1)
        basis.append(p)
    return basis


def envelopes():
    p = [1]+[0]*359
    for i in range(1,7):
        for j in range(i,len(p)):
            p[j] += p[j-i]
    table=[]
    for r in range(60):
        nodes=[r+60*i for i in range(6)]
        basis=lerp5(nodes)
        table.append([sum(row[k]*p[n] for row,n in zip(basis,nodes)) for k in range(6)])
    return tuple(map(min,zip(*table))),tuple(map(max,zip(*table)))

LO, HI = envelopes()
IP = lerp5(list(range(6)))


def terms(b):
    # Index width as c=step*t. Each rational term has argument j-slope*t-intercept.
    step=6//gcd(6,b)
    r=2 if b==15 else 1
    data=Counter()
    def rect(sign, width, const, offset, offconst):
        for k in range(7):
            for subset in combinations(range(1,7),k):
                data[offset+k*width,offconst+k*const+sum(subset)] += sign*(-1)**k
    rect(1,r*step,-12*r,0,42*r)
    rect(-1,r*step,-12*r,(b-6*r)*step,30*r+1)
    rect(-1,b*step//6,0,0,0)
    rect(1,b*step//6,0,0,1)
    return {key:value for key,value in data.items() if value}


def homogeneous_eval(poly, n, d):
    return sum(a*n**k*d**(5-k) for k,a in enumerate(poly))


def certify(b,t0):
    step=6//gcd(6,b)
    lower=(step,1)
    upper=(b*step//2,1)
    counts=terms(b)
    def pos(line,t):
        return line[0]*t+line[1]
    lines=sorted(set(counts)|{lower,upper},key=lambda p:(pos(p,t0),p[0]))
    assert all(l[0]<=u[0] for l,u in zip(lines,lines[1:])), 'increase t0 to avoid crossing of break lines'
    relevant=lines[lines.index(lower):lines.index(upper)+1]
    checked=0
    for l,h in zip(relevant,relevant[1:]):
        # First index is the width sample x=0,...,5. The second is the
        # power of y in 5! (1+y)^5 times the rank polynomial.
        arr=[[0]*6 for _ in range(6)]
        active=[(key,f) for key,f in counts.items() if (pos(key,t0),key[0])<=(pos(l,t0),l[0])]
        for x in range(6):
            t=t0+x
            low=pos(l,t)
            high=pos(h,t)-1
            assert high>=low
            raw=[]
            for y in range(6):
                n=low+high*y
                d=y+1
                raw.append(sum(f*homogeneous_eval(LO if f>0 else HI,n-pos(key,t)*d,d) for key,f in active))
            arr[x]=[sum(raw[j]*IP[j][i] for j in range(6)) for i in range(6)]
        # Newton coefficients in x comprise all leading forward differences.
        for k in range(6):
            if min(arr[0])<0:
                return False,(l,h,k,arr[0].index(min(arr[0])),min(arr[0]))
            arr=[[q-p for p,q in zip(a,z)] for a,z in zip(arr,arr[1:])]
        checked+=1
    return True, checked


def gaussian_coefficients(h, w):
    """Expand the Gaussian product exactly, truncating after its degree h*w."""
    p = [1] + [0] * (h*w)
    for i in range(1, h+1):
        for j in range(i, len(p)):
            p[j] += p[j-i]
        for j in range(len(p)-1, w+i-1, -1):
            p[j] -= p[j-w-i]
    return p


def finite_head(b, t0):
    step = 6//gcd(6, b)
    count = 0
    for t in range((b+step-1)//step, t0):
        c = step*t
        big = gaussian_coefficients(b, c)
        small = gaussian_coefficients(6, b*c//6)
        diff = [u-v for u,v in zip(big,small)]
        assert diff == diff[::-1] and diff[0] == 0
        assert all(diff[j] >= diff[j-1] for j in range(1, b*c//2+1)), (b,c)
        count += 1
    return count


if __name__=='__main__':
    if not __debug__:
        raise RuntimeError("Use ordinary Python with assertions enabled.")
    for b in (8, 9, 10, 15):
        ok, details = certify(b, 100)
        if not ok:
            raise RuntimeError(f"Failed tail certificate for b={b}: {details}")
        print(f"b={b}: {finite_head(b,100)} exact widths, {details} infinite chambers")
