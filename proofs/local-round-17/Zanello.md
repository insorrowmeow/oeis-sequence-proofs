# Finite reductions and certificates for Zanello’s conjecture on Gaussian polynomials

Local research manuscript, 27 November 2026.

Let $P_{u,v}(q)={u+v\brack u}_q$ count partitions inside a $u$ by $v$ rectangle, graded by the number of cells. Given positive integers $a\le b\le c\le d$ with $ad=bc=N$, put $D=P_{b,c}-P_{a,d}$. Zanello conjectured that the coefficients of $D$ are nonnegative and unimodal. His paper proves the statement for $a\le3$. [Zanello, Conjecture 1.1, Proposition 2.2 and Theorem 2.4](https://arxiv.org/pdf/1709.06187)

**Theorem 1.** Zanello’s conjecture holds for every tuple with $a=4$. Section 2 gives a short proof using published results and five explicit computations. Every prime $a$ is already covered by the published divisibility theorem.

**Theorem 2.** For any $a$, write $g=\gcd(a,c)$. The conjecture holds whenever $bg\ge a^2$. For every fixed $a$, only finitely many tuples can fail. There is a terminating algorithm which, given $a$, returns the complete list of its exceptions, possibly empty.

**Theorem 3 (computer-assisted).** Zanello's conjecture holds whenever the smallest side satisfies $1\le a\le24$, for all admissible values of the other three sides. Section 3 reduces the claim to 138 pairs of heights. For 111 pairs an exact certificate uses the full Gaussian difference. For the other 27 pairs it uses centered terms in the KOH decomposition. The 2,749 admissible tuples below the certified thresholds were checked by exact integer arithmetic. Every larger width follows from the rational inequalities in the certificates. [Proof of the certificate method](Equal-area-certificate.md) · [Verification ledger](verification.txt)

## 1. Comparison via an intermediate rectangle

For two rectangles $R,S$ of area $N$, write $R\preceq S$ when $P_S-P_R$ has nonnegative coefficients and these weakly increase through degree $\lfloor N/2\rfloor$. Taking the rotated complement of a partition inside its rectangle proves symmetry on $0,\ldots,N$, including zero endpoints. Thus $\preceq$ expresses precisely the nonnegativity and unimodality in the conjecture. It is transitive because the coefficient sequences and their left-half first differences add.

Gangl, Gutiérrez and Szwej proved that $(u,v)\preceq(x,y)$ whenever $uv=xy$, $u=\min(u,v,x,y)$ and $u$ divides $x$ or $y$. Their coefficientwise result and their unimodality result apply to the same tuples. [Corollaries 1.5 and 1.6 and their proof](https://arxiv.org/pdf/2507.06220#page=7)

Set $g=\gcd(a,c)$ and $h=a/g$. Since $\gcd(h,c/g)=1$, the relation $a\mid bc$ implies $h\mid b$. Write $t=b/h$. The intermediate rectangle $(t,hc)$ has area $N$. If $bg\ge a^2$, then

$$
a\le t\le b\le c\le hc.
$$

The identity $hc=a(c/g)$ shows that $a$ divides the long side of the intermediate rectangle. Its short side $t$ divides $b$ by construction. Apply the cited divisibility theorem twice to obtain

$$
(a,d)\preceq(t,hc)\preceq(b,c).
$$

This proves the criterion. If $a$ is prime, $a\mid bc$ implies $a\mid b$ or $a\mid c$, so the published divisibility theorem applies directly.

## 2. The four-row case

Suppose $a=4$. If $4\mid b$ or $4\mid c$, the published divisibility theorem applies. Otherwise $4\mid bc$ forces $b\equiv c\equiv2\pmod4$. Here $g=\gcd(4,c)=2$. If $b\ge8$, Section 1 applies. With $4\le b<8$ and $b\equiv2\pmod4$, the only remaining possibility is $b=6$. Thus $c\ge6$ is congruent to $2$ modulo $4$, and $d=3c/2$.

Koutschan, Uncu and Wong proved that for every integer $\ell>25$ and every integer $0\le v\le3\ell/2$ the coefficient sequence of

$$
P_{6,\ell}(q)-q^{3\ell-2v}P_{4,v}(q)
$$

is unimodal, with one exception at $v=(3\ell-1)/2$ for odd $\ell$. Take $\ell=c$ and $v=3c/2$. The shift is zero and $c$ is even. Unimodality implies nonnegativity here because the difference has both endpoint coefficients equal to zero. This proves all remaining cases with $c>25$. [Koutschan, Uncu and Wong, Theorem 12](https://arxiv.org/pdf/2302.04067#page=7)

The five widths $c\le25$ are listed below. For a reproducible finite calculation, put $p_{j,w}(n)=[q^n]P_{j,w}(q)$ and extend by zero to negative indices and indices greater than $jw$. Starting from $p_{0,w}(n)=\mathbf 1_{n=0}$, compute rows of increasing $j$, and within each row use increasing $n$. The Gaussian product gives

$$
p_{j,w}(n)=p_{j,w}(n-j)+p_{j-1,w}(n)-p_{j-1,w}(n-w-j)
\qquad (j\ge1,\ 0\le n\le jw).
$$

For $e_n=p_{6,c}(n)-p_{4,d}(n)$, the table records the minimum over **all** $1\le n\le3c$. Since $e_0=0$, the minimum certifies nonnegativity and unimodality by symmetry.

| $c$ | $d$ | $e_{3c}$ | $\min(e_n-e_{n-1})$ |
|---:|---:|---:|---:|
| 6 | 9 | 15 | 0 |
| 10 | 15 | 188 | 0 |
| 14 | 21 | 880 | 0 |
| 18 | 27 | 2771 | 0 |
| 22 | 33 | 6951 | 0 |

This completes the proof of Theorem 1.

## 3. Reducing all widths to pairs of heights

Fix $a$. Say that a pair $(a,t)$ is settled if $(a,d)\preceq(t,s)$ for **every** $t\le s\le d$ with $ad=ts$. Suppose some settled $t$ satisfies $a\le t<b$ and $t\mid b$ or $t\mid c$. Write $s=bc/t$. We have $t\le b\le c\le s\le d$. The settled pair and the divisibility theorem give $(a,d)\preceq(t,s)\preceq(b,c)$.

Apply strong induction on $b$. Direct divisibility disposes of $a\mid b$ and $a\mid c$, including the equality case. Section 1 disposes of $b\gcd(a,c)\ge a^2$. If some proper divisor $t$ of $b$ satisfies $a\le t<b$, its pair is settled by induction, so the preceding argument applies. Thus a sufficient list of height pairs needing independent proofs can be obtained by retaining only

$$
a<b<a^2,\qquad 1<\gcd(a,b)<a,\qquad
\text{every proper positive divisor of } b \text{ is smaller than }a. \tag{1}
$$

Indeed $\gcd(a,b)=1$ forces $a\mid c$. One can discard further widths in (1) by Section 1 or by a divisor of $c$ between $a$ and $b$. Certifying all admissible widths for each retained pair is also valid.

For example, at $a=6$ the remaining heights are $b=8,9,10,15$. If $b=8,10$, direct divisibility leaves $c\equiv3\pmod6$. For $b=9,15$ it leaves $c\equiv2,4\pmod6$. A separate calculation using Zeilberger’s KOH identity handles these four heights over every width and supplies an independent check of the six-row result. [Six-row KOH proof and certificate](Six-row-KOH.md)

The divisibility theorem alone does not exhaust the comparisons for unbounded $a$. To see the obstruction, take consecutive odd primes $p<q<2p$ and a prime $r>2q$, and choose $(a,b,c,d)=(2p,2q,pr,qr)$. No divisor of $2pqr$ lies strictly between $2p$ and $2q$. Moreover $2p$ divides neither $2q$ nor $pr$. Thus transitivity admits no intermediate rectangle at this area to which the divisibility theorem applies. These tuples illustrate a limitation of the reduction and are not counterexamples to the conjecture.

## 4. A terminating decision procedure for each fixed smallest side

Finiteness already follows from the fixed-height theorem in our earlier manuscript. For $a\ge4$, Section 1 handles every $b\ge a^2$. For the finitely many remaining $b>a$ take $k=b$, $W=c$, smaller height $a$, smaller width $d=bc/a$ and shift $s=0$ in that theorem. Each fixed $b$ leaves only finitely many exceptional $c$. The known cases handle smaller $a$. [Fixed-height proof, Section 4](../local-round-16/Gaussian-differences.md#4-a-consequence-for-every-smaller-rectangle-height)

The following argument makes the reduction effective. To enumerate every actual exception, use **all** $a<b<a^2$, not just (1). If a smaller pair fails, its failure alone does not decide the larger pairs which strong induction would otherwise have settled. For each $b$ in this finite range we find a width threshold and check every admissible smaller width exactly.

Let $\Delta^t P(n)=[q^n](1-q)^tP(q)$, $x=n/c$, and $g_b$ be the density of a sum of $b$ independent uniform variables on $[0,1]$. Use $t=1$ with sign $+1$ on $[1,b/2-1/4]$ and $t=2$ with sign $-1$ on $[b/2-1/4,b/2+1/4]$. The function $g_b'$ is strictly positive on the former interval. On the latter interval the identity $g_b''(x)=g'_{b-1}(x)-g'_{b-1}(x-1)$ gives strict negativity, since $x$ is strictly to the right of $(b-1)/2$ and $x-1$ to its left, both inside $(0,b-1)$. Both sign-corrected derivatives attain positive minima on their respective compact intervals. The displayed convolution identity and strict increase of $g_j$ up to its center are proved in Section 3 of the preceding manuscript.

On each of the finitely many rational subintervals cut out by Gaussian numerator shifts, the partial-fraction construction gives a computable lower polynomial

$$
L(c,x)=\sum_{i=0}^{m} A_i(x)c^i,\qquad
m=b-1-t,\qquad
A_m(x)=\frac{\operatorname{sign}\,g_b^{(t)}(x)}{b!}.
$$

Here $\operatorname{sign}$ denotes the chosen multiplier $+1$ or $-1$. To obtain the lower bound, use the exact polynomial from the pole at $q=1$, subtract absolute polynomial bounds for the waves at the other roots of unity, and account for the finitely many negative arguments created by shifting across a numerator knot. All denominator roots have known finite order. Their waves can be computed with rational polynomial arithmetic on residue classes. At height $b\ge5$ the degrees of the nonprincipal waves are at most $\lfloor b/2\rfloor-1<m$. At smaller height $a<b$ the degrees are at most $\max(a-1-t,\lfloor a/2\rfloor-1)<m$. The bounded knot corrections have smaller degree as well. This proves the leading coefficient formula including either endpoint of a chamber, where the leading positive-part powers agree. The details of the lower bound are given in the certificate note. [Equal-area certificate](Equal-area-certificate.md) · [Fixed-height estimates, Section 2](../local-round-16/Gaussian-differences.md#2-uniform-estimates-for-the-two-rectangles)

Set $c=T+z$. The coefficient of $z^k$ in $L(T+z,x)$ is the computable polynomial

$$
B_{k,T}(x)=\sum_{i=k}^{m}\binom{i}{k}T^{i-k}A_i(x).
$$

After division by $T^{m-k}$ it converges uniformly, on the given compact interval, to $\binom{m}{k}A_m(x)>0$. Hence for all sufficiently large integers $T$, every $B_{k,T}$ is strictly positive throughout each chamber. There are only finitely many $k,t$ and chambers. Positivity itself admits a finite rational certificate. On a subinterval $[l,l+w]$ expand the fixed polynomial at $l$. All power coefficients of $B_{k,T}(l+wu)$ except the constant tend uniformly to zero with $w$. Therefore its Bernstein controls all tend uniformly to $B_{k,T}(l)$ as the mesh tends to zero. A positive minimum guarantees that dyadic subdivision eventually yields positive controls everywhere. Alternatively, exact univariate real-root isolation decides positivity on the closed rational interval directly.

An algorithm can try $T=4,8,16,\ldots$ using exact polynomial positivity tests at each stage until the signs are certified. We may require $T\ge8$ so that the center and its adjacent index are in the central interval. For $n\le c$, including the parts $\{2,\ldots,a\}$ in $\{2,\ldots,b\}$ proves the left-half first-difference inequality directly. For the central ranks, negative second differences and symmetry force positive first differences through $\lfloor bc/2\rfloor$ in both parities. The first-derivative interval supplies the ranks in between. This proves the conjecture for all $c\ge T$ for this $(a,b)$. The finite head is then computed by a Gaussian recurrence and gives the exact list of exceptional widths. The algorithm terminates for each input $a$. The command `python verify_equal_area.py --exceptions A` implements this decision procedure for a specified positive integer A. It enumerates threshold and subdivision-depth pairs diagonally, so it eventually reaches a successful certificate. It can skip pairs already settled directly by divisibility, independently of the outcome for any other pair. The bounded run used for Theorem 3 uses the stronger inductive reduction and selected cutoffs for speed.

## 5. Attribution and verification

Zanello proved the cases $a\le3$. Gangl, Gutiérrez and Szwej established the divisibility comparisons used here, which already imply the conjecture for every prime $a$. Their Proposition 3.2 also uses an auxiliary rectangle to establish coefficientwise positivity under unequal-area hypotheses. Koutschan, Uncu and Wong’s six-row centered-difference theorem gives the large-width input for our direct four-row proof. [Zanello](https://arxiv.org/pdf/1709.06187) · [Gangl, Gutiérrez and Szwej, Section 3](https://arxiv.org/pdf/2507.06220#page=7) · [Koutschan, Uncu and Wong, Theorem 12](https://arxiv.org/pdf/2302.04067#page=7)

A 2026 preprint by Phan claims the full positivity theorem proposed by Troyka. Its Theorem B already gives a fixed-$a$ reduction to finitely many exceptions for **coefficientwise positivity**. Section 8.6 explains the obstacle to extending its method to unimodality. Ashfaque’s 2026 note proves an asymptotic estimate for the specialization $q=1$ and poses unimodality as Conjecture 3.1. A literature search through 27 November 2026 found no earlier source establishing the finite-exceptions result for **unimodality** at each fixed $a$, or the claimed all-width coverage for the composite heights through 24. This search establishes no claim of priority. [Phan, Theorem B and Section 8.6](https://hexagonmath.org/pdf/2610.00579v1#page=15) · [Ashfaque, Conjecture 3.1](https://www.researchgate.net/publication/408519704_ASYMPTOTIC_GAPS_AND_POLYNOMIAL_UNIMODALITY_IN_BERGERON%27S_BINOMIAL_CONJECTURE)

The Lean files prove the comparison arithmetic, transitivity, the strong-induction reduction, the full lists of remaining pairs through 24, five explicit four-row examples, and general lemmas for threshold translation and positivity in the Bernstein basis. A third file checks cancellation of the line factor in the retained KOH summand, its symmetry with the stated parameters, and the central first-difference argument in both parities. Their deduction of the four-row case uses the published theorems as hypotheses. The finite-exceptions implication uses the fixed-height result as a hypothesis. The exact Python certificates evaluate the root-of-unity bounds and the remaining finite widths. The full computational deduction and the partial-fraction computations have not been formalized end to end in Lean. [Comparisons and finite examples](Zanello.lean) · [Bernstein lemmas](Bernstein.lean) · [KOH and central differences](KohCenter.lean) · [Exact certificate program](verify_equal_area.py)

To replay the certificate ledger, install the Python package `python-flint` in your Python environment. From this proof directory, run `python verify_equal_area.py --replay verification.txt`.
