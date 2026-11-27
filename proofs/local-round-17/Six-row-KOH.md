# An independent KOH certificate in the six-row case

Let $P_{h,w}(q)={h+w\brack h}_q$. For $b=8,9,10,15$, every $c\ge b$ with $6\mid bc$ gives a symmetric, nonnegative, unimodal polynomial
$$
P_{b,c}(q)-P_{6,bc/6}(q).
$$
The file [check_six_koh.py](check_six_koh.py) is a standalone integer-arithmetic verification of the finite inequalities used below. The comparison is a special case of [Zanello's equal-area conjecture](https://www.combinatorics.org/ojs/index.php/eljc/article/view/v25i2p17).

## A single summand

Write $p_{h,w}(j)=[q^j]P_{h,w}$, taking it as zero outside the support. Put $\Delta p(j)=p(j)-p(j-1)$. Up to rank $c$, the two rectangle first differences count partitions into parts in $\{2,\ldots,b\}$ and $\{2,\ldots,6\}$, respectively. This follows from the Gaussian product after multiplying by $1-q$, since both width parameters are at least $c$. Inclusion proves the desired inequality at these ranks.

Use $r=1$ for $b=8,9,10$, and $r=2$ for $b=15$. For $c\ge12$, apply the KOH decomposition to $P_{b,c}$ and keep the partition $\lambda=(7^r,1^{b-7r})$. Its contribution is
$$
T(q)=q^{42r}P_{6,r(c-12)}(q)
           (1+q+\cdots+q^{(b-6r)c-12r}).
$$
Indeed the two drops in the partition are $6$ at position $r$ and $1$ at position $b-6r$, and $2\sum_i{\lambda_i\choose2}=42r$. Each KOH summand has nonnegative increasing first-half coefficients and shares the same center $bc/2$. In particular, $\Delta p_{b,c}(j)\ge[q^j](1-q)T$ for $j\le bc/2$. The KOH formula and the symmetry and unimodality of its terms are given in [Stanley and Zanello, Lemma 2.1](https://arxiv.org/pdf/1711.10033#page=3).

Write $u=r(c-12)$, $v=(b-6r)c-12r$. It now suffices, for $c<j\le bc/2$ and large $c$, to prove
$$
F=p_{6,u}(j-42r)-p_{6,u}(j-42r-v-1)
  -p_{6,bc/6}(j)+p_{6,bc/6}(j-1)\ \ge0.
$$

## Two variables and four rectangles of height six

Let $H(n)=[q^n]\prod_{i=1}^6(1-q^i)^{-1}$, with $H(n)=0$ for $n<0$. Expanding the numerator of the Gaussian product expresses every coefficient in $F$ as
$$
p_{6,w}(n)=\sum_{S\subseteq\{1,\ldots,6\}}(-1)^{|S|}
              H\left(n-|S|w-\sum_{i\in S}i\right).
$$
On each residue class modulo 60, $H(n)$ is polynomial of degree at most five for all $n\ge0$. To see this, replace the common denominator by $(1-q^{60})^6$. Its numerator becomes the product of six geometric sums of total degree $339$. For $n=60z+s$, each numerator term of degree $60i+s$ contributes a multiple of ${z-i+5\choose5}$, where $0\le i\le5$. The polynomial already vanishes at all nonnegative $z<i$.

The verifier computes $H(0),\ldots,H(359)$ by the partition recurrence. Interpolation on each residue yields 60 integer polynomials for $5!\,60^5 H(n)$. Taking the minimum or maximum separately for each power coefficient gives polynomials $L(n)$ and $U(n)$. For nonnegative arguments, $L(n)\le5!\,60^5H(n)\le U(n)$.

Set $c=s_b t$ with $s_b=6/\gcd(6,b)$. In the subset expansion every argument of $H$ has the form $j-\alpha t-\beta$, with integer $\alpha,\beta$. Collect identical arguments. For $t\ge100$, sorting the finite list of threshold lines by value at $100$ and checking nondecreasing slopes proves their order permanently fixed. Include the two boundary lines $j=c+1$ and $j=bc/2+1$. For each pair of consecutive lines in this range, take all integer ranks from the lower line $A(t)$ through the upper line minus one, $B(t)$. Discard the inactive terms. Replacing $H$ by its scaled lower or upper envelope according to the sign of its multiplier gives a polynomial $G(t,j)\le 5!\,60^5 F$ on that entire strip.

Set $t=100+x$. For finite real $y\ge0$, substitute $j=(A(t)+B(t)y)/(1+y)$ and multiply $G$ by $(1+y)^5$. The resulting polynomial has degree at most five separately in $x,y$. For each $x=0,\ldots,5$, interpolate at $y=0,\ldots,5$ to recover its power coefficients in $y$, up to the common positive multiplier $5!$. For each such coefficient $h(x)$, the script verifies $\Delta^k h(0)\ge0$ for $0\le k\le5$, using forward differences here. Newton's formula $h(x)=\sum_k\Delta^k h(0){x\choose k}$ proves nonnegativity for all integers $x\ge0$. Thus $G$ is nonnegative throughout the strip, including $j=B(t)$ by continuity as $y\to\infty$.

## Exact finite verification

The script expands both original Gaussian polynomials for each remaining admissible width with $t<100$. It checks symmetry and every first difference up to the center. At rank zero the difference is zero, so first-half monotonicity and symmetry also imply nonnegativity.

| $b$ | Widths checked directly | Infinite strips checked | Tail begins at $c$ |
|---:|---:|---:|---:|
| 8 | 97 | 37 | 300 |
| 9 | 95 | 48 | 200 |
| 10 | 96 | 48 | 300 |
| 15 | 92 | 50 | 200 |

Run `python check_six_koh.py` from this directory. All lower bounds and interpolation operations use integer arithmetic.
