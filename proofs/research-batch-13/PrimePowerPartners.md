# A prime with no partner in a power-of-two sum

The prime $A=7629217$ has no prime partner $q$ for which $A+q$ is a power of two. This answers the first question in A401105 by applying a published covering. [OEIS A401105](https://oeis.org/A401105) · [Published covering and residue, INTEGERS 14 (2014), A65](https://math.colgate.edu/~integers/o65/o65.pdf)

Put $M=5592405$. Since $2^{24}\equiv1\pmod M$, only 24 exponent residues are needed. For every $i$ from 0 to 23, one of $d=3,7,5,17,13,241$ satisfies both $2^i\equiv A\pmod d$ and $2^i\not\equiv A+d\pmod M$. These 24 finite checks use the precise residue $A$ in both congruences. If $A+q=2^n$, the first congruence at $i=n\bmod24$ forces $d$ to divide $q$. A prime $q$ would equal $d$, contradicting the second congruence.

The same obstruction applies to any positive number congruent to $A$ modulo $M$. Lean verifies the primality of $A$, the period, all 24 checks and the contradiction. [Lean proof](PowerSumPartners.lean)
