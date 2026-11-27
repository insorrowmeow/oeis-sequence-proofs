# An exact certificate for an unbounded set of widths

Fix two heights $a<b$. We seek to compare the coefficients of the rectangle polynomials $P_{b,c}$ and $P_{a,d}$ for every integer $c\ge b$ such that $d=bc/a$ is an integer. Write
$$
 F=P_{b,c}-P_{a,d},\qquad
 \Delta^t P(n)=[q^n](1-q)^tP(q),\qquad x=n/c .
$$
Both Gaussians are symmetric on the same interval $0,\ldots,bc$. The constant coefficient of their difference is zero.

## Which inequalities suffice

For $n\le c$, the two first differences count partitions using parts from $2,\ldots,b$ and $2,\ldots,a$, respectively. The Gaussian numerator starts above degree $c$ in both cases. Inclusion gives $\Delta F(n)\ge0$.

For $c\ge T$, with $T\ge 4$, the full-polynomial certificate proves
$$
\begin{aligned}
 \Delta F(n)&>0 &&1\le x\le b/2-1/4,\\
 -\Delta^2F(n)&>0 &&b/2-1/4\le x\le b/2+1/4 .
\end{aligned}
$$
Let $u=\lfloor bc/2\rfloor$. If $bc=2u$, symmetry gives $\Delta F(u+1)=-\Delta F(u)$. If $bc=2u+1$, it gives $\Delta F(u+1)=0$. In both cases concavity at $u+1$ gives $\Delta F(u)>0$. Moving left through the central interval only increases that first difference. This covers every rank through the center. Reflection of this half of the coefficient sequence proves nonnegativity and unimodality everywhere.

## Computing the waves

For height $H$ and $t=0,1,2$ consider
$$
 R(q)=\frac{(1-q)^t}{\prod_{i=1}^{H}(1-q^i)}=\frac1{D(q)} .
$$
Here all calls have $H>t$. For every $v=1,\ldots,H$, let $e=\lfloor H/v\rfloor-t\mathbf1_{v=1}$ and $E=\Phi_v^e$. Compute $A_v=(D/E)^{-1}\bmod E$ over the rationals. The program checks the polynomial identity $\sum_v A_v(D/E)=1$. In particular the rational function $A_v/E$ is the exact contribution from this order. Put $J_v=A_v(1-q^v)^e/E$. This division is exact and $\deg J_v<ve$.

For integer $l\ge0$, the coefficient of the $v$-contribution is the following polynomial in $l$ on each residue class:
$$
 W_{v,l\bmod v}(l)=
 \sum_{\substack{i\equiv l\bmod v\\ 0\le i<ve}}[q^i]J_v\,
 \binom{(l-i)/v+e-1}{e-1}.
$$
For $l<i$ in that class the polynomial binomial already vanishes because $-(e-1)\le(l-i)/v\le-1$. Thus the formula is exact starting at $l=0$.

Write $U=W_{1,0}$. Bound the other waves by a single polynomial with nonnegative coefficients:
$$
 V(y)=\sum_k y^k\sum_{v>1}\max_{0\le r<v}|[y^k]W_{v,r}(y)|.
$$
Consequently $U(l)-V(l)\le[q^l]R\le U(l)+V(l)$ for every integer $l\ge0$. For $l<0$ the exact coefficient is zero.

## Translating the Gaussian numerator

In $\prod_{i=1}^H(1-q^{w+i})$, a subset of size $j$ and sum $s$ shifts the argument by $jw+s$ with sign $(-1)^j$. The program computes the multiplicities of $(j,s)$ by subset counting. For width $w=\alpha c$ and $x\ge j\alpha$ put $y=c(x-j\alpha)\ge0$. The main polynomial for this term is $U(y-s)$. The contribution of the other waves in absolute value is at most $V(y)$ when $y-s\ge0$. If $y-s<0$, the polynomial extension error is at most $\max_{1\le i\le s}|U(-i)|$ since the exact coefficient is zero. If $x<j\alpha$, the term vanishes. At a right endpoint $x=j\alpha$, the terms of this new group also vanish because $s>0$ for $j>0$.

On a closed strip $l\le x\le u$ cut at the possible $j\alpha$, summing the signed main polynomials and subtracting all error bounds gives a rational polynomial $L(c,x)$ below the signed first or second difference. The comparison with the smaller Gaussian uses the negative sign for its main term and still subtracts its absolute error.

## Smaller polynomials for larger heights

The alternate certificate uses two lower bounds on first differences of $P_{b,c}$. First, for $a<k\le b$ the Gaussian recurrence gives
$$
 P_{b,c}-P_{k,c}=\sum_{j=k+1}^b q^jP_{j,c-1}.
$$
Each term is symmetric about $j(c+1)/2$ within its shifted support, with weakly increasing coefficients through that point (including initial zeros). Thus $\Delta P_{k,c}\le\Delta P_{b,c}$ up to rank $kc/2$. The program uses $k=\min(b,a+6)$ through $x=k/2-1/4$.

