# Where each integer occurs in Kimberling’s permutation

If n > 1, its unique one-based position T(n) in Kimberling’s sequence is one of **n/2, n+1, 2n+2, 2n+3, 4n+3, 4n+5**. The first option requires even n. For example, 81 occurs at position 329 = 4·81+5. Robert Israel proposed this list in 2020. [Original conjecture](https://oeis.org/A050129/internal) · [Lean theorem](Israel.lean)

Start with 1. At position i try the integer half of the preceding value. Use it if it is positive and new. Otherwise write 2i. Each term is at most 2i, so a fresh fallback 2i exceeds all previous terms. Whenever x appears, its positive integer half has appeared by the next step. These observations give uniqueness and the bound T(n) ≤ 4n+5. Tracing the last few divisions then leaves Israel’s six candidates and one extra candidate, 4n+4. [Seven-position lemma](proofs/early/DoubleHalf.lean)

Suppose n is the least integer at the extra position. Treat “v occurs at t” as a proposition. Each position has one value, and each value has one position. If 2v or 2v+1 occurs at u, then v occurs by u+1. Conversely, if v occurs at t > 1 and v differs from 2t, then its predecessor must be 2v or 2v+1. Together these facts force incompatible assignments around the supposed exception. [Formal constraints](proofs/early/InverseBase.lean)

For n < 32 the kernel checks the initial sequence directly. All larger indices are covered by the following seven forms, with k any nonnegative integer.

| Index | Derivation |
| --- | --- |
| 32+4k | [81 constraints](proofs/early/P4R0.lean) |
| 34+4k | [81 constraints](proofs/early/P4R2.lean) |
| 33+8k | [215 constraints](proofs/early/P8R1.lean) |
| 37+8k | [215 constraints](proofs/early/P8R5.lean) |
| 39+8k | [70 constraints](proofs/early/P8R7.lean) |
| 35+16k | [138 constraints](proofs/early/P16R3.lean) |
| 43+16k | [138 constraints](proofs/early/P16R11.lean) |

A SAT solver helped find the contradictions. In each file Lean derives the constraints from the sequence for arbitrary k and checks the propositional deductions. Strong induction gives the six-position theorem. Its reported axioms are propext, Classical.choice and Quot.sound. [Initial cases](proofs/early/InversePrefix.lean) · [Final induction and theorem](Israel.lean) · [Detailed proof in Russian](proofs/early/Israel-proof.ru.md)

Run `lake build Israel` in the repository root with Lean 4.19.0, or unpack the [standalone project](proofs/archives/oeis-proofs-nov26-round3.zip) and run `lake build` in its inverse directory. The command `python proofs/early/verify_inverse.py` checks the same seven certificates independently using the Python standard library. This work used AI assistance.
