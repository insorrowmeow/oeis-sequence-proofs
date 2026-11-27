# A counterexample to Wiesner's bound for disjoint couples

Fabius Wiesner asks about a graph on $n$ vertices. Let $k$ count all unordered pairs of disjoint edges. For each vertex $j$, let $f_j$ be the least size of a vertex set $S$ containing $j$ such that, for every disjoint edge pair, $S$ meets both edges or neither. Write $f=\max_j f_j$. For $3\le m\le n-1$, the proposed implication is

$$
 k\ \ge\ \tfrac12\binom{m+1}{2}\binom{m-1}{2}
 \quad\Longrightarrow\quad f\ge m.
$$

The question singles out $m=\lceil n/2\rceil$. [Revised question, October 2023](https://mathoverflow.net/questions/455737/another-conjecture-about-couples-of-disjoint-two-element-sets)

## Seven vertices

Take $m=4$ and the complete bipartite graph $K_{2,5}$, with parts $L=\{1,2\}$ and $R=\{3,4,5,6,7\}$. A disjoint pair of edges uses both vertices of $L$ and two vertices of $R$. For each such choice in $R$ there are two matchings, so $k=2\binom52=20$. The proposed threshold is $\binom52\binom32/2=15$.

For each $j$, the set $L\cup\{j\}$ meets every edge, contains $j$, and has size at most three. Hence $f\le3<4$, even though $m=\lceil7/2\rceil$.

## An infinite family and the exact minimum

For each integer $m\ge4$, take $K_{m-2,m+1}$ with parts $L,R$, of total size $n=2m-1$. Choose two vertices from each part and one of their two matchings to obtain

$$
 k=2\binom{m-2}{2}\binom{m+1}{2}.
$$

The ratio of this count to the proposed threshold is $4(m-3)/(m-1)>1$ for $m\ge4$. Again $L\cup\{j\}$ is feasible and $f\le m-1$.

In fact $f=m-1$. Form a graph whose vertices are the edges of $K_{m-2,m+1}$ and in which two vertices are adjacent when the corresponding edges are disjoint. This graph is connected. For any two edges sharing a left endpoint, choose another left endpoint and a right endpoint distinct from both original right endpoints. The resulting edge is adjacent to both. Hence the edges at each fixed left endpoint form a connected subset when paths through the whole graph are allowed. For any two left endpoints there are disjoint edges incident to them, joining these subsets.

On disjoint edges a feasible set has equal hit indicators. By connectivity all edge indicators agree, and a feasible set containing $j$ hits some edge at $j$. Consequently it hits every edge. A vertex cover of a complete bipartite graph must contain all of $L$ or all of $R$, since missing vertices in both parts would give an uncovered edge. Thus the exact minima are $m-2$ for $j\in L$ and $m-1$ for $j\in R$.

## Earlier discussion and verification

Ilya Bogdanov suggested considering edges meeting a small fixed set of $m-1$ vertices, and noted that the pair count could be large. The construction above uses $m-2$ fixed vertices, leaving room to include each prescribed $j$, and gives the exact count and minima. The thread also contains an earlier example by domotorp for the version preceding the author's clarification. A search of the question and its comments found no posted answer to the revised implication. This records what was located, without claiming publication priority. [Bogdanov's comment](https://mathoverflow.net/questions/455737/another-conjecture-about-couples-of-disjoint-two-element-sets#comment1180029_455737), [author's clarification](https://mathoverflow.net/questions/455737/another-conjecture-about-couples-of-disjoint-two-element-sets#comment1180036_455737)

Lean 4.19.0 checks the seven-vertex counterexample using finite sets. It constructs the ten edges, takes all unordered two-edge subfamilies with four distinct endpoints, and proves the count, the threshold inequality, and the exact seven minima. The argument for all $m\ge4$ is the proof above. [Lean source](DisjointCouples.lean)
