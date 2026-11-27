# Unimodality for partitions into distinct parts in near-rectangular Ferrers diagrams

Local research manuscript, 27 November 2026.

Let $\lambda=(\lambda_1>\cdots>\lambda_b>0)$ be a strict partition. Let $a_n$ count strict partitions of $n$ whose $i$th part is at most $\lambda_i$ and whose length is at most $b$. The empty partition contributes $a_0=1$. Write $F_\lambda(q)=\sum_n a_nq^n$. Samuel Zbarsky's Conjecture 15 asks whether, for fixed $b\ge5$, all sufficiently wide shapes with $\lambda_b/\lambda_1$ sufficiently close to one have unimodal $F_\lambda$. [Zbarsky, §7, Conjecture 15](https://arxiv.org/pdf/1408.3895#page=14) · [Journal publication](https://doi.org/10.1016/j.disc.2015.04.004)

**Theorem.** For every integer $b\ge5$ there exist $\epsilon_b>0$ and $L_b$ such that $F_\lambda$ is unimodal whenever $\lambda$ has $b$ distinct parts, $\lambda_1\ge L_b$, and $\lambda_b>(1-\epsilon_b)\lambda_1$.

The lower cutoff on the number of rows is sharp at four. Stanley and Zanello's Theorem 2.5 gives failure for $(L,L-2,L-4,L-6)$ for all sufficiently large $L$, even though $(L-6)/L\to1$. For five or more rows, Alpoge proved the special case of consecutive row lengths for sufficiently large $L$. The theorem above allows arbitrary gaps subject to the ratio condition. [Stanley and Zanello](https://arxiv.org/pdf/1305.6083#page=6) · [Alpoge](https://arxiv.org/abs/1308.2358)

Identify a strict partition with its set of positive parts. Put $L=\lambda_1$, $m=\lambda_b$, and $w=L-m$. Constants in the proof may depend on $b$. We will choose a fixed, sufficiently small $\tau>0$ and prove the assertion under $w\le\tau m$. Taking $\epsilon_b=\tau/(1+\tau)$ then gives the stated condition. We may assume $m\ge b$.

## 1. Separate the freely chosen small parts

For $0\le d\le b$, define

$$A_{d,m}(q)=\sum_{j=0}^d B_{j,m}(q),\qquad B_{j,m}(q)=q^{j(j+1)/2}{m\brack j}_q.$$

Here $B_{j,m}$ counts $j$-subsets of $[m]=\{1,\ldots,m\}$ by their sum. Subtracting $j,j-1,\ldots,1$ from the parts in decreasing order gives an ordinary partition in a $j$ by $m-j$ rectangle. We use the product formula $\,{m\brack j}_q=\prod_{i=1}^j(1-q^{m-j+i})/(1-q^i)$.

Call $H=\{u_1>\cdots>u_h\}\subseteq\{m+1,\ldots,L\}$ admissible if $h\le b$ and $u_i\le\lambda_i$ for all $i\le h$. Once these large parts have been fixed, every choice of at most $b-h$ distinct elements of $[m]$ is allowed, since all remaining row bounds are at least $m$. Thus there is an exact identity

$$F_\lambda(q)=A_{b,m}(q)+\sum_{\substack{H\ {\rm admissible}\\H\ne\varnothing}}q^{\sum_{u\in H}u}A_{b-|H|,m}(q). \tag{1}$$

## 2. Uniform bounds on the differences

Use the backward difference convention $D_sP(n)=[q^n](1-q)^sP(q)$, with coefficients at negative indices zero. For $s=1,2$ and $3\le d\le b$,

$$|D_s A_{d,m}(n)|\le C_b\, m^{d-1-s}\quad\text{for }0\le n\le (b+1)m. \tag{2}$$

The density of the sum of $b$ independent uniform variables on $[0,1]$ is

$$f_b(x)=\frac1{(b-1)!}\sum_{h=0}^b(-1)^h\binom bh(x-h)_+^{b-1},\qquad y_+=\max(y,0).$$

This follows by inclusion-exclusion on the unit cube, starting with the simplex of nonnegative coordinates with sum at most $x$, and differentiating its volume. Uniformly on the same range of $n$,

$$D_s A_{b,m}(n)=\frac{m^{b-1-s}}{b!}\,f_b^{(s)}(n/m)+O_b(m^{b-2-s}),\qquad s=1,2. \tag{3}$$

