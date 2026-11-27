# Two and three columns of A401159

[A401159](https://oeis.org/A401159) counts labeled binary matrices with at most two ones in each row and each column. Its two conjectured column formulas follow from the same count. [A086601](https://oeis.org/A086601) already identifies the second column in its reference to Richard J. Mathar's 2014 table, so the two-column identification predates the conjecture entry.

Write $Q=1+n+\binom n2=1+n(n+1)/2$. A column is specified by choosing zero, one, or two of its $n$ rows. For two columns all $Q^2$ choices obey the row bound. This proves $T(n,2)=\mathrm{A086601}(n)$.

For three columns, start from $Q^3$. A forbidden row consists of three ones. Fix that row. In each column the remaining one, if present, can be in any of the other $n-1$ rows, giving $n$ choices including absence. Thus subtract $n\cdot n^3$. For two specified forbidden rows every column is already full, so exactly one matrix was subtracted twice; add $\binom n2$. Three forbidden rows cannot coexist. Hence
$$
T(n,3)=Q^3-n^4+\binom n2
=1+n+\frac{11n^2}{4}+\frac{13n^3}{8}
 +\frac{n^4}{8}+\frac{3n^5}{8}+\frac{n^6}{8}.
$$
This includes $n=0$ with the natural empty-matrix convention.

[Lean](MatrixColumns.lean) independently proves both formulas for every natural $n$ by induction for all 27 triples of remaining column capacities. Its counting function appends one row at a time, choosing each of the seven legal supports once and rejecting choices that exhaust an already empty capacity. A zero-capacity third column specializes the same construction to two columns. The bijection with matrices is the unique decomposition into the appended row and the preceding rows.
