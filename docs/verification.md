# Statements and Lean verification

Each entry records the mathematical claim, its sources, the exact scope checked in Lean, and any additional computation. [Paired results table](../README.md#results)

<a id="result-139"></a>

### Pastorek’s graph burning bound

[Pastorek’s graph burning bound](../proofs/local-round-23/graph/Proof.md)

A connected graph on 15 vertices has Slater number 2 and burning number 4. The burning number is unbounded at Slater number 2. This resolves the inequality in entry 16 of the AutoGraphForge ranking.

✅ Exact counterexample and unbounded lower bound. The matching upper bound for the family is given in writing. · [SlaterBurning](../proofs/local-round-23/graph/SlaterBurning.lean) · [Unbounded](../proofs/local-round-23/graph/Unbounded.lean)

<a id="result-138"></a>

### Voloshyn’s description-tree formula (3.55)

[Voloshyn’s description-tree formula (3.55)](../proofs/local-round-23/trees/Proof.md)

The signed GWW row polynomial enumerates labeled description trees by leaves and maximal internal vertices for every positive size. The direct bijection asked for separately remains open.

🔷 All coefficients from the published GWW quartic and row normalization. The paper supplies the derivation of these inputs from the matrix model. · [Final](../proofs/local-round-23/trees/Final.lean) · [TreeSemantics](../proofs/local-round-23/trees/TreeSemantics.lean) · [TreeQuartic](../proofs/local-round-23/trees/TreeQuartic.lean)

<a id="result-137"></a>

### Gray–Payne–Swisher–Watson, critical modulus

[Gray–Payne–Swisher–Watson, critical modulus](../proofs/local-round-22/Critical-modulus.md)

At modulus 2d+2, the two fixed-perimeter counts agree identically for one residue pair. For every other pair the difference tends to positive or negative infinity according to an explicit sign test.

✅ Limit, equality criterion and divergence, starting from the two finite sets of partitions. · [Complete](../proofs/local-round-22/Complete.lean)

<a id="result-136"></a>

### Lagarias–Sun, cutoff by partition size

[Lagarias–Sun, cutoff by partition size](../proofs/local-round-21/Size-boundary.md)

The cumulative size cutoff costs asymptotically exp(γ)π²/(12 log n) relative to the largest-part cutoff. This determines the leading correction to the cumulative statistic.

🔷 Partition counts, overflow limit and size expansion from the published prime and Mertens product estimates specified in the proof. · [SizeResult](../proofs/local-round-21/SizeResult.lean)

<a id="result-135"></a>

### Lagarias–Sun, cutoff by perimeter

[Lagarias–Sun, cutoff by perimeter](../proofs/local-round-20/Lagarias-Sun.md)

The cumulative remainder tends to zero with the paper’s empty partition, or to −1 when it is excluded. The proof also gives the leading loss against the largest-part cutoff.

🔷 Partition counts and limits from the named prime estimates. The finer written expansion is identified in the manuscript. · [PrimePerimeter](../proofs/local-round-20/PrimePerimeter.lean)

<a id="result-134"></a>

### Ordinary partition norm at fixed perimeter

[Ordinary partition norm at fixed perimeter](../proofs/local-round-20/Ordinary-norm.md)

The error in the harmonic-number estimate for the ordinary norm improves to O(log n/n). This refines Ma and Zhang’s estimate.

⬜ Written proof.

<a id="result-133"></a>

### Coulter–Do–Moskovsky, multivariate stability

[Coulter–Do–Moskovsky, multivariate stability](../proofs/local-round-19/Hurwitz-stability.md)

The distinct-label refinement of the genus-zero monotone Hurwitz polynomial for cycle lengths (3,3) vanishes in the upper half-plane. The diagonal conjectures remain open.

✅ Finite enumeration and an exact complex zero. The note explains the cycle recurrence and its correspondence with the transposition count. · [Hurwitz33](../proofs/local-round-19/Hurwitz33.lean) · [HiveCount](../proofs/local-round-19/HiveCount.lean) · [HiveCycles](../proofs/local-round-19/HiveCycles.lean) · [HurwitzZero](../proofs/local-round-19/HurwitzZero.lean)

<a id="result-132"></a>

### Connelly et al., products of q-integers

[Connelly et al., products of q-integers](../proofs/local-round-19/ThreeFactorCriterion.md)

An exact criterion characterizes unimodality for up to three ordinary factors and for arbitrary factor count at stride two.

🟡 Necessity for up to three factors and the coefficient drop. The proof gives sufficiency and the general stride-two conclusion in writing. · [ThreeFactors](../proofs/local-round-19/ThreeFactors.lean) · [ThreeFactorDrop](../proofs/local-round-19/ThreeFactorDrop.lean)

<a id="result-131"></a>

### Pak–Panova, strict Schur unimodality

[Pak–Panova, strict Schur unimodality](../proofs/local-round-18/Pak-Panova-Schur.md)

Principal Schur specializations can have an interior plateau for arbitrarily large Durfee squares.

✅ The tableau polynomial, support endpoints and counterexample for every proposed threshold. · [SchurPlateaus](../proofs/local-round-18/SchurPlateaus.lean)

<a id="result-130"></a>

### Gatzweiler–Krattenthaler, four-factor refinement

[Gatzweiler–Krattenthaler, four-factor refinement](../proofs/local-round-18/Shifted-products.md)

Four distinct factors give a negative coefficient for arbitrarily large relative shifts. Earlier work supplied the qualitative counterexample.

✅ The infinite family, cleared polynomial identity and negative coefficient. · [UnboundedShift](../proofs/local-round-18/UnboundedShift.lean) · [FakeGaussian](../proofs/local-round-18/FakeGaussian.lean)

<a id="result-129"></a>

### Zanello, equal-area rectangles (smallest side ≤ 24)

[Zanello, equal-area rectangles (smallest side ≤ 24)](../proofs/local-round-17/Zanello.md)

Nonnegativity and unimodality hold through smallest side 24 for unbounded widths. A finite reduction applies separately to each fixed smallest side. The unrestricted conjecture remains open.

🟡 Comparison and induction lemmas, finite lists, and central-difference and Bernstein criteria. Exact Python certificates complete the stated range. · [Zanello](../proofs/local-round-17/Zanello.lean) · [Bernstein](../proofs/local-round-17/Bernstein.lean) · [KohCenter](../proofs/local-round-17/KohCenter.lean)

<a id="result-128"></a>

### Stanley–Zanello, centered Gaussian differences

[Stanley–Zanello, centered Gaussian differences](../proofs/local-round-16/Gaussian-differences.md)

The sufficiently-large-width classification in Conjecture 1.1(iv) holds at every fixed height at least five, including the exceptional failure.

🟡 Initial differences, the central perturbation criterion and explicit height-eight bounds. The uniform asymptotic estimates are written. · [GaussianEdge](../proofs/local-round-16/GaussianEdge.lean) · [GaussianCenter](../proofs/local-round-16/GaussianCenter.lean) · [EightRowProfile](../proofs/local-round-16/EightRowProfile.lean)

<a id="result-127"></a>

### Zbarsky’s near-rectangular strict partitions

[Zbarsky’s near-rectangular strict partitions](../proofs/local-round-15/Zbarsky-PROOF.md)

For each fixed height of at least five, all sufficiently wide near-rectangular strict shapes have unimodal rank counts (Conjecture 15).

🟡 Weight-preserving split, five-row inequalities and the local-to-global unimodality criterion. The asymptotic estimates and tail argument are written. · [FlagSplit](../proofs/local-round-15/FlagSplit.lean) · [FiveRowProfile](../proofs/local-round-15/FiveRowProfile.lean) · [ShiftedUnimodality](../proofs/local-round-15/ShiftedUnimodality.lean)

<a id="result-126"></a>

### Makowsky–Rakita, random-graph independence counts

[Makowsky–Rakita, random-graph independence counts](../proofs/local-round-14/PROOF.md)

For fixed edge probability strictly between zero and one, the independence counts of G(n,p) are unimodal with probability tending to one. The proof also covers a range of decreasing edge probabilities.

🟡 Deterministic unimodality steps, graph double counting and one exact finite bound. The probabilistic estimates and limiting argument are written. · [Unimodality](../proofs/local-round-14/Unimodality.lean) · [FiniteBound](../proofs/local-round-14/FiniteBound.lean)

<a id="result-1"></a>

### Schott’s decimal insertion bound

[Schott’s decimal insertion bound](../proofs/research-batch-13/DigitRatio.md) · [A401341](https://oeis.org/A401341)

At most nine positive integers give any fixed positive integer multiplier after inserting zeroes between digits. The multiplier 10 attains nine.

✅ Uniform upper bound and all nine primitive witnesses · [upper bound](../proofs/research-batch-13/DigitRatio.lean) · [sharpness](../proofs/research-batch-13/DigitRatioSharp.lean)

<a id="result-2"></a>

### Karttunen’s arithmetic-derivative collisions

[Karttunen’s arithmetic-derivative collisions](../proofs/research-batch-13/PrimorialCarryCollision.md) · [A399369](https://oeis.org/A399369)

A single pair refutes both uniqueness conjectures, including the one requiring the greatest smaller predecessor with the same loss.

🟡 Derivatives, carries, terminal valuations and finite divisibility certificate (native evaluation). Exhaustiveness is proved in the text. · [Lean](../proofs/research-batch-13/PrimorialCarryCollision.lean)

<a id="result-3"></a>

### Weber’s rook inequalities

[Weber’s rook inequalities](../proofs/research-batch-13/RookRanks.md) · [Original question](https://mathoverflow.net/questions/495739#comment1290794_495739)

For a board admitting d nonattacking rooks, the placement counts satisfy r(k) ≤ r(l) if k ≤ l and k+l ≤ d. This extends to claw-free graphs. Priority for the unrestricted result is undetermined.

✅ Both the board and claw-free graph inequalities · [Lean](../proofs/research-batch-13/RookRanks.lean)

<a id="result-4"></a>

### Sharp bounds for a six-phase recurrence

[Sharp bounds for a six-phase recurrence](../proofs/research-batch-13/SixPhaseOrbit.md) · [A400113](https://oeis.org/A400113)

For the seed 1, six explicit formulas give a minimum ratio of 1/6 and supremum 7/3 for n ≥ 10. Merger for arbitrary seeds remains open.

✅ Exact orbit, both bounds, attainment and approach to the supremum · [Lean](../proofs/research-batch-13/SixPhaseOrbit.lean)

<a id="result-5"></a>

### Bounds for the sum-and-halve recurrence

[Bounds for the sum-and-halve recurrence](../proofs/research-batch-13/ParityEnvelope.md) · [A400485](https://oeis.org/A400485)

For the seed 1, n ≤ a(n) ≤ 11n/3 at every index. For any positive seed both bounds hold after an explicit threshold.

✅ Both bounds for the specified recurrence · [Lean](../proofs/research-batch-13/ParityEnvelope.lean)

<a id="result-6"></a>

### Composite partners in sums equal to a power of two

[Composite partners in sums equal to a power of two](../proofs/research-batch-13/CompositePowerPartners.md) · [A401106](https://oeis.org/A401106)

Every odd composite has arbitrarily large odd composite partners. The proof applies Euler’s theorem to c−2.

✅ Arbitrarily large partners for every odd c ≥ 5 · [Lean](../proofs/research-batch-13/PowerSumPartners.lean)

<a id="result-7"></a>

### Prime partners in sums equal to a power of two

[Prime partners in sums equal to a power of two](../proofs/research-batch-13/PrimePowerPartners.md) · [A401105](https://oeis.org/A401105)

The prime 7,629,217 has no prime partner. This applies a published congruence covering to the first question in the entry.

✅ Primality and exclusion of every partner · [Lean](../proofs/research-batch-13/PowerSumPartners.lean)

<a id="result-8"></a>

### Barnabei–Castronuovo–Silimbani, question 8.17

[Barnabei–Castronuovo–Silimbani, question 8.17](../proofs/research-batch-12/InvolutionPoles.md) · [Original question](https://arxiv.org/html/2609.39952v1#S8.SS2.SSS7)

The univariate and bivariate series of involutions avoiding 4321 and 4231 are not D-finite. The univariate series has infinitely many simple poles tending to 1/2.

🟡 Coprimality of consecutive determinants at their zeros and a derivative inequality · [Lean](../proofs/research-batch-12/InvolutionPoles.lean)

<a id="result-9"></a>

### A two-term asymptotic for pattern-avoiding involutions

[A two-term asymptotic for pattern-avoiding involutions](../proofs/research-batch-12/InvolutionSubdominant.md) · [A399659](https://oeis.org/A399659)

The second exponential has base between 2.14809853 and 2.14809858, with remainder of order at most (149/70)ⁿ.

⬜ Analytic proof and two exact Python certificates

<a id="result-10"></a>

### Meeussen’s partition sum

[Meeussen’s partition sum](../proofs/research-batch-12/MeeussenForestCoefficients.md) · [Original question](https://mathoverflow.net/questions/163235)

A forest formula gives all coefficients of a polynomial row and proves the proposed sum over partitions. It uses earlier interpretations by Speyer and Méndez.

🟡 The relation between forest depth and the size of its partition · [Lean](../proofs/research-batch-12/MeeussenForestCoefficients.lean)

<a id="result-11"></a>

### Wiesner’s disjoint-subset coloring problem

[Wiesner’s disjoint-subset coloring problem](../proofs/research-batch-12/PowersetSingleDefect.md) · [Original question](https://mathoverflow.net/questions/455610)

The minimum number of monochromatic disjoint pairs is one for n ≥ 3 when each point sees at most n−1 colors. The note also gives the two-colors-per-point minimum.

🟡 Both bounds for the n−1-color conjecture. The two-color refinement is proved in writing. · [Lean](../proofs/research-batch-12/PowersetSingleDefect.lean)

<a id="result-12"></a>

### Small graphs with prescribed triangle counts

[Small graphs with prescribed triangle counts](../proofs/research-batch-12/TriangleSpectrum.md) · [A400369](https://oeis.org/A400369)

If exactly t triangles require r vertices, every smaller triangle count can be realized on at most r+1. Infinitely many t require the extra vertex.

🟡 Interval covering, triangle losses and degree-list construction · [intervals](../proofs/research-batch-12/TriangleGraphSpectrum.lean) · [degree lists](../proofs/research-batch-12/TriangleTreeDegrees.lean)

<a id="result-13"></a>

### Conditional path density in a minimizing graphon

[Conditional path density in a minimizing graphon](../proofs/research-batch-12/GraphonPinnedLeaves.md) · [Original question](https://mathoverflow.net/questions/488182)

For every edge density strictly between zero and one, a path of length three gives a counterexample after pinning its leaves.

🟡 Two-block conditional values and a finite weighted inequality · [Lean](../proofs/research-batch-12/GraphonPinnedLeaves.lean)

<a id="result-14"></a>

### Höft’s divisor triangle, columns one and three

[Höft’s divisor triangle, columns one and three](../proofs/research-batch-12/OddDivisorMinima.md) · [A384704](https://oeis.org/A384704)

Three column conjectures follow from the least odd integers with a prescribed divisor count, including the exceptional row eight.

🟡 Interval covering lemma and five base cases · [Lean](../proofs/research-batch-12/OddDivisorMinima.lean)

<a id="result-15"></a>

### Divisor-triangle column oscillations

[Divisor-triangle column oscillations](../proofs/research-batch-12/DivisorColumnOscillation.md) · [A400412](https://oeis.org/A400412)

Successive positive terms in every fixed column both rise and fall by arbitrarily large factors.

🟡 Odd-number inequality using a prime divisor of its divisor count · [Lean](../proofs/research-batch-12/DivisorColumnOscillation.lean)

<a id="result-16"></a>

### Powerful numbers with six squarefree neighbors

[Powerful numbers with six squarefree neighbors](../proofs/research-batch-12/PowerfulNeighbors.md) · [A401306](https://oeis.org/A401306)

The relative density among powerful numbers exists and lies between 0.226723 and 0.226943.

🟡 Local conditions modulo 4 and 9. Python certifies the numerical bounds. · [Lean](../proofs/research-batch-12/PowerfulNeighbors.lean)

<a id="result-17"></a>

### Kurkov’s self-squaring triangle coefficients

[Kurkov’s self-squaring triangle coefficients](../proofs/research-batch-11/PositiveDiagonalCoefficients.md) · [A078121](https://oeis.org/A078121)

All normalized diagonal coefficients are positive integers; the diagonal recurrence has its stated exact minimal order. Earlier formulas and special cases are credited in the note.

🟡 A 2-adic valuation bound used in the induction · [Lean](../proofs/research-batch-11/DiagonalArithmetic.lean)

<a id="result-18"></a>

### An explicit diagonal triple sum

[An explicit diagonal triple sum](../proofs/research-batch-11/DiagonalTripleSum.md) · [Original question](https://mathoverflow.net/questions/495883)

Derivation for all indices of the particular triple sum left numerically checked in Epstein’s treatment. The question already had a Vandermonde-based answer.

🟡 Newton-basis expansion of a monomial · [Lean](../proofs/research-batch-11/DiagonalNewton.lean)

<a id="result-19"></a>

### Squares formed from neighboring largest proper divisors

[Squares formed from neighboring largest proper divisors](../proofs/research-batch-11/NeighborDivisorSquares.md) · [A399610](https://oeis.org/A399610)

Infinitely many solutions have two composite neighbors.

✅ Full infinitude theorem, including largest proper divisors · [Lean](../proofs/research-batch-11/NeighborDivisorSquares.lean)

<a id="result-20"></a>

### Signed collisions in the Flavius Josephus sieve

[Signed collisions in the Flavius Josephus sieve](../proofs/research-batch-11/JosephusSignedCollision.md) · [Original question](https://mathoverflow.net/questions/418146)

The first collision step and its sign are determined for every positive starting index.

🟡 Existence, first collision and signs in the rank recurrence. The list interpretation is given in the text. · [Lean](../proofs/research-batch-11/JosephusSignedCollision.lean)

<a id="result-21"></a>

### Wiesner’s disjoint two-element sets

[Wiesner’s disjoint two-element sets](../proofs/research-batch-11/DisjointCouples.md) · [Original question](https://mathoverflow.net/questions/455737)

An infinite family refutes the revised claim, with a counterexample already on seven vertices. The note credits Bogdanov’s earlier idea.

🟡 The seven-vertex counterexample, including all seven minima · [Lean](../proofs/research-batch-11/DisjointCouples.lean)

<a id="result-22"></a>

### Spanning-tree crossover in a Klein-bottle grid

[Spanning-tree crossover in a Klein-bottle grid](../proofs/research-batch-11/KleinTwist.md) · [A401537](https://oeis.org/A401537)

Trees using one seam edge outnumber those using two through 15 columns. The inequality reverses at every width from 16 onward.

🟡 The sign at every width from the derived formulas · [Lean](../proofs/research-batch-11/KleinTwist.lean)

<a id="result-23"></a>

### Row polynomials of non-squashing partitions

[Row polynomials of non-squashing partitions](../proofs/research-batch-11/DyadicChainCut.md) · [Original question](https://mathoverflow.net/questions/509248)

Splitting a dyadic chain proves both proposed identities. The companion Hanna formula has an earlier proof.

🟡 Recursive split for arbitrary length · [Lean](../proofs/research-batch-11/DyadicChainCut.lean)

<a id="result-24"></a>

### Shen’s fragmentation question

[Shen’s fragmentation question](../proofs/research-batch-11/ShenFragmentation.md) · [Original question](https://mathoverflow.net/questions/488756)

A failure with a fixed edge ordering persists on extension and can be detected on four vertices.

🟡 Heredity of a successful elimination order · [Lean](../proofs/research-batch-11/ShenFragmentation.lean)

<a id="result-25"></a>

### First letters for the largest-row variant

[First letters for the largest-row variant](../proofs/research-batch-11/GreedyLargestRows.md) · [A402288](https://oeis.org/A402288)

In the lexicographically largest variant the first row containing k is 1+3·2^(k−4) for all k ≥ 4.

🟡 Subsequence obstruction and construction arithmetic · [Lean](../proofs/research-batch-11/GreedyLargestRows.lean)

<a id="result-26"></a>

### Faces in a unit-circle arrangement

[Faces in a unit-circle arrangement](../proofs/research-batch-10/CircleDigons.md) · [A401663](https://oeis.org/A401663)

Only digons, triangles and quadrilaterals occur as bounded faces. A cyclic sign count gives all three totals. A plateau ending at 688 refutes the proposed endpoint pattern.

🟡 Sign parity and changes under insertion. Python certifies the plateau endpoints. · [Lean](../proofs/research-batch-10/CircleDigons.lean)

<a id="result-27"></a>

### Equal-area, equal-perimeter square cuts

[Equal-area, equal-perimeter square cuts](../proofs/research-batch-10/EqualCuts.md) · [A400685](https://oeis.org/A400685)

The exponential growth constant exists for symmetry classes of simple lattice cuts dividing a square into two equal-area regions with prescribed perimeter.

🟡 Area identities for joined blocks and connectors · [Lean](../proofs/research-batch-10/EqualCuts.lean)

<a id="result-28"></a>

### Twice-prime Heronian tangent lengths

[Twice-prime Heronian tangent lengths](../proofs/research-batch-10/HeronFibers.md) · [A401194](https://oeis.org/A401194)

The proposed classification holds when the largest tangent length is twice a prime, with an exact density for the missing cases. The odd-composite branch remains open.

🟡 Norm-equation identities and angular inequalities · [Lean](../proofs/research-batch-10/HeronFibers.lean)

<a id="result-29"></a>

### Single-loop rectangular mirror placements

[Single-loop rectangular mirror placements](../proofs/research-batch-10/MirrorGrid.md) · [A400778](https://oeis.org/A400778)

A product formula establishes the five conjectured strip formulas and the upper bound with its equality cases.

🟡 Two-step adjacency identity. The five strip recurrences also have an exact transfer certificate. · [Lean](../proofs/research-batch-10/MirrorFaceSteps.lean)

<a id="result-30"></a>

### Jablan’s mirror-count question in the labeled rectangular model

[Jablan’s mirror-count question in the labeled rectangular model](../proofs/research-batch-10/MirrorPolynomial.md) · [Original question](https://www.mi.sanu.ac.rs/vismath/mir/enum.htm)

An explicit polynomial counts single-loop configurations with each possible number of edge mirrors under the A400778 conventions.

⬜ Determinant proof and an independent ray tracer

<a id="result-31"></a>

### Fourteen exponentially odd neighbors of a square

[Fourteen exponentially odd neighbors of a square](../proofs/research-batch-10/OddNeighbors.md) · [A400734](https://oeis.org/A400734)

An Euler product gives the natural density, strictly between 0.08069356 and 0.08069403.

🟡 Exceptional classes modulo 9 and offset identities; Python certifies the interval. · [Lean](../proofs/research-batch-10/OddNeighbors.lean)

<a id="result-32"></a>

### Carry-free factorization of odd loop outputs

[Carry-free factorization of odd loop outputs](../proofs/research-batch-09/A110978.md) · [Original question](https://mathoverflow.net/questions/464360)

Every output of the form 2n+1 from the specified loop is an odd composite admitting nontrivial carry-free binary multiplication.

🟡 Factorization, nontriviality and bit disjointness for each reachable output; termination is proved in writing. · [Lean](../proofs/research-batch-09/CarryFree.lean)

<a id="result-33"></a>

### Vector algorithms for Dyck peak heights

[Vector algorithms for Dyck peak heights](../proofs/research-batch-09/A140717.md) · [Original question](https://mathoverflow.net/questions/477465)

Both proposed vector algorithms compute the peak-height polynomials at every index.

🟡 Prefix inequalities and weight identity for run-end sets · [Lean](../proofs/research-batch-09/DyckValleys.lean)

<a id="result-34"></a>

### A binary square-sum identity

[A binary square-sum identity](../proofs/research-batch-09/A196148.md) · [Original question](https://mathoverflow.net/questions/486776)

A correspondence with triples of lattice paths gives the square sum at every index, refined by number of set bits.

🟡 Binary recurrence and identification of the position count. The path enumeration is applied in writing. · [Lean](../proofs/research-batch-09/DominatedBits.lean)

<a id="result-35"></a>

### Two algorithms for Hanna’s coefficients

[Two algorithms for Hanna’s coefficients](../proofs/research-batch-09/A208832.md) · [Original question](https://mathoverflow.net/questions/482170)

The sequential vector sweep and the two-index recurrence compute the defining generating-function coefficients.

🟡 Row update, convolution and rational-multiplier coefficient identity · [Lean](../proofs/research-batch-09/RationalSweep.lean)

<a id="result-36"></a>

### Factorial sweep for A217061

[Factorial sweep for A217061](../proofs/research-batch-09/A217061.md) · [Original question](https://mathoverflow.net/questions/481279)

Both proposed algorithms compute A217061 at every positive output index, using the exponent convention in the program and the OEIS definition.

🟡 Normalized carry formula, row update and operator iteration · [Lean](../proofs/research-batch-09/FactorialSweep.lean)

<a id="result-37"></a>

### Schröder factorization of the entire R table

[Schröder factorization of the entire R table](../proofs/research-batch-09/A338193.md) · [Original question](https://mathoverflow.net/questions/481528)

The proposed triangular recurrence has the specified first column, and an explicit series determines each entry.

🟡 Coefficient extraction and double induction from the written series identities · [Lean](../proofs/research-batch-09/SchroederRows.lean)

<a id="result-38"></a>

### The greedy coprimality permutation

[The greedy coprimality permutation](../proofs/research-batch-09/CoprimeGreedy.md) · [A400792](https://oeis.org/A400792)

Every positive integer occurs exactly once in the least-eligible construction.

🟡 Score invariant and finite bound on noncoprime terms · [Lean](../proofs/research-batch-09/CoprimeGreedy.lean)

<a id="result-39"></a>

### Increasing derivatives of recursive polynomials

[Increasing derivatives of recursive polynomials](../proofs/research-batch-09/DerivativeGrowth.md) · [Original question](https://mathoverflow.net/questions/247321)

Successive derivatives increase on the specified largest-root interval, with the endpoint equality in the base case identified.

🟡 Real inequality yielding the positive derivative gap · [Lean](../proofs/research-batch-09/DerivativeGrowth.lean)

<a id="result-40"></a>

### Decreasing runs of a greedy square-root walk

[Decreasing runs of a greedy square-root walk](../proofs/research-batch-09/DescendingBlocks.md) · [A399084](https://oeis.org/A399084)

After the initial five singleton runs, the lengths are m,1,m,1 for every m ≥ 2. The permutation is an involution.

🟡 Greedy transitions, visited sets, square-root bounds and stage boundaries · [Lean](../proofs/research-batch-09/DescendingBlocks.lean)

<a id="result-41"></a>

### Dyck ascents, bit complements and a binary triangle

[Dyck ascents, bit complements and a binary triangle](../proofs/research-batch-09/DyckBinary.md) · [A125644](https://oeis.org/A125644)

Prescribed Dyck ascent lengths and the auxiliary triangle give two proposed representations of A347205.

🟡 Two binary recurrences for the list enumeration · [Lean](../proofs/research-batch-09/DominatedBits.lean)

<a id="result-42"></a>

### Two and three columns of a binary matrix

[Two and three columns of a binary matrix](../proofs/research-batch-09/MatrixColumns.md) · [A401159](https://oeis.org/A401159)

Closed formulas count labeled binary matrices with row and column capacity two. The two-column identification also occurs in Mathar’s 2014 table.

🟡 Both formulas in the row-by-row counting model · [Lean](../proofs/research-batch-09/MatrixColumns.lean)

<a id="result-43"></a>

### The greedy no-three-in-line upper bound

[The greedy no-three-in-line upper bound](../proofs/research-batch-09/NoThreeLine.md) · [Original question](https://mathoverflow.net/questions/338528)

The term u(23)=31 refutes the proposed uniform 5n/4 bound under both indexing conventions. The terms already appear in the question.

✅ The 24 greedy terms and the counterexample · [Lean](../proofs/research-batch-09/NoThreeLine.lean)

<a id="result-44"></a>

### Strongly nontriangular numbers

[Strongly nontriangular numbers](../proofs/research-batch-09/TriangularDensity.md) · [A400795](https://oeis.org/A400795)

The complement of the generalized triangular numbers has natural density zero. Its infinitude remains a separate question.

🟡 Coprimality reduction and lattice-count identity · [Lean](../proofs/research-batch-09/TriangularDensity.lean)

<a id="result-45"></a>

### Five weighted binary block identities

[Five weighted binary block identities](../proofs/research-batch-09/WeightedBlocks.md) · [A347205](https://oeis.org/A347205)

Four block sums and the alternating-digits identity hold as polynomial identities in both parameters.

🟡 Odd tails, block transitions and alternating-index transitions · [Lean](../proofs/research-batch-09/WeightedBlocks.lean)

<a id="result-46"></a>

### First column for a yoke-chain recursion

[First column for a yoke-chain recursion](../proofs/research-batch-09/YokeRows.md) · [Original question](https://mathoverflow.net/questions/481674)

The first column of the proposed triangular recursion gives the shifted yoke-chain numbers A006351.

🟡 Row transformation, iteration and first-column extraction · [Lean](../proofs/research-batch-09/YokeRows.lean)

<a id="result-47"></a>

### A318698 and A318699

[A318698 and A318699](../proofs/next-round/navarrete-ru.md)

Digit-sharing greedy permutations from any seed, with asymptotic ratio one.

🟡 [Permutation theorem](../proofs/next-round/Navarrete.lean)

<a id="result-48"></a>

### A022027 and A022028

[A022027 and A022028](../proofs/next-round/number/family.md)

Two strict-rounding recurrences and a family of generating functions.

✅ [Both specified sequences at every index](../proofs/next-round/number/Barker.lean)

<a id="result-49"></a>

### A358048

[A358048](../proofs/next-round/seq/digit-spiral.md)

The digit-sharing spiral fills the nonnegative integers, with a displacement bound.

⬜ Written proof

<a id="result-50"></a>

### MathOverflow 468217

[MathOverflow 468217](../proofs/next-round/comb/sequence-machine.md)

Positions of bitwise complements in Wythoff-word order.

⬜ Written proof

<a id="result-51"></a>

### A402341

[A402341](../proofs/next-round/seq/dyadic-central-coefficients.md)

Classification of lengths with the central-coefficient valuation formula. The length-16 case has an earlier formalization.

⬜ Written proof

<a id="result-52"></a>

### A022031, A022032, A018917 and A022019

[A022031, A022032, A018917 and A022019](../proofs/next-round/number/certificates.md)

Induction certificates for four rounding recurrences, including Israel’s alternating rule.

⬜ Written proof

<a id="result-53"></a>

### A152661 and A077613

[A152661 and A077613](../proofs/next-round/mathar-parity.md)

A bijective proof of Mathar’s parity identity, also implied by previously published formulas.

⬜ Written proof

<a id="result-54"></a>

### A265385, A265386 and A265387

[A265385, A265386 and A265387](../proofs/further-round/binary/gray-growth.md)

The three mean growth factors are 2, √2 and 2.

✅ [All three limits](../proofs/further-round/binary/GrayGrowth.lean) · [Companion limits](../proofs/further-round/binary/GrayTwins.lean)

<a id="result-55"></a>

### A115770

[A115770](../proofs/further-round/binary/karttunen.md)

Equivalence of Karttunen’s two carryless-multiplication conditions.

✅ [Equivalence for every input](../proofs/further-round/binary/Carryless.lean)

<a id="result-56"></a>

### A175287 and A084569

[A175287 and A084569](../proofs/further-round/counts/perimeter-polygons.md)

Perimeter-label counts for triangles and squares, extended to polygons.

🟡 [Triangle count](../proofs/further-round/counts/Triangles.lean)

<a id="result-57"></a>

### A085588 · width-four counterexample

[A085588](../proofs/further-round/automata/rule150.md)

Width 4 refutes the proposed direction of divisibility for Rule 150.

✅ [Width-4 counterexample](../proofs/further-round/automata/Rule150.lean)

<a id="result-58"></a>

### MathOverflow 402635 and 408765

[MathOverflow 402635 and 408765](../proofs/further-round/words/rook-tours.md)

A rook-tour bijection gives both endpoint formulas.

🟡 [Permutation component](../proofs/further-round/words/RookEndpoints.lean)

<a id="result-59"></a>

### A275667

[A275667](../proofs/further-round/automata/triangular.md)

Four recurrences for the triangular cellular automaton.

⬜ Written proof

<a id="result-60"></a>

### A122251 and A122249

[A122251 and A122249](../proofs/further-round/hankel/barry.md)

Barry’s Hankel-determinant identity for every prime and a coprime-step extension.

⬜ Written proof

<a id="result-61"></a>

### A173993, A174013, A174015 and A174016

[A173993, A174013, A174015 and A174016](../proofs/further-round/combin/mathar-algebraic.md)

Four recurrences from algebraic generating functions.

🟡 [Derivation from the series equations in two cases](../proofs/further-round/combin/RowRecurrence.lean)

<a id="result-62"></a>

### A195422

[A195422](../proofs/further-round/counts/cyclic-permanent.md)

Two recurrences for cyclic permanents derived from one generating function.

⬜ Written proof

<a id="result-63"></a>

### Optimal greedy sums of squares · A401548

[A401548](https://oeis.org/A401548)

[Sharp asymptotic for the numbers with an optimal greedy sum of squares](../proofs/research-batch-06/squares/OptimalGreedy.md), including the exact leading constant and the conditional density 3/20.

🟡 [Primitive congruence test, scaling and residue counts](../proofs/research-batch-06/squares/GreedyLocal.lean). The analytic limit has a written proof.

<a id="result-64"></a>

### Exact Rule 150 periods · A085588

[A085588](https://oeis.org/A085588)

[Classification of the widths at which the Rule 150 period equals the width](../proofs/research-batch-06/automata/A085588.md). This proves Khrabrov's implication to A115770. The first reverse exception is 455, with period 4095.

✅ [Complete classification in both directions](../proofs/research-batch-06/automata/PeriodLower.lean) and [the original implication using the XOR definition of A115770](../proofs/research-batch-06/automata/Khrabrov.lean).

<a id="result-65"></a>

### Fibonacci cycle spectra · A401899

[A401899](https://oeis.org/A401899)

[Fibonacci-weighted cycles of length 4Fₖ have exactly 3Fₖ distinct eigenvalues for k ≥ 4](../proofs/research-batch-06/spectra/FibonacciCycle.md), also for two arbitrary distinct positive weights. The question at other lengths remains open.

🟡 [Fibonacci prefix and block lengths](../proofs/research-batch-06/spectra/FibonacciBlocks.lean) and [the transfer-matrix identity criterion](../proofs/research-batch-06/spectra/Transfer.lean). Counting roots by twisted boundary conditions is a written argument.

<a id="result-66"></a>

### Binary Fibonacci columns · A036284

[A036284](https://oeis.org/A036284)

[Two polynomial divisibility conjectures for binary Fibonacci columns](../proofs/research-batch-06/arithmetic/A036284.md).

✅ [Both original assertions for all positive indices](../proofs/research-batch-06/arithmetic/FibonacciBitMasks.lean).

<a id="result-67"></a>

### Digital-root periods · A210456

[A210456](https://oeis.org/A210456)

[All three stated conjectures on the periods of digital roots of the n-step Fibonacci sequence](../proofs/research-batch-06/arithmetic/A210456.md), with exact formulas for n equal to a power of three or one less.

✅ [Every eventual period for n ≥ 2 is divisible by three](../proofs/research-batch-06/arithmetic/MultinacciPeriods.lean) and [both exact period formulas](../proofs/research-batch-06/arithmetic/HeleniusPeriods.lean) for positive exponents.

<a id="result-68"></a>

### Rule 67 rows · A266839

[A266839](https://oeis.org/A266839), [A266838](https://oeis.org/A266838)

[Rule 67 rows in every base](../proofs/research-batch-06/automata/Rule67.md). At n = 3 the proposed formula gives 193/2, while the true value is 97. Corrected closed forms, both recurrences and both generating functions follow.

🟡 [All rows on the infinite line and the numerical counterexample](../proofs/research-batch-06/automata/Rule67.lean). The extraction of the recurrences and generating functions is written.

<a id="result-69"></a>

### Ranks in A260711 · MO 466152

[MathOverflow 466152](https://mathoverflow.net/questions/466152/formula-and-smallest-solution-for-the-a260711)

[Parametrization of the positive terms of A260711, their rank, and the connection to A120242](../proofs/research-batch-06/combinatorics/A260711.md).

🟡 [Parametrization, uniqueness, membership in blocks and the parameter formulas](../proofs/research-batch-06/combinatorics/A260711.lean). The permutation and ordering argument is written.

<a id="result-70"></a>

### Half-turn orbits · A334386

[A334386](https://oeis.org/A334386)

[Equilateral triangles touching all four faces of the tetrahedral grid](../proofs/research-batch-06/geometry/tetrahedral-triangles.md). Their count is 4(n−1) modulo 12.

🟡 [Integer obstruction excluding half-turns](../proofs/research-batch-06/geometry/Kagey.lean). The orbit count is written.

<a id="result-71"></a>

### Column profiles of polyominoes · A308359

[A308359](https://oeis.org/A308359)

[Fixed polyominoes of width n−2](../proofs/research-batch-06/geometry/near-maximal-width.md). Their number is 8n²−51n+86 for n ≥ 5.

🟡 [Weighted column-profile enumeration and polynomial formula](../proofs/research-batch-06/geometry/Polyomino.lean). The correspondence between profiles and shapes is written.

<a id="result-72"></a>

### Domino diagonal identities · A333650

[A333650](https://oeis.org/A333650)

[Three domino-tower diagonals and a generating-function construction for every fixed excess](../proofs/research-batch-06/geometry/domino-towers.md).

🟡 [Three diagonal identities for every height in the row-set model](../proofs/research-batch-06/geometry/Domino.lean). The general rational form has a written proof.

<a id="result-73"></a>

### Pythagorean parameter jumps · A400884

[A400884](https://oeis.org/A400884)

[Large jumps in a count of Pythagorean triangle placements](../proofs/research-batch-06/arithmetic/A400884.md) disprove the proposed O(n) remainder.

🟡 [Failure of the O(n) estimate for the exact Euclidean-parameter sum](../proofs/research-batch-06/arithmetic/PythagoreanJumps.lean). The geometric counting correspondence and quantitative refinement are written.

<a id="result-74"></a>

### Odd-divisor ranks · MO 438304

[MathOverflow 438304](https://mathoverflow.net/questions/438304)

[Ranks of powers of two and odd divisors of the binary length](../proofs/research-batch-06/combinatorics/OddDivisorRanks.md). Das previously gave the membership criterion.

✅ [Both assertions from the defining recurrence](../proofs/research-batch-06/combinatorics/OddDivisorRanks.lean).

<a id="result-75"></a>

### Luschny’s row recurrence · A395454

[A395454](https://oeis.org/A395454)

[An index correction in the recurrence for Luschny's row polynomials](../proofs/research-batch-06/geometry/alexandersson-row-recurrence.md). The printed formula fails in every row from index 2.

✅ [Corrected recurrence and the failure of the proposed formula](../proofs/research-batch-06/geometry/AlexanderssonRows.lean).

<a id="result-76"></a>

### Brennan’s prime generators

[Brennan’s prime generators](../proofs/research-batch-06/geometry/brennan-prime-generators-partial.md)

Partial. Eventual uniqueness and a finite range through least missing prime 10,000,000. The intervening range remains open.

⬜ Written proof and Python enumeration

<a id="result-77"></a>

### Ezerman, Meyer and Solé, Conjecture 4, p. 5

[Ezerman, Meyer and Solé, Conjecture 4, p. 5](https://cs.uwaterloo.ca/journals/JIS/VOL18/Ezerman/eze3.pdf#page=5)

[Two counterexamples and an infinite family of palindromic pairs with carries](../proofs/research-batch-07/digits/PolynomialPairs.md).

✅ [The negated conjecture and witnesses for every parameter](../proofs/research-batch-07/digits/PolynomialPairs.lean).

<a id="result-78"></a>

### Digits in reverse products · A161721

[OEIS A161721](https://oeis.org/A161721)

[At most one digit 2 occurs in each qualifying prime](../proofs/research-batch-07/digits/ReverseProducts.md). This follows from the published carry criterion.

🟡 [Symmetric carries and the digit-square bound](../proofs/research-batch-07/digits/SymmetricCarries.lean). Prime divisibility and the central-column identification are written.

<a id="result-79"></a>

### Continuant periods · MO 487169

[MathOverflow 487169](https://mathoverflow.net/questions/487169)

[The least period of A001040 modulo N is N or 2N, and the even-indexed terms have least period N for odd N](../proofs/research-batch-07/combinatorics/ContinuantPeriods.md).

✅ [Both general theorems](../proofs/research-batch-07/combinatorics/ContinuantPeriods.lean).

<a id="result-80"></a>

### Perimeter-magic squares · A380962

[OEIS A380962](https://oeis.org/A380962)

[The rational generating function for perimeter-magic squares proves the conjectured order-34 recurrence](../proofs/research-batch-07/geometry/perimeter-magic.md).

🟡 [Exact arithmetic certificate for the cleared generating function](../proofs/research-batch-07/geometry/PerimeterMagic.lean). The geometry, inclusion–exclusion and coefficient-bound argument are written.

<a id="result-81"></a>

### Domino tiling coefficients · A401673

[OEIS A401673](https://oeis.org/A401673)

[Last two coefficients of the tiling polynomial, extended to all even rectangles](../proofs/research-batch-07/arithmetic/A401673.md).

🟡 [Strip and adjacent-swap lemmas and coefficient formulas](../proofs/research-batch-07/arithmetic/DomiculeStrips.lean). The geometric bijections are written.

<a id="result-82"></a>

### Labeled mobiles · MO 492609

[MathOverflow 492609](https://mathoverflow.net/questions/492609)

[Proof of the in-place algorithm for labeled mobiles](../proofs/research-batch-07/combinatorics/MobileAlgorithm.md).

🟡 [Accumulator identity and finite check](../proofs/research-batch-07/combinatorics/RowAlgorithms.lean). The inverse-series argument is written.

<a id="result-83"></a>

### Schröder row algorithm · MO 492866

[MathOverflow 492866](https://mathoverflow.net/questions/492866)

[Counterexample to the printed summation limit and proof of the corrected full-row algorithm](../proofs/research-batch-07/combinatorics/SchroederRowAlgorithm.md).

🟡 [The fourth row and the counterexample](../proofs/research-batch-07/combinatorics/RowAlgorithms.lean). The all-row argument is written.

<a id="result-84"></a>

### Repdigit bounds (partial) · A401895

[OEIS A401895](https://oeis.org/A401895)

[Partial. Any further repdigit solution has at least 701 digits, has length divisible by 33, and produces only sixes](../proofs/research-batch-07/digits/ReverseProducts.md).

🟡 [The carry induction and the extreme-column inequality](../proofs/research-batch-07/digits/SymmetricCarries.lean). The [exhaustive search](../proofs/research-batch-07/digits/check_repdigit.py) uses integer arithmetic in Python.

<a id="result-85"></a>

### Markus Sigg, OEIS A399704

[Markus Sigg, OEIS A399704](https://oeis.org/A399704)

[A single admissible tuple minimizes the sum, product and their quotient for every n ≥ 3](../proofs/research-batch-08/extrema/Sigg.md).

✅ [All three minima over actual finite sets and identification of the least last entry](../proofs/research-batch-08/extrema/Sigg.lean).

<a id="result-86"></a>

### Takuto Nakai, OEIS A400474

[Takuto Nakai, OEIS A400474](https://oeis.org/A400474)

[The exact maximum number of interior points from which a triangle subtends three distinct integral multiples of π/n](../proofs/research-batch-08/arithmetic/A400474.md).

🟡 [Optimization and final formula](../proofs/research-batch-08/arithmetic/ViewingAngles.lean). The geometric correspondence and inclusion–exclusion are written.

<a id="result-87"></a>

### Binary Stirling expansion · MO 483753

[MathOverflow 483753](https://mathoverflow.net/questions/483753)

[A falling-factorial expansion connecting A358612 and A373183](../proofs/research-batch-08/combinatorics/BinaryStirling.md).

🟡 [Finite-difference, basis and coefficient identities](../proofs/research-batch-08/combinatorics/BinaryStirling.lean). The complete recurrence argument is written.

<a id="result-88"></a>

### Schröder area polynomials · MO 479628

[MathOverflow 479628](https://mathoverflow.net/questions/479628)

[Schröder area polynomials from a Pascal-type recurrence](../proofs/research-batch-08/combinatorics/SchroederArea.md).

🟡 [Weight-preserving bijection and geometric area](../proofs/research-batch-08/combinatorics/SchroederArea.lean). The enumeration of the input paths by the stated recurrence is written.

<a id="result-89"></a>

### Guttmann and Kotěšovec, area of L-convex polyominoes

[Guttmann and Kotěšovec, area of L-convex polyominoes](https://www.mat.univie.ac.at/~slc/wpapers/lattpath/GuttmannKotesovec/GuttmannKotesovec.pdf)

[Partial. The limit of log a(n)/√n is π√(13/6)](../proofs/research-batch-08/geometry/l-convex-asymptotics.md).

🟡 [Real transfer-matrix bounds](../proofs/research-batch-08/geometry/LConvexTransfer.lean). The integral evaluation and passage to coefficients are written.

<a id="result-90"></a>

### Sun’s eleven-term conjecture

[Sun’s eleven-term conjecture](../results/A279821.md) · [A279821](https://oeis.org/A279821)

1,316,632,279 is an additional composite solution of the central trinomial congruence.

✅ [Full proof](../Sun.lean#L167)

<a id="result-91"></a>

### Wiseman’s all-ones rows

[Wiseman’s all-ones rows](../A385886.md) · [A385886](https://oeis.org/A385886)

Row 7 is (1,1,1,1). Its index contradicts the proposed Fibonacci formula.

✅ [Full proof](../AntiRunWitness.lean#L47)

<a id="result-92"></a>

### Indices of all-ones and one-part rows

[Indices of all-ones and one-part rows](../proofs/early/composition-rank-and-wythoff.txt) · [A385886](https://oeis.org/A385886)

The row of d ones has index $F_{d+2}-1$. The one-part row (r) has index $F_{2r}$ for every positive r.

⬜ Written proof

<a id="result-93"></a>

### Israel’s six-position conjecture

[Israel’s six-position conjecture](../Israel-proof.md) · [A050129](https://oeis.org/A050129)

For every n > 1, its position in Kimberling’s permutation is one of n/2, n+1, 2n+2, 2n+3, 4n+3, 4n+5.

✅ [Full proof](../Israel.lean#L40)

<a id="result-94"></a>

### Hasler’s prime periods

[Hasler’s prime periods](../A300326-period.md) · [A300326](https://oeis.org/A300326)

The least period is p(p−1) for primes p ≥ 5, and 8 and 9 for p = 2 and 3. Each period ends in 1, 1, 0, 0.

✅ [Full proof](../Hasler.lean#L129)

<a id="result-95"></a>

### Prime divisors

[Prime divisors](../A300326-period.md) · [A300326](https://oeis.org/A300326)

For any finite set of primes there are arbitrarily late terms congruent to 1 modulo every prime in the set.

✅ [Full proof](../Hasler.lean#L352)

<a id="result-96"></a>

### Cano’s question, finite range

[Cano’s question, finite range](../proofs/early/check_cano.py) · [A300326](https://oeis.org/A300326)

Every term from index 5 through 5,000 is composite. The question about later primes remains open in this work.

⬜ Exact computation

<a id="result-97"></a>

### Kimberling’s gap conjecture

[Kimberling’s gap conjecture](../proofs/early/gaps-proof.ru.md) · [A376453](https://oeis.org/A376453) · [A376452](https://oeis.org/A376452)

A gap of 6 runs from 104,080,799 to 104,080,805. Every gap size d ≥ 2 occurs infinitely often.

✅ [Full proof](../proofs/early/QuarterGaps.lean#L168)

<a id="result-98"></a>

### First gap of each size

[First gap of each size](../first-gaps.md) · [A376453](https://oeis.org/A376453)

The first gap of size d has right endpoint $E_d$, where $E_2=3$ and $E_{d+1}=E_d^2+1$.

⬜ Written proof

<a id="result-99"></a>

### Mathar’s printed recurrence

[Mathar’s printed recurrence](../results/A103769.txt) · [A103769](https://oeis.org/A103769)

At n = 4 the proposed recurrence has residual −81,756.

✅ [Full proof](../proofs/early/Mathar.lean#L27)

<a id="result-100"></a>

### Corrected recurrence

[Corrected recurrence](../results/A103769.txt) · [A103769](https://oeis.org/A103769)

Multiplying the leading coefficient by 4 gives an identity for all n ≥ 4. [Polynomial identity](../results/correct_mathar.py)

⬜ Written proof

<a id="result-101"></a>

### Fröhlich’s composite witness

[Fröhlich’s composite witness](../proofs/early/short-proof.md) · [A308482](https://oeis.org/A308482)

The composite 413,343 satisfies the stronger congruence modulo its square. [Arithmetic certificate](../proofs/early/frohlich_certificate.py)

✅ [Full proof · native_decide](../proofs/early/FrohlichNative.lean#L5)

<a id="result-102"></a>

### First witness after 189 and a family

[First witness after 189 and a family](../trinomial-proof.ru.md) · [A308482](https://oeis.org/A308482)

413,343 is the smallest composite solution after 189. A separate certificate gives 30 solutions beyond 189. [Family certificate](../proofs/early/family_certificate.py)

⬜ Written proof

<a id="result-103"></a>

### Kimberling’s greedy set

[Kimberling’s greedy set](../results/A026488.md) · [A026488](https://oeis.org/A026488)

Its members are exactly 3 and the positive integers congruent to 1 modulo 3.

✅ [Full proof](../proofs/early/Kimberling.lean#L95)

<a id="result-104"></a>

### Five greedy permutations

[Five greedy permutations](../proofs/early/permutations-proof.ru.md) · [A050128](https://oeis.org/A050128) · [A050135](https://oeis.org/A050135) · [A050136](https://oeis.org/A050136) · [A050137](https://oeis.org/A050137) · [A050138](https://oeis.org/A050138)

Each sequence takes every positive integer exactly once. One family theorem covers the five rules and their seeds.

✅ [Full proof](../proofs/early/IndexPermutations.lean#L119)

<a id="result-105"></a>

### Sharp position bound

[Sharp position bound](../proofs/early/DoubleHalf-RU.md) · [A050128](https://oeis.org/A050128)

The position satisfies T(n) ≤ 4n+5. Equality occurs at n = 81, whose position is 329. [Sharpness check](../proofs/early/verify_double_half.py)

🟡 [Upper bound](../proofs/early/DoubleHalf.lean#L122)

<a id="result-106"></a>

### Murthy’s digit condition

[Murthy’s digit condition](../proofs/early/murthy-digits.md) · [A113572](https://oeis.org/A113572) · [A113573](https://oeis.org/A113573)

An admissible multiple exists exactly when n = 5 or 5 does not divide n. The zero positions are 10, 15, 20, …

✅ [Full proof](../proofs/early/MurthyDigits.lean#L225)

<a id="result-107"></a>

### Hadjicostas’s remainder sum

[Hadjicostas’s remainder sum](../results/A049804.md) · [A049804](https://oeis.org/A049804)

Appending a digit r in any base b ≥ 2 gives $s_b(bn+r)=b s_b(n)+r(1+\lfloor\log_b n\rfloor)$ for n ≥ 1.

✅ [Full proof](../proofs/early/RemainderSum.lean#L30)

<a id="result-108"></a>

### The Frayed Rope permutation

[The Frayed Rope permutation](../proofs/early/A340138.txt) · [A340138](https://oeis.org/A340138)

Under the digital-root rule in the author’s program and table, every nonnegative integer occurs exactly once.

✅ [Full proof](../proofs/early/FrayedRope.lean#L147)

<a id="result-109"></a>

### Growth, residues and powers of ten

[Growth, residues and powers of ten](../proofs/early/A340138.txt) · [A340138](https://oeis.org/A340138)

For $α=\log_{10}9$, $a(n)=n+O(n^α)$. Residues are equidistributed and the displacement of $10^k$ is eventually constant.

⬜ Written proof

<a id="result-110"></a>

### Wiseman’s partition rows

[Wiseman’s partition rows](../proofs/early/A365383.md) · [A365383](https://oeis.org/A365383)

Extended row n has least eventual period n for every n ≥ 1.

✅ [Full proof](../proofs/early/PartitionPeriods.lean#L229)

<a id="result-111"></a>

### First periodic column

[First periodic column](../proofs/early/A365383.md) · [A365383](https://oeis.org/A365383)

An exact formula gives the first column of periodicity for each row. For n = 8 it is column 8, counting from zero.

⬜ Written proof

<a id="result-112"></a>

### Tetrastix distances and spheres

[Tetrastix distances and spheres](../proofs/early/A342235.md) · [A342235](https://oeis.org/A342235)

The exact distance gives sphere sizes $3r^2+1$ at odd radii and $3r^2+2$ at even radii r ≥ 4. The first even sizes are 1 and 12.

🟡 [Distance formula](../proofs/early/Tetrastix.lean#L149)

<a id="result-113"></a>

### Dale’s Pisot–Narayana recurrence

[Dale’s Pisot–Narayana recurrence](../proofs/early/Pisot-A048625.ru.txt) · [A048625](https://oeis.org/A048625)

P(4,6) satisfies $a_{n+3}=a_{n+2}+a_n$. For any positive integer seeds x < y, the first five terms decide whether it holds forever.

✅ [Full proof](../proofs/early/NarayanaPisot.lean#L84)

<a id="result-114"></a>

### Gladkovskii’s continued fraction

[Gladkovskii’s continued fraction](../proofs/early/Pisot-A048625.ru.txt) · [A048625](https://oeis.org/A048625)

The continued fraction equals the generating function as a formal power series.

🟡 [Finite truncation identity](../proofs/early/NarayanaPisot.lean#L151)

<a id="result-115"></a>

### Wu’s and Stephan’s Pisot formulas

[Wu’s and Stephan’s Pisot formulas](../proofs/early/pisot-proof.ru.md) · [A048582](https://oeis.org/A048582) · [A020748](https://oeis.org/A020748)

Wu’s order-seven recurrence for seeds (4,9) holds from n = 7. Stephan’s rational generating function for (4,10) holds at every index. [Certificates](../proofs/early/verify_pisot.py)

⬜ Written proof

<a id="result-116"></a>

### Eight ceiling Pisot sequences

[Eight ceiling Pisot sequences](../results/Pisot-recurrences.txt) · [A048590](https://oeis.org/A048590) · [A048592](https://oeis.org/A048592) · [A048591](https://oeis.org/A048591) · [A048587](https://oeis.org/A048587) · [A020736](https://oeis.org/A020736) · [A048580](https://oeis.org/A048580) · [A048585](https://oeis.org/A048585) · [A048589](https://oeis.org/A048589)

Exact certificates prove eight linear recurrences from their stated starting indices. The note identifies the previously proved case and its shift. [Certificates](../results/verify.py)

⬜ Written proof

<a id="result-117"></a>

### Floor Pisot sequence with seeds (5,9)

[Floor Pisot sequence with seeds (5,9)](../results/Pisot-recurrences.txt) · [A020750](https://oeis.org/A020750)

The order-five recurrence holds for every n ≥ 5. [Certificate](../results/salem.py)

⬜ Written proof

<a id="result-118"></a>

### Wu’s esthetic-number questions

[Wu’s esthetic-number questions](../proofs/early/A377000.md) · [A377000](https://oeis.org/A377000)

Path walks give the differential-composition count, the minimal recurrence in each base, and the diagonal identities with A182555 and A206603.

⬜ Written proof

<a id="result-119"></a>

### Binary runs and Stolarsky digits

[Binary runs and Stolarsky digits](../proofs/early/wiseman-binary.txt) · [A083368](https://oeis.org/A083368) · [A200648](https://oeis.org/A200648) · [A200649](https://oeis.org/A200649) · [A200650](https://oeis.org/A200650)

Run and anti-run lengths give the four statistics, with the first-index exceptions in A200648 and A200650. A083368 uses its changed-bit definition.

⬜ Written proof

<a id="result-120"></a>

### Composition ranks and Kurkov’s recurrence

[Composition ranks and Kurkov’s recurrence](../proofs/early/composition-rank-and-wythoff.txt) · [A385886](https://oeis.org/A385886) · [A385818](https://oeis.org/A385818) · [A348366](https://oeis.org/A348366) · [A200649](https://oeis.org/A200649)

The rank of row j of A385886 is A348366(j). Counting its parts gives the proposed recurrence in A200649.

⬜ Written proof

<a id="result-121"></a>

### Wythoff words and index shifts

[Wythoff words and index shifts](../proofs/early/composition-rank-and-wythoff.txt) · [A341259](https://oeis.org/A341259) · [A117479](https://oeis.org/A117479) · [A200649](https://oeis.org/A200649) · [A200650](https://oeis.org/A200650)

For k ≥ 1, A341259(k) = A200649(k+2) − 1 and A117479(k) = A200650(k+2).

⬜ Written proof

<a id="result-122"></a>

### Kotěšovec’s column asymptotic

[Kotěšovec’s column asymptotic](../proofs/early/A385001.txt) · [A385001](https://oeis.org/A385001)

For every fixed positive column k, a lattice-point count gives its partial-sum asymptotic with error $O_k(N^{2k-1}\log(2N))$.

⬜ Written proof

<a id="result-123"></a>

### Sharma’s visible lattice points

[Sharma’s visible lattice points](../proofs/early/visibility-proof.ru.txt) · [A401897](https://oeis.org/A401897) · [A401675](https://oeis.org/A401675)

The square and hexagonal spiral counts have leading terms $48n/π^2$ and $6n/π^2$, respectively, with error $O(\sqrt n\log(n+1))$.

⬜ Written proof

<a id="result-124"></a>

### Finite simple rank-four matroids · sufficient conditions

[Finite simple rank-four matroids · sufficient conditions](../results/rank-four-interlacing.txt)

The dual Chow and dual right augmented Chow roots strictly interlace if line sizes are constant or every line lies in the same number of planes.

⬜ Written proof

<a id="result-125"></a>

### Finite simple rank-four matroids · restrictions and examples

[Finite simple rank-four matroids · restrictions and examples](../results/rank-four-family.txt)

Failure requires a plane with at least seven points and positive covariance between the number of planes through a line and its size-dependent weight. An explicit family approaches equality from the interlacing side. [Covariance identity](../results/covariance.txt)

⬜ Written proof