To prove (2) and (3), for $j\ge1$ expand the fixed rational function

$$R_{j,s}(q)=\frac{(1-q)^s}{\prod_{i=1}^j(1-q^i)}.$$

Its pole at $1$ has order $j-s$ if $j>s$, with leading coefficient $1/j!$ in powers of $(1-q)^{-1}$. At any other root of unity of order $v\ge2$, its pole order is at most $\lfloor j/v\rfloor\le\lfloor j/2\rfloor$. A partial fraction $c/(1-\omega q)^r$ has coefficient $c\omega^t\binom{t+r-1}{r-1}$ at $t\ge0$. Any polynomial part is supported on a finite set depending only on $j,s$. Consequently for $0\le t\le(b+1)m$ the coefficients are

$$O_b\!\left(m^{\max(0,j-s-1,\lfloor j/2\rfloor-1)}\right).$$

For $j\le d$, $d\ge3$ and $s=1,2$, the exponent is at most $d-1-s$. In $D_sB_{j,m}$, the Gaussian numerator contributes at most $2^j$ shifts of these same coefficients, all by nonnegative integers. The case $j=0$ contributes $(1-q)^s$. Summing proves (2).

For $j=b\ge5$ the inequality $\lfloor b/2\rfloor-1\le b-2-s$ holds for $s=1,2$. After subtracting the highest-order pole at $1$, the coefficient bound therefore improves by one power of $m$. For $0\le t\le(b+1)m$ this gives

$$[q^t]R_{b,s}(q)=\frac{t^{b-1-s}}{b!(b-1-s)!}+O_b(m^{b-2-s}).$$

For negative $t$ both the coefficient and the corresponding positive-part power are zero. Including the fixed staircase shift $b(b+1)/2$, a subset of $h$ Gaussian numerator factors contributes a shift $hm+O_b(1)$. Replacing the shifted positive-part power by $(n-hm)_+^{b-1-s}$ costs $O_b(m^{b-2-s})$, including when the shifted argument changes sign. The signed sum over subsets gives the displayed derivative $f_b^{(s)}$. The other summands, with $j\le b-1$, contribute $D_sA_{b-1,m}$ and are within the same error by (2). This proves (3).

Fix $0<\delta<1/4$ for the moment. When $n/m\le b/2+\delta$, every summand of (1) with $|H|>\lfloor b/2\rfloor$ has shift greater than $n$. Its first two backward differences at $n$ vanish. The remaining terms have $d=b-|H|\ge3$, which also holds when $b=5$. For each $h$ there are at most $\binom wh$ admissible $H$. Applying (2) at $n-\sum H$ when nonnegative, for $w\le\tau m$ and $0<\tau\le1$ we obtain

$$\big|D_s(F_\lambda-A_{b,m})(n)\big|
\le C_b\sum_{h=1}^{\lfloor b/2\rfloor}(\tau m)^h m^{b-h-1-s}
\le C'_b\tau m^{b-1-s}. \tag{4}$$

All constants here are independent of the locations of the large parts and of $m$.

## 3. Signs up to and around the peak

The densities are symmetric about $b/2$. For $j\ge3$ the convolution recursion gives

$$f'_j(x)=f_{j-1}(x)-f_{j-1}(x-1).$$

Since the triangular density $f_2$ is strictly increasing on $(0,1)$, induction using symmetry gives $f'_j(x)>0$ for $0<x<j/2$ and $f'_j(x)<0$ for $j/2<x<j$. Indeed, on the left half, $x$ lies closer to the center $(j-1)/2$ of $f_{j-1}$ than $x-1$ does. Here $f_{j-1}(x)>0$, and a point $x-1$ outside its support contributes zero. The right half follows by reflection. For $b\ge5$,

$$f_b''(b/2)=f'_{b-1}(b/2)-f'_{b-1}(b/2-1)<0.$$

Continuity gives $0<\delta<1/4$ such that $f_b''$ is bounded above by a strictly negative constant on $[b/2-\delta,b/2+\delta]$. Also $f_b'$ has a strictly positive minimum on $[1,b/2-\delta]$. Choose $\tau>0$ so small that the errors in (4), divided by $m^{b-1-s}$, are less than half the respective minima of $f_b'/b!$ and $-f_b''/b!$. By (3), after increasing $m$ sufficiently,

