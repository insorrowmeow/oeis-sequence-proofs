# Proofs and counterexamples for OEIS sequences

Integer sequences, recurrences, congruences and a related study of rank-four matroids. [Русская версия](README.ru.md) · [Run the proofs](#reproduce)

## Results

Open a problem title for its proof or computation. The last column links to the Lean theorem when available.

✅ Full Lean proof of the stated result · 🟡 Lean proof of the indicated part · ⬜ Written proof or computation only

| Problem and OEIS entry | Result | Lean verification |
| :--- | :--- | :--- |
| [Sun’s eleven-term conjecture](results/A279821.md)<br>[A279821](https://oeis.org/A279821) | 1,316,632,279 is an additional composite solution of the central trinomial congruence. | ✅ [Full proof](Sun.lean#L167) |
| [Wiseman’s all-ones rows](A385886.md)<br>[A385886](https://oeis.org/A385886) | Row 7 is (1,1,1,1). Its index contradicts the proposed Fibonacci formula. | ✅ [Full proof](AntiRunWitness.lean#L47) |
| [Indices of all-ones and one-part rows](composition-rank-and-wythoff.txt)<br>[A385886](https://oeis.org/A385886) | The row of d ones has index $F_{d+2}-1$. The one-part row (r) has index $F_{2r}$ for every positive r. | ⬜ Written proof |
| [Israel’s six-position conjecture](Israel-proof.md)<br>[A050129](https://oeis.org/A050129) | For every n > 1, its position in Kimberling’s permutation is one of n/2, n+1, 2n+2, 2n+3, 4n+3, 4n+5. | ✅ [Full proof](Israel.lean#L40) |
| [Hasler’s prime periods](A300326-period.md)<br>[A300326](https://oeis.org/A300326) | The least period is p(p−1) for primes p ≥ 5, and 8 and 9 for p = 2 and 3. Each period ends in 1, 1, 0, 0. | ✅ [Full proof](Hasler.lean#L129) |
| [Prime divisors](A300326-period.md)<br>[A300326](https://oeis.org/A300326) | For any finite set of primes there are arbitrarily late terms congruent to 1 modulo every prime in the set. | ✅ [Full proof](Hasler.lean#L352) |
| [Cano’s question, finite range](check_cano.py)<br>[A300326](https://oeis.org/A300326) | Every term from index 5 through 5,000 is composite. The question about later primes remains open in this work. | ⬜ Exact computation |
| [Kimberling’s gap conjecture](gaps-proof.ru.md)<br>[A376453](https://oeis.org/A376453) · [A376452](https://oeis.org/A376452) | A gap of 6 runs from 104,080,799 to 104,080,805. Every gap size d ≥ 2 occurs infinitely often. | ✅ [Full proof](QuarterGaps.lean#L168) |
| [First gap of each size](first-gaps.md)<br>[A376453](https://oeis.org/A376453) | The first gap of size d has right endpoint $E_d$, where $E_2=3$ and $E_{d+1}=E_d^2+1$. | ⬜ Written proof |
| [Mathar’s printed recurrence](results/A103769.txt)<br>[A103769](https://oeis.org/A103769) | At n = 4 the proposed recurrence has residual −81,756. | ✅ [Full proof](Mathar.lean#L27) |
| [Corrected recurrence](results/A103769.txt)<br>[A103769](https://oeis.org/A103769) | Multiplying the leading coefficient by 4 gives an identity for all n ≥ 4. [Polynomial identity](results/correct_mathar.py) | ⬜ Written proof |
| [Fröhlich’s composite witness](short-proof.md)<br>[A308482](https://oeis.org/A308482) | The composite 413,343 satisfies the stronger congruence modulo its square. [Arithmetic certificate](frohlich_certificate.py) | ✅ [Full proof · native_decide](FrohlichNative.lean#L5) |
| [First witness after 189 and a family](trinomial-proof.ru.md)<br>[A308482](https://oeis.org/A308482) | 413,343 is the smallest composite solution after 189. A separate certificate gives 30 solutions beyond 189. [Family certificate](family_certificate.py) | ⬜ Written proof |
| [Kimberling’s greedy set](results/A026488.md)<br>[A026488](https://oeis.org/A026488) | Its members are exactly 3 and the positive integers congruent to 1 modulo 3. | ✅ [Full proof](Kimberling.lean#L95) |
| [Five greedy permutations](permutations-proof.ru.md)<br>[A050128](https://oeis.org/A050128) · [A050135](https://oeis.org/A050135) · [A050136](https://oeis.org/A050136) · [A050137](https://oeis.org/A050137) · [A050138](https://oeis.org/A050138) | Each sequence takes every positive integer exactly once. One family theorem covers the five rules and their seeds. | ✅ [Full proof](IndexPermutations.lean#L119) |
| [Sharp position bound](DoubleHalf-RU.md)<br>[A050128](https://oeis.org/A050128) | The position satisfies T(n) ≤ 4n+5. Equality occurs at n = 81, whose position is 329. [Sharpness check](verify_double_half.py) | 🟡 [Upper bound](DoubleHalf.lean#L122) |
| [Murthy’s digit condition](murthy-digits.md)<br>[A113572](https://oeis.org/A113572) · [A113573](https://oeis.org/A113573) | An admissible multiple exists exactly when n = 5 or 5 does not divide n. The zero positions are 10, 15, 20, … | ✅ [Full proof](MurthyDigits.lean#L225) |
| [Hadjicostas’s remainder sum](results/A049804.md)<br>[A049804](https://oeis.org/A049804) | Appending a digit r in any base b ≥ 2 gives $s_b(bn+r)=b s_b(n)+r(1+\lfloor\log_b n\rfloor)$ for n ≥ 1. | ✅ [Full proof](RemainderSum.lean#L30) |
| [The Frayed Rope permutation](A340138.txt)<br>[A340138](https://oeis.org/A340138) | Under the digital-root rule in the author’s program and table, every nonnegative integer occurs exactly once. | ✅ [Full proof](FrayedRope.lean#L147) |
| [Growth, residues and powers of ten](A340138.txt)<br>[A340138](https://oeis.org/A340138) | For $α=\log_{10}9$, $a(n)=n+O(n^α)$. Residues are equidistributed and the displacement of $10^k$ is eventually constant. | ⬜ Written proof |
| [Wiseman’s partition rows](A365383.md)<br>[A365383](https://oeis.org/A365383) | Extended row n has least eventual period n for every n ≥ 1. | ✅ [Full proof](PartitionPeriods.lean#L229) |
| [First periodic column](A365383.md)<br>[A365383](https://oeis.org/A365383) | An exact formula gives the first column of periodicity for each row. For n = 8 it is column 8, counting from zero. | ⬜ Written proof |
| [Tetrastix distances and spheres](A342235.md)<br>[A342235](https://oeis.org/A342235) | The exact distance gives sphere sizes $3r^2+1$ at odd radii and $3r^2+2$ at even radii r ≥ 4. The first even sizes are 1 and 12. | 🟡 [Distance formula](Tetrastix.lean#L149) |
| [Dale’s Pisot–Narayana recurrence](Pisot-A048625.ru.txt)<br>[A048625](https://oeis.org/A048625) | P(4,6) satisfies $a_{n+3}=a_{n+2}+a_n$. For any positive integer seeds x < y, the first five terms decide whether it holds forever. | ✅ [Full proof](NarayanaPisot.lean#L84) |
| [Gladkovskii’s continued fraction](Pisot-A048625.ru.txt)<br>[A048625](https://oeis.org/A048625) | The continued fraction equals the generating function as a formal power series. | 🟡 [Finite truncation identity](NarayanaPisot.lean#L151) |
| [Wu’s and Stephan’s Pisot formulas](pisot-proof.ru.md)<br>[A048582](https://oeis.org/A048582) · [A020748](https://oeis.org/A020748) | Wu’s order-seven recurrence for seeds (4,9) holds from n = 7. Stephan’s rational generating function for (4,10) holds at every index. [Certificates](verify_pisot.py) | ⬜ Written proof |
| [Eight ceiling Pisot sequences](results/Pisot-recurrences.txt)<br>[A048590](https://oeis.org/A048590) · [A048592](https://oeis.org/A048592) · [A048591](https://oeis.org/A048591) · [A048587](https://oeis.org/A048587) · [A020736](https://oeis.org/A020736) · [A048580](https://oeis.org/A048580) · [A048585](https://oeis.org/A048585) · [A048589](https://oeis.org/A048589) | Exact certificates prove eight linear recurrences from their stated starting indices. The note identifies the previously proved case and its shift. [Certificates](results/verify.py) | ⬜ Written proof |
| [Floor Pisot sequence with seeds (5,9)](results/Pisot-recurrences.txt)<br>[A020750](https://oeis.org/A020750) | The order-five recurrence holds for every n ≥ 5. [Certificate](results/salem.py) | ⬜ Written proof |
| [Wu’s esthetic-number questions](A377000.md)<br>[A377000](https://oeis.org/A377000) | Path walks give the differential-composition count, the minimal recurrence in each base, and the diagonal identities with A182555 and A206603. | ⬜ Written proof |
| [Binary runs and Stolarsky digits](wiseman-binary.txt)<br>[A083368](https://oeis.org/A083368) · [A200648](https://oeis.org/A200648) · [A200649](https://oeis.org/A200649) · [A200650](https://oeis.org/A200650) | Run and anti-run lengths give the four statistics, with the first-index exceptions in A200648 and A200650. A083368 uses its changed-bit definition. | ⬜ Written proof |
| [Composition ranks and Kurkov’s recurrence](composition-rank-and-wythoff.txt)<br>[A385886](https://oeis.org/A385886) · [A385818](https://oeis.org/A385818) · [A348366](https://oeis.org/A348366) · [A200649](https://oeis.org/A200649) | The rank of row j of A385886 is A348366(j). Counting its parts gives the proposed recurrence in A200649. | ⬜ Written proof |
| [Wythoff words and index shifts](composition-rank-and-wythoff.txt)<br>[A341259](https://oeis.org/A341259) · [A117479](https://oeis.org/A117479) · [A200649](https://oeis.org/A200649) · [A200650](https://oeis.org/A200650) | For k ≥ 1, A341259(k) = A200649(k+2) − 1 and A117479(k) = A200650(k+2). | ⬜ Written proof |
| [Kotěšovec’s column asymptotic](A385001.txt)<br>[A385001](https://oeis.org/A385001) | For every fixed positive column k, a lattice-point count gives its partial-sum asymptotic with error $O_k(N^{2k-1}\log(2N))$. | ⬜ Written proof |
| [Sharma’s visible lattice points](visibility-proof.ru.txt)<br>[A401897](https://oeis.org/A401897) · [A401675](https://oeis.org/A401675) | The square and hexagonal spiral counts have leading terms $48n/π^2$ and $6n/π^2$, respectively, with error $O(\sqrt n\log(n+1))$. | ⬜ Written proof |
| [Rank-four matroids · sufficient conditions](results/rank-four-interlacing.txt) | The dual Chow and dual right augmented Chow roots strictly interlace if line sizes are constant or every line lies in the same number of planes. | ⬜ Written proof |
| [Rank-four matroids · restrictions and examples](results/rank-four-family.txt) | Failure requires a plane with at least seven points and positive covariance between the number of planes through a line and its size-dependent weight. An explicit family approaches equality from the interlacing side. [Covariance identity](results/covariance.txt) | ⬜ Written proof |

## Reproduce

The project pins Lean 4.19.0 and the Mathlib revision in the manifest. With elan installed, run these commands in the repository root.

```sh
lake exe cache get
lake build
```

To inspect the axioms of a particular proof, run its source file, for example `lake env lean Sun.lean` or `lake env lean AntiRunWitness.lean`. The Fröhlich witness uses Lean’s native evaluator and the additional axiom `Lean.ofReduceBool`. The minimality search and the certificate for the 30 examples are separate computations. [Minimality search](frohlich.py) · [Family certificate](family_certificate.py)

Mathematical discovery, writing and formalization used AI assistance. The notes cite prior results, including the earlier permutation argument in A050132, the spectral formula for esthetic numbers and MacMahon’s divisor sums. The final two entries prove statements for specified rank-four matroids. Their scope is given in the proofs.

[Standalone proof files from 27 November](oeis-proofs-2026-11-27.zip) · [Collection with the standalone Israel project](oeis-proofs-nov26-round3.zip) · [Earlier computation scripts](results/README.md)
