# A disk containing exactly two poles

Let $F(x)=\sum_{n\ge0}a_nx^n$ count involutions avoiding 4321 and 4231. The two smallest positive poles $\rho_1,\rho_2$ are the only singularities in the closed complex disk $|x|\le70/149$. In particular there exist $C_1,C_2>0$ such that

$$
 a_n=C_1\rho_1^{-n}+C_2\rho_2^{-n}+O((149/70)^n).
$$

The numerical bounds from the real-axis certificate give
$2.34823753<1/\rho_1<2.34823761$ and
$2.14809853<1/\rho_2<2.14809858$.
Anthony Guttmann previously predicted a two-pole expansion by differential approximants. His estimate for the second reciprocal pole was $2.1484$. [OEIS A399659](https://oeis.org/A399659)

## The four-row Schur complement

Use $s$, $x=s/(1+s^2)$, and the tridiagonal matrix $J$ of the [non-D-finiteness proof](InvolutionPoles.md), derived from [Corollary 8.19 of Barnabei, Castronuovo and Silimbani](https://arxiv.org/html/2609.39952v1#S8.SS2.SSS8). Write $D_k$ for the determinant on the first $k$ indices $0,\ldots,k-1$. Thus $D_0=1$, $D_1=1-s-s^2$, and $D_{i+1}=b_iD_i-s^{4i+2}D_{i-1}$ for $i\ge1$. Set $r=7/10$. On $|s|\le r$, the tail $T$ on indices $4,5,\ldots$ differs from $(1-s^2)^2I$ in operator norm by at most $(1+r^2)r^9+2r^{11}$, by the maximum row and column sum bounds. Consequently $T$ is invertible and

$$
 \|T^{-1}\|\le1/\delta,\qquad
 \delta=(1-r^2)^2-(1+r^2)r^9-2r^{11}
       =16042659071/100000000000.
$$

Only the last diagonal of the four-row Schur complement $S$ changes. Expansion along that entry gives
$$
 \det S=D_4-s^{18}(T^{-1})_{44}D_3.
$$
Here the tail inverse uses the original row labels. To compare $\det S$ with $D_4$ on $|s|=r$, it suffices to show $\delta^2|D_4|^2-r^{36}|D_3|^2>0$ there.

## Exact count on the circle

The [certificate](check_involution_complex_disk.py) uses integer and rational polynomial arithmetic. It performs the following two checks.

1. For real $c_j$, the expression $\left|\sum_j c_j e^{ij\theta}\right|^2$ equals $\sum_j c_j^2+2\sum_{h\ge1}T_h(\cos\theta)\sum_j c_jc_{j+h}$, where $T_h$ is the Chebyshev polynomial. Applying this to $D_4(rz)$ and $D_3(rz)$ gives the comparison polynomial in $u=\cos\theta$ of degree 23. It is positive at $u=\pm1$. Its Sturm chain has 13 sign changes at each endpoint, so it has no zero between them. This proves the strict boundary inequality.

2. The polynomial $p(z)=D_4(rz)$ has degree 23 and has no zeros on the unit circle by the first check. Its number of roots in the open unit disk is exactly two, counted with multiplicity. For reproducibility, the counting recurrence for any real polynomial $p$ of degree $d>0$ uses its constant coefficient $a$, leading coefficient $b$, and reversal $p^*(z)=z^dp(1/z)$. Set $q=(bp-ap^*)/z$. At every step $|a|\ne|b|$, so $q$ has degree $d-1$. On the unit circle $|p^*|=|p|$. If $|b|>|a|$, Rouché's theorem gives $N(p)=1+N(q)$. If $|b|<|a|$, it gives $N(p)=d-1-N(q)$, since $N(p^*)=d-N(p)$. The same comparison ensures no boundary roots at the next step. The implementation reduces rational coefficients by positive common factors at each stage.

By Rouché's theorem the analytic determinant $\det S$ also has exactly two zeros in $|s|<7/10$, and none on the boundary. The [exact real brackets](check_involution_poles.py) place two distinct simple poles in this disk. They therefore exhaust its singularities.

## Transfer to $x$ and coefficients

The inverse $s(x)=(1-\sqrt{1-4x^2})/(2x)$, with $s(0)=0$, has nonnegative Taylor coefficients and is analytic on $|x|<1/2$. Hence $|s(x)|\le s(|x|)\le7/10$ whenever $|x|\le70/149$. Both positive poles lie strictly inside this $x$-disk, since $s\mapsto s/(1+s^2)$ increases for $0<s<1$. A preimage of either pole parameter $s_j$ necessarily satisfies $x=s_j/(1+s_j^2)=\rho_j$. Thus the two positive poles exhaust all singularities in the closed $x$-disk.

Let $C_j=-\operatorname{Res}_{x=\rho_j}F(x)/\rho_j$. These constants are positive. In the notation of the simplicity proof, if $u$ spans the unit kernel of $H(s_j)$, the residue of $[S^{-1}]_{00}$ is $(e_0^{\mathsf T}W^{-1}u)^2/(u^{\mathsf T}H'(s_j)u)<0$. The numerator is nonzero by the tridiagonal recurrence. Multiplication by $1-s_j^4$ and the change to $x$, whose derivative is positive, preserve that sign. Subtracting $C_j/(1-x/\rho_j)$ for both poles leaves a function holomorphic on a neighborhood of $|x|\le70/149$. Cauchy's coefficient estimate on its boundary proves the stated error bound.
