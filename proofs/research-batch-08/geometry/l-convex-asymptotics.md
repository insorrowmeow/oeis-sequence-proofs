# The exponential constant for L-convex polyominoes by area

Let a(n) count fixed L-convex polyominoes of area n, up to translation. Guttmann and Kotěšovec conjectured a full asymptotic from 2000 exact coefficients. The following proves its stretched exponential, including the constant in the exponent:

$$\lim_{n\to\infty}\frac{\log a(n)}{\sqrt n}=\pi\sqrt{13/6}.$$

Their finer prediction has a factor (13√2/768)n^(−3/2). The theorem here leaves that factor open. [Guttmann and Kotěšovec, 2023](https://arxiv.org/pdf/2109.09928), [OEIS A126764](https://oeis.org/A126764)

## Bounding the generating function

Write q=exp(−ε) with ε>0. The known area generating function is

$$A(q)=1+\sum_{k\ge0}\frac{q^{k+1}f_k}{(1-q^{k+1})\prod_{j=1}^k(1-q^j)^2},$$

where f₀=1, f₁=1+2q−q² and f_k=2f_{k−1}−(1−qᵏ)²f_{k−2} for k≥2. [Castiglione et al., 2007](https://doi.org/10.1016/j.ejc.2006.06.020), [Guttmann and Kotěšovec, equation (1.1)](https://arxiv.org/pdf/2109.09928)

Set s_j=√(2qʲ−q²ʲ), λ_j=1+s_j and v_j=(1,s_j). For k≥1 set V_k=(f_{k−1},f_k−f_{k−1}); take V₀=(1,0). The recurrence says exactly that

$$V_j=M_j V_{j-1},\qquad M_j=\begin{pmatrix}1&1\\s_j^2&1\end{pmatrix},\qquad M_jv_j=\lambda_jv_j.$$

All matrices preserve coordinatewise order. As j increases, s_j decreases through positive values. Thus v_j≤v_{j−1}≤(s_{j−1}/s_j)v_j. Initially V₀≤v₁ and V₁=(1,s₁²)≥s₁v₁. Induction and f_k=(1,1)V_k now give, for every k≥1,

$$\frac{s_1}{1+s_1}\prod_{j=1}^k\lambda_j
\ \le\ f_k\ \le\ \frac{2}{s_k}\prod_{j=1}^k\lambda_j.$$

Let G_k=∏_{j≤k}λ_j/(1−qʲ)². Because (1−qʲ)²=1−s_j², its jth factor is 1/(1−s_j). Write G∞ for the full product. It converges for each 0<q<1. Since s_k≥q^(k/2), the upper bound gives

$$A(q)\le 1+\frac{q}{1-q}+\frac{2q G_\infty}{1-q}\sum_{k\ge1}q^{k/2}.$$

As ε↓0 this is at most a constant times ε⁻²G∞. For a lower bound fix M>0 and take k=⌊M/ε⌋ in the sum for A. Then A(q)≥q^(k+1) s₁G_k/(1+s₁), and the prefactor tends to exp(−M)/2.

Set g(y)=−log(1−√(2e^(−y)−e^(−2y))). This is decreasing and positive. Its singularity at zero is −2log y+O(1), and it is O(e^(−y/2)) at infinity. Hence the ε-mesh Riemann sums converge, both for the entire integral and up to any fixed M. They are precisely ε log G∞ and ε log G_⌊M/ε⌋. The two bounds, followed by M→∞, give

$$\lim_{\varepsilon\downarrow0}\varepsilon\log A(e^{-\varepsilon})=I=\int_0^\infty g(y)\,dy.$$

## Exact evaluation

First substitute x=e^(−y), then x=2t²/(1+t²). The radical becomes 2t/(1+t²) and dx/x=(2/t−2t/(1+t²))dt. Expanding the product gives

$$I=\frac{\pi^2}{12}+\frac{2\pi^2}{3}-\frac{(\log2)^2}{2}+4J,\qquad
J=\int_0^1\frac{t\log(1-t)}{1+t^2}\,dt.$$

The first two integrals use the series for log(1±t) and the Basel sum. Integrating J by parts with primitive ½log((1+t²)/2), whose vanishing at t=1 removes the endpoint term, and substituting y=1−t gives

$$J=\tfrac12\int_0^1\frac{\log(1-y+y^2/2)}{y}\,dy=-\Re\operatorname{Li}_2((1+i)/2).$$

Put z=(1+i)/2. The reflection formula Li₂(z)+Li₂(1−z)=π²/6−log z log(1−z) follows by differentiating and taking z→0. It applies on the principal branches here, where 1−z is the conjugate of z. Therefore J=−5π²/96+(log 2)²/8, and

$$I=13\pi^2/24.$$

## Passing to an individual area

The counts a(n) are nondecreasing. Each row is an interval, as is each column. Two row intervals must be nested: if each contained a column the other missed, the two corresponding cells could not be joined with at most one bend. Extend the right end of the topmost widest row by one cell. It still contains every row, the new column has one cell, and the old row intervals remain nested. These properties ensure an L-shaped path between any two cells, by following the column of the cell in the smaller row and then the larger row. The image has a unique widest row, and deleting its rightmost cell recovers the original polyomino.

Here are details of the exponential coefficient estimate. Give integer j probability a(j)exp(−εj)/A(exp(−ε)) and put m=I/ε². Fix 0<δ<1. Markov's inequality applied to exp(±hεj), with h>0 sufficiently small, gives

$$\Pr(j\ge(1+\delta)m)\le\exp\!\left(\frac I\varepsilon
[1/(1-h)-1-h(1+\delta)+o(1)]\right),$$

$$\Pr(j\le(1-\delta)m)\le\exp\!\left(\frac I\varepsilon
[1/(1+h)-1+h(1-\delta)+o(1)]\right).$$

Both brackets are negative for small fixed h. Hence the probability between the two endpoints tends to one. Choose ε=√((1+δ)I/n), so the upper endpoint is n. Removing the weights on this interval gives

$$\sum_{j\le n}a(j)\ \ge\ (1-o(1))\,A(e^{-\varepsilon})\exp(\varepsilon(1-\delta)m).$$

Monotonicity bounds its left side above by (n+1)a(n). Thus the liminf of log a(n)/√n is at least (2−δ)√(I/(1+δ)); let δ tend to zero. The opposite inequality follows from a(n)≤exp(εn)A(exp(−ε)) with ε=√(I/n). Substituting the computed I proves the theorem.

## Verification scope

`LConvexTransfer.lean` proves the scalar two-sided estimate for every nonincreasing positive sequence of parameters with first parameter at most one. Its indexing starts at zero. The Lean proof works over the real numbers and uses the standard Lean axioms. The integration, monotonicity injection and coefficient limit have written proofs above.
