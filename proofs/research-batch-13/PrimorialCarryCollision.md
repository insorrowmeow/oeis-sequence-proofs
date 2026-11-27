# A counterexample to two conjectures of Karttunen on arithmetic-derivative collisions

Antti Karttunen asked whether $j=16,\ k=28$ is the only positive-loss pair with identical arithmetic derivatives and identical primorial-carry losses. The first conjecture also requires $j$ to be the **largest** smaller integer with the same loss as $k$. Both statements have the same counterexample below. [A399369, official OEIS snapshot](https://github.com/oeis/oeisdata/blob/976b0c73e00453b1c1e6f16d83108cb9bb744c3b/seq/A399/A399369.seq) · [The maximal-predecessor sequence A399370](https://oeis.org/A399370)

Put $Z=123017^{1504}$. The base of this power is prime. Take

$$
j=656100 Z=2^2 3^8 5^2 Z,\qquad
k=2624372 Z=2^2\cdot137\cdot4789 Z.
$$

Here 137 and 4789 are prime. For $n>0$ write $C(n)$ for the number obtained by repeatedly replacing a factor $p^p$ by the next prime $p^+$, processing primes in increasing order. Write $L(n)=n-C(n)$, exactly A376418. Each carry is a strict decrease; the prime exponents of the terminal number are all smaller than their respective primes. Both displayed inputs are multiples of $2^2$. [Definition and algorithm for the loss](https://oeis.org/A376418/internal)

**Equality of losses.** For $j$ the successive coefficients of $Z$ after the carries are

$$
656100 \ \to\ 492075\ \to\ 91125\ \to\ 16875\ \to\ 3125\ \to\ 7.
$$

The carry primes are $2,3,3,3,5$. For $k$ a single carry at 2 gives $1968279Z=3\cdot137\cdot4789Z$. The two resulting integers are terminal, since $1504<123017$ and all small prime factors in them have exponent one. Hence $L(j)=L(k)=656093Z=:\Delta>0$.

**Equality of derivatives.** The arithmetic derivative $D$ has $D(p)=1$ for primes and obeys the product rule. The displayed factorizations yield $D(656100)=2668140$ and $D(2624372)=2644076$. Their difference is $24064$. On the other hand $D(Z)/Z=1504/123017$, and

$$
(2624372-656100)\cdot1504/123017=24064.
$$

The product rule now gives $D(j)=D(k)$. This alone disproves Conjecture 2.

**Maximality of the predecessor.** Suppose $j<m<k$ and $L(m)=\Delta$. The function $1-\Delta/m$ increases strictly in $m$, so the final-to-initial ratio $r=C(m)/m$ must satisfy

$$
\frac{7}{656100}<r<\frac34 .
$$

Every individual carry contributes a factor $p^+/p^p<1$ to $r$. For $p\ge11$, Bertrand's postulate gives $p^+<2p$, so this factor is at most $2/11^{10}<7/656100$. Such a carry is impossible. For counts $a,b,c,d$ of carries at $2,3,5,7$ we therefore have $r=U/V$, where

$$
U=3^a5^b7^c11^d,\qquad V=4^a27^b3125^c823543^d.
$$

Taking respectively $40,7,2,2$ powers of the four individual factors already gives a value below $7/656100$. Thus $a<40,\ b<7,\ c<2,\ d<2$. For a proposed ratio in range, $L(m)=\Delta$ forces the integer equation $m(V-U)=\Delta V$. Exactly 198 of the 1,120 exponent quadruples lie in range. In all 198 cases $V-U$ fails to divide $\Delta V$. This finite step can be reproduced directly:

~~~python
from itertools import product
loss = 656093 * 123017**1504
in_range = 0
for a, b, c, d in product(range(40), range(7), range(2), range(2)):
    u = 3**a * 5**b * 7**c * 11**d
    v = 4**a * 27**b * 3125**c * 823543**d
    if 7*v < 656100*u and 4*u < 3*v:
        in_range += 1
        assert (loss*v) % (v-u) != 0
assert in_range == 198
~~~

It follows that $j$ is the maximal predecessor of $k$ in the same positive-loss class. Thus the two indices occur as the paired values of A399370 and A399369 and disprove Conjecture 1 as well.

**Verification and relation to A379240.** Lean 4.19.0 checks the factorizations, equality for every function satisfying the defining arithmetic-derivative laws, the individual carries, the prime-exponent terminal conditions, the common loss, the numerical cutoffs and the full finite nondivisibility certificate. The deduction that these finitely many carry ratios exhaust all possible intervening integers uses Bertrand's postulate and the monotonicity argument above. A379240 asks a separate question that also uses the invariant $\gcd(n,D(n))$. For this pair $3$ divides $\gcd(j,D(j))$ and does not divide $k$, so that invariant distinguishes the two numbers. [Lean certificate](PrimorialCarryCollision.lean) · [A379240](https://oeis.org/A379240)
