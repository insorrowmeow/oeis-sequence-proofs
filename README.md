# Mathematical proofs and counterexamples

Integer sequences, partitions, graph theory and related problems in combinatorics and number theory. [Русская версия](README.ru.md) · [Detailed statements and verification](docs/verification.md) · [Run the proofs](#reproduce)

## Results

Each title opens a proof. Select its status for the precise Lean statement, source files and any hypotheses.

✅ Full result in Lean · 🔷 Lean proof from stated mathematical inputs · 🟡 Partial Lean verification · ⬜ Written proof or computation

| Problem | Lean | Problem | Lean |
| :--- | :---: | :--- | :---: |
| [Pastorek’s graph burning bound](proofs/local-round-23/graph/Proof.md) | [✅ Full](docs/verification.md#result-139) | [A085588 · width-four counterexample](proofs/further-round/automata/rule150.md) | [✅ Full](docs/verification.md#result-57) |
| [Voloshyn’s description-tree formula (3.55)](proofs/local-round-23/trees/Proof.md) | [🔷 From inputs](docs/verification.md#result-138) | [MathOverflow 402635 and 408765](proofs/further-round/words/rook-tours.md) | [🟡 Partial](docs/verification.md#result-58) |
| [Gray–Payne–Swisher–Watson, critical modulus](proofs/local-round-22/Critical-modulus.md) | [✅ Full](docs/verification.md#result-137) | [A275667](proofs/further-round/automata/triangular.md) | [⬜ No Lean](docs/verification.md#result-59) |
| [Lagarias–Sun, cutoff by partition size](proofs/local-round-21/Size-boundary.md) | [🔷 From inputs](docs/verification.md#result-136) | [A122251 and A122249](proofs/further-round/hankel/barry.md) | [⬜ No Lean](docs/verification.md#result-60) |
| [Lagarias–Sun, cutoff by perimeter](proofs/local-round-20/Lagarias-Sun.md) | [🔷 From inputs](docs/verification.md#result-135) | [A173993, A174013, A174015 and A174016](proofs/further-round/combin/mathar-algebraic.md) | [🟡 Partial](docs/verification.md#result-61) |
| [Ordinary partition norm at fixed perimeter](proofs/local-round-20/Ordinary-norm.md) | [⬜ No Lean](docs/verification.md#result-134) | [A195422](proofs/further-round/counts/cyclic-permanent.md) | [⬜ No Lean](docs/verification.md#result-62) |
| [Coulter–Do–Moskovsky, multivariate stability](proofs/local-round-19/Hurwitz-stability.md) | [✅ Full](docs/verification.md#result-133) | [Optimal greedy sums of squares · A401548](proofs/research-batch-06/squares/OptimalGreedy.md) | [🟡 Partial](docs/verification.md#result-63) |
| [Connelly et al., products of q-integers](proofs/local-round-19/ThreeFactorCriterion.md) | [🟡 Partial](docs/verification.md#result-132) | [Exact Rule 150 periods · A085588](proofs/research-batch-06/automata/A085588.md) | [✅ Full](docs/verification.md#result-64) |
| [Pak–Panova, strict Schur unimodality](proofs/local-round-18/Pak-Panova-Schur.md) | [✅ Full](docs/verification.md#result-131) | [Fibonacci cycle spectra · A401899](proofs/research-batch-06/spectra/FibonacciCycle.md) | [🟡 Partial](docs/verification.md#result-65) |
| [Gatzweiler–Krattenthaler, four-factor refinement](proofs/local-round-18/Shifted-products.md) | [✅ Full](docs/verification.md#result-130) | [Binary Fibonacci columns · A036284](proofs/research-batch-06/arithmetic/A036284.md) | [✅ Full](docs/verification.md#result-66) |
| [Zanello, equal-area rectangles (smallest side ≤ 24)](proofs/local-round-17/Zanello.md) | [🟡 Partial](docs/verification.md#result-129) | [Digital-root periods · A210456](proofs/research-batch-06/arithmetic/A210456.md) | [✅ Full](docs/verification.md#result-67) |
| [Stanley–Zanello, centered Gaussian differences](proofs/local-round-16/Gaussian-differences.md) | [🟡 Partial](docs/verification.md#result-128) | [Rule 67 rows · A266839](proofs/research-batch-06/automata/Rule67.md) | [🟡 Partial](docs/verification.md#result-68) |
| [Zbarsky’s near-rectangular strict partitions](proofs/local-round-15/Zbarsky-PROOF.md) | [🟡 Partial](docs/verification.md#result-127) | [Ranks in A260711 · MO 466152](proofs/research-batch-06/combinatorics/A260711.md) | [🟡 Partial](docs/verification.md#result-69) |
| [Makowsky–Rakita, random-graph independence counts](proofs/local-round-14/PROOF.md) | [🟡 Partial](docs/verification.md#result-126) | [Half-turn orbits · A334386](proofs/research-batch-06/geometry/tetrahedral-triangles.md) | [🟡 Partial](docs/verification.md#result-70) |
| [Schott’s decimal insertion bound](proofs/research-batch-13/DigitRatio.md) | [✅ Full](docs/verification.md#result-1) | [Column profiles of polyominoes · A308359](proofs/research-batch-06/geometry/near-maximal-width.md) | [🟡 Partial](docs/verification.md#result-71) |
| [Karttunen’s arithmetic-derivative collisions](proofs/research-batch-13/PrimorialCarryCollision.md) | [🟡 Partial](docs/verification.md#result-2) | [Domino diagonal identities · A333650](proofs/research-batch-06/geometry/domino-towers.md) | [🟡 Partial](docs/verification.md#result-72) |
| [Weber’s rook inequalities](proofs/research-batch-13/RookRanks.md) | [✅ Full](docs/verification.md#result-3) | [Pythagorean parameter jumps · A400884](proofs/research-batch-06/arithmetic/A400884.md) | [🟡 Partial](docs/verification.md#result-73) |
| [Sharp bounds for a six-phase recurrence](proofs/research-batch-13/SixPhaseOrbit.md) | [✅ Full](docs/verification.md#result-4) | [Odd-divisor ranks · MO 438304](proofs/research-batch-06/combinatorics/OddDivisorRanks.md) | [✅ Full](docs/verification.md#result-74) |
| [Bounds for the sum-and-halve recurrence](proofs/research-batch-13/ParityEnvelope.md) | [✅ Full](docs/verification.md#result-5) | [Luschny’s row recurrence · A395454](proofs/research-batch-06/geometry/alexandersson-row-recurrence.md) | [✅ Full](docs/verification.md#result-75) |
| [Composite partners in sums equal to a power of two](proofs/research-batch-13/CompositePowerPartners.md) | [✅ Full](docs/verification.md#result-6) | [Brennan’s prime generators](proofs/research-batch-06/geometry/brennan-prime-generators-partial.md) | [⬜ No Lean](docs/verification.md#result-76) |
| [Prime partners in sums equal to a power of two](proofs/research-batch-13/PrimePowerPartners.md) | [✅ Full](docs/verification.md#result-7) | [Ezerman, Meyer and Solé, Conjecture 4, p. 5](proofs/research-batch-07/digits/PolynomialPairs.md) | [✅ Full](docs/verification.md#result-77) |
| [Barnabei–Castronuovo–Silimbani, question 8.17](proofs/research-batch-12/InvolutionPoles.md) | [🟡 Partial](docs/verification.md#result-8) | [Digits in reverse products · A161721](proofs/research-batch-07/digits/ReverseProducts.md) | [🟡 Partial](docs/verification.md#result-78) |
| [A two-term asymptotic for pattern-avoiding involutions](proofs/research-batch-12/InvolutionSubdominant.md) | [⬜ No Lean](docs/verification.md#result-9) | [Continuant periods · MO 487169](proofs/research-batch-07/combinatorics/ContinuantPeriods.md) | [✅ Full](docs/verification.md#result-79) |
| [Meeussen’s partition sum](proofs/research-batch-12/MeeussenForestCoefficients.md) | [🟡 Partial](docs/verification.md#result-10) | [Perimeter-magic squares · A380962](proofs/research-batch-07/geometry/perimeter-magic.md) | [🟡 Partial](docs/verification.md#result-80) |
| [Wiesner’s disjoint-subset coloring problem](proofs/research-batch-12/PowersetSingleDefect.md) | [🟡 Partial](docs/verification.md#result-11) | [Domino tiling coefficients · A401673](proofs/research-batch-07/arithmetic/A401673.md) | [🟡 Partial](docs/verification.md#result-81) |
| [Small graphs with prescribed triangle counts](proofs/research-batch-12/TriangleSpectrum.md) | [🟡 Partial](docs/verification.md#result-12) | [Labeled mobiles · MO 492609](proofs/research-batch-07/combinatorics/MobileAlgorithm.md) | [🟡 Partial](docs/verification.md#result-82) |
| [Conditional path density in a minimizing graphon](proofs/research-batch-12/GraphonPinnedLeaves.md) | [🟡 Partial](docs/verification.md#result-13) | [Schröder row algorithm · MO 492866](proofs/research-batch-07/combinatorics/SchroederRowAlgorithm.md) | [🟡 Partial](docs/verification.md#result-83) |
| [Höft’s divisor triangle, columns one and three](proofs/research-batch-12/OddDivisorMinima.md) | [🟡 Partial](docs/verification.md#result-14) | [Repdigit bounds (partial) · A401895](proofs/research-batch-07/digits/ReverseProducts.md) | [🟡 Partial](docs/verification.md#result-84) |
| [Divisor-triangle column oscillations](proofs/research-batch-12/DivisorColumnOscillation.md) | [🟡 Partial](docs/verification.md#result-15) | [Markus Sigg, OEIS A399704](proofs/research-batch-08/extrema/Sigg.md) | [✅ Full](docs/verification.md#result-85) |
| [Powerful numbers with six squarefree neighbors](proofs/research-batch-12/PowerfulNeighbors.md) | [🟡 Partial](docs/verification.md#result-16) | [Takuto Nakai, OEIS A400474](proofs/research-batch-08/arithmetic/A400474.md) | [🟡 Partial](docs/verification.md#result-86) |
| [Kurkov’s self-squaring triangle coefficients](proofs/research-batch-11/PositiveDiagonalCoefficients.md) | [🟡 Partial](docs/verification.md#result-17) | [Binary Stirling expansion · MO 483753](proofs/research-batch-08/combinatorics/BinaryStirling.md) | [🟡 Partial](docs/verification.md#result-87) |
| [An explicit diagonal triple sum](proofs/research-batch-11/DiagonalTripleSum.md) | [🟡 Partial](docs/verification.md#result-18) | [Schröder area polynomials · MO 479628](proofs/research-batch-08/combinatorics/SchroederArea.md) | [🟡 Partial](docs/verification.md#result-88) |
| [Squares formed from neighboring largest proper divisors](proofs/research-batch-11/NeighborDivisorSquares.md) | [✅ Full](docs/verification.md#result-19) | [Guttmann and Kotěšovec, area of L-convex polyominoes](proofs/research-batch-08/geometry/l-convex-asymptotics.md) | [🟡 Partial](docs/verification.md#result-89) |
| [Signed collisions in the Flavius Josephus sieve](proofs/research-batch-11/JosephusSignedCollision.md) | [🟡 Partial](docs/verification.md#result-20) | [Sun’s eleven-term conjecture](results/A279821.md) | [✅ Full](docs/verification.md#result-90) |
| [Wiesner’s disjoint two-element sets](proofs/research-batch-11/DisjointCouples.md) | [🟡 Partial](docs/verification.md#result-21) | [Wiseman’s all-ones rows](A385886.md) | [✅ Full](docs/verification.md#result-91) |
| [Spanning-tree crossover in a Klein-bottle grid](proofs/research-batch-11/KleinTwist.md) | [🟡 Partial](docs/verification.md#result-22) | [Indices of all-ones and one-part rows](proofs/early/composition-rank-and-wythoff.txt) | [⬜ No Lean](docs/verification.md#result-92) |
| [Row polynomials of non-squashing partitions](proofs/research-batch-11/DyadicChainCut.md) | [🟡 Partial](docs/verification.md#result-23) | [Israel’s six-position conjecture](Israel-proof.md) | [✅ Full](docs/verification.md#result-93) |
| [Shen’s fragmentation question](proofs/research-batch-11/ShenFragmentation.md) | [🟡 Partial](docs/verification.md#result-24) | [Hasler’s prime periods](A300326-period.md) | [✅ Full](docs/verification.md#result-94) |
| [First letters for the largest-row variant](proofs/research-batch-11/GreedyLargestRows.md) | [🟡 Partial](docs/verification.md#result-25) | [Prime divisors](A300326-period.md) | [✅ Full](docs/verification.md#result-95) |
| [Faces in a unit-circle arrangement](proofs/research-batch-10/CircleDigons.md) | [🟡 Partial](docs/verification.md#result-26) | [Cano’s question, finite range](proofs/early/check_cano.py) | [⬜ No Lean](docs/verification.md#result-96) |
| [Equal-area, equal-perimeter square cuts](proofs/research-batch-10/EqualCuts.md) | [🟡 Partial](docs/verification.md#result-27) | [Kimberling’s gap conjecture](proofs/early/gaps-proof.ru.md) | [✅ Full](docs/verification.md#result-97) |
| [Twice-prime Heronian tangent lengths](proofs/research-batch-10/HeronFibers.md) | [🟡 Partial](docs/verification.md#result-28) | [First gap of each size](first-gaps.md) | [⬜ No Lean](docs/verification.md#result-98) |
| [Single-loop rectangular mirror placements](proofs/research-batch-10/MirrorGrid.md) | [🟡 Partial](docs/verification.md#result-29) | [Mathar’s printed recurrence](results/A103769.txt) | [✅ Full](docs/verification.md#result-99) |
| [Jablan’s mirror-count question in the labeled rectangular model](proofs/research-batch-10/MirrorPolynomial.md) | [⬜ No Lean](docs/verification.md#result-30) | [Corrected recurrence](results/A103769.txt) | [⬜ No Lean](docs/verification.md#result-100) |
| [Fourteen exponentially odd neighbors of a square](proofs/research-batch-10/OddNeighbors.md) | [🟡 Partial](docs/verification.md#result-31) | [Fröhlich’s composite witness](proofs/early/short-proof.md) | [✅ Full](docs/verification.md#result-101) |
| [Carry-free factorization of odd loop outputs](proofs/research-batch-09/A110978.md) | [🟡 Partial](docs/verification.md#result-32) | [First witness after 189 and a family](trinomial-proof.ru.md) | [⬜ No Lean](docs/verification.md#result-102) |
| [Vector algorithms for Dyck peak heights](proofs/research-batch-09/A140717.md) | [🟡 Partial](docs/verification.md#result-33) | [Kimberling’s greedy set](results/A026488.md) | [✅ Full](docs/verification.md#result-103) |
| [A binary square-sum identity](proofs/research-batch-09/A196148.md) | [🟡 Partial](docs/verification.md#result-34) | [Five greedy permutations](proofs/early/permutations-proof.ru.md) | [✅ Full](docs/verification.md#result-104) |
| [Two algorithms for Hanna’s coefficients](proofs/research-batch-09/A208832.md) | [🟡 Partial](docs/verification.md#result-35) | [Sharp position bound](proofs/early/DoubleHalf-RU.md) | [🟡 Partial](docs/verification.md#result-105) |
| [Factorial sweep for A217061](proofs/research-batch-09/A217061.md) | [🟡 Partial](docs/verification.md#result-36) | [Murthy’s digit condition](proofs/early/murthy-digits.md) | [✅ Full](docs/verification.md#result-106) |
| [Schröder factorization of the entire R table](proofs/research-batch-09/A338193.md) | [🟡 Partial](docs/verification.md#result-37) | [Hadjicostas’s remainder sum](results/A049804.md) | [✅ Full](docs/verification.md#result-107) |
| [The greedy coprimality permutation](proofs/research-batch-09/CoprimeGreedy.md) | [🟡 Partial](docs/verification.md#result-38) | [The Frayed Rope permutation](proofs/early/A340138.txt) | [✅ Full](docs/verification.md#result-108) |
| [Increasing derivatives of recursive polynomials](proofs/research-batch-09/DerivativeGrowth.md) | [🟡 Partial](docs/verification.md#result-39) | [Growth, residues and powers of ten](proofs/early/A340138.txt) | [⬜ No Lean](docs/verification.md#result-109) |
| [Decreasing runs of a greedy square-root walk](proofs/research-batch-09/DescendingBlocks.md) | [🟡 Partial](docs/verification.md#result-40) | [Wiseman’s partition rows](proofs/early/A365383.md) | [✅ Full](docs/verification.md#result-110) |
| [Dyck ascents, bit complements and a binary triangle](proofs/research-batch-09/DyckBinary.md) | [🟡 Partial](docs/verification.md#result-41) | [First periodic column](proofs/early/A365383.md) | [⬜ No Lean](docs/verification.md#result-111) |
| [Two and three columns of a binary matrix](proofs/research-batch-09/MatrixColumns.md) | [🟡 Partial](docs/verification.md#result-42) | [Tetrastix distances and spheres](proofs/early/A342235.md) | [🟡 Partial](docs/verification.md#result-112) |
| [The greedy no-three-in-line upper bound](proofs/research-batch-09/NoThreeLine.md) | [✅ Full](docs/verification.md#result-43) | [Dale’s Pisot–Narayana recurrence](proofs/early/Pisot-A048625.ru.txt) | [✅ Full](docs/verification.md#result-113) |
| [Strongly nontriangular numbers](proofs/research-batch-09/TriangularDensity.md) | [🟡 Partial](docs/verification.md#result-44) | [Gladkovskii’s continued fraction](proofs/early/Pisot-A048625.ru.txt) | [🟡 Partial](docs/verification.md#result-114) |
| [Five weighted binary block identities](proofs/research-batch-09/WeightedBlocks.md) | [🟡 Partial](docs/verification.md#result-45) | [Wu’s and Stephan’s Pisot formulas](proofs/early/pisot-proof.ru.md) | [⬜ No Lean](docs/verification.md#result-115) |
| [First column for a yoke-chain recursion](proofs/research-batch-09/YokeRows.md) | [🟡 Partial](docs/verification.md#result-46) | [Eight ceiling Pisot sequences](results/Pisot-recurrences.txt) | [⬜ No Lean](docs/verification.md#result-116) |
| [A318698 and A318699](proofs/next-round/navarrete-ru.md) | [🟡 Partial](docs/verification.md#result-47) | [Floor Pisot sequence with seeds (5,9)](results/Pisot-recurrences.txt) | [⬜ No Lean](docs/verification.md#result-117) |
| [A022027 and A022028](proofs/next-round/number/family.md) | [✅ Full](docs/verification.md#result-48) | [Wu’s esthetic-number questions](proofs/early/A377000.md) | [⬜ No Lean](docs/verification.md#result-118) |
| [A358048](proofs/next-round/seq/digit-spiral.md) | [⬜ No Lean](docs/verification.md#result-49) | [Binary runs and Stolarsky digits](proofs/early/wiseman-binary.txt) | [⬜ No Lean](docs/verification.md#result-119) |
| [MathOverflow 468217](proofs/next-round/comb/sequence-machine.md) | [⬜ No Lean](docs/verification.md#result-50) | [Composition ranks and Kurkov’s recurrence](proofs/early/composition-rank-and-wythoff.txt) | [⬜ No Lean](docs/verification.md#result-120) |
| [A402341](proofs/next-round/seq/dyadic-central-coefficients.md) | [⬜ No Lean](docs/verification.md#result-51) | [Wythoff words and index shifts](proofs/early/composition-rank-and-wythoff.txt) | [⬜ No Lean](docs/verification.md#result-121) |
| [A022031, A022032, A018917 and A022019](proofs/next-round/number/certificates.md) | [⬜ No Lean](docs/verification.md#result-52) | [Kotěšovec’s column asymptotic](proofs/early/A385001.txt) | [⬜ No Lean](docs/verification.md#result-122) |
| [A152661 and A077613](proofs/next-round/mathar-parity.md) | [⬜ No Lean](docs/verification.md#result-53) | [Sharma’s visible lattice points](proofs/early/visibility-proof.ru.txt) | [⬜ No Lean](docs/verification.md#result-123) |
| [A265385, A265386 and A265387](proofs/further-round/binary/gray-growth.md) | [✅ Full](docs/verification.md#result-54) | [Finite simple rank-four matroids · sufficient conditions](results/rank-four-interlacing.txt) | [⬜ No Lean](docs/verification.md#result-124) |
| [A115770](proofs/further-round/binary/karttunen.md) | [✅ Full](docs/verification.md#result-55) | [Finite simple rank-four matroids · restrictions and examples](results/rank-four-family.txt) | [⬜ No Lean](docs/verification.md#result-125) |
| [A175287 and A084569](proofs/further-round/counts/perimeter-polygons.md) | [🟡 Partial](docs/verification.md#result-56) |  |  |

## Reproduce

The root Lake project pins Lean 4.19.0 and Mathlib. From the repository root, run:

```sh
lake exe cache get
lake build
```

The new manuscripts under `proofs/local-round-14` through `proofs/local-round-23` ship as independent groups of Lean modules. From the same root, pass the directory holding the desired sources to the checker. For example:

```sh
lake env python proofs/check_lean.py proofs/local-round-22
lake env python proofs/check_lean.py proofs/local-round-23/graph proofs/local-round-23/trees
```

Earlier collections with their own `lakefile.toml` build from that file’s directory. Each manuscript lists its numerical checks.

To inspect the axioms of a particular proof, run its source file, for example `lake env lean Sun.lean` or `lake env lean AntiRunWitness.lean`. The Fröhlich witness uses Lean’s native evaluator and the additional axiom `Lean.ofReduceBool`. The minimality search and the certificate for the 30 examples are separate computations. [Minimality search](proofs/early/frohlich.py) · [Family certificate](proofs/early/family_certificate.py)

Mathematical discovery, writing and formalization used AI assistance. The notes cite prior results, including the earlier permutation argument in A050132, the spectral formula for esthetic numbers and MacMahon’s divisor sums. Historical priority is undetermined where no earlier proof is cited.

[Standalone proof files from 27 November](proofs/archives/oeis-proofs-2026-11-27.zip) · [Collection with the standalone Israel project](proofs/archives/oeis-proofs-nov26-round3.zip) · [Earlier computation scripts](results/README.md)

[Browse the original top-level paths before the reorganization](https://github.com/insorrowmeow/oeis-sequence-proofs/tree/62bc0904513720ccfc9c27b08ec42de31ba695f4).
