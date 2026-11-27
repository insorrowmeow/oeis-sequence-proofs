# Density zero for the strongly nontriangular numbers

[OEIS A400795](https://oeis.org/A400795) conjectures infinitude and natural density zero for the positive integers outside the generalized triangular numbers of [Petersen, Validashti and Wayland](https://doi.org/10.1080/0025570X.2026.2627861). We prove the density assertion. In fact, a density-one set of positive integers has a representation with **coprime** sides $i,j>1$:
$$
n=P(i,j)=(ij+i+j-\gcd(i,j))/2.
$$

### From a prime divisor to a triangle

If an odd prime $p\mid n+1$ satisfies $\gcd(p-1,2n+1)=1$, take $i=p-1,\ j=2(n+1)/p-1$. Then $(i+1)(j+1)=2(n+1)$ and $2n+1=j+i(j+1)$, so $\gcd(i,j)=1$ and $P(i,j)=n$. For fixed $p$, $j>1$ once $n+1>p$.

### Supply of prime divisors with few obstructions

For an odd prime $p$ define
$$
w(p)=\sum_{\substack{q\mid p-1\\q\ \mathrm{odd\ prime}}}1/q.
$$
For every $\epsilon>0$, the primes with $w(p)\le\epsilon$ have divergent reciprocal sum. Here are details to control the large prime factors of $p-1$, which cannot be omitted just by fixing finitely many congruences.

Choose an integer $B>16/\epsilon+3$ and fix $W$, the product of all primes up to $B$. Restrict to primes $p\equiv-1\bmod W$; no odd $q\le B$ divides $p-1$. Among the $A(x)$ such primes up to $x$, the prime number theorem in arithmetic progressions gives $A(x)\sim x/(\varphi(W)\log x)$ as $x\to\infty$ with $W$ fixed.

For a prime $B<q\le x^{1/3}$, the additional condition $p\equiv1\bmod q$ specifies one reduced class modulo $Wq$. For sufficiently large $x$ we have $Wq\le x^{1/2}$. The Brun–Titchmarsh inequality bounds the count in this class by $4x/(\varphi(W)(q-1)\log x)$. Hence the contribution from all such $q$ to $\sum_p w(p)$, divided by $A(x)$, is at most
$$
(4+o(1))\sum_{q>B}\frac1{q(q-1)}
\le (4+o(1))/B,
$$
where the last bound sums over all integers above $B$. Each $p-1<x$ has at most two prime divisors greater than $x^{1/3}$; their contribution per prime is at most $2x^{-1/3}$. Thus the mean of $w$ on the class is eventually below $\epsilon/2$. At least half of $A(x)$ have $w(p)\le\epsilon$. Partial summation gives divergence of their reciprocal sum since their counting function is bounded below by a positive constant times $x/\log x$ for all sufficiently large $x$. [Brun–Titchmarsh inequality](https://ac.inf.elte.hu/Vol_045_2016/101_45.pdf).

### Density of the missed integers

Fix a finite set $F$ of such good odd primes and put $H=\sum_{p\in F}1/p$. For a uniform integer residue $n$ modulo the product of the distinct primes occurring in $F$ or as odd factors of their predecessors, let $X$ count $p\in F$ dividing $n+1$, and $Y$ count those divisors for which $\gcd(p-1,2n+1)>1$. The Chinese remainder theorem gives $\mathbb E X=H$ and $\operatorname{Var}(X)\le H$, by pairwise independence of its indicators. For each fixed $p$ and odd $q\mid p-1$, the event $p\mid n+1,\ q\mid 2n+1$ has probability $1/(pq)$, since $p\ne q$. A union bound therefore gives $\mathbb E Y\le\sum_{p\in F}w(p)/p\le\epsilon H$. Independence between different obstruction events is unnecessary.

All $n>\max F$ outside the coprime-representable set satisfy $X=Y$. Thus their upper density is at most
$$
\Pr(X<H/2)+\Pr(Y\ge H/2)\le 4/H+2\epsilon
$$
by Chebyshev and Markov. The residue probabilities are exact periodic densities for each fixed $F$. First take finite sets with $H$ arbitrarily large using the divergence above, then let $\epsilon$ tend to zero. This proves density zero for the exceptional integers, hence also for A400795.

**Scope.** [Lean](TriangularDensity.lean) checks the coprimality reduction and exact value of the constructed lattice count. The sieve and density estimates are written proofs using the classical theorems cited above. Infinitude of A400795 is a separate question and remains unresolved here. No priority claim is made.
