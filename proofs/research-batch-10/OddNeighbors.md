# Density of fourteen exponentially odd neighbors of a square

[OEIS A400734](https://oeis.org/A400734) asks for the density of the positive integers $k$ such that all fourteen numbers $(4k+2)^2+d$, $0<|d|\le7$, have only odd exponents in their prime factorization. We prove the empirical density assertion and give an Euler product. The next numbers at offsets $\pm8$ both have 2-adic valuation two, so the stipulated runs have precisely length seven.

For a prime $p\ge5$ put
$$
R_p=\sum_{\substack{0<|d|\le7\\p\nmid d}}\left(1+\left(\frac{-d}{p}\right)\right).
$$
Then the natural density is
$$
\boxed{\displaystyle D=\frac7{27}\prod_{p\ge5}\left(1-\frac{R_p}{p(p+1)}\right).}
$$
In particular $0.08069356<D<0.08069403$.

**Local factors for odd primes.** Write $x=4k+2$. This change of variables preserves uniform residues modulo all odd prime powers. An offset is disallowed at $p$ precisely when the valuation is positive and even. If $p\ge5$ divides $d$, then it occurs in $d$ just once; thus $p^2$ never divides $x^2+d$. Otherwise there are $1+(-d/p)$ simple roots modulo $p$, each lifting uniquely to every higher prime power. The measure corresponding to one root and exact positive even valuation is
$$
\sum_{h\ge1}(p^{-2h}-p^{-2h-1})=1/(p(p+1)).
$$
Events for distinct offsets are disjoint for $p\ge5$, since their difference has absolute value at most $14<p^2$. This gives the product factor above. It is positive since $R_p\le28<p(p+1)$.

At $p=3$ we first fix $x\bmod9$. For $3\mid x$ no offset gives divisibility by 9. If $x^2\equiv1\bmod9$, only $d=-1$ can give even positive valuation; its conditional probability of being allowed is $1/4$, from the simple-root lifts at valuation $3,5,\ldots$. If $x^2\equiv4$ or $7\bmod9$, there are two offsets divisible by 9 whose difference is 9. At least one has valuation exactly two. The allowed 3-adic measure is $1/3+(2/9)(1/4)=7/18$.

**Local factor at two.** The odd offsets have valuation zero. Offsets $\pm2,\pm6$ have valuation one. The value at $+4$ has valuation three. At $-4$ we obtain $16k(k+1)$. Of $k,k+1$ precisely one is even; its valuation is $t\ge1$ with probability $2^{-t}$ under uniform residues. We require $t$ odd, of total measure $2/3$. The small-prime contribution is therefore $7/27$.

**Existence of the density.** On imposing just the primes up to $Y$, the density is the product of their local factors. Indeed, truncate the valuation tests at depth $h$ for every such prime. The resulting conditions are periodic and independent by the Chinese remainder theorem. The disagreement at the truncation boundary has density tending to zero as $h\to\infty$: each large-depth root condition has vanishing measure by the preceding counts.

For integers $1\le k\le X$, any additional prime obstruction satisfies $p^2\mid (4k+2)^2+d$, hence $p\le4X+3$. For $p>Y\ge7$ the fourteen polynomials give at most 28 classes modulo $p^2$. The number of integers discarded by primes beyond $Y$ is bounded by
$$
28X\sum_{p>Y}p^{-2}+28\pi(4X+3).
$$
On dividing by $X$, the second term tends to zero for fixed $Y$; the first is $O(1/Y)$. This justifies the infinite product and shows its value is the natural density. The product is positive since its factors are positive and the excluded masses have convergent sum.

**Certified interval.** [The verifier](odd_neighbors_density.py) uses quadratic reciprocity to evaluate $R_p$ and directed integer rounding with denominator $10^{20}$. For $Y=5000000$ it multiplies the finite lower bound by $1-28/(Y+1)$, since $\sum_{p>Y}R_p/[p(p+1)]\le28\sum_{n>Y}1/[n(n+1)]=28/(Y+1)$. The returned lower and upper numerators are $8069356973661851928$ and $8069402162305271612$. [Lean](OddNeighbors.lean) verifies the exceptional classes modulo 9 and the two identities for offsets $\pm4$; the sieve proof is written above.
