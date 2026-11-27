# Four vertices detect failure of star removal

Yu-Fu Shen asked whether adding one element to an unfragmented set preserves this property. Give each unordered pair of vertices its position in the sorted list of pair values. The edge order is then a strict total order, and an induced subset inherits the restricted order. This includes distinct values and any fixed tie-breaking order that is respected under restriction. The question gives no convention for changing the relative order of tied old pairs when adding an element. [Shen's MathOverflow question, March 2025](https://mathoverflow.net/questions/488756/conjecture-on-the-preservation-of-unfragmented-sets-under-element-addition).

For a set of size $k$, the first $k-1$ edges contain a vertex $v$ exactly $k-1$ times if and only if they are the entire star at $v$. Call such a vertex removable. A set is fragmented if successive removals exhaust it, treating a singleton and the empty set as terminal successes.

**Theorem.** A finite edge-ordered complete graph is fragmented if and only if, on every four vertices, the three lightest induced edges share a vertex. It follows that adding any number of vertices to an unfragmented graph preserves failure. Four is best possible since all graphs on at most three vertices are fragmented, while a four-vertex ordering starting with disjoint edges fails.

First, a successful removal order restricts to a successful order on every subset. At each retained vertex $v$, its edges to later retained vertices still precede every edge between two of those later vertices. On four vertices this means exactly that the first three edges form a star. This argument alone proves Shen's conjecture.

For the converse it suffices to show that every complete graph of order at least four with no removable vertex has a failing four-vertex restriction. Assume otherwise. If the two lightest edges are disjoint, their endpoints already give such a restriction. Thus they share a vertex $b$. Let $uv$ be the first edge in the order avoiding $b$, and let $S$ consist of all $x$ for which $bx$ precedes $uv$. We have $|S|\ge2$. Some $w\ne b$ lies outside $S$, since otherwise $b$ could be removed. All edges preceding $uv$ are incident with $b$.

* If $u,v\in S$, take $b,u,v,w$. Its first three edges are $bu,bv,uv$ in some order within the first two. They form a triangle.
* If exactly one endpoint, say $u$, belongs to $S$, choose $x\in S\setminus\{u\}$. On $b,u,v,x$ the first two edges are $bu,bx$ and the third is $uv$. They have no common vertex.
* If neither endpoint lies in $S$, choose $x\in S$. On $b,u,v,x$ the first two edges are $bx$ and $uv$, which are disjoint.

Each case gives the desired four vertices. Hence the local condition guarantees an initial removable vertex. The condition persists upon deleting it. Induction completes the proof.

**Enumeration.** On a fixed labeled set of $k\ge3$ vertices, the center of a successful first star is unique. Choose that vertex in $k$ ways, order its edges in $(k-1)!$ ways and then use any successful order on the remaining vertices. With one order for two vertices, the number of fragmented strict edge orders is therefore $\prod_{i=3}^k i!$.

**Verification and scope.** [ShenFragmentation.lean](ShenFragmentation.lean) proves restriction of a removal order to every sublist and hence the hereditary assertion for fixed edge ranks. The converse four-vertex characterization and enumeration are proved above. An independent enumeration checked the characterization against direct removals for every labeled edge ordering at sizes four and five, up to the symmetry fixing the first edge. It counted 144 and 17,280 successful orders respectively. Searches under the original terminology and in the edge-ordered complete graph literature did not locate this exact characterization. The source question had no posted answer when checked.
