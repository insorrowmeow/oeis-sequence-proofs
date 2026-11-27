# The description-tree refinement of Voloshyn's Gross–Witten–Wadia polynomials

**Theorem.** Let $s\ge1$. In each rooted plane tree with $s$ edges, give every leaf label $2$, allow every other vertex a label from $2$ to $2+$ the sum of its children's labels, and force the root to take the largest allowed label. Write $\nu(T)$ for the number of leaves plus the number of internal vertices taking their largest allowed label. If $B_s(z)$ is Voloshyn's signed substitution in row $s$ of A336110, then

$$
 B_s(z)=\sum_T z^{\nu(T)-2}.
$$

The sum includes each allowable labeling of each ordered shape. The theorem proves equation (3.55), which the author verified by enumeration for $s\le9$ and proved in its two extreme statistic classes. The requested direct bijection with a walk or matrix-expansion model is a separate open problem. [Statement and indexing, §3.7](https://arxiv.org/html/2611.11670v1#S3.SS7) · [Companion preprint, revised November 20](https://arxiv.org/html/2609.31189v3)

## Counting ordered forests

Work over $K=\mathbb Q(z)$, with $t$ marking vertices. First allow the root of each component to take any of the labels permitted to a nonroot vertex. Let $U=U(t,x)$ count one such tree, with weight $t^{|T|}z^{\nu(T)}x^{\ell(\mathrm{root})}$, and let $W=W(t,x)$ count ordered lists of these trees, including the empty list. Then $W=(1-U)^{-1}$. Write $F=W(t,1)$. Coefficients at every $t$-degree are polynomials in $x,z$. In fact the label at a vertex is at most twice its subtree size, by induction.

Fix a forest of children with sum of root labels $k$. A new root can take the $k$ nonmaximal labels $2,\ldots,k+1$, or take $k+2$ and acquire a factor $z$. For an empty forest this gives exactly one marked leaf. The generating polynomial for its choices, apart from $t$, is $x^2(1+x+\cdots+x^{k-1}+zx^k)$, with the first sum empty at $k=0$. Multiplication by $1-x$ and summation over all forests gives

$$
 (1-x)U=t x^2\{F-W+z(1-x)W\}.
$$

Define $a=t x^2(1-z+zx)$ and $b=1-x-t x^2 F$. Substitution of $U=1-1/W$ gives

$$
 aW^2+bW-(1-x)=0. \tag{1}
$$

Each nonempty ordered forest of $s$ vertices becomes precisely one tree of the theorem with $s$ edges when a maximal root is attached. Its vertices acquire one additional mark at that root. Thus

$$
 F=1+z\sum_{s\ge1}t^s\sum_T z^{\nu(T)-2}. \tag{2}
$$

## A repeated root in the catalytic variable

Set $J=2aW+b$. Equation (1) gives
$$
 \Delta(t,x)=b^2+4a(1-x)=J^2.
$$
Since $J(0,x)=1-x$, there exists a unique series $\xi\in K[[t]]$ with $J(t,\xi)=0$. To see this directly, write $J=1-x+tH(t,x)$, where each coefficient of $H$ is polynomial in $x$. Start with $\xi_0=1$ and apply $u\mapsto1+tH(t,u)$. Each iteration preserves all established coefficients and determines one more. Equivalently, the substitution raises the order of any input difference by at least one. Evaluation and formal differentiation in $x$ therefore give
$$
 \Delta(t,\xi)=0,\qquad (\partial_x\Delta)(t,\xi)=0.
$$
Differentiation precedes evaluation, since $J$ itself is the square root in $K[x][[t]]$.

For arbitrary $f$, replace $F$ by $f$ in $\Delta$. Its coefficients at $x^4,x^3,x^2,x,1$ are
$$
 A=t^2 f^2-4tz,\quad B=2tf+4t(2z-1),\quad
 D=1-2tf+4t(1-z),\quad E=-2,\quad L=1.
$$
Form the invariants $I=12AL-3BE+D^2$ and
$J_4=72ADL+9BDE-27AE^2-27B^2L-2D^3$.
At a repeated root $r$, the derivative and value equations give
$E=-4Ar^3-3Br^2-2Dr$ and $L=3Ar^4+2Br^3+Dr^2$.
Their substitution gives $4I^3-J_4^2=0$. This calculation allows a vanishing leading coefficient as well.

## Identifying the same algebraic branch

Here is the common reduced polynomial in a form that permits direct checking. Set $w=f-1$ and
$$
\begin{aligned}
 c_1&=(z^2-10z+1)w^2+10z(z+1)w+z^2,\\
 c_2&=-8\big[(-z^2+4z-1)w^3+(z^3+2z^2+2z+1)w^2\\
    &\hspace{36mm}+(4z^3-2z^2+4z)w+z^3+z^2\big],\\
 c_3&=16f^2(z-1)^2(z+w)^2,\\
 C(t,z,f)&=z(1-f)+t[c_1+t(c_2+tc_3)].
\end{aligned}
$$

Two polynomial identities complete the comparison. For the first, use the quartic coefficients above. For the second, let $P_4(g;u,h)$ be precisely Voloshyn's equation (3.10). Its dependence on $h$ is through $h^2$, so the substitution below takes place in ordinary formal series.

$$
\begin{aligned}
 4I^3-J_4^2 &= 6912\,t^3\,C(t,z,f),\\
 256P_4\!\left(-z/2+t(1-z)^2f\,;\,-z,h\right)
   \big|_{h^2=4t(1-z)^3}
   &=16t(1-z)^6\,C(t,z,f).
\end{aligned} \tag{3}
$$

Both identities follow by expansion over the integers after writing the second one in terms of $2g$ and $h^2$. The supplied Lean file checks them as identities in every commutative ring. [Algebraic certificate](Quartic.lean) · [Source quartic, §3.2](https://arxiv.org/html/2611.11670v1#S3.SS2)

The first identity and the repeated root prove $C(t,z,F)=0$. On the GWW side put $G=1+z\sum_{s\ge1}B_s(z)t^s$. Formula (3.56) follows algebraically from (3.20) and the definition of the signed numerator rows. Indeed, for $q=h^2/4$, one has $R_0(-z)=-z/(1-z)$ and $R_s(-z)=-zB_s(z)/(1-z)^{3s+1}$ for $s\ge1$. Therefore
$$
 g(-z,h)+z/2
  =\frac q{1-z}+\frac{zq}{1-z}\sum_{s\ge1}B_s(z)
      \left(\frac q{(1-z)^3}\right)^s .
$$
This uses only the analytic rows. Setting $q=t(1-z)^3$ gives
$$
 g(-z,h)=-z/2+t(1-z)^2G,\qquad h^2=4t(1-z)^3 .
$$
The second identity then gives $C(t,z,G)=0$.

There is at most one root of $C(t,z,f)=0$ in $K[[t]]$. For two roots $f_1,f_2$, subtract the equations. The difference in the right-hand polynomial correction factors through $f_1-f_2$. Consequently $(f_1-f_2)(z-tH)=0$ for some $H\in K[[t]]$. The second factor is a unit because its constant coefficient $z$ is nonzero in $K$. Thus $F=G$. Equation (2) gives the required coefficient identity. Its two sides belong to $\mathbb Z[z]$, so it holds after every specialization of $z$, including $0$ and $1$. $\square$

The tree construction uses the plane-tree family and quadratic method of Cori and Schaeffer. Their unrefined formula fixes the row totals. The added variable here marks every leaf and every maximal internal vertex, giving a comparison for every individual column of the GWW numerator triangle. [Cori and Schaeffer, 2003](https://doi.org/10.1016/S0304-3975(01)00221-3)

As of November 27, 2026, the latest version of the companion preprint (November 20, §4.6) still listed the enumerative identity as conjectural. The author's comment in the November 23 version of OEIS A401900 also records it as conjectural. A search by the statement, row data, A336110, A401900, and the leaf/maximal-label statistic found the author's checks and the classical descriptions of the unrefined family. We did not locate a prior proof of (3.55). [Companion preprint](https://arxiv.org/html/2609.31189v3) · [OEIS A401900](https://oeis.org/A401900)

## Lean verification

Lean 4.19.0 checks the exact sum over the finite type of valid labeled description trees, the forest recursion, formal substitution, double root, algebraic identities, uniqueness and extraction of every row polynomial. The theorem **Voloshyn.voloshyn_3_55** takes the published GWW quartic and row normalization, combined in **GwwRowEquations**, as its mathematical input. The converse theorem proves that the actual trees give the unique positive-indexed row family with that characterization. The derivation of the quartic from the matrix model is supplied by Voloshyn's paper. The final theorems use the standard Lean axioms **propext**, **Classical.choice** and **Quot.sound**. [Main statements](Final.lean) · [Rooted trees and statistic](TreeSemantics.lean) · [Unconditional quartic for the tree series](TreeQuartic.lean)

Run **python check_lean.py Final** in this directory. A mathlib v4.19.0 project with built dependencies can invoke the same checker through **lake env python /path/to/check_lean.py Final**. [Checker](check_lean.py)

## Independent numerical check

Running **python verify_rows.py --through 28** compares all 406 coefficients in rows $1$ to $28$. One computation enumerates ordered forests by vertex count, sum of root labels and number of marks. The other differentiates the rational functions in (3.21) three times per row. Each row sum is independently compared with $2^s(3s)!/((s+1)!(2s+1)!)$. Row 28 accounts for $2\,482\,798\,285\,346\,192\,330\,927\,898\,624$ labeled trees. [Verification code](verify_rows.py)
