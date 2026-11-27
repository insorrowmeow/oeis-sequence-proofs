# The rows of Rule 67 and two OEIS conjecture entries

Start the infinite automaton from the single live cell at position zero. Read its row from \(-n\) to \(+n\), left to right, as an integer in base \(b\). Write \(a_b(n)\) for this value. A266839 uses \(b=2\); A266838 writes the same digit string in base ten. Both sequences start at \(n=0\).

**Counterexample.** Keller's odd-index formula in A266839 gives \(193/2\) for \(n=3\). The actual row is \(1100001_2=97\). The odd formula is valid for every odd \(n\ge5\). The even formula in A266839 and both formulas in A266838 hold on their stated ranges. The recurrences and generating functions proposed by Colin Barker follow in both bases.

## The configuration on the whole line

Rule 67 returns 1 precisely on the neighborhoods 000, 001 and 110. From the single seed its uniform background alternates. The early configurations are:

| Time | Background | Sites differing from the background |
| --- | --- | --- |
| 0 | 0 | 0 |
| 1 | 1 | 0, 1 |
| 2 | 0 | −1, 1 |
| 3 | 1 | −1, 0, 1, 2 |
| 4 | 0 | −2, 0, 1, 2 |
| 5 | 1 | −2, −1, 0, 1, 3 |
| 6 | 0 | −3, −1, 0, 1 |

Every entry follows by applying the three live neighborhoods above. Row 6 equals row 4 translated one site left. Since the local rule commutes with translations, all subsequent rows repeat the same pair of patterns with that shift. The Lean theorem **SingleSeed67.all_rows** proves the two descriptions as equalities of functions on every integer site, for all times from 4 onwards.

## From sites to the conjectured numbers

At index \(4+2m\) the live cells are at \(\{-2,0,1,2\}-m\), and at \(5+2m\) the holes are at \(\{-2,-1,0,1,3\}-m\). The digit at site \(i\) has place value \(b^{n-i}\), so for every integer \(b\ge2\) and \(m\ge0\),

\[
\begin{split}
a_b(4+2m)&=b^{2+3m}(b^4+b^2+b+1),\\
a_b(5+2m)&=\frac{b^{11+4m}-1}{b-1}
    -b^{2+3m}(b^5+b^4+b^3+b^2+1).
\end{split}
\]

For the second formula subtract the five holes from a word of \(11+4m\) ones. Substituting \(b=2,10\) and \(n=4+2m\) or \(5+2m\) gives the stated Keller formulas on the corrected ranges.

In each parity class the expression is a linear combination of \(1^m,(b^3)^m,(b^4)^m\), including zero coefficients. Thus for \(n\ge4\),
\[
a_b(n+6)=(1+b^3+b^4)a_b(n+4)
 -(b^3+b^4+b^7)a_b(n+2)+b^7a_b(n).
\]
This gives Barker's two recurrences exactly. The generating-function denominator is \(Q=(1-x^2)(1-b^3x^2)(1-b^4x^2)\). The recurrence makes the numerator vanish in degrees 10 and higher. Multiplying by the first ten terms gives the following coefficient vectors, in increasing degree:

* \(b=2:\ (1,4,-15,-3,-6,-14,-172,-28,192,-64)\).
* \(b=10:\ (1,100,-9991,-99,-88910,-9990,-10901100,-99900,11000000,-1000000)\).

These are the two conjectured generating-function numerators. The corresponding denominators agree after factoring \(1-b^4x^2\).

## Verification and sources

[Rule67.lean](Rule67.lean) proves the full configuration theorem and the counterexample using the rule and the finite word evaluation. [check_automata.py](check_automata.py) independently evolves the automaton and compares the formulas, numerators and recurrences. The algebraic extraction of the universal word formulas above is a written argument. This note establishes the assertions in the entries and makes no claim of historical priority.

* [OEIS A266839, base two](https://oeis.org/A266839)
* [OEIS A266838, base ten](https://oeis.org/A266838)
