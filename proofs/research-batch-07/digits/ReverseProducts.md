# Prime reversal products, and a restriction for repdigits

## A161721

Robert G. Wilson v conjectured that each prime in [OEIS A161721](https://oeis.org/A161721/internal) contains at most one digit 2. A term \(p\) is prime, \(q=\operatorname{rev}(p)\) is prime, and \(pq\) is a decimal palindrome. The conjecture follows from Propositions 10 and 14 of [Ezerman, Meyer and Solé (2015)](https://cs.uwaterloo.ca/journals/JIS/VOL18/Ezerman/eze3.pdf).

For a prime with at least two digits, both end digits are odd and nonzero. If \(pq\) has even length then \(11\mid pq\), by the alternating-digit test on a palindrome. Primality gives \(p=11\) or \(q=11\); either forces \(p=q=11\), whose product has odd length. Hence the product has exactly \(2L-1\) digits, where \(L\) is the common length of the factors. Proposition 14 then gives carry-free multiplication. Its central column is the sum of the squares of the digits of \(p\); as a single digit it is at most 9. Two occurrences of 2 would be interior and their contribution, together with the two ends, would be at least \(4+4+1+1=10\). One-digit primes satisfy the assertion as well.

In fact, among pairs of mutually reversed primes the criterion \(\sum d_i^2\le9\) characterizes when the product is palindromic. Each raw multiplication column is a sum of pairwise digit products bounded by the central sum by Cauchy–Schwarz. Thus if the bound holds, no column needs a carry, and the symmetric raw columns are the digits of the product. This also follows from Proposition 10. This solution of the OEIS conjecture is an application of published results.

[SymmetricCarries.lean](SymmetricCarries.lean) proves the two-ended carry induction and the bound on occurrences of 2. The identification of the multiplication columns with the digit convolution and the argument using primality are supplied above.

## A401895

[OEIS A401895](https://oeis.org/A401895) conjectures that \(n\operatorname{rev}(n)\) has only one distinct decimal digit exactly at \(n=1,2,3\). The following restrictions and exhaustive search are partial results. Write \(L\) for the number of digits of \(n\). A positive multiple of 10 has a zero at the end of the product and cannot be a solution.

For \(L\ge2\), a repdigit of length \(2L-1\) is impossible. Proposition 14 gives a carry-free product whose extreme column is the product of the end digits \(a,b>0\). Its middle column is at least \(a^2+b^2>ab\). The two columns cannot give the same digit.

For a repdigit of length \(2L\), put \(d\) equal to the repeated digit. Suppose that \(p,q\) are the leading \(k\)-digit prefixes of \(n,\operatorname{rev}(n)\), and \(u,v\) their reversals as length-\(k\) words, allowing zeros. Here \(1\le k<L\). Writing \(z=10^k\), the two necessary conditions are
\[
 9uv+d\equiv0\pmod z,\qquad
 9pq<dz^2\le9(p+1)(q+1).
\]
The first is the product identity modulo \(z\). For the second divide \(9n\operatorname{rev}(n)=d(10^{2L}-1)\) by \(10^{2(L-k)}\) and bound both scaled factors between their prefix and the prefix plus one. The discarded term \(d/10^{2(L-k)}\) is less than 1 and the bounds are integers.

Start with all nonzero first and last digits, identifying reversal symmetry. Extend each pair of prefixes by trying the ten possible digits on each side and retain exactly those satisfying both conditions. At depth \(k\), joining the two ends (optionally overlapping one matching digit) tests all full inputs of lengths \(2k\) and \(2k-1\) by the original exact integer equation. One-digit inputs are checked directly. At depth 14 only \(d=6\) survives. At depth 350 there are 10,696 surviving prefix pairs, and the search through that depth finds no additional full solution. Thus the conjecture holds for every positive input of up to **700 decimal digits**.

Every counterexample of greater length would have to give a string of sixes, and its length \(L\) would be a multiple of 33. Indeed \(n\equiv\operatorname{rev}(n)\bmod9\), so \(n^2\equiv6(2L)\pmod9\) forces \(3\mid L\). Since \(11\mid n\operatorname{rev}(n)\), divisibility of a number by 11 is invariant under digit reversal, and hence \(121\mid n\operatorname{rev}(n)\). The identity \(9n\operatorname{rev}(n)=6(100^L-1)\) and \(100^L=(1+99)^L\equiv1+99L\bmod121\) give \(11\mid L\).

The [two-ended search](check_repdigit.py) uses standard Python and exact integer arithmetic. Run it with argument **350** to reproduce the 700-digit bound. This is not a proof for all inputs.
