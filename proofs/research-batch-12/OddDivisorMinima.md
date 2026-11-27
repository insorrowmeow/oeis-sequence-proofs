# Columns one and three for the symmetric divisor-sum triangle

Write $M_i$ for the least positive odd integer with exactly $i$ divisors, and $T(i,k)$ for the smallest integer with $i$ odd divisors whose divisor list splits into $k$ blocks at the adjacent ratios strictly greater than 2. We use the block definition in [A400412](https://oeis.org/A400412), equivalent to the symmetric representation in [Höft's A384704](https://oeis.org/A384704). The two entries use different missing-value conventions but the minima here exist. The $M_i$ are [A038547](https://oeis.org/A038547).

**Theorem.** For all $i>1$, $T(i,1)=2M_i$. For every composite $i\ne8$, as well as $i=3$, $T(i,3)=M_i$. At $i=8$ the values are $M_8=105,\ T(8,1)=210,\ T(8,3)=135$. In particular $T(i,1)/2$ is odd and the proposed relation $T(i,1)=2T(i,3)$ holds throughout its specified range.

The factorization of $M_i$ uses consecutive odd primes starting at 3 and has nonincreasing exponents on them. Replacing a prime with a missing smaller odd prime or transferring the larger of two exponents to the smaller prime preserves the divisor count and strictly decreases the number. For composite $i=ab$ with $a,b\ge2$, $M_i$ has at least two prime factors: $3^{a-1}5^{b-1}$ is smaller than the best single prime power $3^{ab-1}$ since $5<3^a$.

Say that a sorted list joins at ratio $L$ if each successive ratio is at most $L$. Two such lists with overlapping endpoint intervals, or with an endpoint gap of ratio at most $L$, join at ratio $L$ in their sorted union. Indeed the intervals $[d,Ld]$ for one list cover the full interval from its least term to $L$ times its largest. Adding any points between the joint extremes preserves this property.

**One block.** Construct $M_i$ by successively adjoining its prime factors in nondecreasing order. The divisor lists for $m$ and $pm$ obey $D(pm)=D(m)\cup pD(m)$, even when $p\mid m$. For the first step $p=3$; on each later step either $p$ is repeated or it is the next prime after the current largest prime $q$. Bertrand's postulate gives $p<2q$ in the latter case. In particular $p\le 3m$ at every step, so the two translated lists join at ratio 3 by induction. It follows that $D(M_i)\cup 2D(M_i)=D(2M_i)$ joins at ratio 2: every $[d,4d]$ is covered by $[d,2d]$ and $[2d,4d]$, and successive odd divisors differ by a factor at most 3. A single block is impossible for any odd integer greater than 1 because of its first nonunit divisor. Every even integer with $i$ odd divisors is at least $2M_i$. This proves the first formula.

**Three blocks.** Call the divisors of $m$ other than $1,m$ its inner divisors. If 3 is the smallest prime factor, their endpoints are $3,m/3$. When these divisors join at ratio 2, they form a single middle block, with the two outer divisors isolated.

Suppose the inner divisors of $m$ join at ratio 2 and $p$ is an odd prime, $3\le p\le 2m/9$. The old inner divisors and their $p$-multiples join, since the second list begins at $3p\le2(m/3)$. Their joint endpoints are $3,pm/3$. The only other possible inner divisors of $pm$ are $p,m$, and both lie between those endpoints. This proves the induction step.

The inner divisors join directly for $15,\ 45,\ 1155=3\cdot5\cdot7\cdot11$. For 1155 the list is
$$
 3,5,7,11,15,21,33,35,55,77,105,165,231,385 .
$$
If $M_i$ uses at least two primes and the exponent of 3 is at least 2, start at 45, increase the exponents on 3 and 5 as required, and introduce the remaining prime powers in order. If it is squarefree, the first possibilities are $15,105,1155$; beyond 1155 start with that base and introduce the remaining consecutive primes. On each multiplication after either 45 or 1155, the current number $m$ is at least $9q$, where $q$ is the current largest prime: this holds for each base and persists as factors are added (for a new prime the new quotient is the old $m$). The next factor satisfies $p\le 2q$ by Bertrand, so the induction applies. This leaves only $105$ exceptional. The prime row $i=3$ has $M_3=9$, with its single inner divisor 3.

For $i=8$ the possible exponent patterns are $7$, $3,1$, and $1,1,1$. Among odd numbers with this count the two smallest are $105=3\cdot5\cdot7$ and $135=3^3\cdot5$. The next squarefree candidate is at least $3\cdot5\cdot11=165$. The inner list of 105 has a gap from 7 to 15, whereas that of 135 joins at ratio 2. No even candidate lies below 210. This verifies the exception.

The [Lean file](OddDivisorMinima.lean) proves the general interval-cover extension used in the induction and verifies the numbers of blocks for 15, 45, 105, 135 and 1155 from their divisors. The deductions about all minimizers are proved above.

The prime-row case $T(p,1)=2\cdot3^{p-1}$ already appears in [A398694](https://oeis.org/A398694), credited there to Martin Ehrenstein. Höft also reports a computational check of the third-column formula for composite indices through $10^9$, with the stated exception at 8. [A384704](https://oeis.org/A384704)
