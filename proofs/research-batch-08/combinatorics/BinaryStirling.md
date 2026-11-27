# A binary analogue of the Stirling expansion

The conjectured change of basis between A358612 and A373183 holds for every \(n\). It was asked on MathOverflow on December 7, 2024. The Stack Exchange API returned zero answers when checked. [Question 483753](https://mathoverflow.net/questions/483753/generalized-identity-with-stirling-numbers-of-the-second-kind-and-falling-factor) · [A358612](https://oeis.org/A358612) · [A373183](https://oeis.org/A373183)

Write \(w(n)\) for binary weight and let \(R_n(x)\) be the A373183 row polynomial, with \(R_0(x)=x\). Define

\[
Q_n(x)=(-1)^{w(n)+1}R_n(-x),\qquad L_n(x)=xQ_n(x).
\]

The row recurrences become \(Q_{2n+1}(x)=xQ_n(x)\) and \(Q_{2n}(x)=x(Q_n(x)-Q_n(x-1))\). In the even rule take \(n\ge1\); the initial row supplies index zero. Every \(Q_n\) is divisible by \(x\), every \(Q_n(1)=1\), and \(\deg Q_n\le w(n)+1\). These facts follow by induction: for an even index the finite difference lowers degree by at least one, and \(Q_{2n}(1)=Q_n(1)-Q_n(0)=1\).

Write \(F_j(x)=(x)_j=x(x-1)\cdots(x-j+1)\), including \(F_0=1\). The monic \(F_j\) form a polynomial basis with one element in each degree. Define \(U(n,j)\) from

\[
 L_n(x)=\sum_{j=1}^{w(n)+2}U(n,j)F_j(x).
\]

The missing constant term follows by evaluating at zero. Evaluating at one gives \(U(n,1)=1\). The initial polynomial \(L_0=x^2=F_2+F_1\) gives the initial row of A358612.

The identity \(xF_j=F_{j+1}+jF_j\) immediately gives the odd rule \(U(2n+1,j)=jU(n,j)+U(n,j-1)\), with out-of-range entries set to zero.

For an even index substitute \(Q_n=\sum_j U(n,j)(x-1)_{j-1}\) into its difference rule. The identity \((x-1)_d-(x-2)_d=d(x-2)_{d-1}\) for \(d\ge1\) gives

\[
 (x-1)L_{2n}(x)=x\sum_{j\ge1}(j-1)U(n,j)F_j(x).
\]

On the left use \((x-1)F_j=F_{j+1}+(j-1)F_j\). On the right use the preceding formula for \(xF_j\). Equating the coefficient of \(F_j\) yields

\[
 U(2n,j-1)+(j-1)U(2n,j)
   = j(j-1)U(n,j)+(j-2)U(n,j-1).
\]

For \(j\ge2\) this is exactly the even recurrence of A358612 after collecting its two terms divided by \(j-1\). The first coefficient is already fixed at one. Thus the given recurrences determine \(U(n,j)=T(n,j)\) row by row and within each row from left to right. Dividing the expansion of \(L_n\) by \(x\) gives the claimed signed expansion of \(R_n(-x)\), including the sign \((-1)^{w(n)-j+1}\) on the ordinary power \(x^j\).

The public comment by Jon23 proposes testing small moduli. The proof above is over the rational polynomial ring. The accompanying Lean file checks the finite-difference and even-row basis identities at every rational argument and the coefficients' rearrangement; the identification of the two complete recursive arrays is written above. [Lean identities](BinaryStirling.lean)
