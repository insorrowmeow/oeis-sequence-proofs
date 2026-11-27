"""Independent checker for the universal A050129 certificate. Python 3 standard library."""
from math import gcd
from pathlib import Path
import json

BASE = 32


class Linear(tuple):
    """The integer function a*k+b on k >= 0."""
    def __new__(cls, a, b):
        return tuple.__new__(cls, (a,b))

    def __add__(self, other):
        if isinstance(other,int):
            return Linear(self[0],self[1]+other)
        return Linear(self[0]+other[0],self[1]+other[1])

    def __mul__(self, m):
        return Linear(self[0]*m,self[1]*m)

    def below(self, other):
        return self[0]<=other[0] and self[1]<other[1]

    def meets(self, other):
        a,b=self[0]-other[0],other[1]-self[1]
        if a==0:
            return b==0
        return b%a==0 and b//a>=0


def divide(x,m):
    if x[0]%m==0 and x[1]%m==0:
        return Linear(x[0]//m,x[1]//m)
    if x[1]%gcd(x[0],m)!=0:
        return None  # not integral at any k
    raise ValueError("division requires a finer residue class")


def allowed_maybe(n,v,t):
    regular = [(t*2,v),(t,v+1),(t,v*2+2),(t,v*2+3),(t,v*4+3),(t,v*4+5)]
    return any(x.meets(y) for x,y in regular) or (not v.below(n) and t.meets(v*4+4))


def row_or_column(cl, cells, n, row):
    assert all(i>0 for i in cl)
    coords=[cells[i] if row else cells[i][::-1] for i in cl]
    key=coords[0][0]
    assert all(k==key for k,_ in coords)
    selected={v for _,v in coords}
    if row:
        ordinary=[divide(key,2),key+1,key*2+2,key*2+3,key*4+3,key*4+5]
        extra=key*4+4
        extra_needed=not key.below(n)
    else:
        ordinary=[key*2,key+-1,divide(key+-2,2),divide(key+-3,2),
                  divide(key+-3,4),divide(key+-5,4)]
        extra=divide(key+-4,4)
        extra_needed=extra is not None and not extra.below(n)
    assert set(x for x in ordinary if x is not None) <= selected
    assert not extra_needed or extra in selected


def validate_input(kind,cl,cells,n):
    if kind in ('row','col'):
        row_or_column(cl,cells,n,kind=='row')
    elif kind=='bad':
        assert len(cl)==1 and cl[0]>0 and cells[cl[0]]==(n,n*4+4)
    elif kind=='distinct':
        assert len(cl)==2 and all(i<0 for i in cl)
        (v,t),(w,u)=[cells[-i] for i in cl]
        assert (v==w and not t.meets(u)) or (t==u and not v.meets(w))
    elif kind=='half':
        assert len(cl)==2 and all(i<0 for i in cl)
        (v,t),(w,u)=[cells[-i] for i in cl]
        assert w in (v*2,v*2+1) and (u+1).below(t)
    elif kind=='parent':
        assert cl[0]<0 and all(i>0 for i in cl[1:])
        v,t=cells[-cl[0]]
        assert not (t*2).meets(v)
        selected={cells[i] for i in cl[1:]}
        for w in (v*2,v*2+1):
            assert (w,t+-1) in selected or not allowed_maybe(n,w,t+-1)
    else:
        raise ValueError(kind)


def verify_case(case):
    mod,r=case['mod'],case['r']
    assert mod>0 and 0<=r<mod and BASE%mod==0
    n=Linear(mod,BASE+r)
    cells=[None]+[(Linear(a,b),Linear(c,d)) for a,b,c,d in case['atoms']]
    assert all(x[0]>=0 and x[1]>1 for pair in cells[1:] for x in pair)
    known=[None]
    for kind,cl in case['inputs']:
        validate_input(kind,cl,cells,n)
        known.append(cl)
    for claim, reasons in case['steps']:
        assert all(0<abs(i)<len(cells) for i in claim)
        true={-v for v in claim}  # negate the proposed clause
        assert not any(-v in true for v in true)
        conflict=False
        for j in reasons:
            assert 0<j<len(known)
            options={v for v in known[j] if -v not in true}
            if not options:
                conflict=True
                break
            assert len(options)==1
            true.update(options)
        assert conflict
        known.append(claim)
    assert known[-1]==[]


def verify_prefix():
    end=4*(BASE-1)+4
    seen=bytearray(2*end+1)
    seen[0]=seen[1]=1
    last=1
    for t in range(2,end+1):
        half=last//2
        last=2*t if seen[half] else half
        assert not seen[last]
        seen[last]=1
        if t%4==0 and t>=12:
            assert last!=(t-4)//4


def main():
    if not __debug__:
        raise SystemExit("Run with Python assertions enabled")
    import zipfile
    verify_prefix()
    with zipfile.ZipFile(Path(__file__).with_name('residue-certificates.zip')) as archive:
        patterns=[json.loads(archive.read(s)) for s in archive.namelist()]
    covered=set()
    modulus=max(c['mod'] for c in patterns)
    for c in patterns:
        verify_case(c)
        assert modulus%c['mod']==0
        residue=set(range(c['r'],modulus,c['mod']))
        assert not residue & covered
        covered.update(residue)
    assert len(covered)==modulus
    print(f"Verified the finite prefix n < {BASE}, and {len(patterns)} symbolic "
          f"certificates covering every residue modulo {modulus} for n >= {BASE}.")


if __name__=="__main__":
    main()
