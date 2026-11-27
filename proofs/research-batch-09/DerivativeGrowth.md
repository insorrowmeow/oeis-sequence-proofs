# Increasing derivatives of recursively defined polynomials

[MathOverflow 247321, August 2016](https://mathoverflow.net/questions/247321/increasing-derivatives-of-recursively-defined-polynomials) defines $f_0=x,\ f_{n+1}=f_n-u f_n'$, where $u=x(1-x)$, and denotes the largest root of $f_n$ by $x_n$.

**Theorem.** For every $n\ge2$ and $x_{n+1}\le x<1$, one has $f_n'(x)>f_{n-1}'(x)$. For $n=1$ the same inequality holds on $(x_2,1)$, with equality at $x_2=1/2$.

**Roots.** Since $f_1=x^2$, induction gives a double zero at zero and $n-1$ simple zeros in $(0,1)$ for $f_n$, $n\ge1$. Indeed,
$$
 f_{n+1}=-x^2\left((1-x)f_n/x\right)'.
$$
The polynomial inside the derivative has simple roots at zero, the $n-1$ interior roots, and one. Rolle's theorem gives one derivative root strictly between each consecutive pair. These exhaust the degree and give $x_{n+1}>x_n$. Also $f_n(1)=1$, so $f_n$ is positive to the right of its largest root up to one. Direct calculation gives $x_3=(3+\sqrt3)/6>3/4$.

**Derivative comparison.** Fix $n\ge2$ and $x\in[x_{n+1},1)$. Write $p=f_{n-1}$. With the sum over roots of $p$, including multiplicities, set
$$
 t=u\,p'/p=u\sum_r (x-r)^{-1},\qquad
 z=u^2\sum_r (x-r)^{-2},\qquad c=2x-1 .
$$
Every denominator is positive, $c>1/2$, and $t>0$. Also $t<1$ because $f_n=p(1-t)>0$. Differentiating the sum gives $ut'=-ct-z$. Applying the original recurrence twice now yields
$$
 0\le f_{n+1}/p=(1-t)^2-ct-z,\qquad
 u(f_n'-p')/p=ct+z-t^2 .
$$
If $t\ge1/2$, the first identity requires $(1-t)^2\ge ct+z>1/4$, whereas $1/2\le t<1$ gives $(1-t)^2\le1/4$. Thus $t<1/2<c$, and the second identity is strictly positive. Since $p,u>0$, this is the desired inequality, including at the left endpoint. For $n=1$ the derivative difference is simply $2x-1$.

**Lean scope.** [DerivativeGrowth.lean](DerivativeGrowth.lean) proves the real inequality turning the two identities and the bounds on $c,t,z$ into a strictly positive derivative gap. The polynomial identities, Rolle argument, and their application to the recurrence are proved in writing above.