For the other strips, choose integers $h,r$ with $r\ge1$, $b>(h+1)r$. In the KOH decomposition of $P_{b,c}$ the partition $((h+1)^r,1^{\,b-(h+1)r})$ contributes exactly
$$
 S_r(q)=q^{rh(h+1)}P_{h,w}(q)(1+q+\cdots+q^v),\quad
 w=r(c-2h),\quad v=(b-hr)c-2hr .
$$
Indeed its only drops have sizes $h,1$ at positions $r,b-hr$, respectively. Substitution into the KOH formula gives the displayed shift and factors. The threshold ensures $w,v\ge0$ for every summand used. Both $S_r$ and the sum of all the remaining KOH terms are symmetric about $bc/2$ and unimodal. The identity and the properties of its terms appear in [Stanley and Zanello, Lemma 2.1](https://arxiv.org/pdf/1711.10033#page=3).

It therefore suffices on each noncentral left strip to prove $\Delta(S_r-P_{a,d})>0$ for one choice of $r$ there. In the central interval the program uses **one fixed summand throughout**. Negative second differences of $S_r-P_{a,d}$ imply positive left-half first differences of this same symmetric polynomial by the reflection argument above. The omitted KOH terms have nonnegative left-half first differences. This does not require concavity of their sum.

In $(1-q)^tS_r$, multiplying the line factor by $1-q$ leaves $1-q^{v+1}$, hence two shifted copies of $(1-q)^{t-1}P_{h,w}$. Arguments now take the form $c(x-\alpha)-z$ with an integer offset $z$ of either sign. Set $y=c(x-\alpha)$. For $x\ge\alpha$ the absolute wave bound becomes $V(y+\max(0,-z))$, with the same extension correction up to $z$ when $z>0$. For a strip ending at $u\le\alpha$, an otherwise inactive term might still contribute when $z<0$. Its coefficient argument is at most $\lfloor-T(\alpha-u)\rfloor-z$. The program bounds all such contributions with $\max_{0\le i\le\lfloor-T(\alpha-u)\rfloor-z}(|U(i)|+V(i))$, using zero for an empty range. These bounds apply on both sides of every knot.

## Certifying a half-infinite strip

Writing $L(c,x)=\sum_i c^i A_i(x)$ and $c=T+z$, the polynomial at $z^k$ is $\sum_{i\ge k}\binom{i}{k}T^{i-k}A_i(x)$. On a rational subinterval of a strip, rescale $x$ to $l+(u-l)y$. If the resulting polynomial is $\sum_{j=0}^D p_jy^j$, its degree-$D$ Bernstein controls are
$$
 \beta_k=\sum_{j=0}^k p_j\binom{k}{j}/\binom{D}{j}.
$$
Positive controls imply positivity for every $0\le y\le1$, since the Bernstein basis is nonnegative and sums to one. The verifier allows a zero polynomial for positive powers of $z$; the constant term must be strictly positive. It may bisect a strip and repeat the same exact check. Thus the accepted strip covers all real $c\ge T$ for the bounding polynomial and every admissible integer width and rank for the original coefficient inequality. The two algebraic steps are also proved in [Bernstein.lean](Bernstein.lean).

For $b\le c<T$ with $a\mid bc$, both original Gaussians are evaluated over the integers. The program checks the consecutive differences through the midpoint and symmetry, padding zeros through degree $bc$. Each row of the [run ledger](verification.txt) reports $a,b,T$, the tail method and the number of finite widths checked. Run [verify_equal_area.py](verify_equal_area.py) with Python and python-flint 0.9.0. Its default range reproduces the ledger. The [independent six-row certificate](check_six_koh.py) uses only the Python standard library.

## Reproducing the checks

The following commands run from this directory with Python and python-flint 0.9.0 available.

```text
python verify_equal_area.py
python verify_equal_area.py --replay verification.txt
python check_six_koh.py
python verify_equal_area.py --exceptions 6
```

The first command writes the ledger to standard output. The second recomputes all its tail inequalities and checks every finite interval a second way. It uses the published divisibility theorem wherever it finds a valid chain of intermediate rectangles, and otherwise computes all required differences with an integer whose radix digits encode the polynomial coefficients. The radix bound and the sign test are documented in [packed_head.py](packed_head.py). The replay covered 2,014 finite tuples by divisor chains and 735 by packed expansions. The original run had expanded all 2,749 tuples directly. The third command reproves the four six-row families using period-60 formulas. The last runs the unrestricted fixed-side algorithm with input 6.

The three Lean files compile individually with Lean 4.19.0 and matching mathlib. The arithmetic reduction and bounded examples are in [Zanello.lean](Zanello.lean), the interval-positivity rules in [Bernstein.lean](Bernstein.lean), and the central-reflection and line-factor identities in [KohCenter.lean](KohCenter.lean).
