# Two conjectures of Mikhail Kurkov on binary positions

The December 2021 conjecture in [OEIS A125644](https://oeis.org/A125644) identifies the count of Dyck paths with a prescribed list of ascent lengths with A347205 at the bit complement of the composition index. The December 2024 conjecture in [OEIS A347205](https://oeis.org/A347205/internal) describes the same binary sequence by an auxiliary triangle T. Both identities hold for every index.

## A model for A347205

Index bits from zero at the right. For a nonnegative integer k with set bits at positions s₁<⋯<sᵣ let F(k) count ways to choose strictly increasing nonnegative positions t₁<⋯<tᵣ with tᵢ≤sᵢ. In particular F(0)=1.

For 2k+1 the smallest chosen position must be zero. Remove it and shift the others down one, obtaining F(k). For 2k with k>0 there are two cases. If position zero is absent, shifting all positions down gives F(k). If zero is present, remove it and the smallest bounding position, then shift the rest down; this gives F(k−lowbit(k)), where lowbit(k) is its least nonzero binary place value. Both transformations are reversible. These are precisely the defining recurrences of A347205, so strong induction proves F=A347205. The [Lean recurrence proof](DominatedBits.lean) uses lists of bounds, choosing the smallest available position and rebasing the tail.

## Dyck paths and the bit complement

Take n>0 with L binary digits. Read the leading 1 as starting a part, every following 1 as starting a new part, and each 0 as extending the last part. This is the [standard OEIS composition order](https://oeis.org/A066099). Let C={c₁<⋯<cₛ} be the partial sums before the last part, all in U={1,…,L−1}. For a path with these ascent lengths let dᵢ be the cumulative number of down steps at the end of its i-th descent. Exactly the sets D={d₁<⋯<dₛ} with dᵢ≤cᵢ are admissible: these inequalities enforce nonnegative height at all valleys. Successive differences recover the descent lengths, using endpoint L.

The inequalities are equivalent to |D∩[1,j]|≥|C∩[1,j]| for every j. Taking complements in U reverses them, and reflecting positions by j↦L−1−j reverses the coordinate order once more. Thus the reflected complement of D is an arbitrary increasing choice bounded coordinatewise by the reflected complement of C. The latter consists exactly of the set bits of the L-digit complement of n: a cut at position j is encoded by the bit of weight 2^(L−1−j). This proves A125644(n)=F(A035327(n)). At n=0 the empty Dyck path contributes one and the OEIS complement is 1, with F(1)=1. [Complement convention](https://oeis.org/A035327)

## The auxiliary triangle

If n has w set bits, write their positions in *decreasing* order b₁>⋯>b_w. Form the weakly decreasing nonnegative row lengths λᵢ=bᵢ−(w−i). Subtracting the same staircase from a dominated choice gives a bijection with weakly decreasing nonnegative integer rows μᵢ≤λᵢ, the subpartitions of λ. Define T(n,k) to count subpartitions of its first k−1 rows for 1≤k≤w+1. Empty rows give T(0,1)=1; using all rows gives T(n,w+1)=F(n).

Appending a 1 at the right of the binary word leaves the old row lengths unchanged and appends a zero row. This copies every old T entry and repeats the last one. Appending a 0 increases every row length by one. For a subpartition of the first k−1 enlarged rows, let j be its number of positive rows. Subtract one from each of these j rows. This bijects that class with all subpartitions of the first j original rows, including those ending in zeros. Thus T(2n,k)=Σᵢ₌₁ᵏ T(n,i). Taking the full row count yields F(2n)=Σᵢ₌₁ʷ⁺¹T(n,i). The empty shape at n=0 obeys the same rules. This proves every recurrence and readout in the stated conjecture.

The path and partition bijections are written proofs. Lean 4.19.0 checks the two general binary recurrence identities for the list enumeration. This file makes no claim of priority or of evaluating the separate A196148 square sum.
