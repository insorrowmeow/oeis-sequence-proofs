# Counting single-loop placements with exactly m edge mirrors

In the labeled rectangular edge-mirror model of [A400778](https://oeis.org/A400778), let $F_{n,k}(t)=\sum_m N_{n,k,m}t^m$, where $N_{n,k,m}$ counts single-loop placements with exactly $m$ interior mirrors. A count by mirror number was asked for in [Jablan's enumeration problem](https://www.mi.sanu.ac.rs/vismath/mir/enum.htm). All counts here retain the OEIS model's labeled edges and single allowed orientation at each edge. Other conventions for mirror orientations or equivalence under symmetry require separate counts.

Write $u=n-1,\ v=k-1,\ b=uv$. For $h_i=2\cos(\pi i/n)$, $l_j=2\cos(\pi j/k)$, the following product determines every coefficient:
$$
 F_{n,k}(t)^2 =
 \prod_{i=1}^{u}\prod_{j=1}^{v}
 \left((16-(h_i+l_j)^2)t^2+(h_i-l_j)^2\right).
$$
Take the polynomial square root with positive leading coefficient. The empty product gives 1. At $t=1$ this recovers the unweighted [product formula and the six A400778 conjectures](MirrorGrid.md).

**Proof.** In the bordered determinant expansion in the companion proof a deleted ribbon edge is a mirror. Thus $F_{n,k}(t)=\det(J+tCC^\mathsf T)$: every one-boundary spanning subgraph contributes exactly its mirror monomial, including spanning trees. Put $H=P_u\otimes I_v$, $V=I_u\otimes P_v$ where $P_s$ is undirected path adjacency. Up to exchanging the colors or axes, $J+tCC^\mathsf T=4tI-B$. On black sites $B$ takes horizontal steps with weight $t+1$ and vertical steps with weight $t-1$; on white sites the weights are interchanged. Every step changes color. Since $HV=VH$,
$$
 B^2=(t^2-1)(H^2+V^2)+2(t^2+1)HV .
$$
Indeed two parallel steps always have coefficient $(t+1)(t-1)$; for a mixed pair the two possible orders give $(t+1)^2+(t-1)^2$. The path adjacencies implement boundary restrictions automatically. Conjugation by the diagonal checkerboard sign matrix changes $B$ to $-B$, so the square determinant becomes $\det(16t^2I-B^2)$. The product formula now follows by simultaneous diagonalization of $H,V$ in the usual sine basis. The coefficient at $t^b$ of $F$ is the positive number of spanning trees of the grid, fixing the sign.

In particular, $F_{3,3}(t)=48t^2+192t^4$. In general the **least** possible mirror count is $\gcd(n,k)-1$, since it is the multiplicity of $h_i=l_j$ in the product. This recovers the known minimal count directly from the formula. The **greatest** possible count is $(n-1)(k-1)$, with positive coefficient from spanning trees. These extrema agree when a side is one.

An independent [ray-tracing check](check_mirror_polynomial.py) enumerates all placements on the 1×4, 2×5, 3×3 and 3×4 boards and checks their complete mirror-count polynomials against the integer determinants. For 3×4 it gives coefficients 1, 77, 1091 and 2415 at degrees 0, 2, 4 and 6.
