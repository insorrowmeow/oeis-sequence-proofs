"""Matroids on two affine slices with nonlinear paired-plane erections.

For q prime power let K=GF(q^3). Choose distinct parallel affine 2-flats
T0,T1 of the three-dimensional Fq-space K. The point sets are Ti x K.
Long lines are affine lines inside each side; cross lines have two elements.
Graph blocks: for each f(X)=aX+bX^q+c, unite its two slice graphs.
Vertical blocks: unite a vertical line in T0 x K with a parallel vertical
line in T1 x K. All remaining internal affine 2-flats stay unmodified.

Two distinct graph blocks intersect either in at most one point or in the
trace of an affine Fq-line: nonzero differences of their linear parts have
kernel dimension at most 1 (a nonzero degree-q polynomial has <=q roots).
The trace is an internal line, two cross points, a singleton, or empty.
Graph vs vertical block intersect in at most one point per side. Vertical
blocks with distinct directions have at most one common point per side.
If same direction, they can share one whole line and nothing else.
Unmodified internal affine 2-flats intersect a graph or vertical block
in at most a single line. Thus all distinct blocks meet in rank <=2.

Each independent triple lies in one block. For an internal triple, use
its original 2-flat, possibly promoted to a graph block. For an internal
line and one exterior point, a vertical line determines the parallel
vertical through the exterior point. Otherwise the three projection
coordinates are Fq-affinely independent: two from one slice and one
from the parallel slice. Exactly one f interpolates since a nonzero
difference cannot vanish on an affine 2-flat and there are |K|^3 maps.
These flat axioms define a rank-4 matroid: a four-set is independent iff
all of its triples are independent and it lies in no block. Extending an
independent triple by any point outside its unique block gives a basis.
If a new point formed a dependent triple with two old ones, it would
belong to their line, which the block already contains. Augmentation for
smaller independent sets follows the corresponding singleton/line closure.
"""
from math import factorial
from fractions import Fraction


def counts(q):
    x=q**5
    directions=(x-1)//(q-1)
    lines=x//q*directions
    h=x//(q*q)*directions*((q**4-1)//(q-1))//(q+1)
    graph=q**9
    vertical=(q*q+q+1)*q**8
    k=q*q
    lh=q*(q+1)
    vh=q*lh
    assert lines*x-graph*lh*k-vertical*q==0
    rows=[(2*(h-graph),k,lh,vh),
          (graph,2*k,2*lh+k*k,2*vh+2*k*k),
          (vertical,2*q,2+q*q,2*q+2*q*q)]
    total_h=sum(z[0] for z in rows)
    v,w,t=[sum(z[0]*z[i] for z in rows) for i in (1,2,3)]
    return 2*x,2*lines+x*x,total_h,2*q*lines+2*x*x,v,w,t


def products(q):
    n,l,h,u,v,w,t=counts(q)
    alpha=t-u-v-w+n+l+h-1
    beta=v+w-n-l-2*h+2
    return beta*(u-n-l+1), alpha*(l-1)


def coefficients(values):
    first=[]
    while values:
        first.append(values[0])
        values=[b-a for a,b in zip(values,values[1:])]
    return first


if __name__=='__main__':
    for q in (2,3,4,5,7,11,17,23,101,509):
        be,ad=products(q)
        print(q, "ratio",format(be/ad,'.12f'), "Delta",be-ad)
    be,ad=zip(*(products(q) for q in range(2,43)))
    for name, vals in [('Delta',[x-y for x,y in zip(be,ad)]),('AD',list(ad))]:
        newton=coefficients(vals)
        degree=max(i for i,c in enumerate(newton) if c)
        print(name,'degree',degree,'leading',Fraction(newton[degree],factorial(degree)),
              'nonzero forward differences',sum(bool(x) for x in newton))
        assert all(c>=0 for c in newton) and newton[0]>0
        assert degree<=27  # n <= deg 5, lines <= 10, all flags <= degree 17.
