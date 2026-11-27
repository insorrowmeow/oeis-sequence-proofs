# The asymptotic number of optimal greedy sums of squares

Abo Khmiss's [OEIS A401548](https://oeis.org/A401548) asks whether the number \(O(X)\) of positive integers \(n\le X\) for which repeatedly subtracting the largest possible square uses the minimum possible number of squares satisfies \(O(X)\sim cX^{15/16}\) for some \(c>0\).

**Theorem.**
\[
 O(X)\ \sim\ \frac{16\,2^{17/8}}{525}\,X^{15/16}.
\]
Among numbers whose greedy decomposition takes exactly four squares, the proportion for which it is optimal tends to \(3/20\).

## The residues of the greedy square roots

For \(j\ge1\) let \(G_j(X;\mathbf r,M)\) count numbers \(n\le X\) with exactly \(j\) strictly positive greedy roots \(a_1,\ldots,a_j\), in that order, where \(a_i\equiv r_i\bmod M\). Fix \(M\ge1\) and the residue vector. We claim
\[
 G_j(X;\mathbf r,M)\sim M^{-j} C_j X^{e_j},\qquad
 e_j=1-2^{-j},\quad C_1=1,\quad C_{j+1}=2^{e_j}C_j/(1+e_j).
\]
For \(j=1\) this is the count of one arithmetic progression up to \(\lfloor\sqrt X\rfloor\). For the induction step put \(L=\lfloor\sqrt X\rfloor\). A first greedy root \(a<L\) gives precisely the positive remainders up to \(2a\), since the next square is \((a+1)^2\). Thus the contribution of all complete intervals is
\[
\sum_{\substack{1\le a<L\\a\equiv r_1\bmod M}}G_j(2a;(r_2,\ldots,r_{j+1}),M).
\]
The single incomplete interval at \(a=L\) contributes at most \(O(L^{e_j})\) by the induction hypothesis. Using a Riemann sum on the fixed progression gives \(\sum_{a<L,\ a\equiv r_1(M)} a^{e_j}\sim L^{1+e_j}/(M(1+e_j))\). The pointwise little-oh error from the induction hypothesis also sums to \(o(L^{1+e_j})\): bound it by \(\epsilon a^{e_j}\) beyond a fixed cutoff, then let \(\epsilon\) decrease to zero. This proves the claim.

In particular the ordered greedy roots for length four become uniformly distributed modulo every fixed \(M\). Their unrestricted count has constant
\[
 C_4=\frac{64\,2^{17/8}}{315}.
\]

## Which greedy quadruples are optimal?

By the three-square theorem, a sum \(S\) of four positive squares needs four squares precisely when \(S=4^e(8h+7)\). Call this property \(E\). It is invariant under multiplication by 4. A root quadruple is primitive at 2 when at least one coordinate is odd.

For a uniform primitive-or-imprimitive random residue quadruple modulo 16, the following probabilities are **unconditional**. They cover precisely the primitive quadruples satisfying \(E\).

* With three odd coordinates, \(S\equiv7\bmod8\) exactly when the remaining coordinate is \(2\bmod4\). This has probability \(4(1/2)^3(1/4)=1/8\).
* With four odd coordinates, \(S\equiv4\bmod8\). Its quotient by four is \(7\bmod8\) exactly when \(S\equiv28\bmod32\). For a uniform odd residue modulo 16, its square modulo 32 is uniformly one of \(1,9,17,25\). Conditional on the other three odd coordinates, exactly one of those four square residues works. This case has probability \((1/2)^4(1/4)=1/64\).
* With one odd coordinate, \(S\) is 1 or 5 modulo 8. With two odd coordinates its 2-adic valuation is one. Both cases are excluded.

The primitive success probability is therefore \(9/64\) before conditioning on primitivity. The probability that all four coordinates are even is \(1/16\). To apply the same count repeatedly, fix \(H\) and use equidistribution with modulus \(2^{H+4}\). For \(0\le t<H\), quadruples divisible coordinatewise by \(2^t\) whose scaled quadruple is primitive and successful have limiting proportion \(16^{-t}(9/64)\). Scaling multiplies the sum by \(4^t\), which preserves \(E\). The unexamined tail has limiting proportion at most \(16^{-H}\), since every coordinate there is divisible by \(2^H\). Letting \(H\to\infty\) proves the asserted fraction \((9/64)/(1-1/16)=3/20\).

Lagrange's four-square theorem excludes optimal decompositions with more than four greedy roots. Decompositions of lengths one through three contribute at most \(O(X^{7/8})\) by the counting lemma. Multiplying \(C_4\) by \(3/20\) proves the theorem.

## Scope

The limit argument is given above. [GreedyLocal.lean](GreedyLocal.lean) formalizes the primitive congruence test, invariance under multiplying by four, and the residue counts \(9216/61440=3/20\). The [independent calculation](check_greedy.py) enumerates all \(16^4\) quadruples and checks the optimal greedy counts through \(10^5\). The density \(1/6\) of integers of the form \(4^e(8h+7)\) among all integers, mentioned in the OEIS heuristic, differs from the limiting proportion \(3/20\) in the specific greedy four-root sample. The entry labels the asymptotic as a conjecture. Publication priority has not been established.
