# Five weighted binary identities in A347205

The four conjectured sums over binary blocks and the conjecture for alternating binary digits in [OEIS A347205](https://oeis.org/A347205/internal) follow from two weighted path enumerations. Throughout, b(0)=1 and the two parameters p,q are those of that entry. All generating functions are formal. The results hold as polynomial identities in the parameters.

## Reading a binary block

Write S(n,m)=Σ_{0≤k<2ⁿ} b(2ᵐk). For a vector v define L₀(v)=v₀ and Lₘ₊₁(v)=pLₘ(v)+qvₘ₊₁. Then

    Lₘ(v) = pᵐv₀ + q Σ_{j=1}^m p^(m−j)vⱼ.

For fixed k put vⱼ=b(2ʲk). The defining recurrence gives b(2ᵐ(2k+1))=Lₘ(v): the base case discards the final 1; in the even update, removing the lowest set bit from 2ᵐ(2k+1) leaves 2ᵐ⁺¹k. Splitting the binary block into odd and even indices and using linearity gives

    S(0,m)=1,     S(n+1,m)=S(n,m+1)+Lₘ(S(n,·)).

Thus S(n,0) is the total weight of n-step paths starting at height zero. A step from m goes up to m+1 with weight 1, to zero with weight pᵐ, or to any j from 1 to m with weight q p^(m−j).

Let Uⱼ be the generating function by length for paths ending at j. Counting the last step gives

    U₀ = 1 + x Σ_{m≥0} pᵐ Uₘ,
    Uⱼ = x Uⱼ₋₁ + x q Σ_{m≥j} p^(m−j) Uₘ    (j≥1).

There is a unique solution with Uⱼ divisible by xʲ: the constant coefficients are prescribed and every next coefficient uses only the preceding degree. All sums at each degree are finite. Let t be the unique series with constant zero satisfying

    t = x + x q t/(1−pt).

Substitution shows that Uⱼ=U₀ tʲ with U₀=1/(1−x/(1−pt)) satisfies both equations. Summing over j gives the general block generating function

    F = Σ S(n,0)xⁿ = 1/((1−t)(1−x/(1−pt))).

Equivalently x=t(1−pt)/(1+(q−p)t), and F=(1+(q−p)t)/((1−t)(1+(q−p−1)t)).

## The four specializations

* For (p,q)=(2,1), F=1/(1−2t), and substitution yields F=1+xF+xF² with constant 1, the large Schröder generating function. [A006318](https://oeis.org/A006318)
* For p=q=s, t=xC(sx) where C(z)=1+zC(z)². Thus F=(1−xC(sx))⁻². When s=2 or 3, this is exactly the self-convolution generating function in the two stated entries. Indeed 1/(1−t)=(s−1+st)/(s−1+x), by x=t−st². [A115197](https://oeis.org/A115197) · [A116867](https://oeis.org/A116867)
* For (p,q)=(3,1), set y=xF=t/(1−t). Substitution gives x=y(1−2y)/(1−y²). This rational function has linear coefficient 1, so its compositional inverse is unique. That inverse is the generating function of A108524 starting at degree 1. Thus S(n,0)=A108524(n+1), including n=0. [A108524](https://oeis.org/A108524/internal)

## Alternating bits

Write M₀=0, Mₙ₊₁=4Mₙ+1, hence Mₙ=(4ⁿ−1)/3. Put V(n,m)=b(2ᵐ Mₙ). The same odd-tail identity gives V(n+1,m)=Lₘ(j↦V(n,j+1)), with V(0,m)=1. A path for V(n,0) takes a forced first step to height 1 with weight one. Subtract one from all subsequent heights. From shifted height i we can go to zero with weight p^(i+1) or to any j=1,…,i+1 with weight q p^(i+1−j).

For paths after the forced step let Wⱼ count endpoints by length. The incoming equations are W₀=1+xpΣᵢ pⁱWᵢ and Wⱼ=xqΣ_{i≥j−1}p^(i+1−j)Wᵢ for j≥1. Again they determine the series coefficient by coefficient. Their solution is Wⱼ=W₀uʲ, where u=xq/(1−pu)=qxC(pqx) and W₀=1/(1−pxC(pqx)). Therefore

    Σ b(Mₙ)xⁿ = 1 + x / ((1−pxC(pqx))(1−qxC(pqx))).

The product following x is c(qx;p)c(px;q) in equations (4)–(5) of Abate and Whitt. In the paper's indexing b(Mₙ₊₁)=Cₙ(p,q); b(M₀)=1 supplies the extra initial term in the OEIS convention. For example, (2,3) starts 1,1,5,49,653 in OEIS while the paper starts 1,5,49,653. [Abate and Whitt, pp. 2 and 7](https://cs.uwaterloo.ca/journals/JIS/VOL14/Whitt/whitt6.pdf) · [OEIS convention for C(2,3;n)](https://oeis.org/A116873)

## Verification status

[WeightedBlocks.lean](WeightedBlocks.lean) checks the odd-tail identity, the complete block transition and the alternating-index transition for arbitrary natural parameters and any sequence obeying the binary rules. The solution of the endpoint equations and the identification of generating functions are written proofs. The five identities belong to the single conjecture block in A347205. No priority claim is made.

[Finite checks for the five identities](check_weighted_blocks.py)
