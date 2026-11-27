# A Pascal-type recurrence for the Schröder area polynomials

The diagonal in MathOverflow 479628 is the entire area polynomial of Schröder paths of semilength \(n\). The original post had neither answers nor comments in the Stack Exchange API when checked. [Original question](https://mathoverflow.net/questions/479628/recursion-for-a129179-similar-to-recursion-for-pascals-triangle) · [OEIS A129179](https://oeis.org/A129179)

For a position \((a,b)\) in the posted recurrence put \(h=a-b\). It counts walks beginning at height zero and staying nonnegative. There are three kinds of step:

| Initial height | Final height | Weight | Change in \(b\) |
|---|---|---|---|
| any \(h\) | \(h+1\) | \(1\) | \(0\) |
| odd \(h\) | \(h-1\) | \(z^{h-1}\) | \(1\) |
| odd \(h\ge3\) | \(h-2\) | \(z^{h-2}\) | \(1\) |

Indeed, the up-step corresponds to the summand \(P(a-1,b)\). For a descent landing at height \(h\), the predecessor in the other summand has height \(h+1+(h\bmod 2)\), necessarily odd. Its contribution has the factor \(z^h\). With \(b=0\) there is precisely one all-up walk to each nonnegative height. A walk ending at \((a,b)\) has at most \(a-b+2b\) up-steps, so the counts are finite and obey the exact boundary and recurrence in the question.

Now take walks counted by \(P(n+1,n+1)\). They start and end at zero with \(n+1\) descents. Each starts by going to height one, and each ends by descending from one to zero. Between these endpoints, every visit to an even height is followed by the forced up-step back to an odd height.

Read only the successive visits to odd heights, replacing height \(2u+1\) by \(u\). From \(u\) the three possibilities are as follows.

* Two up-steps lead to \(u+1\). Encode them by a Schröder up-step.
* A descent by one followed by the forced up-step leads back to \(u\). Encode them by a horizontal step of length two, of weight \(z^{2u}\).
* A descent by two leads to \(u-1\). Encode it by a down-step of weight \(z^{2u-1}\).

The first step from zero and the last descent to zero are discarded, and the last descent has weight one. Each encoded walk is a nonnegative Schröder excursion. Its semilength is the number of horizontal steps plus the number of down-steps, namely \(n\). Conversely, expanding the three step types and inserting the two end-steps reconstructs the original walk uniquely. This includes the empty Schröder excursion at \(n=0\).

At height \(u\), a length-two horizontal step contributes geometric area \(2u\). Match each up-step from height \(u-1\) to \(u\) with its first returning down-step. The two unit-width steps together contribute area \(2u-1\). Thus the exponent of \(z\) is exactly the geometric area below the encoded path. Summing over all excursions proves the proposed equality at every index.

Lean checks that expansion and compression are mutual inverses, including the last descent, and that they preserve the weights. The theorem `excursion_geometry` independently sums the trapezoidal areas of the individual geometric steps. The identification of the numerical triangle recurrence with the enumeration of the input walks is written above. [Formal bijection and area proof](SchroederArea.lean)
