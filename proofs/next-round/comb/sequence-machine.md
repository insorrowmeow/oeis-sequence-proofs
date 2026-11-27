# The position of the complement of a Wythoff word

For every positive integer $n$, the position of the bitwise complement of Kimberling's $n$-th word is

    A344960(n) = A345253(A030109(A353654(n+2))) − 1
               = A345253(A348366(n+1)) − 1.

The first equality answers the April 2024 MathOverflow question. The second proves the formula Sequence Machine proposed in OEIS. Both compute the same intermediate integer. For example, the third word is 00 and its complement 11 is seventh. Here A353654(5) = 15, A030109(15) = 7, and the label at node 7 is 8. [MathOverflow question](https://mathoverflow.net/questions/468217/interesting-conjecture-by-sequence-machine) · [OEIS A344960](https://oeis.org/A344960)

## The word for an integer

Let F₀ = 0, F₁ = 1. List binary words beginning and ending in 1 with no consecutive zeros, first by length and then lexicographically. Write Cⱼ for word j, starting with C₁ = 1. Its integer value in ordinary binary is A247648(j). Give bit position i, counting from 1 on the right, weight Fᵢ. Then the Fibonacci weight of Cⱼ is exactly j. [A247648](https://oeis.org/A247648)

Indeed, lengths 1 and 2 consist of 1 and 11, of weights 1 and 2. More generally the weights at length r run in increasing order through [Fᵣ₊₁, Fᵣ₊₂−1]. At length r ≥ 3 the words start with 10u, then 1v, with u and v ranging over lengths r−2 and r−1. Prefixing adds exactly Fᵣ to the weights in both blocks. By induction the parent intervals together are [Fᵣ₋₁, Fᵣ₊₁−1], proving the assertion.

After the first 1, break Cⱼ into blocks 1 and 01, encoding them as 1 and 0 respectively. Call the resulting string Uⱼ, which may be empty. Thus C₅ = 1011 gives U₅ = 01. This bijection identifies the canonical words with all finite bit strings. Write rev for reversal and bar for bitwise complement, both preserving length.

## Why Wythoff's two branches append exactly these blocks

Let φ = (1+√5)/2 and ψ = −1/φ. For a word Cⱼ write S = Σ dᵢFᵢ₊₁, with dᵢ its digits. Since Fᵢ₊₁−φFᵢ = ψⁱ and d₁ = 1, the error S−φj is strictly between −1 and 0. The lower bound follows by retaining all odd negative powers in the infinite series, whose sum is −1. The upper bound retains ψ and all the even positive powers, whose sum is 0. Both bounds are strict because the word is finite. Hence S = floor(φj).

Appending 1 to Cⱼ gives weight S+1, and appending 01 gives weight S+j+1 = floor(φ²j)+1. Accordingly these operations append 1 or 0 to Uⱼ.

In the Wythoff ordering let Wₙ be word n and adjoin the empty word W₀. The children of Wₖ have indices floor(φ(k+1)) and floor(φ²(k+1)); their words are 0Wₖ and 1Wₖ. This is Kimberling's definition: at the (k+1)-st term of either Beatty sequence there are exactly k earlier terms in that sequence. At k = 0 this gives W₁ = 0 and W₂ = 1. Hence induction gives

    Wₙ = rev(bar(Uₙ₊₁)).

In particular, if Uⱼ = u and j = n+1, the position of the complement of Wₙ is j′−1, where Uⱼ′ = bar(u). This is the only such position. [Definition of the words](https://oeis.org/A341258)

## Reading the two sides of the identity

The maximal Fibonacci tree A345253 has root 1. For a node label j at canonical length r the largest t with Fₜ ≤ j is r+1. The left child adds Fᵣ₊₁ and the right adds Fᵣ₊₂, by the defining branches of that tree. In canonical words this prefixes 1 or 10, respectively. In U this prepends one bit: 1 on the left, 0 on the right. Consequently a heap address with binary expansion 1v has label j′ with Uⱼ′ = rev(bar(v)). For v = rev(u) this is exactly the desired label. [Tree definition](https://oeis.org/A345253) · [Lower Fibonacci inverse](https://oeis.org/A130233)

We now derive the heap address from the zero-balanced numbers A353654. For j ≥ 1 let z be the number of zeros of Uⱼ. Form the binary word

    Bⱼ = 1 Uⱼ 1 0ᶻ.

It has z trailing and z other zeros. Conversely every such number except 1 has a nontrailing prefix beginning and ending with 1 and containing at least two ones. Remove its leading and last ones and the trailing zeros to recover Uⱼ, hence Cⱼ. The length of Bⱼ is |Cⱼ|+1. Within one length the first mismatch of C words occurs at a block boundary, where 01 precedes 1. Their U strings differ in the same order; a proper-prefix tie would require different encoded lengths. Thus Bⱼ is the binary expansion of A353654(j+1). Reversing Bⱼ, suppressing leading zeros, subtracting 1 and dividing by 2 gives binary 1 rev(Uⱼ), exactly the required heap address. This proves the MathOverflow formula. [Zero-balanced sequence](https://oeis.org/A353654) · [Reversal operation](https://oeis.org/A030109)

For the OEIS version set K(j) = binary value of 1 rev(Uⱼ) for positive j, and K(0) = 0. If j ≥ 2, deleting the initial 10 or 1 in Cⱼ gives parent index h = j−Fᵣ by the interval proof above. For r = 2 use the sole word 11 with parent 1. The bit adjoined on the right of K(h) is 0 or 1 according as the length drop is two or one. Thus K(1) = 1 and

    K(j) = 2K(h) + ((r(j) − r(h)) mod 2).

The interval proof shows that length r(j) is A072649(j) and Fᵣ is A130312(j). Hence these are exactly the initial conditions and defining recurrence of A348366. [Recurrence](https://oeis.org/A348366) · [Lengths](https://oeis.org/A072649) · [Fibonacci blocks](https://oeis.org/A130312)

## Related conjectures resolved by the same code

* The A353654 rewrite conjecture follows by appending 1 to Cⱼ and decoding 1 as 1 and 01 as 0. This yields 1Uⱼ1, the odd part of Bⱼ. The length count above gives a(Fₘ) = 2ᵐ⁻¹−1 for m ≥ 2, since this is the last number of bit length m−1. Here a = A353654; length one contributes the initial 1 and the lengths 2 through m−1 contribute Σ Fᵢ for i from 1 through m−2.
* For the recursion of A353654, set j = n−1 ≥ 2, h = j−Fᵣ, H = a(h+1), and g = [j > 2h]. The 10-parent block ends just before j = 2Fᵣ; indeed its start is Fᵣ₊₁ and its size is Fᵣ₋₂. Thus g = 1 in that block and g = 0 in the other (also at r = 2). If H has binary form 1w, the child has form 10w0 for g = 1 and 11w for g = 0. Reading the two binary values gives exactly a(n) = 2ᵍ(H + (2−g)2^floor(log₂ H)). The initial values are 1 and 3. [Conjectures](https://oeis.org/A353654)
* A025480(m−1) deletes all trailing zeros of the positive binary number m and then its final one, by its even and odd recurrences. Thus A358654(j) = binary value of 1Uⱼ for j ≥ 1. This proves the rewrite conjecture in that entry. Its second conjecture at positive j follows too: the maximal expansion used in A343152 is Cⱼ (its published algorithm subtracts Fᵣ at each step, exactly our rank recursion). Its operation reverses the internal bits, equivalently the whole word since both end bits are 1. The blocks between successive ones therefore have their gaps reversed. Applying K to the resulting index reverses these gaps back and gives 1Uⱼ. The entry's additional initial value “a(0) = 1” conflicts with its defining formula, which gives A025480(0) = 0, as its data also show. The composition proved here is asserted only for j ≥ 1. [A358654](https://oeis.org/A358654) · [Reversal, examples and implementation](https://oeis.org/A343152/internal) · [A025480](https://oeis.org/A025480)

## Earlier results and checks

The two main formulas describe one position. The connection between Fibonacci gaps, compositions with parts 1 and 2, Wythoff trees, and reversal already occurs in J. Parker Shectman's 2021 work, in particular the discussion of Corollary 7.4 and Figure 24(c). His A345253 entry also describes the tree via inner composition of shifted Wythoff functions. The distinct step used here connects the zero-balanced integers in the 2024 question to the heap addresses of that tree. [Shectman, *A Quilt after Fibonacci*, Part 2](https://www.ootlinc.com/Fibonacci_Quilt_2_of_3_Cohorts_and_Numeration.pdf) · [Shectman's tree entry](https://oeis.org/A345253/internal)

The MathOverflow API returned zero answers, OEIS listed the A348366 version as a conjecture, and neither A344960 nor A353654 was found by exact identifier in the TrureTuring catalogue or its GitHub issues and pull requests when checked on 27 November 2026. Historical priority is undetermined. [MathOverflow record](https://api.stackexchange.com/2.3/questions/468217?site=mathoverflow) · [OEIS record](https://oeis.org/A344960/internal) · [TrureTuring catalogue](https://www.trureturing.org/conjectures)

This is a written proof. Run `python verify.py` alongside it. For n from 1 through 10,000 it independently constructs Kimberling's words, scans the defining zero condition on positive integers, and evaluates the tree both by its branch labels and by the low-bit-first algorithm printed in the MathOverflow question.
