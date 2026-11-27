# The twice-prime branch of the Heronian tangent-length conjecture

[A401194](https://oeis.org/A401194) predicts which integers fail to occur as the largest incircle tangent length of an integral triangle with integral area. Write $H(n)$ for representability: there must be $1\le k,m\le n$ with $nkm(n+k+m)$ a square. The sides are $n+k,k+m,m+n$. We use the prime and $13\bmod24$ formulas already given in [A401193](https://oeis.org/A401193).

**Results.** The twice-prime part of the proposed classification is valid. Among all primes $p$, the relative natural density for which $H(2p)$ fails is
$$
\frac18\left(1-\frac{\arctan\sqrt2-\arctan(1/\sqrt2)}{\pi}\right).
$$
The odd-composite branch remains open. For each fixed prime $p\equiv5,7\bmod8$, a positive-density set of primes $q\equiv p\bmod8$ satisfies $H(pq)$.

### Covering the twice-prime cases

If $p\equiv1,3\bmod8$, the source gives $H(p)$, hence $H(2p)$ by doubling all tangent lengths. The exceptional $p=2,3$ are covered by $(4,4,1)$ and twice $(3,2,1)$, respectively.

If $p\equiv5\bmod24$, then $(-6/p)=1$. The primitive reduced positive forms of discriminant $-24$ are $x^2+6y^2$ and $2x^2+3y^2$ (enumerate reduced forms with leading coefficient at most $\sqrt{24/3}$). Splitting gives representation by one of these; the first is excluded modulo 3. Thus $p=k+m$ with $k=2x^2,m=3y^2$, both positive. The Heron product for $n=2p$ is $6p^2km=(6pxy)^2$.

Suppose $p\equiv7\bmod8$. The prime splits in the norm-Euclidean ring $\mathbb Z[\sqrt2]$. Choose a generator $\pi$ of one of the two primes above $p$, of norm $\pm p$. The totally positive element $3\pi^2$ has norm $9p^2$. Multiplying it by a suitable integral power of $\eta=3+2\sqrt2$ gives $\alpha=X+Y\sqrt2$ with $\eta^{-1/2}\le\alpha/(3p)\le\eta^{1/2}$. Adding the two conjugates gives $3p\le X\le3\sqrt2\,p$. The lower bound is strict, since $\alpha=3p$ would imply $(\pi)^2=(p)$ contrary to splitting. The norm equation gives $X$ odd. Thus $m=(X-3p)/2$ is positive and less than $p$, and $X^2-2Y^2=9p^2$ gives $2m(3p+m)=Y^2$. Taking the three lengths $2p,p,m$ now gives area $|pY|$.

The remaining primes are $p\equiv13\bmod24$. The OEIS source's exact formula for this residue class says $H(2p)$ holds precisely if $p=2x^2+5y^2$, $x,y>0$, with $5y^2\le4x^2\le20y^2$. This is exactly the exception test in A401194. The preceding arguments use the source's formula as input.

#### Check of the cone criterion

For completeness, let $p\equiv13\bmod24$ and $n=2p$. If $k=2p$, the square condition gives $m(m+4p)=v^2$, hence $(m+2p-v)(m+2p+v)=4p^2$. These factors are both even and their halves multiply to $p^2$, forcing $m=0$ or $m=(p-1)^2>2p$. If $k=p$ and $p$ does not divide $m$, the required square $2m(3p+m)$ modulo $p$ contradicts $(2/p)=-1$. Both $k,m$ divisible by $p$ would give the scaled-down lengths $(2,1,1),(2,2,1)$ or $(2,2,2)$, none with square Heron product. By symmetry neither $k$ nor $m$ is divisible by $p$.

Consequently $k+m=tp$ for $t=1,2,3$, and $\gcd(k,m)\mid t$. For $t=1$, $6km$ must be square and the coprime pair gives either $p=x^2+6y^2$, impossible modulo 8, or $p=2x^2+3y^2$, impossible modulo 3. For $t=2$, $8km$ is square. Parity forces both $k,m$ even. Their halves are coprime, so $p=x^2+2y^2$, impossible modulo 8. For $t=3$, $10km$ is square. Were $k,m$ coprime, their sum $3p$ would be $x^2+10y^2$ or $2x^2+5y^2$; either form vanishes modulo 3 only when both coordinates vanish modulo 3. Hence $\gcd(k,m)=3$. The quotients $k/3,m/3$ give the same two alternatives for $p$, and modulo 8 excludes the first. The remaining tangents are $6x^2,15y^2$; their upper bounds give the stated cone. Conversely these lengths give Heron area $30pxy$.

### Computing the density

For a prime in the $13\bmod24$ class, splitting in $\mathbb Q(\sqrt{-10})$ is equivalent to $p\equiv2,3\bmod5$, by quadratic reciprocity. Half the primes in this class split, by the prime number theorem in progressions modulo 120. Reduction of binary quadratic forms gives the two classes of discriminant $-40$, represented by $[1,0,10]$ and $[2,0,5]$. A split prime must be represented by the latter, since $x^2+10y^2$ cannot be $5\bmod8$. The representation of $p=2x^2+5y^2$ by positive $x,y$ is unique: the two prime ideals above $p$ are conjugate and the units are $\pm1$.

More explicitly, multiplying either prime ideal by $\mathfrak a=(2,\sqrt{-10})$ yields a principal ideal with generator $2x+y\sqrt{-10}$, of norm $2p$. Up to signs and conjugation its angle $\theta$ is in $(0,\pi/2)$ and $\tan\theta=\sqrt{10}y/(2x)$. Within the split residue classes modulo 120, these folded angles are uniformly distributed on $[0,\pi/2]$. This is the fixed-modulus Hecke prime-ideal equidistribution theorem: prescribe a ray class modulo $120\mathcal O_K$, which fixes ideal class and norm residue modulo 120, then use the nontrivial infinite-order angular characters for each nonzero Fourier mode. On each eligible ray class, multiplication by the fixed ideal just rotates the angle parametrization for generators. Conjugation and reduction modulo sign yield the folded distribution. Finite unions of these ray classes give the two eligible rational prime classes. Inert degree-two prime ideals have zero relative density in ideal norm order. Standard sector prime theorem reference: [D. Hensley, *An asymptotic inequality concerning primes in contours for the case of quadratic number fields*](https://bibliotekanauki.pl/articles/1393548.pdf).

The cone requires $1/\sqrt2\le\tan\theta\le\sqrt2$. Its conditional frequency among the split primes is $2(\arctan\sqrt2-\arctan(1/\sqrt2))/\pi$. Multiplying by the splitting fraction $1/2$ and accounting for the other seven reduced classes modulo 24 proves the stated exceptional density.

### Fixed smaller odd prime

Fix any $p\equiv5,7\bmod8$. The form $p x^2+16(p+1)y^2$ is positive definite and primitive. By the classical prime theorem for primitive positive binary quadratic forms it represents a positive density of rational primes (relative to all primes). For all but finitely many represented primes $q$, both coordinates are nonzero, $q>p$, and $q\equiv p\bmod8$ since $x$ must be odd. Write $k=px^2$, $m=16(p+1)y^2$. Then $q=k+m$ and for $n=pq$ the Heron product is $(4p(p+1)xyq)^2$. This supplies unbounded ratios $q/p$ in every fixed obstructed-prime fiber.

**Verification.** [HeronFibers.lean](HeronFibers.lean) checks the odd-fiber polynomial identity, the area identity from the norm equation, and the angle inequalities. The classification, use of the source formulas and analytic density arguments are written proofs. This is a local research note with no claim of historical priority.
