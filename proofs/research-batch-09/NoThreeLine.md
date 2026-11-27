# The proposed upper bound for the greedy no-three-in-line sequence

[MathOverflow 338528](https://mathoverflow.net/questions/338528/on-the-first-sequence-without-collinear-triple) asks, as a subsidiary question, whether $n/10\le u_n\le5n/4$. With the zero-based indexing of [OEIS A236266](https://oeis.org/A236266), $u_{23}=31$ gives $4u_{23}=124>115$. If one numbers the first term as term 1, the same point gives $124>120$. This is a counterexample to the uniform upper bound under either convention. The initial terms giving the witness already appear in the question.

[Lean certificate](NoThreeLine.lean) checks directly from the greedy definition that the first 24 entries are forced. At each column $n$ it checks the proposed ordinate and every smaller nonnegative ordinate against every earlier pair $i<j<n$. The criterion for a forbidden triple is $(j-i)y+(n-j)u_i=(n-i)u_j$.

The independent [integer sieve](check_no_three_line.py) extends every earlier pair along its primitive integer direction and marks all forbidden future lattice points up to column 999. The upper bound fails at 15 indices in this range, the last being $u_{922}=1191$. This does not settle eventual bounds or the principal question of whether every nonnegative integer occurs twice.
