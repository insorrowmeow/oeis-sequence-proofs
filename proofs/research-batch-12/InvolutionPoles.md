# Infinitely many simple poles for involutions avoiding 4321 and 4231

**Theorem.** Let $F(x,y)$ count involutions avoiding both patterns, by length and descents. The analytic germ $F(x,1)$ continues to a meromorphic function along $0<x<1/2$, with infinitely many distinct simple real poles tending to $1/2$. Consequently $F(x,1)$ is not D-finite. The bivariate series $F(x,y)$ is not even D-finite in $x$ over $\mathbb C(y)$. This answers both parts of [Barnabei, Castronuovo and Silimbani, Question 8.17](https://arxiv.org/html/2609.39952v1#S8.SS2.SSS7). The counts are [OEIS A399659](https://oeis.org/A399659).

### The continued fraction as a matrix element

Set $x=s/(1+s^2)$ and $q=s^2$, using the branch $s(0)=0$ for the inverse. Define a symmetric tridiagonal matrix $J(s)$ indexed by $0,1,\ldots$. Its diagonal and upper/lower off-diagonal are
$$
 b_0=1-s^2-s,\quad b_i=(1-s^2)^2-s^{2i+1}(1+s^2)\ (i\ge1),
 \qquad e_i=-s^{2i+3}\quad (i\leftrightarrow i+1).
$$
Near $s=0$ the claimed representation is
$$
 G(s):=F\bigl(s/(1+s^2),1\bigr)
   =(1-s^4)\,[J(s)^{-1}]_{00}.
 \tag{1}
$$
Indeed, this is exactly the tridiagonal continued fraction of [Corollary 8.19](https://arxiv.org/html/2609.39952v1#S8.SS2.SSS8): elimination introduces the squared off-diagonals $s^{4i+6}$ in successive numerators. Here are analytic details connecting its formal meaning to (1). The bounded operator $J(s)$ on $\ell^2$ differs from $c(s)I$, $c(s)=(1-s^2)^2$, by a compact operator analytic in norm on $|s|<1$. Indeed, except for the single first entry, the deviations and off-diagonals decay uniformly geometrically on each closed subdisk; tridiagonal row and column bounds give norm convergence. Replace the tail after an initial finite section by $c(s)I$ and decouple it. These approximations tend to $J(s)$ uniformly on subdisks. All are uniformly close to $I$ in a common neighborhood of zero, so their inverses converge there uniformly as well. Their $(0,0)$ entries are the finite continued fractions. Their Taylor coefficients stabilize to the formal continued fraction of the corollary, since the first omitted coupling has order tending to infinity. Thus the analytic and enumerative germs agree.

### Eliminate only the tail

Fix $r<1$. Split the space at an index $N$, keeping indices $0,\ldots,N-1$ in the head $A$ and indices $\ge N$ in the tail $T$. Write $E$ for the head-to-tail block. Since $|c(s)|\ge(1-r^2)^2$, we may take $N$ so large that $\|T-c(s)I\|<(1-r^2)^2/2$ on $|s|\le r$. The Neumann series gives an analytic tail inverse there. For real $0\le s\le r$ the tail is strictly positive. Its finite Schur complement
$$
 S(s)=A(s)-E(s)T(s)^{-1}E(s)^{\mathsf T}
$$
differs from $A$ only in the last diagonal entry. Transpose here supplies the analytic continuation of the real symmetric block formula. Since $S(0)=I$, $\det S$ has isolated zeros. Equation (1) now holds meromorphically on $|s|<r$ with $[J^{-1}]_{00}=[S^{-1}]_{00}$. Different choices of $r,N$ agree as meromorphic germs by uniqueness. This constructs a single meromorphic continuation on $|s|<1$.

At any real $s_0\in(0,r)$ with $\det S(s_0)=0$, all off-diagonals are nonzero. A kernel vector is determined by its first coordinate by the row recurrence, so the kernel is one-dimensional and its first coordinate is nonzero. Equivalently the trailing principal cofactor is nonzero: if the full and the first trailing determinants vanished, the tridiagonal determinant recurrence would force all the trailing determinants, including the empty determinant 1, to vanish. Hence the $(0,0)$ inverse entry has a genuine pole at every such point, and $1-s_0^4$ cannot cancel it.

### There are infinitely many singular parameters

Given any $m\ge1$, choose $0<t<1$ close enough to 1 that $b_2(t), b_4(t),\ldots,b_{2m}(t)$ are negative. Each tends to $-2$ for its fixed index. Take $t<r<1$ and choose $N>2m+1$ large enough for the tail construction. The restriction of $S(t)$ to the span of those $m$ coordinate vectors is diagonal and negative definite. Thus $S(t)$ has at least $m$ negative eigenvalues. At zero it is the identity. The ordered eigenvalues of this real symmetric finite matrix are continuous on $[0,t]$, and the kernel at each singular parameter has dimension one. Consequently at least $m$ distinct parameters in $(0,t)$ have singular $S$. Since $m$ is arbitrary and poles cannot accumulate inside the disk or at zero, a sequence of poles tends to 1.

### Each positive real pole is simple

For $0<s<1$, rescale a finitely supported quadratic form by writing $u_i=s^{i+1}v_i$. Then $\langle v,Jv\rangle$ in the $u$ coordinates has off-diagonal $-1$ and diagonals
$$
 h_0=s^{-2}-s^{-1}-1,\qquad
 h_i=(1-s^2)^2s^{-2i-2}-(s+s^{-1})\quad (i\ge1).
$$
All their derivatives are strictly negative. In the tail, differentiating the first factor of the product contributes $-4(1-s^2)s^{-2i-1}$, which already dominates the positive contribution $(1-s^2)s^{-2}$ from the last parentheses. Differentiating the other factor gives an additional negative term. At index zero $h'_0=(s-2)/s^3<0$.

Let $W=\operatorname{diag}(s^{i+1}:0\le i<N)$ on the **finite head** and $H=W^{-1}SW^{-1}$. For fixed head coordinates $u$, the value $u^{\mathsf T}Hu$ is the infimum of the full rescaled quadratic form over all finitely supported real tail coordinates. To see this, in the original coordinates fix the head at $W^{-1}u$ and complete the square with the positive invertible tail $T$. Finite-support tails are dense, and rescaling them at any fixed $s>0$ bijects the finite-support space to itself. This argument needs no bounded inverse of an infinite rescaling operator.

For $s<t$ in the interval of positive tails, subtract the two rescaled forms on the same finite vector. Every tail diagonal decreases, and the off-diagonals agree. Taking the infima gives, in quadratic-form order,
$$
 H(t)-H(s)\ \le\ \operatorname{diag}_{i<N}(h_i(t)-h_i(s)).
$$
It follows that $H'(s)$ is strictly negative definite. At a singular point $H$ has nullity one. In an orthonormal basis starting with its unit kernel vector $u$, the derivative of its determinant is $u^{\mathsf T}H'u$ times the determinant of its invertible restriction to $u^\perp$, hence nonzero. Since $S=WHW$, its determinant also has a simple zero. The nonvanishing cofactor proves the simple-pole assertion.

### Consequences for differential equations

The map $s\mapsto x=s/(1+s^2)$ has positive derivative on $(0,1)$, so the distinct simple poles give distinct simple poles in $x$, accumulating at $1/2$. A nonzero homogeneous linear differential equation with polynomial coefficients permits no poles at ordinary points. More explicitly, substituting (1) and applying the chain rule makes any such equation for $F(x,1)$ a rational-coefficient equation for the meromorphic $G(s)$, first near zero and then throughout the disk by analytic continuation. Its leading coefficient is nonzero away from finitely many points. Infinitely many poles contradict this. Finally, any nontrivial equation in $x$ over $\mathbb C(x,y)$ can be cleared of denominators and stripped of the common factor $y-1$ from its coefficients. Since every coefficient of $x^n$ in $F$ is a polynomial in $y$, substitution $y=1$ would yield a nontrivial equation for $F(x,1)$. This proves the bivariate assertion.

### Exact numerical certificates and scope of verification

The first four positive poles in increasing order correspond to $s$ in the following rational open intervals (finite decimals here are exact).

| Pole | Lower endpoint | Upper endpoint |
|---|---:|---:|
| 1 | .55885060 | .55885063 |
| 2 | .68215406 | .68215409 |
| 3 | .74002770 | .74002773 |
| 4 | .77598006 | .77598009 |

At both endpoints the head of size 12 suffices. The true tail quadratic form is bounded below by $\ell I$, $\ell=b_{12}-2|e_{12}|>0$, by the monotonicity of the tail diagonal and decay of the edges. Eliminating it changes just the last head diagonal, downwards by an amount in $[0,e_{11}^2/\ell]$. Exact rational tridiagonal elimination gives the same final pivot sign at both extremes of this uncertainty interval, with every earlier pivot nonzero. Hence its number of negative pivots equals the negative index of the full operator. At the endpoints of the $j$-th bracket these indices are $j-1$ and $j$; strict downward crossing gives precisely one pole there. For the first two positive real poles, $1/x$ is approximately $2.34823757$ and $2.14809855$, respectively. The [complex-disk certificate and asymptotic formula](InvolutionSubdominant.md) show that these two poles are the nearest singularities to zero in the complex plane and give both leading exponential terms.

The [reproducible program](check_involution_poles.py) uses floating point only to propose endpoints, then certifies each count with rational arithmetic. The [Lean file](InvolutionPoles.lean) checks that consecutive tridiagonal determinants cannot vanish together when the off-diagonals are nonzero, and proves the sign inequality for the scaled interior diagonals. The analytic continuation, the infinite sequence of poles, and non-D-finiteness are written proofs.
