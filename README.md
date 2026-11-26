# Proofs and counterexamples for OEIS sequences

## Robert Israel’s six-position conjecture

Where does an integer first appear in Kimberling’s permutation? In February 2020 Robert Israel conjectured that for every n > 1 its position is one of n/2, n+1, 2n+2, 2n+3, 4n+3 or 4n+5. The proof rules out the remaining candidate 4n+4 for every n. Lean 4.19 checks the theorem from the defining recurrence. [English proof guide](Israel-proof.md) · [Formal theorem](Israel.lean) · [OEIS A050129](https://oeis.org/A050129)

## Further proofs

| OEIS entry | Result |
| --- | --- |
| [A113572](https://oeis.org/A113572) and [A113573](https://oeis.org/A113573) | Murthy’s digit condition admits a multiple of n exactly when n is 5 or is coprime to 5. [Proof](murthy-digits.md) · [Lean](MurthyDigits.lean) |
| [A048625](https://oeis.org/A048625) | The Pisot sequence P(4,6) obeys the Narayana recurrence. For any positive integer seeds x < y, five terms decide whether this recurrence holds forever. The note also proves Gladkovskii’s continued fraction. [Written proof and earlier results](Pisot-A048625.ru.txt) · [Lean certificates](NarayanaPisot.lean) |
| [A377000](https://oeis.org/A377000) | Walks on a path give proofs of Wu’s three statements about esthetic numbers and identify two diagonals. The recurrence follows from earlier work. [Proofs and sources](A377000.md) · [Checks](verify_esthetic.py) |

The [downloadable collection](oeis-proofs-nov26-round3.zip) includes a standalone A050129 project requiring only the Lean standard library.

For Clark Kimberling’s sequence [A376453](https://oeis.org/A376453), the OEIS entry conjectures that consecutive terms differ by 2, 3, 4 or 5. The first larger gap runs from **104,080,799 to 104,080,805**. Every integer at least 2 occurs infinitely often as a gap.

The sequence consists of integers whose greedy expansion using the place values 1, 2, 4, 6, 9, 12, … ends in 1. A gap with endpoints `a,b` yields another with endpoints `b(b−1)+a, b²+1`. Its length increases by one. Starting from (1,3) gives (7,10), (97,101), (10197,10202), and the gap of 6 above. Lean checks adjacency, the exact gap spectrum and recurrence of each gap. A separate written proof identifies the first occurrence of every gap size. [Lean proof](QuarterGaps.lean) · [First occurrences](first-gaps.md) · [Verification script](verify_gaps.py)

| Question | Result and verification |
| --- | --- |
| [Fröhlich, A308482](https://oeis.org/A308482) | 413343 is the smallest composite after 189 satisfying the stronger congruence modulo its square. A search through one million establishes minimality. Lean verifies the witness from the polynomial coefficient definition, using `native_decide` for the final numerical remainder. An independent certificate gives 30 examples beyond 189. [Lean](FrohlichNative.lean) · [Short proof](short-proof.md) · [Family certificate](family_certificate.py) |
| Kimberling’s five permutation questions | A050128, A050135, A050136, A050137 and A050138 each contain every positive integer exactly once. In A050128 the position of n is at most 4n+5, with equality for n=81. [General Lean proof](IndexPermutations.lean) · [Position bound](DoubleHalf.lean) · [OEIS](https://oeis.org/A050128) |
| [Wu, A048582](https://oeis.org/A048582) and [Stephan, A020748](https://oeis.org/A020748) | A linear recurrence and a generating function hold at every index. The written proofs use exact rational certificates for root bounds and integer checks for a finite prefix. [Proofs](pisot-proof.ru.md) · [Certificates](verify_pisot.py) |
| [Sharma, A401897](https://oeis.org/A401897) and [A401675](https://oeis.org/A401675) | The visible-point counts are asymptotic to 48n/π² on the square lattice and 6n/π² on the hexagonal spiral, each with error O(√n log(n+1)). [Written proofs](visibility-proof.ru.txt) · [Numerical checks](visible.py) |

## Reproduce

With elan installed, run these commands in the repository root.

```sh
lake exe cache get Mathlib.Data.Nat.Sqrt Mathlib.Tactic.Linarith Mathlib.Tactic.Ring Mathlib.Tactic.NormNum.Prime Mathlib.Data.Int.ModEq Mathlib.Algebra.Polynomial.Derivative
lake build
python verify_gaps.py
python frohlich_certificate.py
python family_certificate.py
```

The toolchain is pinned to Lean 4.19.0 and the Mathlib revision is recorded in the manifest. The Python scripts use the standard library. The Fröhlich witness uses Lean’s native evaluator, with the additional axiom `Lean.ofReduceBool`. The gap and permutation theorems use the usual kernel axioms. The Pisot and visibility proofs are written arguments. This work used AI assistance for discovery and formalization. Historical priority remains open. The related M=3, D=2 permutation result already has a 2006 proof sketch in [A050132](https://oeis.org/A050132).

[Russian overview, sources and reproduction instructions](README.ru.md)
