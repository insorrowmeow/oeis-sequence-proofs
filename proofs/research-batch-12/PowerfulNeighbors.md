# Powerful numbers with six squarefree neighbors

Amiram Eldar recorded numerical evidence that the powerful numbers $n$ for which all six numbers $n\pm1,n\pm2,n\pm3$ are squarefree have relative density $0.226\ldots$ among the powerful numbers. We prove this limit exists, give a convergent series for it, and enclose it between $0.226723$ and $0.226943$. [OEIS A401306](https://oeis.org/A401306) · [Official export of November 26, 2026](https://github.com/oeis/oeisdata/blob/976b0c73e00453b1c1e6f16d83108cb9bb744c3b/seq/A401/A401306.seq)

**Decomposition.** Every powerful integer has a unique form $a^2b^3$ with $b$ squarefree. For each prime, write its exponent as an even number plus 3 if the exponent is odd. The exponents allowed in a powerful number are zero and the integers from 2 on, so the construction and its inverse are immediate. Put $D=\sum_{b\ {\rm squarefree}}b^{-3/2}=\zeta(3/2)/\zeta(3)$. The number of powerful integers at most $X$, divided by $\sqrt X$, tends to $D$ by summing $\lfloor\sqrt X/b^{3/2}\rfloor$ and applying dominated convergence.

For a fixed squarefree $b$, let $\rho_b(p)$ count the classes of $a$ modulo $p^2$ in which at least one of the six shifts of $b^3a^2$ vanishes modulo $p^2$. Set

$$
\delta_b=\prod_p\left(1-\frac{\rho_b(p)}{p^2}\right).
$$

The finite product over $p\le Y$ gives the density of the simultaneous conditions at these primes by the Chinese remainder theorem. For $a\le A$ large enough that the shifted values are positive, a bad prime has $p\le (b^{3/2}+2)A$. Each prime $p>Y\ge3$ contributes at most $12(A/p^2+1)$ such integers, by the root counts below. The fraction discarded by these primes is therefore at most

$$
12\sum_{p>Y}p^{-2} + \frac{12}{A}\,\pi((b^{3/2}+2)A).
$$

For fixed $b$ the second term tends to zero since $\pi(t)=o(t)$. Then send $Y$ to infinity. Discarding the finitely many centers with a nonpositive neighbor leaves the limit unchanged. Thus $\delta_b$ gives the density for this $b$. Another application of dominated convergence, with the same majorant $b^{-3/2}$, proves that the required relative density is

$$
\boxed{\displaystyle \frac{1}{D}\sum_{b\ {\rm squarefree}}\frac{\delta_b}{b^{3/2}}.}
$$

**Local factors.** At 2 the center must be zero modulo 4, giving factor 1 when $2\mid b$ and $1/2$ otherwise. At 3 the factor is 1 when $3\mid b$. For a unit $b$ its cube modulo 9 is $1$ or $-1$; precisely the four unit classes with square $1$ or $7$ modulo 9 cause a bad shift. The factor is $5/9$. [Lean verification of every small-prime case](PowerfulNeighbors.lean)

For $p\ge5$ dividing $b$ none of the six offsets is zero modulo $p^2$, so $\rho_b(p)=0$. Otherwise each equation $a^2=-h/b^3\bmod p^2$ for $h\in\{\pm1,\pm2,\pm3\}$ has $1+\chi_p(-hb)$ solutions, since roots modulo $p$ are simple. Distinct offsets give disjoint classes modulo $p^2$. Consequently

$$
\rho_b(p)=6+\chi_p(b)(1+\chi_p(-1))(1+\chi_p(2)+\chi_p(3)),
$$

where $\chi_p$ is the Legendre symbol. In particular $\rho_b(p)\le12$.

**Certified decimal bounds.** The verifier uses positive integer arithmetic and outward rounding for all summands and local products. For each squarefree $b\le 2400000$ it obtains bounds on $\delta_b$ from a finite prime product. The lower bound multiplies that product by $1-\sum_{p>y}12/p^2$, using a directed upper bound on the sum through $600000$ and $\sum_{m>P}m^{-2}\le1/P$ beyond it.

To control large $b$, write $e_b$ for the product of just the local factors at 2 and 3. Under the probability weights $b^{-3/2}/D$ on squarefree integers, divisibility by distinct primes is independent, with probabilities $t_p=1/(1+p^{3/2})$. This follows directly from the Euler product for $D$. Therefore $\mathbb E(e_b)=(1+t_2)(5+4t_3)/18$. The verifier sums a lower bound for $\delta_b$ over $b\le2400000$ to obtain the lower endpoint. For the upper endpoint it subtracts a lower bound for $e_b-\delta_b$ on the same range from $\mathbb E(e_b)$. Finally $D$ is bounded using decreasing-function integral estimates for the zeta series. The two endpoints printed in millionths are $226723$ and $226943$. [Reproducible integer verifier](powerful_neighbors.py)
