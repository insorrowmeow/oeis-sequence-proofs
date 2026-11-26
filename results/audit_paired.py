"""Independently enumerate all planes and all triples for the q=2 member."""
from collections import Counter
from itertools import combinations, product
from math import comb
from paired_planes import counts

def mul8(a,b):
    val=0
    while b:
        if b&1:
            val^=a
        a<<=1
        if a&8:
            a^=0b1011
        b>>=1
    return val

def mask(points):
    return sum(1<<x for x in points)

def members(flat):
    return [i for i in range(64) if flat>>i & 1]

sides=[range(32),range(32,64)]
inside={mask([a,b,c,a^b^c]) for side in sides for a,b,c in combinations(side,3)}
blocks=set()
for a,b,c in product(range(8),repeat=3):
    pts=[t*8+(mul8(a,t)^mul8(b,mul8(t,t))^c) for t in range(8)]
    inside.remove(mask(pts[:4]))
    inside.remove(mask(pts[4:]))
    blocks.add(mask(pts))
for direction in range(1,8):
    for t0,t1,y0,y1 in product(range(4),range(4,8),range(8),range(8)):
        if y0>y0^direction or y1>y1^direction:
            continue
        blocks.add(mask([t0*8+y0,t0*8+(y0^direction),
                         t1*8+y1,t1*8+(y1^direction)]))
blocks |= inside
triples=Counter()
for h in blocks:
    triples.update(combinations(members(h),3))
assert len(triples)==comb(64,3) and set(triples.values())=={1}
n=64
l=comb(n,2)
flags=(n,l,len(blocks),2*l,sum(h.bit_count() for h in blocks),
       sum(comb(h.bit_count(),2) for h in blocks),
       2*sum(comb(h.bit_count(),2) for h in blocks))
assert flags==counts(2)
print("verified triples:",len(triples),"plane sizes:",dict(Counter(h.bit_count() for h in blocks)),
      "flags:",flags)
