# Triangle counts and the minimum order of a graph

Let $a(t)$ be the minimum number of vertices of a finite simple undirected graph with exactly $t$ triangles, for $t\ge1$. Pontus von Brömssen observed in October 2026 that $a(k)\le a(n)+1$ appears to hold for every $1\le k<n$. We prove this bound and show that equality occurs infinitely often. [OEIS A400369](https://oeis.org/A400369)

Kittipassorn and Popielarz had already established a stronger asymptotic result. On $m$ vertices all triangle counts up to $\binom m3-(\sqrt{2}+o(1))m^{3/2}$ occur. This implies the bound needed here for sufficiently large $m$, since $\binom m3-\binom{m-1}3=\binom{m-1}2$. The proof below gives an explicit cutoff and certificates for every smaller order. [Published paper](https://www.cambridge.org/core/journals/bulletin-of-the-australian-mathematical-society/article/abs/how-many-triangles-can-a-graph-have/764AEE60B12149AACA9478F6547C9E91), [Popielarz's abstract, p. 3](https://www.memphis.edu/msci/grad/documents/researchday.pdf)

## An interval of triangle counts

**Theorem.** For each $m\ge3$, every integer in $[0,\binom{m-1}3]$ occurs as the number of triangles of a graph on $m$ vertices.

Adding an isolated vertex preserves the triangle count. Starting at $m=3$, where the required count is zero, it suffices to realize the band

$$\binom{m-2}3\le t\le\binom{m-1}3$$

on $m$ vertices for each $m\ge4$. We take $\binom hk=0$ when $0\le h<k$.

### Orders at least 75

Start with $K_m$ and remove the edges of a tree $H$ with $s$ edges, on $s+1\le m$ vertices. Every deleted edge lies in $m-2$ triangles of $K_m$. Two deleted edges lie in a common triangle precisely when they share a vertex, and $H$ has no triangle. Inclusion–exclusion gives the number of lost triangles as

$$s(m-2)-\sum_{i\in V(H)}\binom{\deg_H(i)}2.$$

Write $d_i=\deg_H(i)-1$. These are nonnegative and sum to $s-1$. Conversely, any list of $s+1$ nonnegative integers of sum $s-1$ occurs this way. To obtain a tree, form a Prüfer word containing $d_i$ copies of vertex $i$ and decode it. Since $\binom{d+1}2=\binom d2+d$, the number lost is

$$B_s-\sum_i\binom{d_i}2,\qquad B_s=s(m-3)+1.$$

Fix $\lfloor m/2\rfloor\le s\le m-1$ and $0\le w\le m-3$. Let $a\ge1$ be greatest with $\binom a2\le w$, and put $u=w-\binom a2$. Thus $0\le u<a$. Start the list with $a$ and $u$ copies of $2$. This contributes exactly $w$ to the sum of binomial coefficients and consumes $a+2u\le3a$ units of degree budget. For $a\le12$, we have $3a\le36\le\lfloor m/2\rfloor-1$. For $a\ge13$, we have $\binom a2\ge6a$, so $m\ge w+3\ge6a+3$, again giving $3a\le\lfloor m/2\rfloor-1$. In both cases the cost is at most $s-1$. Append ones until the degree sum is $s-1$, then append zeros until the list has length $s+1$. This is possible because every positive entry contributes at least one unit to the degree sum.

Consequently the achievable deficits include $[B_s-(m-3),B_s]$. Consecutive such intervals meet at their endpoints. At the largest $s$, we have

$$B_{m-1}=(m-2)^2=\binom m3-\binom{m-2}3.$$

At the smallest $s$, we have $B_{\lfloor m/2\rfloor}\le\binom{m-1}2$. For $m=2v$ this is equality. For $m=2v+1$ the two sides are $2v^2-2v+1$ and $2v^2-v$. Thus the union includes every deficit from $\binom{m-1}2=\binom m3-\binom{m-1}3$ through $(m-2)^2$. Complementing these deficits against $\binom m3$ gives the required band.

### Orders from 4 to 74

Start with a clique on $h=m-2$ vertices. Add two vertices with respectively $a$ and $b$ neighbours in the clique, with $0\le b\le a\le h$. When the two vertices are nonadjacent, the triangle count is

$$x=\binom h3+\binom a2+\binom b2.$$

When they are adjacent, the triangle count is $x+c$, where $c$ is the size of the overlap of their two neighbourhoods. Every integer from $\max(0,a+b-h)$ to $b$ can occur as $c$: choose $c$ neighbours from the first neighbourhood and $b-c$ from its complement. Enumerating these integer intervals and $x$ for all $(a,b)$ leaves just six pairs $(m,t)$ in the required bands.

In each of these six cases delete the edges of a star, a path and a matching on disjoint vertex sets from $K_m$, using the edge counts in the table. A zero means omit that component.

| Vertices $m$ | Triangles $t$ | Star edges | Path edges | Matching edges |
|---:|---:|---:|---:|---:|
| 11 | 116 | 0 | 6 | 0 |
| 12 | 164 | 0 | 5 | 1 |
| 13 | 217 | 4 | 3 | 0 |
| 17 | 558 | 5 | 4 | 0 |
| 21 | 1130 | 0 | 10 | 1 |
| 23 | 1533 | 5 | 5 | 2 |

For row parameters $(A,R,J)$ the count is $\binom m3-(A+R+J)(m-2)+\binom A2+R-1$ by the same inclusion–exclusion formula. The companion checker enumerates the clique extensions, builds the six exceptional graphs and counts their triangles directly over triples. This proves the finite step and completes the induction. [Python certificate](check_triangle_spectrum.py)

## The inequality and sharpness

For $1\le k<n$, set $r=a(n)$. Then $k<n\le\binom r3$. The theorem at $m=r+1$ realizes $k$ on $r+1$ vertices, so $a(k)\le a(n)+1$.

For every $r\ge4$, write $N=\binom r3$. Clearly $a(N)=r$. Any proper subgraph of $K_r$ omits an edge and loses at least $r-2\ge2$ triangles. Thus $N-1$ cannot be realized on $r$ vertices, or on fewer vertices since those graphs can be padded with isolates. The theorem realizes $N-1$ on $r+1$ vertices, giving $a(N-1)=r+1$. In particular, the drop from $a(N-1)$ to $a(N)$ attains the bound for infinitely many $N$.

## Lean scope

The companion Lean files give the degree-sum identity and coverage of the large-order intervals, and the construction of degree lists with the prescribed sum, length and binomial sum. The graph realization, inclusion–exclusion proof and induction relating graph order to $a(t)$ are given above. [Interval and deficit lemmas](TriangleGraphSpectrum.lean), [degree-list construction](TriangleTreeDegrees.lean)
