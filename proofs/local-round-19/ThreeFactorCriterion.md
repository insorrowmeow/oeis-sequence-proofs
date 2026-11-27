# An exact unimodality criterion for products of three ordinary q-integers and one spaced q-integer

Write $[a]=1+q+\cdots+q^{a-1}$ and $[b]_r=1+q^r+\cdots+q^{r(b-1)}$. For integers $r\ge2$, $a_i,b\ge1$, put

$$
P(q)=[b]_r\prod_{i=1}^k[a_i],\qquad
T=\sum_{i=1}^k\lfloor a_i/r\rfloor .
$$

**Theorem.** For $1\le k\le3$, the coefficient sequence of $P$ is unimodal if and only if $r$ divides some $a_i$ or $b\le T+1$. The same equivalence holds for $r=2$ with any number of ordinary factors.

Connelly, Ito, Martinez, Shevchenko and Yang proposed the equivalence for $k\le3$ or $r\le3$. They proved the one-factor case for every $r$, the two-factor case at $r=2$, and sufficiency of divisibility. João Pacheco subsequently posted a proof of sufficiency for all $r,k$. Shivam Patel previously refuted the unrestricted $r=3$ necessity claim using $(1+q)^6(1+q^3)$. Both public submissions explicitly leave the $k\le3$ necessity question undecided. The contribution below is its proof, with an exact formula for a coefficient drop. The same argument gives the $r=2$ assertion. A targeted search found no earlier proof of the general three-factor converse. Priority is unestablished. [Original, Corollary 4.3, Propositions 4.5 and 5.3, and Conjecture 5.4](https://arxiv.org/pdf/2605.12822#page=14) · [MathDB, the two original submissions](https://mathdb.com/p/374707/unimodality-conjecture-for-products-of-q-analogs)

## A coefficient on the decreasing step

Suppose that $b\ge T+2$ and that $r$ divides none of the $a_i$. For $k<3$, append copies of $[1]$ until there are three factors. Reorder the factors and write

$$
a_i=ru_i+s_i,\qquad 1\le s_1\le s_2\le s_3<r,\qquad
t=\max(s_3,s_1+s_2-1),\qquad j=rT+t.
$$

If $c_\ell=[q^\ell]P$, we will prove the exact identity

$$
c_{j-1}-c_j=\min(t-s_3+1,\ r-s_3)>0,\qquad 2j\le\deg P .
$$

Indeed, set $S=s_1+s_2+s_3$. Since $t$ is the larger of its two defining arguments, the two inequalities $s_3\le s_1+s_2+r-3$ and $s_1+s_2-s_3\le r-1$ give $2t\le S-3+r$. It follows that

$$
2j\le 2rT+S-3+r\le rT+S-3+r(b-1)=\deg P .
$$

Let $A=\prod[a_i]$ and $B=(1-q)A$, of degree $rT+S-2$. Coefficients outside the support of a polynomial are taken as zero. Since $t<2r$ and $b\ge T+2$, we have $j<rb$. Also $t\ge s_1+s_2-1$ and $r>s_3$ give $j+r>\deg B$. Hence every nonnegative power in the support of $B$ congruent to $j$ modulo $r$ occurs in the following sum:

$$
c_j-c_{j-1}=[q^j](1-q)P=\sum_{v=0}^{b-1}[q^{j-rv}]B .
$$

In the quotient ring $\mathbb Z[q]/(q^r-1)$ this sum is the coefficient of $q^{j\bmod r}$ in the remainder of $B$. In that ring $[a_i]=u_i[r]+[s_i]$ and $(1-q)[r]=0$. Thus $B$ has the same remainder as $(1-q)[s_1][s_2][s_3]$. Put $U=[s_1][s_2]$ and $U_\ell=[q^\ell]U$. Since $t+r>S-2$, and $t<2r$, only exponents $t$ and $t-r$ can contribute. Using $(1-q)[s_3]=1-q^{s_3}$ gives

$$
c_j-c_{j-1}=U_t-U_{t-s_3}+U_{t-r}-U_{t-r-s_3}.
$$

The first term vanishes because $t>\deg U$. Put $i=t-s_3$. By the ordering of the residues, $0\le i\le s_1-1$. The last term vanishes since its index is $i-r<0$. On the increasing side of $U$ one has $U_i=i+1$ and $U_{t-r}=\max(0,i+1-(r-s_3))$. Substitution proves the claimed drop. The coefficients of $P$ are symmetric, so a strict drop ending at or before its center rules out unimodality.

## Step size two and arbitrary factor count

In fact, suppose all $a_i\equiv1\pmod r$ for any $k$. Then $\deg A=rT$, and $(1-q)A\equiv1-q\pmod{q^r-1}$. If $b\ge T+2$, take $j=rT+1$. Once again $j<rb$ and $j+r>\deg((1-q)A)$. The residue sum now gives $c_j-c_{j-1}=-1$, while $2j\le rT+r(b-1)=\deg P$. This proves necessity for $r=2$, since all its nonzero residues are 1.

## Sufficiency

For completeness, the following is Pacheco's argument. Products of symmetric, unimodal polynomials with nonnegative coefficients are symmetric and unimodal. This follows by decomposing each of the two coefficient sequences into sums of intervals of constant height centered at its midpoint. The product of two such interval polynomials has triangular or trapezoidal coefficients. Nonnegative sums with a common center preserve unimodality as well.

If $a_h=ru$, then $[a_h][b]_r=[r][u]_r[b]_r$. The coefficients repeat each entry of the symmetric unimodal sequence of $[u][b]$ exactly $r$ times. Multiplication by the remaining ordinary factors preserves the result.

Now suppose that no $a_i$ is divisible by $r$ and $b\le T+1$. Use induction on $b$, with $b=1$ given by the product property. For $b\ge2$ there is an $a=a_h>r$. Let $R$ be the product of the remaining ordinary factors. The identity

$$
[a][b]_r=[a+r(b-1)]+q^r[a-r][b-1]_r
$$

follows by multiplying by $(1-q)(1-q^r)$. On multiplying by $R$, the first term is symmetric and unimodal. The second has the same center, and is symmetric and unimodal by induction since the replacements $a\mapsto a-r$, $b\mapsto b-1$ lower $T$ and $b$ by one. Their sum establishes the sufficient condition. [Pacheco's original proof](https://mathdb.com/p/374707/unimodality-conjecture-for-products-of-q-analogs)

## Independent computation

Lean 4.19.0 checks the necessary direction for one, two and three ordinary factors, for all lengths and strides. The formal proof works with integer polynomials, transports a coefficient drop from the residues to the original lengths, and uses reflection symmetry to rule out every possible mode. A second file independently verifies the precise size of the drop in the residue sum used above. The sufficiency argument and the all-factor-count corollary for $r=2$ are given in the written proof. [ThreeFactors.lean](ThreeFactors.lean) · [ThreeFactorDrop.lean](ThreeFactorDrop.lean)

An independent exact check constructs ordinary products by integer convolution and tests both the equivalence and the stated drop size. All 209,160 products passed. They cover sorted tuples with at most three factors as well as longer tuples for $r=2$. [verify_three_factor.py](verify_three_factor.py)
