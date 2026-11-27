# The critical modulus for fixed-perimeter partition differences

Local research note, 27 November 2026

## Question

The perimeter of a nonempty partition is its largest part plus its number of parts minus one. Write $h_d^{(a)}(n)$ for the number of partitions of perimeter $n$ whose parts are at least $a$ and whose consecutive parts differ by at least $d$. Write $\ell_m^{(u,v)}(n)$ for the number of partitions of perimeter $n$ whose parts belong to the two residue classes $u,v$ modulo $m$, with $m$ representing residue zero.

Gray, Payne, Swisher and Watson ask what becomes of the difference of these counts at $m=2d+2$ when the pairs of residues cross. Proposition 1.6 settles the componentwise comparisons. The critical question appears in the paragraph after that proposition. The separately numbered Conjecture 1.5 concerns the two strict inequalities for the modulus. [Authors' question and previous cases](https://arxiv.org/html/2502.12394v1#S1.SS5)

## Theorem

Put $s=d+1\ge2$, $1\le a\le s$ and $1\le u<v\le 2s$. Let $r$ be the unique root of $r+r^s=1$ in $(0,1)$, and define

$$
D_n=h_{s-1}^{(a)}(n)-\ell_{2s}^{(u,v)}(n),\qquad
J=2r^{a+s}-r^{u+s}-r^v .
$$

* If $(u,v)=(a,a+s)$, then $D_n=0$ for every $n$.
* In every other case $J\ne0$. If $J>0$, then $D_n\to+\infty$. If $J<0$, then $D_n\to-\infty$.

More precisely, in all cases,

$$
 \lim_{n\to\infty} r^n D_n =
 \frac{J}{2r^{s+1}(1+s r^{s-1})}.
$$

This is an effective three-way classification. Test the aligned pair first. Otherwise bisect $x^s+x-1$ on $[0,1]$ and bound each power in $J$ by its values at the interval endpoints. Those rational bounds eventually exclude zero, because $J\ne0$. Equivalently, for fixed $s,u,v$, compare $a$ with the real threshold $\log((r^{u+s}+r^v)/2)/\log r-s$. Below this threshold the difference tends to $+\infty$ and above it to $-\infty$.

## Proof

**1. Generating functions.** A gap partition with $j+1$ parts, written in increasing order, is specified by $j+1$ nonnegative excesses. The first excess is the smallest part minus $a$, and the rest are successive differences minus $s-1$. The perimeter is $a+sj$ plus the sum of the excesses. Its generating function at fixed $j$ is therefore $z^{a+sj}/(1-z)^{j+1}$.

For the two residue classes, fix the largest part $w$ and remove one copy of it. The remaining multiplicities of all allowed sizes up to $w$ are free. Each added part increases the perimeter by one. For $w=u+2sj$ there are $2j+1$ such sizes, and for $w=v+2sj$ there are $2j+2$. Summing the resulting geometric series gives

$$
 H(z)=\frac{z^a}{1-z-z^s},\qquad
 L(z)=\frac{z^u(1-z)+z^v}{(1-z)^2-z^{2s}}.
$$

These are also equations (4.4) at $y=1$ and (5.2) at $m=2s$ in the source. [Gray et al.](https://arxiv.org/html/2502.12394v1)

Set $B=(1-z-z^s)(1-z+z^s)$ and $A=z^a(1-z+z^s)-z^u(1-z)-z^v$. Then $H-L=A/B$. For the aligned pair $A$ vanishes identically.

**2. Dominant root.** Strict monotonicity of $x^s+x$ on $[0,1]$ gives existence and uniqueness of $r$. Any complex zero $z$ of $B$ with $|z|\le r$ satisfies

$$
 1-|z|\le |1-z|=|z|^s\le r^s=1-r\le1-|z|.
$$

Thus $|z|=r$ and equality in the reverse triangle inequality forces $z=r$. The zero is simple, since $B'(r)=-2r^s(1+s r^{s-1})$. Also $A(r)=J$. Subtracting $C/(1-z/r)$ with $C=-A(r)/(rB'(r))$ removes the singularity at $r$. The remainder is analytic on a closed disk of some radius $R>r$, since a polynomial has only finitely many zeros. Cauchy's estimate gives $D_n=C r^{-n}+O(R^{-n})$, including the case $C=0$. This yields the stated normalized limit. Shivam Patel previously gave the dominant-pole comparison and this critical asymptotic for $J\ne0$. [Patel's solution](https://mathdb.com/p/367166/fixed-perimeter-tipping-point-conjecture-for-two-residue-cla)

**3. Degree of the positive root.** Let $P$ be the monic minimal polynomial of $r$ over the rationals, and put $f=X^s+X-1$. Since $r$ is an algebraic integer, $P$ has integer coefficients and divides $f$ in $\mathbb Z[X]$. We need only $2\deg P>s$.

For even $s$, substituting $-X$ into $X^s-X-1$ gives $f$, which is irreducible by Selmer's Theorem 1. For odd $s$, substitute $-X$ into $X^s+X+1$ and change the overall sign. By the same theorem this is irreducible unless $s\equiv5\pmod6$, when it is the product of $X^2-X+1$ and one irreducible factor of degree $s-2$. The quadratic has no real root. Thus $\deg P=s$ or $\deg P=s-2$ with $s\ge5$, as required. The Lean proof obtains the same bound directly from the reciprocal-factor rigidity of an integer unit trinomial. [Selmer, Theorem 1](https://doi.org/10.7146/math.scand.a-10478)

**4. The short-power obstruction.** There are no integers $0<k<s$ and $h\ge0$ with $1+r^k=2r^h$. Indeed, such an equality would give $P\mid X^k+1-2X^h$. Reduce this and $P\mid f$ modulo two. The reduction $M$ of $P$ is monic of the same degree $e$, so in $\mathbb F_2[X]$

$$
 M\mid X^s+X+1,\qquad M\mid X^k+1,\qquad 2e>s.
$$

In particular $e\le k$, and subtracting $X^{s-k}(X^k+1)$ from the first dividend gives $M\mid X+1-X^{s-k}$. This last polynomial has constant coefficient one. Its degree is at most $\max(1,s-k)<e$, since $e>s/2$, $e\le k$, and $s\ge2$. This contradiction proves the obstruction.

**5. All equality cases.** Suppose $J=0$. Set $b=u+s,\ c=v,\ t=a+s$. If $b\ne c$, the strict monotonicity of $r^x$ puts $t$ strictly between $b,c$. The separation $k=|b-c|=|s-(v-u)|$ satisfies $0<k<s$ because $1\le v-u\le2s-1$. Dividing $r^b+r^c=2r^t$ by $r^{\min(b,c)}$ contradicts Step 4. Thus $b=c$, and then $t=b=c$, giving exactly $u=a,\ v=a+s$. Together with Steps 1 and 2 this proves every case.

## A change of one residue reverses the limit

Take $s=4,\ d=3,\ a=2,\ u=1$. The componentwise comparison in Proposition 1.6 covers neither row. Using $r+r^4=1$, the scores factor as $-r^5(1-r)^2$ for $v=7$ and $r^7(1-r)(1-r^2)$ for $v=8$. Their signs follow immediately from $0<r<1$. The last column gives the actual difference at one finite perimeter. [Lean proof of both limits](Examples.lean)

| Residues modulo 8 | Limit of the difference | $D_{100}$ |
|---|---:|---:|
| 1 and 7 | $-\infty$ | −1,493,783,971,861 |
| 1 and 8 (zero modulo 8) | $+\infty$ | +1,352,136,545,454 |

## Computational cross-check

Run **python verify_critical.py**. Literal enumeration through perimeter 14 agrees with both generating functions for all 2,387 parameter tuples with $2\le s\le8$. Rational interval isolation for $2\le s\le20$ gives 46,738 negative cases, 209 equalities and 38,382 positive cases. Of the strictly crossing pairs, 16,148 give a negative sign and 7,792 a positive one. The proof above applies for unbounded $s,n$.

## Lean verification

The end-to-end theorems are **partition_count_limit** and **partition_count_classification**. They start from cardinalities of finite sets of actual partitions. The first proves the normalized limit above. The second characterizes equality at every perimeter and proves divergence with the indicated sign in both remaining cases, including $a=d+1$. [Complete.lean](Complete.lean)

The gap count uses increasing tuples of parts, with a verified bijection to multisets of slack units. The residue count uses an allowed largest part and a multiset of actual additional positive parts. The formal proof derives the generating functions from these counts. [Gap partitions](GapPartitions.lean) · [Residue partitions](ResiduePartitions.lean) · [Coefficient identities](Counting.lean)

For the algebraic step the formal proof factors $f=PQ$. Reciprocal rigidity of a unit trinomial gives $P\mid f^*$ or $Q\mid f^*$, where $f^*=1+X^{s-1}-X^s$. In the first case $P$ would divide $(X-1)f+Xf^*=X^2-X+1$, impossible at the real root $r$. In the second case $Q$ divides that quadratic, so $\deg Q\le2$, sufficient when $s\ge5$. For $s=2,3,4$ the formal proof carries out the short polynomial divisions separately. Hence the degree bound in Step 3 is also proved inside Lean. The rigidity argument adapts Thomas Browning's mathlib proof for unit trinomials under the Apache 2.0 license. [Rigidity](Rigidity.lean) · [Degree bound](Degree.lean) · [License for adapted mathlib code](LICENSE.mathlib)

To reproduce the kernel check, run **python check_lean.py** in this directory inside the pinned Lake environment, or run **lake env python /path/to/check_lean.py** from a mathlib v4.19.0 project with its dependencies built. The checker reports the axioms used by the main theorems. The analytic proof treats repeated roots outside the dominant disk by factoring over $\mathbb C$ and proving convergence of the resulting power-series products. [Coefficient transfer](Transfer.lean) · [Specialization to the critical denominator](DiskFactors.lean)
