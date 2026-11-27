# One tuple simultaneously minimizes sum, product and their quotient

For each \(n\ge3\), let \(a(n)\) be the smallest \(k\ge n\) for which the sum of \(1,2,\ldots,n-1,k\) divides its product. Markus Sigg conjectured that this tuple minimizes the sum, product and product divided by sum among **all** sets of \(n\) different positive integers satisfying the divisibility condition. All three minima hold. [Original statement, OEIS A399704](https://oeis.org/A399704)

Write \(T=n(n+1)/2\), \(F=(n-1)!\), and call \(T+i\) a canonical sum if \(T+i\mid F(n+i)\). The proposed sum is the least canonical sum with \(i\ge0\). A sorted tuple with sum \(T+j\) has largest entry at most \(n+j\), because its other entries total at least \(1+\cdots+(n-1)\). Hence its product divides \((n+j)!\). We prove the stronger result that the **first** \(j\ge0\) satisfying \(T+j\mid(n+j)!\) is also the first canonical offset.

If \(n+1\) is composite, \(T\mid n!\), as noted in the source. Indeed, \(n+1\mid 2(n-1)!\): a factorization into two different proper factors puts both in the factorial, while for \(n+1=r^2\), the factors \(r,2r\) occur if \(r\ge3\). For \(r=2\) the assertion is immediate. Cancelling \(n\) proves the claim. Henceforth \(n+1\) is prime and \(n\) is even. Now \(T\) is not a square, since \(n+1\) occurs to exponent one. Write \(n=2t\). The sum \(T+t=t(2t+2)\) is canonical since \(2(t+1)\mid F\) (the two distinct factors \(2,t+1\) lie in the factorial). This suffices to restrict attention to \(j\le t\).

For \(n<18\) with \(n+1\) prime the following rows give the canonical offset \(j_*\) and, for each \(0\le j<j_*\) in turn, a prime dividing \(T+j\) and exceeding \(n+j\).

| \(n\) | \(j_*\) | Excluding primes, in order |
| ---: | ---: | --- |
| 4 | 2 | 5, 11 |
| 6 | 3 | 7, 11, 23 |
| 10 | 1 | 11 |
| 12 | 2 | 13, 79 |
| 16 | 4 | 17, 137, 23, 139 |

Assume \(n\ge18\). Suppose that \(s=T+j\) divides \((n+j)!\) for some \(j\) below the first canonical offset. Then \(s\nmid F\). Choose a prime power \(p^e\mid s\) with \(p^e\nmid F\). The multiples \(p,2p,\ldots,ep\) would give \(p^e\mid F\) if \(ep<n\). Thus \(ep\ge n\).

In fact \(e\le2\). For \(e\ge3,\ p\ge2,\ ep\ge18\) one has \(2p^e>(ep)(ep+2)\). For \(3\le e\le7\), take the least prime \(p\) allowed, respectively \(7,5,5,3,3\), in the inequality \(2p^{e-2}>e^2+2e/p\); the left side increases and the right side decreases with \(p\). For \(e\ge8\), \(2^{e-2}>e(e+1)/2\) follows by induction. The claim contradicts \(p^e\le s\le n(n+2)/2\).

If \(e=2\), then \(p\ge n/2\). For \(p=n/2\), \(2p^2<T\) and \(3p^2>T+n/2\). For \(p\ge n/2+1\), \(2p^2>T+n/2\). Thus the only remaining possibility is \(s=p^2\). Since \(T\) is not square, \(T\le s-1\). Also \(p\le n-2\), since \(n(n+2)/2<(n-1)^2\). The distinct factors \(p-1,p+1\) belong to \(F\). This gives a canonical sum \(s-1\), a contradiction.

If \(e=1\), put \(p=q=n+r\). Then \(1\le r\le j\): the prime \(q\) fails to divide \(F\), exceeds the even composite \(n\), and divides \((n+j)!\). Put \(b=s/q\). We have \(2b\le n\), by \(s\le n(n+2)/2\) and \(q\ge n+1\), since \(n\) is even. Also \(2b\ge n+1-r\), since \((n+r)(n+1-r)=n(n+1)-r(r-1)\le 2s\). Form
\[
 s'=\frac{q+1}{2}(2b-1).
\]
The difference \(s-s'=(q+1)/2-b\) lies between 1 and \(r\). Thus \(T\le s'<s\). Its two factors are positive and at most \(n-1\), with the first at most \(n-2\) since \(r\le n/2\). If they differ then \(s'\mid F\). If both equal \(h\), then \(s'\ne T\) and \(s'-1=(h-1)(h+1)\mid F\), with \(s'-1\ge T\). In either case an earlier canonical sum exists, again a contradiction. This proves the minimum-sum assertion.

For product and quotient, write the sorted entries as \(i+d_i\), \(1\le i\le n\), so \(d_i\ge0\) and \(\sum d_i=j\). Expanding the product of positive factors gives
\[
 \frac{\prod (i+d_i)}{n!}
 =\prod_i(1+d_i/i)\ \ge\ 1+\sum_i d_i/i\ \ge\ 1+j/n.
\]
Hence the product is at least \(F(n+j)\), and the quotient is at least \(F(n+j)/(T+j)\). Both lower bounds increase strictly with \(j\) because \(T>n\), and the canonical tuple attains them both at the smallest feasible \(j\).

### Lean verification

The theorem **Sigg.simultaneous_minima** constructs the canonical finite set, proves that it is admissible, and compares all three quantities with those of every admissible set. **Sigg.least_k** identifies the last entry with the least integer specified by Sigg. Division in the formal statement is exact on both sides because admissibility requires the sum to divide the product. [Main Lean theorem](Sigg.lean) · [Factorial and prime-power argument](SiggArithmetic.lean) · [Finite-set bounds](SiggTuples.lean)
