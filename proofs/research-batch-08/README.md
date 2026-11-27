# Research results, 27 November 2026

| Original statement | Result | Lean coverage |
| --- | --- | --- |
| [Markus Sigg, OEIS A399704](https://oeis.org/A399704) | [A single admissible tuple minimizes the sum, product and their quotient for every n ≥ 3](extrema/Sigg.md). | [All three minima over actual finite sets and identification of the least last entry](extrema/Sigg.lean). |
| [Takuto Nakai, OEIS A400474](https://oeis.org/A400474) | [The exact maximum number of interior points from which a triangle subtends three distinct integral multiples of π/n](arithmetic/A400474.md). | [Optimization and final formula](arithmetic/ViewingAngles.lean). The geometric correspondence and inclusion–exclusion are written. |
| [MathOverflow 483753](https://mathoverflow.net/questions/483753) | [A falling-factorial expansion connecting A358612 and A373183](combinatorics/BinaryStirling.md). | [Finite-difference, basis and coefficient identities](combinatorics/BinaryStirling.lean). The complete recurrence argument is written. |
| [MathOverflow 479628](https://mathoverflow.net/questions/479628) | [Schröder area polynomials from a Pascal-type recurrence](combinatorics/SchroederArea.md). | [Weight-preserving bijection and geometric area](combinatorics/SchroederArea.lean). The enumeration of the input paths by the stated recurrence is written. |
| [Guttmann and Kotěšovec, area of L-convex polyominoes](https://www.mat.univie.ac.at/~slc/wpapers/lattpath/GuttmannKotesovec/GuttmannKotesovec.pdf) | [Partial. The limit of log a(n)/√n is π√(13/6)](geometry/l-convex-asymptotics.md). | [Real transfer-matrix bounds](geometry/LConvexTransfer.lean). The integral evaluation and passage to coefficients are written. |


Run **lake build** in this directory with Lean 4.19.0 and the pinned mathlib revision. Run **python arithmetic/check_viewing_angles.py** to reproduce the independent finite checks for A400474.
