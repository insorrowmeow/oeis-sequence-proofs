# The dyadic row decomposition of A089177

[MathOverflow 509248](https://mathoverflow.net/questions/509248/row-polynomials-of-number-of-non-squashing-partitions-of-n-into-k-parts) asks for two identities for reversed row polynomials of [A089177](https://oeis.org/A089177). Both follow by cutting a chain at the first term below a sequence of halving thresholds. We use the explicit row recurrence and indexing in the question and OEIS.

Let $C(N,d)$ count positive integer chains $N\ge t_1,\ t_i\ge 2t_{i+1}$ of length $d$, including one empty chain. The maximum length for $N>0$ is $D(N)=1+\lfloor\log_2 N\rfloor$; set $D(0)=0$. Removing chains with first entry exactly $N$ gives $C(N,d)-C(N-1,d)=C(\lfloor N/2\rfloor,d-1)$ for $N,d\ge1$. Thus $C(N,d)=T(N,d)$ with the question's initial rows. Set $R_N(x)=\sum_d C(N,d)x^d$, $Q_N(x)=x^{D(N)}R_N(1/x)$.

**Binary split.** Put $A=2^L$, $0\le B<A$, $N=A+B$. In a chain mark the maximal initial run $t_i>A/2^{i-1}$, of length $k$. The differences $u_i=t_i-A/2^{i-1}$ form a positive chain with first term at most $B$. These subtractions are integral: the first $L+1$ thresholds are integers, and $k=L+1$ would force $B\ge2^L$, which is excluded. The suffix is any chain bounded above by $A/2^k$. Conversely adding the thresholds to such a prefix and appending any such suffix recovers a valid chain: if both pieces are nonempty the last prefix term strictly exceeds twice the maximum permitted first suffix term. Therefore
$$
 R_N(x)=\sum_{k=0}^{D(B)} x^k C(B,k)\,R_{2^{L-k}}(x).
$$
Since $D(2^{L-k})=D(N)-k$, reversing the polynomials yields $Q_N=\sum_k C(B,k)\,Q_{2^{L-k}}$, the second conjecture.

**Power-of-two rows.** For $s\ge1$ put $H(s,j)=C(2^{s-1},s-j)$ for $0\le j\le s$; put $H(0,0)=1$. The empty chain and the unique maximum-length chain give diagonal and first column identically one. For $s\ge2,\ 1\le j<s$, put $d=s-j$ and use the same prefix cut with $A=B=2^{s-2}$. Here the equality case $B=A$ is permitted because we are counting only chains of length $d\le s-1$. Every subtracted threshold up to the $d$-th is integral. A prefix of length $k$ permits a suffix bounded by $\lfloor A/2^k\rfloor$, which is zero for $k=s-1$; in that case only the empty suffix occurs. With $i=s-1-k$, the prefix count is $H(s-1,i)$, and the suffix count is $H(i,j-1)$, including $H(0,0)$. Thus
$$
 H(s,j)=\sum_{i=j-1}^{s-1}H(s-1,i)H(i,j-1).
$$
The defining recurrence of [A078121](https://oeis.org/A078121) now gives $H=M$, proving the first conjecture.

**Previously proved coefficient formula.** The OEIS entry labels this formula conjectural, but [Epstein's Theorem 7.3, case $s=1$](https://github.com/Eppie/oeis-proofs/blob/feafd9b033ee5f4391b001d3dfd4d706b6ddf0ba/proofs/A000123.md) already proves it. Here is its short derivation from the chains. For $0\le j<s$, set $d=s-j,\ N=2^{s-1}$. A chain is encoded uniquely by its nonnegative slacks $N-t_1,\ t_i-2t_{i+1}\ (1\le i<d),\ t_d-1$. Their weighted sum is $N-2^{d-1}$ with weights $1,1,2,4,\ldots,2^{d-1}$ (for $d=1$ there are just two unit weights). Hence
$$
 M(s,j)=[z^{N-2^{d-1}}]\frac{1}{(1-z)\prod_{h=0}^{d-1}(1-z^{2^h})}
 =[z^{2^s-2^d}]\prod_{h=0}^{d}(1-z^{2^h})^{-1}.
$$
For the last identity the exponent is even, so the exponent drawn from the unit-weight factor on the right must be even. Dividing all exponents by two gives the first product.

**Scope and prior art.** [Lean](DyadicChainCut.lean) proves for arbitrary chain lengths the equality of the direct chain recurrence with its recursive threshold decomposition whenever the starting threshold is divisible by the required power of two. Collecting the results by prefix length, identifying the matrix, and extracting its generating function are written proofs. Sloane and Sellers studied the underlying partitions and their binary encodings in [On non-squashing partitions](https://arxiv.org/abs/math/0312418); A089177 and A078121 already cross-reference each other. No priority claim is made.
