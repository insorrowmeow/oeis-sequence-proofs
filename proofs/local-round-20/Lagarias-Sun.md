# The limiting correction for reciprocal supernorms of partitions of bounded perimeter

Local research note, 27 November 2026

Jeffrey C. Lagarias and Chenyang Sun proved that the total reciprocal supernorm of partitions of perimeter at most $n$ is $e^\gamma(\log n+\log\log n)+O(1)$. Immediately after Theorem 3.3 they suggested that the bounded correction might converge to a negative constant. It converges to **zero**. We also determine the asymptotic cost of restricting the perimeter when the largest part is already at most $n$. [Original paper, *Ramanujan J.* 65 (2024), 487–520, §3.2.3](https://doi.org/10.1007/s11139-024-00893-8)

## Statement

Let $p_j$ be the $j$-th prime, starting at $p_1=2$. For a nonempty partition $\lambda=(\lambda_1,\ldots,\lambda_k)$ in decreasing order, write $w(\lambda)=\prod_i p_{\lambda_i}^{-1}$ and $\operatorname{per}(\lambda)=\lambda_1+k-1$. Give the empty partition weight one, perimeter one and maximum zero, as in §2 of the paper. Write $C_{\rm per}(n)$ and $C_{\max}(n)$ for the sums of $w$ over partitions with perimeter and maximum at most $n$, respectively. Hats on supernorm statistics are suppressed in this note.

**Theorem.** As $n\to\infty$ through all positive integers,

$$
 C_{\rm per}(n)-e^\gamma(\log n+\log\log n)\longrightarrow 0,
 \qquad
 C_{\max}(n)-C_{\rm per}(n)
 \sim \frac{e^\gamma\log\log n}{n}.
$$

The first assertion determines the constant asked about in the authors' remark. The second determines the smaller difference between two ensembles. These are distinct errors.

**Why the empty partition matters.** Section 2 explicitly includes the empty partition and assigns it perimeter one. If one instead sums only over nonempty partitions, the cumulative statistic decreases by exactly one at every $n\ge1$, so the limiting correction is **$-1$**. Equation (2.3) in the same paper counts $2^{n-1}$ partitions of perimeter $n$. At $n=1$ this count is correct for nonempty partitions, whereas the explicit convention gives both $(1)$ and $\varnothing$. Reporting both constants resolves the normalization issue without any assumption about how the figures were computed. The difference $C_{\max}-C_{\rm per}$ is identical under consistent inclusion or omission of the empty partition.

## A short proof of the limiting constant

For $m\ge0$ and $0\le z<2$, put

$$
 H_m(z)=\prod_{j=1}^m(1-z/p_j)^{-1}=\sum_{\ell\ge0}h_{m,\ell}z^\ell.
$$

The coefficient $h_{m,\ell}$ is the total weight of all partitions with $\ell$ parts in $\{1,\ldots,m\}$, by the geometric series for each part multiplicity. In particular $H_m(1)=C_{\max}(m)$. The coefficients are nonnegative and nondecreasing in $m$.

Set $R=3/2$. Since $p_j\ge j+1$ for $j\ge1$,

$$
 (1-R/p_j)^{-1}\le\frac{j+1}{j-1/2}\le \frac{(j+1)^2}{j^2}.
$$

The last inequality reduces to $j\ge1$. The product telescopes to give $H_m(R)\le(m+1)^2$. Hence for $t\ge0$,

$$
 T_m(t):=\sum_{\ell>t}h_{m,\ell}\le R^{-t}H_m(R).
 \tag{1}
$$

Take $L=\lfloor\sqrt n\rfloor$, $M=n-L$ and $E_n=(n+1)^2R^{-L}$. All partitions with maximum at most $M$ and length at most $L$ have perimeter at most $n$ for $n\ge2$. Every partition of perimeter at most $n$ has maximum at most $n$. Including the empty partition at both ends gives

$$
 H_M(1)-E_n\le C_{\rm per}(n)\le H_n(1).
 \tag{2}
$$

Theorem 3.2 of Lagarias and Sun gives $H_m(1)=e^\gamma(\log m+\log\log m)+o(1)$. Since $M/n\to1$, both $\log M-\log n$ and $\log\log M-\log\log n$ tend to zero. Also $E_n\to0$. Subtract $e^\gamma(\log n+\log\log n)$ throughout (2) to obtain the first assertion. In particular, the authors' informal prediction of a strictly negative limiting value is false.

## The sharper boundary asymptotic

For $n\ge1$ the empty partition cancels from $C_{\max}(n)-C_{\rm per}(n)$. A partition with largest part $m\le n$ falls outside the perimeter bound just when deleting one copy of $m$ leaves more than $n-m$ parts. Conversely one can prepend $m$ to every such remainder with parts at most $m$. This operation is bijective even when the largest part is repeated. Therefore

$$
 G_n:=C_{\max}(n)-C_{\rm per}(n)=
 \sum_{t=0}^{n-1}\frac{T_{n-t}(t)}{p_{n-t}}.
 \tag{3}
$$

Let $D_m=\sum_{t\ge0}T_m(t)$. By nonnegativity we can sum first over lengths, and the finite Euler product is analytic near $z=1$. Thus

$$
 D_m=\sum_{\ell\ge1}\ell h_{m,\ell}=H_m'(1)
     =H_m(1)\sum_{j\le m}\frac{1}{p_j-1}.
$$

For $0\le t\le L$, the summand in (3) lies between $T_M(t)/p_n$ and $T_n(t)/p_M$. By (1), for every $m\le n$,
$\sum_{t>L}T_m(t)\le E_n/(R-1)=2E_n$.
The same bound controls a sum with varying $m=n-t$, term by term. Since $p_j\ge2$, extending the two end sums gives

$$
 D_M/p_n-2E_n\le G_n\le D_n/p_M+2E_n.
 \tag{4}
$$

The prime number theorem gives $p_j\sim j\log j$. Comparing the divergent positive sums with $\sum_{2\le j\le m}1/(j\log j)$ gives $\sum_{j\le m}(p_j-1)^{-1}\sim\log\log m$. With $H_m(1)\sim e^\gamma\log m$, both main terms in (4) are asymptotic to $e^\gamma\log\log n/n$. The error $E_n$ is smaller than every fixed inverse power of $n$. This proves the second assertion.

An elementary alternative used in the Lean proof avoids a separate prime-sum estimate. At $q=1/p_j$, the difference $q/(1-q)+\log(1-q)$ lies between zero and $q^2/(1-q)$, by integrating $1/(1-x)$ on $[0,q]$. Its upper bound is at most $1/[j(j+1)]$. Summing shows that $\sum_{j\le m}1/(p_j-1)-\log H_m(1)$ lies in $[0,1]$, which gives the same equivalent.

## The correction eventually has positive sign

Write $x=\log n,\ y=\log\log n$. The classical expansion for the $n$-th prime gives $p_n/n=x+y-1+O(y/x)$. Taking logs and expanding $\log(1+u)$ at zero yields $\log p_n=x+y+(y-1)/x+O(y^2/x^2)$. [Axler, *New Estimates for the nth Prime Number*, equation (1.2)](https://cs.uwaterloo.ca/journals/JIS/VOL22/Axler/axler17.pdf)

By Lemma 4.3(2) in the original paper, $H_n(1)=e^\gamma\log p_n+O(1/x^2)$. The loss $G_n=O(y/n)$ from (4) is smaller than $1/x^2$. Hence
$$
 C_{\rm per}(n)-e^\gamma(x+y)
 =e^\gamma\,\frac{y-1}{x}+O\!\left(\frac{y^2}{x^2}\right)
 \sim e^\gamma\,\frac{\log\log n}{\log n}.
$$
In particular, the remainder approaches zero from above for all sufficiently large $n$. This sign conclusion uses the sharper input on primes. The short proof of a zero limit only uses the authors' Theorem 3.2.

## The exact-perimeter statistic

The same coefficients yield an independent proof of numbered Conjecture 3.6, equation (3.17). Let $W_{\rm per}(n)$ denote the weight of partitions of perimeter exactly $n$. For $n\ge2$, deleting one largest part leaves exactly $\ell=n-m$ parts and gives

$$
 W_{\rm per}(n)=\sum_{\ell=0}^{n-1} h_{n-\ell,\ell}/p_{n-\ell}.
$$

On $0\le\ell\le L$, monotonicity puts each term between $h_{M,\ell}/p_n$ and $h_{n,\ell}/p_M$. For larger $\ell$, (1) bounds the entire omitted weight by $E_n$. Consequently

$$
 H_M(1)/p_n-E_n\le W_{\rm per}(n)\le H_n(1)/p_M+E_n.
$$

Multiply by $n$ and use $nE_n\to0$, $M/n\to1$, $p_n\sim n\log n$ and $H_n(1)\sim e^\gamma\log n$. Both bounds tend to $e^\gamma$.

### Prior claim for the exact-perimeter limit

Haobo Ma and Wenlin Zhang give a proof of Conjecture 3.6 using length truncation in §3 of their preprint. The exact-perimeter proof above is recorded as an independent derivation. Their paper treats the pointwise limit and several extensions. A reading of the full text and a targeted literature search on 27 November 2026 did not locate either of the two cumulative conclusions in the theorem above. [Ma and Zhang, *The Lagarias–Sun size and perimeter conjectures for reciprocal supernorms*](https://doi.org/10.5281/zenodo.24578337) · [Public formalization request](https://github.com/the-omega-institute/trureturing-requests/issues/717)

## Reproducing the formal and numerical checks

Run `python check_lean.py` from this directory using the local bundled toolchain, or `lake env python /path/to/check_lean.py` in a project with mathlib v4.19.0. The script compiles the local modules in dependency order. Run `python verify_weights.py` for independent rational-arithmetic checks of the coefficient, cumulative and gap identities for every $1\le n\le16$.

The final declarations in `PrimePerimeter.lean` use the actual sequence of primes and finite sets of weakly decreasing lists of positive parts. The constant `eulerGamma` uses the defining limit of mathlib's Euler–Mascheroni constant.

| Declaration | Result checked by Lean | Classical input supplied as a hypothesis |
| --- | --- | --- |
| `correction_zero` | Cumulative remainder tends to zero with the paper's empty partition | Theorem 3.2 in its additive $o(1)$ form |
| `correction_nonempty` | Cumulative remainder tends to $-1$ after erasing the empty partition | Same |
| `boundary_gap_limit` | $n(C_{\max}-C_{\rm per})/\log\log n\to e^\gamma$ | $p_n/(n\log n)\to1$ and $H_n(1)/\log n\to e^\gamma$ |
| `correction_positive` | The normalized remainder tends to $e^\gamma$ and the remainder is eventually positive | $p_n/n-\log n-\log\log n\to-1$ and $\lvert H_n(1)-e^\gamma\log p_n\rvert=O(1/\log^2 n)$ |
| `literal_perimeter_limit` | $nW_{\rm per}(n)\to e^\gamma$ on the literal partition set | Same two first-order estimates as `boundary_gap_limit` |

All twelve local Lean modules passed a fresh rebuild with Lean 4.19.0 on 27 November 2026. The final declarations report only `propext`, `Classical.choice` and `Quot.sound`. The proofs discharge the length truncations, partition identifications, moments, finite inequalities and limit transitions internally. The explicit prime estimates are external published theorems. The finer error term displaying $y-1$ in the numerator and the [supplementary ordinary-norm estimate](Ordinary-norm.md) are written proofs.
