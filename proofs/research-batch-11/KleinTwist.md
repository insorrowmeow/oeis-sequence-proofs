# The crossover for twist-edge counts in a three-row Klein-bottle grid

Use the undirected multigraph and the three distinguished seam edges specified in [OEIS A401537](https://oeis.org/A401537). Let $c_j(n)$ count spanning trees with exactly $j$ of those edges. For $n=1$ the construction includes a loop and parallel edges.

**Theorem.** For $1\le n\le15$, $c_1(n)>c_2(n)$. For every $n\ge16$, $c_1(n)<c_2(n)$. The assertion of a crossover between 7 and 8 already fails at $n=8$, where $c_1=88757780045$ and $c_2=84444825220$. Also
$$
 \frac{c_1(n)}{c_0(n)}
 = n+\frac{2\sqrt{21}-9}{3}+O\bigl(((5-\sqrt{21})/2)^{2n}\bigr).
$$
Thus the ratio is asymptotic to $n$, and its difference from $n$ has a strictly positive limit.

### A seam-weight generating polynomial

Put $U_0=0,\ U_1=1,\ U_{n+1}=5U_n-U_{n-1}$. For $n\ge1$ write $u=U_n,\ v=U_{n-1},\ d=u-v$, and set $g=d/(3u)$, $h=1/(3u)$. The exact polynomial is
$$
 \sum_{j=0}^3 c_j(n)y^j
 =3u^2\,[1+(n-1)y]\,[1+2(g-h)y]\,[1+2(g+h)y].
$$

To prove it, remove the three seam edges, leaving $C_3\square P_n$. On the three-dimensional row coordinate, reflection in the twist commutes with the triangle Laplacian. Choose orthonormal row modes proportional to $(1,1,1),(1,-2,1),(1,0,-1)$. The triangle Laplacian eigenvalues are $0,3,3$, and the reflection signs are $+,+,-$. Within each mode, adding the seam edges of weight $y$ adds $y bb^{\mathsf T}$ with $b=e_n-\epsilon e_1$ for the reflection sign $\epsilon$. This follows by summing $y(f_{r,n}-f_{2-r,1})^2$ over rows $r=0,1,2$.

In the constant row mode, the path acquires one extra end-to-end edge of weight $y$. Its spanning-tree weight is $1+(n-1)y$: using the new edge entails deleting one of the $n-1$ original edges. By the matrix-tree theorem the product of the nonzero eigenvalues of this mode is $n[1+(n-1)y]$, including the one-vertex case. In each transverse mode put $A=3I+L(P_n)$. The matrix determinant lemma gives $\det(A+ybb^{\mathsf T})=\det(A)(1+y b^{\mathsf T}A^{-1}b)$. The two endpoint diagonal entries of $A^{-1}$ are $g$ and the endpoint cross-entry is $h$.

Indeed, for $n\ge2$, $A$ has endpoint diagonal 4, interior diagonal 5 and subdiagonals $-1$. The leading minors up to size $n-1$ are $U_{j+1}-U_j$ by expansion along the last row. The final expansion gives $\det A=3U_n$. Cofactors give $g=(U_n-U_{n-1})/(3U_n)$ and $h=1/(3U_n)$, since the off-diagonal endpoint cofactor is 1. For $n=1$, $A=(3)$, and the same formulas give $g=h=1/3$. Consequently $b^{\mathsf T}A^{-1}b=2(g-\epsilon h)$. Multiplying the three mode contributions and dividing by $3n$ proves the displayed tree polynomial, initially for $y\ge0$ and hence identically.

### The sign for all widths

Coefficient extraction yields
$$
 3(c_1-c_2)=9(n-1)u^2-12(n-2)ud-4(d^2-1).
$$
The recurrence preserves $u\ge1,\ v\ge0,\ 110v\le23u$, starting at $(v,u)=(0,1)$ and iterating $(v,u)\mapsto(u,5u-v)$. Hence $110d\ge87u$, and $u\ge5$ for $n\ge2$. Holding $u,d$ fixed, the coefficient of $n$ in the displayed expression is $9u^2-12ud<0$. For $n\ge16$, substitution of 16 and $d\ge87u/110$ gives the upper bound
$$
 \left(135-168(87/110)-4(87/110)^2\right)u^2+4<0
$$
for $u\ge5$. The first fifteen signs are positive by exact integer recurrence evaluation. The [Lean file](KleinTwist.lean) proves the sign of this expression for every index and checks both numbers at $n=8$. The spectral reduction and its link to spanning trees are proved above. A separate [integer cofactor calculation](klein_twist_check.py) constructs the graph directly and checks every coefficient for $1\le n\le20$ by four distinct evaluations of each cubic.

Finally $c_1/c_0=n-1+4g$. If $\rho=(5-\sqrt{21})/2$, then $U_n=(\rho^{-n}-\rho^n)/\sqrt{21}$, so $v/u=\rho+O(\rho^{2n})$. Substitution gives the theorem. For broader prior results on tree polynomials for Klein-bottle grids, see [Tzeng and Wu](https://arxiv.org/abs/cond-mat/0001408). The calculation here addresses the seam-specific comparison in the OEIS entry.
