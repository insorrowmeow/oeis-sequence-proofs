# A counterexample to Ezerman–Meyer–Solé, Conjecture 4

Martianus Frederic Ezerman, Bertrand Meyer and Patrick Solé call \(A,B\) a *palindromic pair* when reversing the decimal digits of \(AB\) gives the product of the reversals of \(A\) and \(B\). Their Conjecture 4 asserts that if both factors differ from their reversals, their multiplication is carry-free. This is the conjecture stated after Table 1 in [On Polynomial Pairs of Integers, JIS 18 (2015), Article 15.3.5, p. 5](https://cs.uwaterloo.ca/journals/JIS/VOL18/Ezerman/eze3.pdf#page=5). The [2012 preprint abstract](https://arxiv.org/abs/1210.7593) also records the statement.

**Counterexample.** Take \(A=778998,\ B=857\). Both have nonzero last digits and both change under reversal:

\[
\begin{aligned}
 778998\cdot857&=667601286,\\
 899877\cdot758&=682106766=\operatorname{rev}(667601286).
\end{aligned}
\]

The units column has coefficient \(8\cdot7=56\), while the units digit of the product is 6. Thus the product of the digit polynomials already differs from the digit polynomial of \(AB\) at the constant term. [PolynomialPairs.lean](PolynomialPairs.lean) verifies the reversed integers from their decimal digits and proves the negation of the quantified conjecture. Another example is \(9295\cdot54349=505173955\), with \(5929\cdot94345=559371505\).

## An infinite family directly from the paper's table

The table supplies \(77\cdot80088=6166776\), a palindromic pair with one palindromic factor. For every \(K\ge7\), put
\[
 A_K=77(1+10^K+10^{2K+1}),\qquad B=80088 .
\]
The three copies of 77 in \(A_K\) have unequal intervening gaps. Reversal changes their starting positions, measured from the units place, from \(0,K,2K+1\) to \(0,K+1,2K+1\). The same holds for the three copies of the seven-digit block 6166776 in \(A_KB\), which fit without overlapping. Reversing each block gives 6776616, equal to \(77\cdot88008\). Consequently \(\operatorname{rev}(A_KB)=\operatorname{rev}(A_K)\operatorname{rev}(B)\). Both factors change under reversal, and their units column \(7\cdot8\) always requires a carry. The values of \(A_K\) strictly increase with \(K\). The Lean theorem **family_witness** verifies the construction for every \(K=7+t\).

This addresses Conjecture 4. Conjecture 11 in the same paper imposes \(B=\operatorname{rev}(A)\), an additional hypothesis. No publication-priority claim is made.
