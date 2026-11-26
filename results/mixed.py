"""Exact counterexample search on deliberately nonuniform projective configurations."""
from fractions import Fraction
from itertools import combinations, product
import argparse
import json
import random


class Geometry:
    """GF(p²) encoded by a + p*b with z² = c+d*z."""
    def __init__(self, p):
        q = p*p
        c,d = ((1,1) if p == 2 else (2,0))
        assert p in (2,3)
        self.q = q
        def add(x,y):
            return (x%p+y%p)%p + p*((x//p+y//p)%p)
        def mul(x,y):
            a,b,i,j=x%p,x//p,y%p,y//p
            return (a*i+c*b*j)%p + p*((a*j+b*i+d*b*j)%p)
        self.points = vs = [v for v in product(range(q),repeat=4)
                            if next((x for x in v if x),0) == 1]
        self.full = (1<<len(vs))-1
        self.subfield = sum(1<<i for i,v in enumerate(vs) if max(v)<p)
        self.planes=[]
        for normal in vs:
            weights=[[mul(a,x) for x in range(q)] for a in normal]
            left=[[add(weights[0][i],weights[1][j]) for j in range(q)] for i in range(q)]
            right=[[add(weights[2][i],weights[3][j]) for j in range(q)] for i in range(q)]
            inverse=[next(i for i in range(q) if add(i,x)==0) for x in range(q)]
            self.planes.append(sum(1<<i for i,(a,b,c1,d1) in enumerate(vs)
                                   if left[a][b] == inverse[right[c1][d1]]))
        lines = {}
        self.plane_lines=[set() for _ in vs]
        for i,j in combinations(range(len(vs)),2):
            line=self.planes[i]&self.planes[j]
            idx=lines.setdefault(line,len(lines))
            self.plane_lines[i].add(idx)
            self.plane_lines[j].add(idx)
        self.lines=list(lines)
        self.plane_lines=[tuple(sorted(x)) for x in self.plane_lines]
        assert len(self.lines)==(q*q+1)*(q*q+q+1)
        assert all(len(x)==q*q+q+1 for x in self.plane_lines)
        self.subplanes=[h & self.subfield for h in self.planes if (h&self.subfield).bit_count()==p*p+p+1]
        self.sublines=[l & self.subfield for l in self.lines if (l&self.subfield).bit_count()==p+1]

    def profile(self,m):
        n=m.bit_count()
        if n<4 or any(m&h==m for h in self.planes):
            return None
        sizes=[(m&l).bit_count() for l in self.lines]
        t=[0]*len(sizes)
        l=sum(s>=2 for s in sizes)
        u=sum(s for s in sizes if s>=2)
        f3=f13=f23=f123=0
        P=-(n-1)**2
        S=0
        dense_plane=False
        for h, indices in zip(self.planes,self.plane_lines):
            k=(m&h).bit_count()
            if k<3:
                continue
            active=[i for i in indices if sizes[i]>=2]
            if len(active)<2:
                continue
            lh=len(active)
            v=sum(sizes[i] for i in active)
            for i in active:
                t[i]+=1
            f3+=1
            f13+=k
            f23+=lh
            f123+=v
            S+=k-2
            P+=(n+1)*(k-2)+2+(k-1)*(n-1-k)
            dense_plane |= v-2*lh >= k-1
        A=f123-u-f13-f23+n+l+f3-1
        B=f13+f23-n-l-2*f3+2
        E=u-n-l+1
        D=l-1
        score=B*E-A*D
        U=tw=0
        for s,d in zip(sizes,t):
            if s>=2:
                w=(s-2)*(n-s)
                U+=w
                tw+=w*d
        covnum=l*tw-f23*U
        positive=l*D*P+U*(l*(S-n+1)+f23)
        assert (n+1)*l*score==positive-D*covnum
        assert positive>0 and (n+1)*E-(n-1)*D==U
        assert dense_plane or score>0
        return (Fraction(D*covnum,positive),dense_plane,covnum,score,n,
                (n,l,f3,u,f13,f23,f123))


def search(p, repeat):
    g=Geometry(p)
    rng=random.Random(20261126+p)
    full=g.full
    primary=[g.subfield, *g.subplanes]
    known={}
    best=None
    def eval(m):
        nonlocal best
        if m not in known:
            profile=g.profile(m)
            known[m]=profile
            if profile is not None and (best is None or profile[0]>best[0][0]):
                best=profile,m
        return known[m]
    for j in range(12):
        core=rng.choice(primary)
        m=core
        for _ in range(1+j%4):
            m |= rng.choice(g.subplanes if j%2 else g.lines)
        val=eval(m)
        for _ in range(repeat):
            kind=rng.randrange(8)
            if kind==0:
                block=rng.choice(g.planes)
            elif kind==1:
                block=rng.choice(g.subplanes)
            elif kind==2:
                block=rng.choice(g.sublines)
            elif kind==3:
                block=1<<rng.randrange(len(g.points))
            elif kind==4:
                block=rng.choice(g.planes)&~g.subfield
            elif kind==5:
                block=rng.choice(g.lines)&~g.subfield
            elif kind==6:
                block=rng.choice(g.lines)
            else:
                block=rng.choice(g.planes)&rng.getrandbits(len(g.points))
            op=rng.randrange(3)
            nxt=(m|block) if op==0 else (m&~block if op==1 else m^block)
            if j%3==0: nxt|=core
            trial=eval(nxt)
            if trial is not None and (val is None or trial[0]>=val[0] or rng.randrange(23)==0):
                m,val=nxt,trial
    valid=[x for x in known.values() if x is not None]
    prof,m=best
    return dict(q=p*p,distinct=len(known),spanning=len(valid),
                positive_covariance=sum(x[2]>0 for x in valid),
                positive_covariance_and_dense_plane=sum(x[1] and x[2]>0 for x in valid),
                nonpositive_delta=sum(x[3]<=0 for x in valid),
                max_danger=str(prof[0]), witness=hex(m), flag_vector=prof[-1], margin=prof[3])


if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--steps',type=int,default=65)
    args=parser.parse_args()
    for p in (2,3):
        print(json.dumps(search(p,args.steps)),flush=True)
