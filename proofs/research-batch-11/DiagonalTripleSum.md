# The literal triple-sum formula on the diagonals of A078121

Let $a_n=M_{n+m,n}$ for $m\ge1$, $z=2^m$, $q=4$, and $d=\lfloor(m+1)/2\rfloor$. Write $R_i(X)=\prod_{\ell=0}^{i-1}(q^\ell-X)=\sum_j R(i,j)X^j$. The proposed formula is
$$
 a_n=\sum_{i=0}^{d-1}\ \sum_{j,k=0}^{i}
 \frac{2^{n(m-2i+2j)-i(i-3)-k(m-2i+2)}
 R(i,j)R(i,k)a_k}{\prod_{\ell=1}^i(4^\ell-1)} .
 \tag{1}
$$
The original question and its posted answer describe a Vandermonde argument. Epstein proves the spectral representation $a_n=\sum_{s=0}^{d-1}c_s(zq^{-s})^n$ for every $m,n$, and points out that the simplification to the particular triple sum was only numerically verified in his treatment through $m=20$. Below is an explicit derivation for every $m$. The spectral representation also follows directly from the centered difference equation in the [companion proof](PositiveDiagonalCoefficients.md). [Original question and answer](https://mathoverflow.net/questions/495883/closed-form-for-diagonals-of-a078121) · [Epstein, §§0, 5, 8](https://github.com/Eppie/oeis-proofs/blob/feafd9b033ee5f4391b001d3dfd4d706b6ddf0ba/proofs/A078121-diagonal.md)

Both sides of (1) are linear in the sequence, so fix $a_k=(zq^{-s})^k$ with $0\le s<d$. Put $x=q^{-n}$, $t=q^{-1}$. After division by $z^n$, the sum over $j$ supplies the factor
$$
 q^{-ni}R_i(q^n)=\prod_{\ell=0}^{i-1}(q^\ell x-1)
 =q^{\binom i2}N_i(x),\qquad
 N_i(x)=\prod_{\ell=0}^{i-1}(x-t^\ell).
$$
The sum over $k$ supplies $R_i(q^{i-1-s})$. This vanishes if $i>s$. Otherwise its value is $q^{\binom i2}\prod_{h=s-i+1}^{s}(1-t^h)$. The denominator in (1) is $q^{i(i+1)/2}\prod_{h=1}^i(1-t^h)$. Combining these factors with $2^{-i(i-3)}=q^{i(3-i)/2}$ cancels every power of $q$. Thus the remaining identity is
$$
 x^s=\sum_{i=0}^s {s\brack i}_t\,N_i(x),\qquad
 {s\brack i}_t=\frac{\prod_{h=s-i+1}^{s}(1-t^h)}{\prod_{h=1}^i(1-t^h)}.
 \tag{2}
$$
For completeness, $xN_i=N_{i+1}+t^iN_i$. The product quotient in (2) satisfies
${s+1\brack i}_t={s\brack i-1}_t+t^i{s\brack i}_t$, with out-of-range coefficients zero and boundary coefficients one. For $1\le i\le s$, divide both sides by ${s\brack i}_t$; the numerator of the resulting right side over $1-t^{s-i+1}$ is $1-t^i+t^i(1-t^{s-i+1})=1-t^{s+1}$. Multiplying (2) by $x$ now proves its next case. The case $s=0$ is immediate. This proves (1) at every index.
## Verification

The [Lean proof](DiagonalNewton.lean) establishes the Newton-basis expansion of a monomial for every degree using the coefficient recurrence. The identification with the explicit Gaussian product and the reduction of the literal triple sum are proved above. The [standalone check](check_diagonal_formulas.py) also compares the original triple sum with the matrix defined by its original recurrence.
