# The burning number can grow arbitrarily at Slater number two

## Statement and attribution

Ján Pastorek's AutoGraphForge project released a list of conjectures alongside its ITAT 2026 paper. Entry 16 in the author's audited ranking predicts that every nontrivial connected graph satisfies $b(G)\leq s\ell(G)+1$. Its source record lists 278,835 graphs supporting the candidate. The next entry rewrites the same inequality. We resolve this single machine-generated conjecture. [Author's audited conjecture list, entry 16](https://github.com/JanPastorek/AutoGraphForge/blob/main/results/audit_top.json#L258-L276) · [Project paper, §4](https://arxiv.org/html/2609.03478v1#S4)

The burning number $b$ is the minimum $k$ such that closed balls of radii $k-1,k-2,\ldots,0$ cover the graph. For decreasing degrees $d_1,\ldots,d_n$, the Slater number $s\ell$ is the least $k$ with $k+\sum_{i=1}^k d_i\geq n$. These are the coverage model of the project's graph library and the Slater definition in the author's formalization. [GraphCalc burning model](https://graphcalc.readthedocs.io/en/stable/api/graphs/invariants/zero_forcing.html#graphcalc.graphs.invariants.zero_forcing.burning_number) · [AutoGraphForge definitions](https://github.com/JanPastorek/AutoGraphForge/blob/main/lean_project/LeanProject/GraphInvariants.lean#L53-L64)

## A 15-vertex counterexample

Start with the path on levels $0,1,\ldots,9$. Add five more vertices at level 1, each adjacent to vertices 0 and 2. The result is $K_{2,6}$ with a path of seven edges attached to one of its two hubs. It is connected, simple, planar and bipartite.

The degree sequence is $7,6,2^{(12)},1$, where the exponent indicates multiplicity. Thus $1+7<15$ and $2+7+6=15$, giving $s\ell(G)=2$.

Every edge changes level by one. A ball of radius $r$ reaches at most $2r+1$ distinct levels. Three rounds offer balls of radii $2,1,0$, which cover at most $5+3+1=9$ levels. The graph contains ten levels. Four rounds suffice with ignitions at levels $2,7,9,5$, in that order. The first ball covers every vertex through level 5, and the second covers levels 5 through 9. All four ignitions are admissible under the convention that a fresh source must be unburnt at the preceding round. Hence

$$
b(G)=4>3=s\ell(G)+1 .
$$

## An infinite family and exact values

For $t\geq 3$, take $K_{2,t}$ and attach a path of $t+1$ edges to one hub. There are $2t+3$ vertices. The two highest degrees are $t+1$ and $t$, so that $s\ell(G_t)=2$. The levels now run from 0 through $t+3$. Level 1 has $t$ vertices and every other level has one. We claim

$$
b(G_t)=\left\lceil\sqrt{t+4}\right\rceil .
$$

If $k$ rounds suffice, their balls reach at most $\sum_{r=0}^{k-1}(2r+1)=k^2$ levels. This gives the lower bound. It is the diameter lower bound of Bonato, Janssen and Roshanbin in this family. [Original graph burning paper](https://math.ryerson.ca/~abonato/papers/Burning-IM-April17.pdf)

For the upper bound, set $k=\lceil\sqrt{t+4}\rceil\geq3$. Cover consecutive levels from left to right by intervals of lengths $2k-1,2k-3,\ldots,1$, truncating at the right endpoint when necessary. Their total capacity is $k^2$. A ball centered at the midpoint covers each interval in the allocated radius. For the first interval we may center at level $k-1$, since the graph has at least $k$ levels. That center is at level at least 2, and all vertices at level 1 have the same distance $k-2$ to it. Thus the first ball covers every copy of level 1. The remaining intervals consist of single-vertex levels. This gives the required cover. In particular no function of the Slater number bounds the burning number on connected planar bipartite graphs.

## Verification and related results

[SlaterBurning.lean](SlaterBurning.lean) checks the stated 15-vertex graph as a mathlib simple graph, its connectedness, the whole sorted degree sequence, and all shortest-path distances. It proves $s\ell=2$, $b=4$ and the strict violation using only the standard Lean axioms. Both invariant definitions are given in that file.

[Unbounded.lean](Unbounded.lean) checks the lower bound of the infinite-family argument for every number of rounds. It proves connectedness and the size-two degree threshold, and that no zero- or one-vertex set reaches the threshold. For every proposed bound on the number of rounds it constructs a member whose balls cannot cover all the levels. The interval construction giving the matching upper bound is in the proof above.

Run **python check_lean.py** for the Lean files. A standalone copy can be checked from a mathlib v4.19.0 project with **lake env python /path/to/check_lean.py**.

[verify_graph.py](verify_graph.py) independently constructs the graph from its edges, computes distances by breadth-first search and checks all $15^3=3375$ triples of ignition centers, as well as the displayed legal four-round schedule. It uses only the Python standard library.

Gentner and Rautenbach previously showed that the ordinary domination number can be unbounded at fixed Slater number. Their displayed Slater-two example is disconnected. We found no prior resolution of the burning-number inequality in the literature and project records examined. The project's single open GitHub issue concerns a chromatic-number inequality. [Gentner–Rautenbach](https://arxiv.org/abs/1608.04560) · [Project issue](https://github.com/JanPastorek/AutoGraphForge/issues/1)