$$\begin{aligned}
D_1 F_\lambda(n)&>0 &&\text{if }1\le n/m\le b/2-\delta,\\
D_2 F_\lambda(n)&<0 &&\text{if }b/2-\delta\le n/m\le b/2+\delta. 
\end{aligned} \tag{5}$$

At weights $0\le n<m$ an injection from weight $n$ to $n+1$ sends a nonempty partition to the result of increasing its largest part by one. The new largest part is at most $n+1\le m$. For $n=0$ send the empty partition to $(1)$. This proves weak increase below the interval in (5).

## 4. Monotonicity beyond the middle of the ambient rectangle

Fix the number $j\ge1$ of positive parts, and form the real inner-product space $V$ with orthonormal basis $e_1,\ldots,e_L$. Define

$$Ue_i=\sqrt{i(L-i)}\,e_{i+1},\qquad De_i=\sqrt{(i-1)(L-i+1)}\,e_{i-1},$$

where the actions at the ends with coefficient zero are zero. The operators are adjoint and $(UD-DU)e_i=(2i-L-1)e_i$. Extend both to the $j$th exterior power by acting in turn on each factor and adding. In the orthonormal wedge basis the extensions are still adjoint. Actions on distinct factors cancel in the commutator, so on a basis wedge indexed by $S=\{i_1<\cdots<i_j\}$ of sum $n$ the commutator $UD-DU$ is scalar multiplication by $2n-j(L+1)$.

For any vector $v$ of this weight we have

$$\|Dv\|^2-\|Uv\|^2=(2n-j(L+1))\|v\|^2.$$

Thus $D$ is injective on the weight-$n$ space whenever $n>j(L+1)/2$. Each nonzero term of $D$ lowers a single part by one, and keeps all parts distinct and positive. A repeated part vanishes in the exterior power, and the coefficient at $i=1$ vanishes. Lowering an admissible subset in this way preserves all upper bounds $\lambda_i$. Hence $D$ restricts to an injection from the span of admissible $j$-subsets of weight $n$ into the corresponding span at weight $n-1$. Comparing dimensions and summing over $j\le b$, including the empty-set term, proves

$$D_1F_\lambda(n)\le0 \qquad\text{for every integer }n>b(L+1)/2. \tag{6}$$

Decrease $\tau$ if necessary so that $b\tau/2<\delta/2$. Then $b(L+1)/2<(b/2+\delta)m-1$ for all sufficiently large $m$. The strictly decreasing first differences in the second interval of (5) therefore overlap the nonpositive differences in (6). More explicitly, they are positive from $m$ through $\lfloor(b/2-\delta)m\rfloor$, with weak increase beforehand. Each subsequent first difference through $\lfloor(b/2+\delta)m\rfloor$ is strictly smaller than its predecessor, and every later one is nonpositive by (6). The coefficients can only rise and then fall. This completes the proof.

## Verification and scope

The manuscript proves existence of the shape and size thresholds for each fixed row count. It does not give numerical values of these thresholds. A search of later publications and public research repositories found no previous proof of Conjecture 15 in its full stated generality. This local manuscript has not undergone external peer review.

The following parts have been checked with Lean 4.19.0 and mathlib.

- The weight-preserving bijection for (1), for arbitrary row bounds and each rank, splits an admissible set of parts into its high and low subsets and reconstructs it by taking their union. [FlagSplit.lean](FlagSplit.lean)
- For five rows, the explicit truncated-power formulas in (3) satisfy $f'_5(x)\ge1/16$ on $[1,9/4]$ and $f''_5(x)\le-17/16$ on $[9/4,11/4]$. These bounds hold on the full real intervals. [FiveRowProfile.lean](FiveRowProfile.lean)
- Increasing and decreasing outer segments, together with nonpositive second differences in the middle, give unimodality. The file also verifies elementary injections at the two extreme ends and all 58 coefficients for $(14,13,11,10,9)$. The unique maximum is 146 at rank 34. [ShiftedUnimodality.lean](ShiftedUnimodality.lean)

The uniform asymptotic estimates in (2)–(4) and the exterior-power argument giving the full tail bound (6) are proved in the text. The complete theorem has yet to be formalized in Lean.

Two independent exact counting algorithms agree coefficient by coefficient for the five sample shapes in the accompanying script. For $(44,42,40,38)$ the counts at ranks 86, 87 and 88 are 2283, 2282 and 2288. This illustrates the failure at four rows. [check_shapes.py](check_shapes.py)
