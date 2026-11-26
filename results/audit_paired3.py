"""Full independent triple/flat replay for the genuinely mixed member q=3."""
from collections import Counter
from itertools import combinations, product
from math import comb
from paired_planes import counts

def vecadd(a,b):
    result=0
    place=1
    while a or b:
        a, digit_a=divmod(a,3)
        b, digit_b=divmod(b,3)
        result+=place*((digit_a+digit_b)%3)
        place*=3
    return result

def mul27(a,b):
    """Modulo X³−X+1; it has no root in F3."""
    result=0
    for _ in range(3):
        b,digit=divmod(b,3)
        for k in range(digit):
            result=vecadd(result,a)
        top=a//9
        a=(a%9)*3
        for k in range(top):
            a=vecadd(a,5)  # X−1 has base-3 encoding 5.
    return result

def bitmask(points):
    return sum(1<<x for x in points)

def main():
    q=3; side=243; n=486
    add=[[vecadd(a,b) for b in range(side)] for a in range(side)]
    neg=[row.index(0) for row in add]
    field=[[mul27(a,b) for b in range(27)] for a in range(27)]
    cube=[field[field[t][t]][t] for t in range(27)]
    dirs=[a for a in range(1,side) if a<neg[a]]
    subspaces={tuple(sorted({0,a,b,neg[a],neg[b],
                             add[a][b],add[a][neg[b]],add[neg[a]][b],add[neg[a]][neg[b]]}))
               for a,b in combinations(dirs,2)}
    assert all(len(s)==9 for s in subspaces)
    C2=[comb(i,2) for i in range(n)]
    C3=[comb(i,3) for i in range(n)]
    visited=bytearray(comb(n,3))
    # Class 2 marks internal collinear triples, class 1 independent covered once.
    for offset in (0,side):
        for a,b in combinations(range(side),2):
            c=neg[add[a][b]]
            if c>b:
                visited[offset+a+C2[offset+b]+C3[offset+c]]=2
    expected=visited.count(0)
    replaced=[set(),set()]
    histogram=Counter()
    totals=[0,0,0,0] # planes, point-plane, line-plane, complete flags
    def audit_plane(points,kind):
        pts=tuple(sorted(points)); lc=0; assigned=0
        for a,b,c in combinations(pts,3):
            i=a+C2[b]+C3[c]
            mark=visited[i]
            if mark==2:
                lc+=1
            else:
                assert mark==0,(a,b,c,kind)
                visited[i]=1;assigned+=1
        # Every rank-two flat is a 2- or 3-point line; each collinear triple
        # represents one 3-point line. All other pairs are 2-point lines.
        ell=comb(len(pts),2)-2*lc
        histogram[kind]+=1
        for i,v in enumerate((1,len(pts),ell,2*ell+lc)):
            totals[i]+=v
    for a,b,c in product(range(27),repeat=3):
        pair=[[],[]]
        for t in range(18):
            group=t//9
            y=add[add[field[a][t]][field[b][cube[t]]]][c]
            pair[group].append((t%9)*27+y)
        for j in range(2):
            key=bitmask(pair[j])
            assert key not in replaced[j]
            replaced[j].add(key)
        audit_plane(pair[0]+[side+y for y in pair[1]],'graph')
    for value in range(1,27):
        if value>neg[value]: continue
        vertical=[]
        for t in range(9):
            for y in range(27):
                line=(y,add[y][value],add[y][neg[value]])
                if y==min(line):
                    vertical.append(tuple(27*t+z for z in line))
        for left,right in product(vertical,repeat=2):
            audit_plane((*left,*(side+v for v in right)),'vertical')
    for sub in subspaces:
        for x in range(side):
            pts=[add[x][v] for v in sub]
            if x!=min(pts):continue
            for j in range(2):
                if bitmask(pts) not in replaced[j]:
                    audit_plane([z+j*side for z in pts],'internal')
    assert visited.count(1)==expected and visited.count(0)==0
    global_triples=visited.count(2)
    lines=comb(n,2)-2*global_triples
    h,v,w,t=totals
    flags=(n,lines,h,2*lines+global_triples,v,w,t)
    assert flags==counts(3)
    print('q=3 independent triples:',expected,'dependent triples:',global_triples,
          'plane types:',dict(histogram),'flags:',flags)

if __name__=='__main__':
    main()
