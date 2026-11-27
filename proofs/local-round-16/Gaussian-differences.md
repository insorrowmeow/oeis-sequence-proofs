# Unimodality of the centered differences of Gaussian polynomials

Local research manuscript, 27 November 2026.

**Theorem.** For every integer $k\ge5$ there exists $M(k)$ such that the following conclusion holds for all integers $m\ge M(k)$ and all integers $b$ satisfying

$$
k-2\le b\le\frac{km-4k+4}{k-2},\qquad k(m-b)\equiv0\pmod2.
$$

The polynomial

$$
f(k,m,b)(q)={m\brack k}_q
-q^{k(m-b)/2+b-2k+2}{b\brack k-2}_q
$$

has nonnegative unimodal coefficients except when $(k-2)b=km-4k+2$. In the exceptional case it fails unimodality.

In every nonexceptional case the difference between consecutive coefficients is strictly positive at every index $r$ with $k-1\le r\le\lfloor k(m-k)/2\rfloor$, for all sufficiently large $m$ depending only on $k$.

This is Conjecture 1.1(iv) of Stanley and Zanello. They proved the classifications for $k\le4$ and part (iv) for $k=5$. Koutschan, Uncu and Wong subsequently treated $k=6,7$ (Theorems 12–13 and Corollary 14). The theorem here gives the fixed-$k$, sufficiently-large-$m$ assertion in part (iv) for every $k$, including all heights $k\ge8$. [Stanley and Zanello, Conjecture 1.1 and Theorems 2.2 and 2.4](https://arxiv.org/pdf/1711.10033) · [Koutschan, Uncu and Wong](https://arxiv.org/pdf/2302.04067#page=8)

## 1. Rectangles, the shift and the initial coefficients

Write $P_{j,A}={A+j\brack j}_q$ for the generating polynomial of partitions in a $j$ by $A$ rectangle. Its degree is $jA$, and rotation of the complementary boxes proves symmetry about $jA/2$. Define

$$
W=m-k,\qquad B=b-k+2,\qquad D=kW,\qquad s=\frac{kW-(k-2)B}{2}.
$$

The hypotheses give $B\ge0$, $s\in\mathbb Z_{\ge0}$ and $B\le kW/(k-2)$. The difference $F=P_{k,W}-q^sP_{k-2,B}$ is symmetric on the coefficient range $0,\ldots,D$, allowing zero endpoints. Throughout the proof let $\Delta^tP(n)=[q^n](1-q)^tP(q)$, extending coefficients by zero at negative indices.

For $n\le W$, $\Delta P_{k,W}(n)$ counts partitions of $n$ into parts from $\{2,\ldots,k\}$. Indeed, in the Gaussian product

$$
P_{j,A}(q)=\prod_{i=1}^j\frac{1-q^{A+i}}{1-q^i},
$$

the numerator first affects degree $A+1$, and $1-q$ cancels the first denominator factor. If $0\le n\le W$ and $n<s$, the smaller polynomial does not contribute. If $s\le n\le W$, then $(k-2)B=kW-2s\ge(k-2)W$, giving $B\ge W$. In this case $\Delta P_{k-2,B}(n-s)$ counts partitions of $n-s$ into parts from $\{2,\ldots,k-2\}$.

For $s=0$, inclusion of part sets gives an injection from the latter partitions into those counted by $\Delta P_{k,W}(n)$. For $s\ge2$, choose a fixed partition of $s$ into twos and threes. Such a partition exists for every even $s$ and for every odd $s\ge3$. Adjoining its parts gives an injection, since deleting that fixed multiset recovers the input. Consequently

$$
\Delta F(n)\ge0\qquad(0\le n\le W,\ s\ne1). \tag{1}
$$

For $k-1\le n\le W$ this inequality is strict. Any target partition containing $k$ or $k-1$ lies outside the injection's image, since the source has largest part at most $k-2$ and the added parts are at most $3$. Such a partition exists at each of these weights. Use $(k-1)$, $(k)$ and $(k-1,2)$ at weights $k-1,k,k+1$, respectively. At every weight $n\ge k+2$ add a partition of $n-k$ into twos and threes to $(k)$. When $n<s$ the same witness gives a positive coefficient directly.

When $s=1$ and $W\ge2$, the coefficients of $F$ at degrees $0,1,2$ are $1,0,1$. Indeed, now $B\ge W$, the large rectangle has initial coefficients $1,1,2$, and the small one has initial coefficients $1,1$. Algebraically $s=1$ is exactly $(k-2)b=km-4k+2$, establishing the claimed exception.

## 2. Uniform estimates for the two rectangles

Let $k\ge5$ remain fixed and let $W\to\infty$. Write $x_+=\max(x,0)$ and define

$$
g_k(x)=\frac{1}{(k-1)!}\sum_{h=0}^k(-1)^h\binom kh (x-h)_+^{k-1}.
$$

This is the density of the sum of $k$ independent uniform random variables on $[0,1]$. The distribution function is the volume below a linear cut of the unit cube. Inclusion-exclusion on the inequalities that each coordinate is at most one gives the formula after differentiation.

For $t=1,2$, uniformly over integers $0\le n\le kW$,

$$
\Delta^tP_{k,W}(n)
=\frac{W^{k-1-t}}{k!}\,g_k^{(t)}(n/W)+O_k(W^{k-2-t}). \tag{2}
$$

The companion estimate, uniform also over all admissible $B,s$, is

$$
\left|\Delta^t P_{k-2,B}(n-s)\right|
=O_k(W^{k-3-t}),\qquad t=1,2. \tag{3}
$$

Here and below the $k$ in the subscript allows constants depending only on $k$. To prove both estimates, consider the fixed rational function

$$
R_{j,t}(q)=\frac{(1-q)^t}{\prod_{i=1}^j(1-q^i)}.
$$

For $j\ge3$ and $t\in\{1,2\}$ its pole at $1$ has order $j-t$ and leading term $(1-q)^{-(j-t)}/j!$. At any primitive $v$th root with $v\ge2$ its pole order is at most $\lfloor j/v\rfloor\le\lfloor j/2\rfloor$. A term $(1-\omega q)^{-u}$ has coefficient $\omega^\ell\binom{\ell+u-1}{u-1}$ in degree $\ell\ge0$. Since $\lfloor j/2\rfloor-1\le j-1-t$ for all $j\ge3$, partial fractions give

$$
\left|[q^\ell] R_{j,t}(q)\right|=O_k(W^{j-1-t})
\quad(3\le j\le k,\ 0\le\ell\le kW).
$$

Multiplication by the Gaussian numerator takes a signed sum of at most $2^j$ nonnegative shifts, counted with multiplicities. Negative resulting coefficient indices contribute zero. Taking $j=k-2$ proves (3), including the bounded second-difference estimate at $k=5$.

For $j=k\ge5$, the sharper inequality $\lfloor k/2\rfloor-1\le k-2-t$ holds. Removing the leading pole at $1$ leaves coefficients of order $O_k(W^{k-2-t})$, so

$$
[q^\ell]R_{k,t}(q)
=\frac{\ell^{k-1-t}}{k!(k-1-t)!}+O_k(W^{k-2-t})
\quad (0\le\ell\le kW).
$$

Every size-$h$ subset of the $k$ numerator factors shifts $\ell$ by $hW+c$ with $0\le c\le k(k+1)/2$. After extending the coefficients by zero for $\ell<0$, replacing $(n-hW-c)_+^{k-1-t}$ by $(n-hW)_+^{k-1-t}$ costs $O_k(W^{k-2-t})$ uniformly, by the mean value bound for the positive-part power. The signs and multiplicities of these shifts give $g_k^{(t)}$ and prove (2), including at integer knots. Related leading asymptotics for Gaussian coefficients and their differences were studied by Stanley and Zanello. [Stanley and Zanello, *Some Asymptotic Results on $q$-Binomial Coefficients*](https://math.mit.edu/~rstan/papers/qbc.pdf)

## 3. The bulk and the center

The density $g_j$ is symmetric about $j/2$. Convolution with the uniform density on $[0,1]$ gives

$$
g'_j(x)=g_{j-1}(x)-g_{j-1}(x-1)\qquad (j\ge3).
$$

Starting with the triangular density $g_2$, induction shows that $g'_j(x)>0$ on $0<x<j/2$ and $g'_j(x)<0$ on $j/2<x<j$. Indeed, on the open left half $x$ is closer than $x-1$ to the center of $g_{j-1}$; if $x-1$ is outside its positive support it contributes zero. Reflection treats the right half. In particular,

$$
g_k''(k/2)=g'_{k-1}(k/2)-g'_{k-1}(k/2-1)<0.
$$

The derivatives needed here are continuous for $k\ge5$. Choose $0<\delta<1/4$ so that $g_k''$ is bounded above by a strictly negative constant on $[k/2-\delta,k/2+\delta]$. The minimum of $g'_k$ on $[1,k/2-\delta]$ is strictly positive. Comparing (2) and (3) now gives, for all sufficiently large $W$ depending only on $k$,

$$
\begin{aligned}
\Delta F(n)&>0 && (1\le n/W\le k/2-\delta),\\
\Delta^2 F(n)&<0 && (k/2-\delta\le n/W\le k/2+\delta).
\end{aligned} \tag{4}
$$

There is no dependence of this threshold on $b$. The first-difference signal from the large rectangle has order $W^{k-2}$ on the first interval, whereas the small rectangle contributes $O_k(W^{k-4})$. The second-difference signal in the second interval has order $W^{k-3}$, and the perturbation there is $O_k(W^{k-5})$.

Let $H=\lfloor D/2\rfloor$ and assume $W$ large enough that $H+1$ lies in the central interval. If $D=2H$, symmetry gives $\Delta F(H+1)=-\Delta F(H)$. Since $\Delta^2 F(H+1)<0$, it follows that $\Delta F(H)>0$. If $D=2H+1$, symmetry gives $\Delta F(H+1)=0$, again forcing $\Delta F(H)>0$. In both cases the strictly decreasing first differences in the central interval stay positive through $H$. Together with (1), its strict improvement from $k-1$ on, and the first line of (4), this proves weak increase through the center and strict increase at each claimed index for every $s\ne1$. Symmetry gives weak decrease on the other side. The constant coefficient is $0$ for $s=0$ and $1$ for $s>0$, so every coefficient is nonnegative. This proves the theorem.

## 4. A consequence for every smaller rectangle height

Fix $k\ge5$. For all sufficiently large $W$, choose any $1\le d<k$ and any $B\ge0$ for which $s=(kW-dB)/2$ is a nonnegative integer. The centered difference $P_{k,W}-q^sP_{d,B}$ has nonnegative unimodal coefficients whenever $s\ne1$, and fails unimodality when $s=1$.

For the initial interval it suffices that $B+s\ge W$, so that $0\le n-s\le B$ whenever $s\le n\le W$. If $d\ge2$, then $B+s=(1-2/d)s+kW/d\ge W$. If $d=1$, then $B+s=(kW+B)/2\ge W$. Thus the same injection by adjoining twos and threes applies. For $d=1$ the allowed parts $\{2,\ldots,d\}$ form the empty alphabet and only the empty partition occurs. At $s=1$ the initial three coefficients are again $1,0,1$ for large $W$.

For $3\le d<k$ the partial-fraction bound in Section 2 gives $\Delta^tP_{d,B}(n-s)=O_k(W^{k-2-t})$, one power smaller than the main terms in (2). For $d=1,2$ the coefficients of $R_{d,t}$ are bounded for $t=1,2$: all its poles have order at most one. The numerator gives only finitely many shifts. These bounds yield the two strict signs in (4) uniformly over $d$ and $B$. The symmetry argument then proves the claim.

**Shape of the exception.** For $s=1$ all coefficients are still nonnegative, and deleting the first and last coefficient leaves a unimodal sequence, once $W$ is sufficiently large. To see this, let $2\le r\le W$. The smaller first difference counts partitions of $r-1$ into parts between $2$ and $d$. Every such partition is nonempty. Increase one largest part by one. The resulting partition of $r$ has parts between $2$ and $k$, since $d<k$. Its largest part is unique, so decreasing it recovers the source. This injects the smaller first difference into the larger and proves $\Delta F(r)\ge0$ on these ranks. The estimates (4) apply to $s=1$ as well. Hence the coefficients weakly increase from degree $1$ to the middle. The coefficient at degree $1$ is zero, and symmetry gives the claim at the other end.

## 5. Verification and scope

The manuscript establishes the existence of a width threshold for each fixed height. It gives no numerical value for the least threshold. The literature and public-repository search found no earlier proof covering all heights. This local draft has not undergone external peer review.

- [GaussianEdge.lean](GaussianEdge.lean) uses finite sets of integer partitions to relate the initial first differences to partitions without ones. It checks the padding injection, its strict comparison, and the exceptional coefficients $1,0,1$ for arbitrary rectangle widths of at least two and $k\ge5$. The file also checks the injective operation of increasing a largest part in the unit-shift case of Section 4.
- [GaussianCenter.lean](GaussianCenter.lean) proves a uniform finite-difference criterion for both parities of the total degree. A symmetric main polynomial whose gaps decrease by at least $H$ in the central interval has left-hand gaps of at least $H/2$ there. A smaller perturbation preserves their sign. The file proves the implications for nonnegativity and both monotone halves, including the zero padding of the centered shift.
- [EightRowProfile.lean](EightRowProfile.lean) verifies two explicit margins in the first previously untreated height, $k=8$. In the truncated-power formulas of (2), $g'_8(x)\ge1/720$ on $[1,15/4]$ and $g''_8(x)\le-1/2$ on $[15/4,17/4]$.
- [check_gaussian_differences.py](check_gaussian_differences.py) evaluates the exact coefficients for all 15,000 admissible triples with $5\le k\le12$ and $2\le W\le60$. The code also checks two independent coefficient formulas on selected rectangles. For $k=8$ the finite range contains 2,478 differences. The largest width in that range admitting a failure other than the unit shift is $W=9$.

The Lean files use version 4.19.0 and mathlib. The partial-fraction expansion, uniform asymptotic estimates, and deduction of their validity for all sufficiently large widths are justified in the manuscript. The complete asymptotic theorem has yet to be formalized in Lean.
