# The A259192 row algorithm and its summation limit

The displayed conjecture in MathOverflow 492866 fails first at \(n=4\). Its algorithm in fact produces the **full** row polynomial of A259192, exactly as tested by the author's program. The displayed summation stops at \(k=n\), whereas the full row has degree \(n(n-1)/2\). The question was posted May 19, 2025. The Stack Exchange API returned zero answers when checked. [Original question](https://mathoverflow.net/questions/492866/algorithm-for-row-polynomials-of-a259192) · [OEIS A259192 and its explicit fourth row](https://oeis.org/A259192)

The polynomial returned at \(n=4\), including the factor two in the question, is

\[
 2+12y+16y^2+20y^3+16y^4+8y^5+16y^6.
\]

For example, at \(y=1\) it is 90 while the truncated sum is 66. The first three positive-index rows have degree at most their index.

In May 2025 Peter Taylor gave a Sage implementation, identified the suffix multiplier \((1-z)/(1-2z)\), and rewrote the functional equation for \((A+1)/2\). The gist labels the match of the in-place updates to the desired power series as conjectural. The walk decomposition below proves that match. [Taylor's Sage gist](https://gist.github.com/pjt33/305596241802672c7c10a640de44f3a5) · [Taylor's comment on the functional equation](https://mathoverflow.net/questions/492866/algorithm-for-row-polynomials-of-a259192#comment1288260_492866)

## The full row identity

Let \(E(x)=\sum_{n\ge0}\nu_{n+1}x^n\), where \(\nu_{n+1}\) denotes the settled diagonal entry of the algorithm. The dependence on \(y\) is implicit. We prove

\[
 E(x)-1=xE(x)(2E(xy)-1).
\]

It then follows that \(A=2E-1\) is the unique formal series with constant term one satisfying \(A(x)=(1+xA(xy))/(1-xA(xy))\), the defining equation of A259192.

Before processing position \(i\), let \(F(z)=\sum_{h\ge0}\nu_{i+h}z^h\). Let \(G\) encode these same entries after processing that position. The accumulator contains the sum of the entries already updated to its left, so for \(l\ge0\)

\[
 [z^l]G=y^l[z^l]F+\sum_{j<l}[z^j]G.
\]

It follows that \(G=C(z)F(yz)\), with \(C(z)=(1-z)/(1-2z)\); write \(c_r=[z^r]C\). Thus \(c_0=1\) and \(c_r=2^{r-1}\) for \(r\ge1\). The next row starts one position later. The linear operator carrying one row to the next is therefore

\[
 L(F)=\frac{C(z)F(yz)-F(0)}{z}.
\]

In height coordinates a step from \(h\) to \(h+r-1\), with \(r\ge0\), has weight \(y^h c_r\). Negative heights are discarded by the subtraction. As the initial row is 1, \(\nu_{n+1}=[z^0]L^n(1)\) is the total weight of nonnegative walks of length \(n\) starting and ending at zero. The use of infinite rows is legitimate because the diagonal of a length-\(n\) walk cannot depend on any height from which the remaining steps cannot descend to zero. Equivalently, each finite in-place update depends only on its prefix.

A nonempty excursion begins with a step to height \(r-1\), for some \(r\ge1\). Split its remainder at each first descent from the levels \(r-1,r-2,\ldots,1\), then retain its final excursion at level zero. At level \(h\) the part before the descent is an arbitrary excursion shifted up by \(h\), with generating function \(E(xy^h)\). Each of the prescribed descents has weight \(y^h c_0=y^h\). The first step and these descents account for \(r\) steps in total. The resulting contribution for each \(r\) is \(c_r Q_r(x)\), where

\[
 Q_r(x)=x^r y^{r(r-1)/2}\prod_{h=0}^{r-1}E(xy^h),\qquad Q_0=1.
\]

Every decomposition is reversible, so \(E(x)-1=\sum_{r\ge1}2^{r-1}Q_r(x)\). Since \(Q_r(x)=xE(x)Q_{r-1}(xy)\), the sum equals \(xE(x)(1+2(E(xy)-1))\), as required. Consequently the corrected upper limit \(n(n-1)/2\) proves the author's full-row algorithm for every positive \(n\).
