# Correcting the row index in OEIS A395454

Per Alexandersson's June 2026 conjecture for the row polynomials of Peter Luschny's triangle uses index n−2 in two coefficients. The correct index in both is n−1. The printed formula fails for every n≥2. Already the row with index 2 is 2t and the proposed expression gives zero. [A395454](https://oeis.org/A395454)

**The corrected recurrence.** Start with P₀=1 and P₁=0. For n≥2 one has

$$P_n=(n-1)(1+t)P_{n-1}+t(1-t)P'_{n-1}+2(n-1)tP_{n-2}.$$

For example, the recurrence gives P₃=6t+2t² and P₄=24t+34t²+2t³.

## Derivation

Let Q_j(t) be the polynomial obtained by reversing row j of the second-order Eulerian triangle A201637, retaining its trailing zero before reversal. Its standard coefficient recurrence gives

$$Q_{j+1}=(j+(j+1)t)Q_j+t(1-t)Q'_j,\qquad Q_0=1.$$

For clarity, the reversed row coefficient at k in Q_{j+1} is (j+k) times the coefficient at k in Q_j plus (j+2−k) times its coefficient at k−1. [A201637](https://oeis.org/A201637), [A288874, reversed-row recurrence](https://oeis.org/A288874)

For 0≤j≤n the generalized binomial in A395454 is (−1)^(n−j) times the ordinary binomial n choose j. Reversing the Eulerian row inside the sum contributes the factor t^(n−j), so

$$P_n(t)=\sum_{j=0}^n {n\choose j}(-t)^{n-j}Q_j(t).$$

Write Q(z,t), P(z,t) for the respective exponential generating series in the row index. The binomial transform says Q=exp(tz)P. Multiplication of the recurrence for Q by z^j/j! and summation gives

$$Q_z=tQ+(1+t)zQ_z+t(1-t)Q_t.$$

Substitute Q=exp(tz)P and cancel the common exponential to obtain

$$P_z=(1+t)zP_z+t(1-t)P_t+2tzP.$$

Reading coefficients gives the corrected recurrence at every index. At t=1, the row sums a_n satisfy a₀=1, a₁=0 and a_n=2(n−1)(a_{n−1}+a_{n−2}). Consecutive row sums have positive sum, by induction. Replacing n−1 by n−2 therefore gives the wrong value at t=1 for every n≥2. The known row sums also provide an independent check. [A053871](https://oeis.org/A053871)

## Lean

`AlexanderssonRows.lean` verifies the binomial transform, the corrected identity in the polynomial ring ℤ[t], and the failure of the printed identity in every row n≥2. It works directly with finite differences of the standard reversed second-order Eulerian recurrence and does not require formal exponential series. The three theorems use only the standard Lean axioms and were checked with Lean 4.19.0. This is an index correction in a specific OEIS formula.
