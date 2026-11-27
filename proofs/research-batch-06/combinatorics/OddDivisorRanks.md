# Odd-divisor ranks in a binary recurrence

Both conjectures in MathOverflow question 438304 hold. Let \(b(k,0)=k\), \(b(k,i+1)=2b(k,i)-2^i\), and write \(c(1),c(2),\ldots\) for the increasing sequence of positive even integers \(k\) such that \(k\mid b(k,1+\lfloor\log_2 k\rfloor)\). On January 12, 2023, Alapan Das gave the odd-part parametrization, its derivation and the inclusion in A082662 in comments. The count below gives the precise rank asked for in the other conjecture. The thread contained no posted answer and its six public comments contained no rank calculation when checked. [Original question](https://mathoverflow.net/questions/438304/subsequence-such-that-can-2n) · [Das's parametrization](https://mathoverflow.net/questions/438304/subsequence-such-that-can-2n#comment1130296_438304) · [Das's derivation](https://mathoverflow.net/questions/438304/subsequence-such-that-can-2n#comment1130376_438304)

**Membership criterion.** If \(r=1+\lfloor\log_2 k\rfloor\) and \(q\) is the odd part of an even number \(k\), then \(k\) occurs in \(c\) precisely when \(q\mid r\).

For \(r\ge1\), induction in the recurrence gives \(b(k,r)=2^r k-r2^{r-1}\). Write \(k=2^v q\), with \(q\) odd. Because \(2^v\le k<2^r\), we have \(v\le r-1\). In the test for divisibility by \(k\), the first term drops out, and the second term already has at least \(v\) factors of two. Its remaining odd divisibility condition is exactly \(q\mid r\).

**Rank of the powers of two.** Fix \(r\ge2\). Each odd divisor \(q\mid r\) gives exactly one element of \(c\) with \(r\) binary digits, namely

\[
k=q\,2^{r-1-\lfloor\log_2 q\rfloor}.
\]

In fact, appending binary zeros to \(q\) gives exactly one integer with the prescribed bit length. This integer is even. For \(r\ge3\) we have \(q\le r<2^{r-1}\); when \(r=2\), \(q=1\). Conversely every member in the block determines its odd divisor uniquely. The first member of each block is its lower endpoint, corresponding to \(q=1\).

Write \(d_o(r)\) for the number of positive odd divisors of \(r\). The one-based rank of \(2^n\) in \(c\) is

\[
1+\sum_{r=2}^{n}d_o(r)=\sum_{r=1}^n d_o(r)=\mathrm{A060831}(n).
\]

This includes \(n=1\), where the first member is 2. Therefore \(c(\mathrm{A060831}(n))=2^n\) for every positive \(n\). [OEIS A060831](https://oeis.org/A060831)

**Containment in A082662.** We need \(q^2<2k\). For \(r\ge5\) one has \(r^2<2^r\). The base case is \(25<32\), and \((r+1)^2<2r^2\) for \(r\ge5\) gives the induction step. Since \(q\mid r\) and \(2^{r-1}\le k\), it follows that \(q^2\le r^2<2^r\le2k\). For \(r=2,3,4\), the complete blocks are respectively \(\{2\},\{4,6\},\{8\}\), which satisfy the same inequality. Thus every member of \(c\) belongs to A082662. [OEIS A082662](https://oeis.org/A082662)

The Lean file proves both conjectures for all their indices. The theorem `rank_of_power` states that \(2^n\) belongs to the sequence and that the number of members strictly below it plus one equals the sum of odd-divisor counts. The theorem `all_members_contained` computes the odd part from the factorization of each member and proves the required strict inequality. [Lean proof](OddDivisorRanks.lean)
