# A large Durfee square does not force strict unimodality

Pak and Panova ask in §3.5 of *Strict unimodality of q-binomial coefficients* whether a sufficiently large Durfee square of a partition guarantees strict unimodality of the coefficients of its principal Schur specialization. Their definition in Theorem 1 permits equalities at the ends and, for odd degree, between the two central coefficients. Koutschan, Uncu and Wong repeat the conjecture in §5 of their 2023 paper. [Pak and Panova, corrected paper, pp. 1 and 4](https://www.math.ucla.edu/~pak/papers/StrictCR.pdf) · [Koutschan, Uncu and Wong, p. 8](https://arxiv.org/pdf/2302.04067#page=8)

## Counterexample for every proposed threshold

Let $N\ge 6$, take the alphabet $1,q,\ldots,q^{N-1}$, and put

$$
\lambda_N=(N+2,\underbrace{N,\ldots,N}_{N-1\text{ rows}}).
$$

The diagram contains an $N\times N$ square, and it has exactly $N$ rows. Its Durfee square therefore has side $N$. Put $E=N\binom{N}{2}$. We claim that

$$
s_{\lambda_N}(1,q,\ldots,q^{N-1}) =
q^E\sum_{0\le i\le j<N} q^{i+j}.
$$

Use the tableau definition of a Schur polynomial, with labels $0,\ldots,N-1$ and weight equal to the sum of the labels. Each of the first $N$ columns has height $N$. Strict increase down a column forces the entries, in order, to be $0,1,\ldots,N-1$. These columns have total weight $E$. The two remaining boxes lie at the end of the top row. Their entries can be any $i\le j$ in the alphabet, and every such choice extends uniquely to a tableau. This proves the identity.

Write $c_t$ for the coefficient of $q^{E+t}$. The support after removing $q^E$ is the whole interval $0,\ldots,2N-2$. For $0\le t\le N-1$, a tableau of relative weight $t$ is determined by $0\le i\le\lfloor t/2\rfloor$ with $j=t-i$. Reflection of the pair, $(i,j)\mapsto (N-1-j,N-1-i)$, gives the other half. Hence

$$
c_t=1+\left\lfloor\frac{\min(t,2N-2-t)}2\right\rfloor
\qquad (0\le t\le 2N-2).
$$

In particular, $c_2=c_3=2$ and $c_4=3$. Both equal coefficients are strictly before the center $N-1$. For every proposed Durfee threshold $D$, take $N\ge\max(6,D)$. This violates the required strict inequality and rules out a uniform threshold.

For $N=7$, the diagram is $(9,7,7,7,7,7,7)$. After removing $q^{147}$, the coefficients are

$$
1,1,2,2,3,3,4,3,3,2,2,1,1.
$$

## Scope and earlier work

This refutes the published implication when the sole size condition is imposed on the Durfee square and the specialization ranges over all alphabets on which the Schur polynomial is nonzero. In this family the number of rows equals the number of variables. Measuring the Durfee square after removing columns of full height, or requiring the alphabet to be sufficiently large relative to each fixed partition, poses a different question.

Removal of full columns and the resulting determinant factor are classical. Paget and Wildon give the forced-column argument explicitly in Lemma 4.1. Their Corollary 1.8 already implies examples with constant coefficients across a nontrivial interval by appending a single box to the square. The two-box family above gives a rise after an interior equality. Pak and Panova themselves record these equalities for two-row Gaussian coefficients in the proof of Theorem 6. No earlier work explicitly calling either family a counterexample to §3.5 was located in the priority search. Historical priority for the deduction is unestablished. [Paget and Wildon, Lemma 4.1](https://arxiv.org/pdf/1907.07616#page=18) · [Corollary 1.8](https://arxiv.org/pdf/1907.07616#page=4) · [Pak and Panova, Theorem 6](https://www.math.ucla.edu/~pak/papers/StrictCR.pdf#page=3)

## Verification

[SchurPlateaus.lean](SchurPlateaus.lean) uses mathlib semistandard Young tableaux. Coefficients are defined as the numbers of tableaux of each weight, which is the tableau definition of the principal specialization. The two free boxes and their contribution follow from the tableau inequalities. An independent script computes the entire specialized polynomial using the hook-content formula and compares it with the claimed coefficients for $6\le N\le 32$. [verify_schur.py](verify_schur.py)

The Lean file constructs the polynomial as a finite sum over tableaux, identifies its support endpoints and proves that no Durfee threshold can imply even the strict inequalities on the left half of the support. The parameter called $n$ in the Lean file equals $N-1$ above. The final theorem is named `SchurPlateaus.no_durfee_threshold`. It was checked with Lean 4.19.0 and mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`. Its printed axioms are `propext`, `Classical.choice` and `Quot.sound`. In a mathlib project with this toolchain and built dependencies, run `lake env lean /path/to/SchurPlateaus.lean`.
