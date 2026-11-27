# The growth constant for equal-perimeter, equal-area lattice cuts exists

[A400685](https://oeis.org/A400685) counts, up to square symmetries, the simple lattice cuts of a $2n$-by-$2n$ square into two equal-area regions each of perimeter $8n$. The entry conjectures that $a(n)^{1/n}$ converges. We prove this, without assuming monotonicity.

Normalize a cut to start at $(q,0)$ and end at $(2n-q,2n)$, with $0<q<2n$, oriented upward from its lower endpoint (downward steps inside are allowed). Indeed the two boundary arcs must both have length $4n$ and the cut itself length $4n$; the endpoints are antipodal and a corner cannot be an endpoint because its first edge would lie on the boundary. Let $M_n$ be the maximum, over $q$, of the number of distinct oriented cuts with this fixed start. Then $a(n)\le(2n-1)M_n$, and at most eight normalized paths represent any one symmetry class. All counts grow at most exponentially, since there are at most $4^{4n}$ paths for fixed $q$.

**Block construction.** Fix $n$ with $M_n>0$ and an endpoint $q$ attaining the maximum. Write $N=sn+r$, $0\le r<n,\ s\ge1$. We claim
$$
 8a(N)\ \ge\ M_n^s .
$$
First construct a central path in the square of side $2sn$. Select $s$ independent paths from the $q$-family. Put copy $j$, $0\le j<s$, at translation
$$
 ((s-1)q+j(2n-2q),\;2nj).
$$
Its square fits in the large square: the extreme horizontal shifts are $(s-1)q$ and $(s-1)(2n-q)$, both in $[0,2n(s-1)]$. Consecutive paths meet only at their common endpoint because the interior of each path lies strictly between its two horizontal seam lines. The complete path has length $4sn$, with antipodal endpoints at bottom abscissa $sq$ and top abscissa $s(2n-q)$. No other point meets the outer boundary.

The chord connecting each pair of endpoints bisects its own square by central symmetry. Replacing this chord by the chosen path makes zero signed-area change since the path also bisects its square. This statement is translation invariant, including for a path that crosses its chord: the change is the difference of line integrals $\int x\,dy$ along the path and chord. The $s$ chords join collinearly, so replacing all of them preserves bisection of the large square.

If $r>0$, translate the central square by $(r,r)$ in the $2N$-by-$2N$ square. Start at $(sq,0)$, go up $r$ steps and right $r$ steps to the translated lower endpoint. At the far end append the half-turn image of this connector traversed in reverse. Both connectors stay within their respective end strips and contact the central path only at their chosen endpoints. Only the first and last points are on the outer boundary. This adds $4r$ to the length. The connectors together with the straight central chord give a centrally symmetric simple cut, hence equal areas. Its central chord may be replaced by the constructed central path with zero signed-area change. Thus the resulting cut satisfies all requirements for $N$. The construction is injective before quotienting by symmetries: remove the prescribed connectors and split at the known horizontal seams to recover every block. This proves the claim for all remainders, including $r=0$.

**Limit.** Holding $n$ fixed and taking lower limits in the claim gives $\liminf_{N\to\infty} a(N)^{1/N}\ge M_n^{1/n}$. On the other hand $a(N)\le (2N-1)M_N$, so $\limsup a(N)^{1/N}\le\sup_{n\ge1} M_n^{1/n}$. Consequently the limit exists and equals this supremum. For instance $a(3)=36$ from the source, so $M_3>1$ and the limit exceeds one.

[Lean](EqualCuts.lean) checks the area algebra for arbitrary chains of equal-displacement blocks and for the pair of half-turn connectors. Its data record displacement and twice the integral relative to the starting abscissa. The geometric embedding, recovery of blocks, integral interpretation and limiting argument are proved in writing. No numerical value or priority claim is asserted for the growth constant.
