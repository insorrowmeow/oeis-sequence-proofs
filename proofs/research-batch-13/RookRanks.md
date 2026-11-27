# Mirror inequalities for rook placements

For a finite board $P$, let $r_k$ count the ways of placing $k$ indistinguishable, pairwise nonattacking rooks on its cells. As in the source question, a missing cell interrupts an attack along a row or column. Let $d$ be the largest $k$ with $r_k>0$. Daniel Weber conjectured in June 2025 that $r_k\le r_{d-k}$ whenever $2k\le d$. The proof below establishes a stronger inequality. [Weber's conjecture](https://mathoverflow.net/questions/495739/can-a-product-of-non-palindromic-mathcalp-rook-polynomials-be-palindromic#comment1290794_495739)

**Theorem.** If $k\le l$ and $k+l\le d$, then $r_k\le r_l$. This holds for every finite board, including boards with several maximum placements. For example, the full $3\times3$ board has six maximum placements and $(r_0,r_1,r_2,r_3)=(1,9,18,6)$.

## Proof

Fix a placement $A$ of $d$ rooks. Group all nonattacking placements $F$ according to the set $S=F\setminus A$ of rooks outside $A$. Write $s=|S|$ and let $p$ be the number of cells of $A$ compatible with every rook of $S$. A rook outside $A$ attacks at most one rook of $A$ along its horizontal run and at most one along its vertical run. Hence

$$p\ge d-2s.$$

With $S$ fixed, we may use any subset of these $p$ remaining cells independently. Thus the generating polynomial of this group is $x^s(1+x)^p$. Its coefficient at $k$ is zero when $s>k$. Otherwise let $i=k-s$ and $j=l-s$. The hypotheses imply

$$0\le i\le j,\qquad i+j=k+l-2s\le d-2s\le p.$$

In row $p$ of Pascal's triangle one has $\binom pi\le\binom pj$ under these conditions. Indeed $i\le\min(j,p-j)\le p/2$, and the binomial coefficients increase up to the middle and are symmetric. Summing this inequality over the groups proves the theorem. Taking $l=d-k$ answers Weber's question.

## Independent sets and matchings

For a finite graph $G$, write $i_j(G)$ for the number of independent sets of $j$ vertices. The same proof works with any fixed independent set $A$ of size $d$, provided each vertex outside $A$ has at most two neighbours in $A$. In particular, every claw-free graph meets this condition. Three neighbours in $A$ would form an induced claw together with their common neighbour. Consequently

$$i_k(G)\le i_l(G)\qquad(k\le l,\ k+l\le\alpha(G))$$

for every finite claw-free graph. The analogous inequality for the numbers of matchings of each size holds for every finite simple graph. Its line graph is claw-free, since each edge can meet at most two edges of a fixed matching.

## Relation to the earlier answer

The main MathOverflow post asked whether a product of rook polynomials can be palindromic if a factor is nonpalindromic. Peter Taylor answered that question in June 2025. In proving it he established the mirror inequalities in the case of a unique maximum matching. This case suffices for his question because a palindromic product with constant coefficient one must have all leading coefficients one. Max Alekseyev also credited a related argument in a deleted answer by Dennis. The proof here establishes Weber's coefficient conjecture for arbitrary leading coefficient and the corresponding graph theorem. The deleted answer and migrated chat were unavailable for a full comparison, so priority for the unrestricted result is undetermined. [Taylor's answer and comments](https://mathoverflow.net/a/495808)

Navarra, Qureshi and Rinaldo study the switching rook polynomial, which counts equivalence classes of rook placements under switching. Their characterization of its palindromicity concerns these classes. The coefficients used throughout this proof count individual placements. [Navarra, Qureshi and Rinaldo](https://arxiv.org/abs/2511.13982)

## Lean verification

The accompanying file uses Lean 4.19.0. The theorem `rook_mirror` counts subsets of a finite set of cells. Each cell carries two labels identifying its maximal horizontal and vertical run. Distinct cells attack when either label agrees. The theorem derives the mirror inequality from a nonzero coefficient $r_d$ and $2k\le d$.

The same file proves the more general `rook_ranks` and `claw_free_ranks`, including the bijection between independent subsets and their compatible parts inside and outside $A$. [Lean proof](RookRanks.lean)
