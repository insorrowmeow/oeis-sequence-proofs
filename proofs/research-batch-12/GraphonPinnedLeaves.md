# Pinning two leaves at a graphon density minimizer

The [MathOverflow question 488182](https://mathoverflow.net/questions/488182/property-of-host-graph-attending-minimum-density-of-bipartite-graph-a-question) asks whether fixing vertices in one bipartition class of a bipartite graph gives the same conditional homomorphism density for every choice of their positions, when the graphon globally minimizes the unconditioned density at fixed edge density. The three-vertex path gives a negative answer for every edge density $0<p<1$, even if constancy is required only almost everywhere.

Write $P_3$ for a path with two leaves and one center. For a graphon $W$ put $d(y)=\int_0^1 W(x,y)\,dx$ and assume $\int_0^1d=p$. By Fubini its path density is

$$t(P_3,W)=\int_0^1d(y)^2\,dy=p^2+\int_0^1(d(y)-p)^2\,dy.$$

Consequently every $p$-regular graphon is a global minimizer, and those are all the minimizers up to null sets. Here regular means $d(y)=p$ almost everywhere. This variance identity is the classical two-edge star case of the tree density inequality.

Let $s$ equal $+1$ on one half of the unit interval and $-1$ on the other. Choose $0<\varepsilon\le\min(p,1-p)$ and set

$$W(x,y)=p+\varepsilon s(x)s(y).$$

It is a symmetric $[0,1]$-valued graphon and its degree at every point is $p$. Fix the two leaves in the same bipartition class at distinct positions $x,z$. Integrating the center gives

$$C(x,z)=\int_0^1W(x,y)W(z,y)\,dy=p^2+\varepsilon^2s(x)s(z).$$

The two possible conditional densities each occur on a set of pairs of measure one half. In particular $p=\varepsilon=1/2$ gives a global minimum $1/4$ and conditional densities $1/2$ and $0$. All the integral identities used here are finite sums on two blocks, except for proving optimality against arbitrary graphons.

There is also an exact characterization for this path. Among its minimizers, constancy of $C$ almost everywhere is equivalent to $W=p$ almost everywhere. To see this, the integral of $C$ is $p^2$, so if $C$ is constant then it equals $p^2$. Set $U=W-p$ and define $T$ on $L^2[0,1]$ by $(Tf)(x)=\int U(x,y)f(y)\,dy$. Regularity and symmetry give $\int U(x,y)U(y,z)\,dy=C(x,z)-p^2=0$ almost everywhere. Thus $T^2=0$. Symmetry implies $\|Tf\|_2^2=\langle f,T^2f\rangle=0$ for every $f$. In particular, for each interval $I$ with rational endpoints, $T\mathbf1_I=0$ almost everywhere. On one common set of full measure in $x$, the indefinite integral of $U(x,\cdot)$ thus vanishes at all rational endpoints, hence everywhere by continuity. Its derivative is $U(x,\cdot)$ almost everywhere. Fubini gives $W=p$ almost everywhere. The converse follows directly.

This answers the specific question on pinned vertices. The variance and codegree calculations are standard graphon arguments. A search located no posted answer or comment on the MathOverflow record when checked. [GraphonPinnedLeaves.lean](GraphonPinnedLeaves.lean) verifies all two-block values and the lower bound for arbitrary finite weighted degree distributions over the reals. The unrestricted integral lower bound and characterization are written proofs.
