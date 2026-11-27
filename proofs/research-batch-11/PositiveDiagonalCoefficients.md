# Positive integral coefficients in every diagonal of the self-squaring triangle

Let $M$ be the lower unitriangular matrix A078121 with first column all ones and $M_{i+1,j+1}=(M^2)_{i,j}$. Write $k=m-2j$. Kurkov's diagonal coefficients are normalized by
$$
 M_{n+m,n}=\frac1{m!}\sum_{0\le j<m/2}
      (-1)^j\,2^{\binom{k}{2}}P(m,j)\,(2^n)^k,\qquad m\ge1,\ n\ge0.
$$
**Theorem.** Every $P(m,j)$ in this formula is a strictly positive integer, and $P(m,0)=1$.

The representation itself is prior work. The original OEIS conjectural line was withdrawn. Epstein subsequently recorded positivity and integrality as open, and Bowles proved both in the first two nonleading strips plus positivity in further strips. The theorem above deals with all the coefficients in their stated normalization (their polynomial variable is $2^{n-1}$). [Epstein, Corollary 4 and §6](https://github.com/Eppie/oeis-proofs/blob/feafd9b033ee5f4391b001d3dfd4d706b6ddf0ba/proofs/A078121-diagonal.md) · [Bowles, October 2026, Diagonal_Coefficients/solution.md in the supplement](https://sulayman-bowles.dev/research/math-2026-10-19/harder/Harder_Math_Progress_2026-10-19.zip)

### A centered difference equation

Put $F_m(x)=(M^x)_{m,0}$, where $M^x=\sum_{t\ge0}\binom xt(M-I)^t$. At row $m$ and column 0 this is a rational polynomial of degree at most $m$. It is integer-valued on the nonnegative integers and $m!F_m\in\mathbb Z[x]$ directly from the binomial expansion. We have $F_0=1$ and $F_m(0)=0$ for $m>0$. Shifting one row and column respects lower triangular products, and acts on $M^x$ by taking $M^{2x}$, first for integral $x\ge0$, then by polynomial identity. Iterating gives $M_{n+m,n}=F_m(2^n)$.

The first column of $M-I$ is $0,1,1,\ldots$. Hence the $(m,0)$-entry of $M^x(M-I)$, for $m\ge1$, is the sum of row $m-1$ of $M^{2x}$, which equals $(M^{2x}M)_{m-1,0}$. Therefore
$$
 F_m(x+\tfrac12)-F_m(x-\tfrac12)=F_{m-1}(2x).
 \tag{1}
$$
The leading coefficient comparison gives $m![x^m]F_m=2^{\binom m2}$ by induction.

### Every sign is strict

With $D$ the differentiation operator, finite Taylor expansion in (1) gives
$$
 F'_m(x)=\frac{D/2}{\sinh(D/2)}\, F_{m-1}(2x).
$$
Only finitely many terms act on a fixed polynomial. The scalar series $t/\sinh t$ has coefficient of degree $2r$ equal to $(-1)^r b_r$ with $b_r>0$ for all $r\ge0$. Indeed Euler's product for sine gives $u/\sin u=\prod_{h\ge1}(1-u^2/(\pi h)^2)^{-1}$. This converges near zero, and each even coefficient is positive already in the first factor. Substitute $u=it$.

Induct on $m$. To obtain degree $m-1-2j$ of $F'_m$, apply $D^{2r}$ to degree $m-1-2(j-r)$ of $F_{m-1}(2x)$. Every nonzero contribution has sign $(-1)^r(-1)^{j-r}=(-1)^j$. The term $r=j$ differentiates the positive leading monomial, giving a nonzero contribution for every $m-2j\ge1$. Integration with zero constant term preserves these strict signs and leaves only the indicated parity of powers. This establishes $P(m,j)>0$.

### The power of two in the normalization

Put $f_{m,k}=F_m^{(k)}(0)$ and $v_2(0)=+\infty$. We claim $v_2(f_{m,k})\ge\binom k2$ for $0\le k\le m$. For $k=0$ the constant term is 0 or 1. For $k\ge1$ differentiate (1) $k-1$ times at zero. The result reads
$$
 f_{m,k}
 =2^{k-1}f_{m-1,k-1}-
   \sum_{\substack{r\ge1\\ k+2r\le m}}
     \frac{f_{m,k+2r}}{2^{2r}(2r+1)!}.
 \tag{2}
$$
Induct on $m$, and for fixed $m$ descend in $k$. The first term has valuation at least $k-1+\binom{k-1}{2}=\binom k2$. For $k,r\ge1$,
$$
 \binom{k+2r}{2}-\binom k2=r(2k+2r-1)
 \ \ge\ 4r-1\ \ge\ 2r+v_2((2r+1)!).
$$
For the first inequality check $r=1$, and use $2k+2r-1\ge5$ for $r\ge2$. The second follows from Legendre's formula because $2r+1$ is odd and greater than 1, with at least two set bits. Thus every summand has the required valuation and (2) proves the claim.

Finally $m![x^k]F_m=(m!/k!)f_{m,k}$ is an integer, with 2-adic valuation at least $\binom k2$. Division by $2^{\binom k2}$ and the sign already proved produce a positive integer for every admissible $m,j$.

**Sharp recurrence order.** For fixed $m$, the sequence $M_{n+m,n}$ is a linear combination of the $\lfloor(m+1)/2\rfloor$ distinct exponentials $(2^{m-2j})^n$ with nonzero coefficients. An annihilating polynomial in the shift must vanish at every one of these bases, since their Vandermonde matrix is nonsingular. Their product of linear factors annihilates the sequence. Its minimal constant-coefficient recurrence thus has exactly this order.

The [Lean file](DiagonalArithmetic.lean) verifies the binomial gap against the exact 2-adic valuation of the factorial at every $k,r\ge1$. The centered differences, signs, valuation induction and resulting integrality theorem are written proofs. A [separate script](check_diagonal_formulas.py) checks the normalized coefficients through $m=45$ directly from integer matrix powers.
