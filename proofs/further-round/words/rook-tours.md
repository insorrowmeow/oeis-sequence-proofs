# Two questions about biased rook tours

On a line of $m$ cells numbered $1,\ldots,m$ from left to right, a tour is the visitation order of all cells, with arbitrary starting and ending cells. The coloring is the binary expansion of $2n$ from left to right. Thus the last cell is white. For $n>0$ the first cell is black and $m=2+\lfloor\log_2 n\rfloor$. For $n=0$ take one white cell. Write $S$ for the black cells.

For a rook of the first kind, departures from white cells must go left. Black cells allow either direction. For the second kind, departures from white cells must go left and departures from black cells must go right. A final cell has no departure. Let $A(n)$ count first-kind tours ending anywhere, and $E(n)$ count second-kind tours ending on white. We prove the endpoint formulas posed in August 2021, give the requested interpretation of the transform from November 2021 and identify $A,E$ with A284005 and A329369. [Endpoint question](https://mathoverflow.net/questions/402635) · [Transform question](https://mathoverflow.net/questions/408765) · [A284005](https://oeis.org/A284005) · [A329369](https://oeis.org/A329369)

## From a tour to a permutation

Given any visitation word, start a new block immediately before each left-to-right minimum (including the first letter). Make each block into a cycle of a permutation $\pi$, in its written order. This is invertible. Write each cycle starting at its least element, order the cycles by decreasing minima and erase the separators. For example, the tour $4,3,1,2$ becomes $(4)(3)(1\,2)$.

Within a block, $\pi(x)$ is the cell visited after $x$, except at the block end. At a block end, $\pi(x)$ is the block minimum and is at most $x$. A departure to the next block also goes left. The final block begins at the global minimum 1, so the end cell $q$ satisfies $\pi(q)=1$. In particular, the set of rightward departures is exactly

$$R=\{i:\pi(i)>i\}.$$

A first-kind tour on black set $S$ has $R\subseteq S$. A second-kind tour ending on white has $R=S$. This proves the first conjecture in the COMMENTS of A329369 directly from its definition by exact excedance sets. For different board widths the same count results after padding a mask on its left with white cells, since each additional leading white cell is a fixed point of $\pi$, removable in order. In visitation order the padding cells appear at the end in decreasing order. [OEIS A329369](https://oeis.org/A329369)

For the first kind there is a direct product. Fill each white row $i$ of the permutation by a still available value $\le i$, in increasing order of the white rows. Earlier white rows have all used values in that interval, giving exactly $1+\#\{b\in S:b<i\}$ choices. Then fill the black rows arbitrarily. This gives

$$A(n)=|S|!\prod_{i\notin S}(1+\#\{b\in S:b<i\}).$$

Appending a zero before the board's final white cell multiplies this product by $1+|S|$. Appending a one instead turns the previous final white cell into a black one and appends a new final white cell. The factorial ratio cancels the old white factor, leaving the new factor $1+\operatorname{wt}(2n+1)$. Thus $A(t)=(1+\operatorname{wt}(t))A(\lfloor t/2\rfloor)$, with $A(0)=1$ and $A(1)=2$, exactly A284005. The base value at $1$ follows from the two tours on $10$. [OEIS A284005](https://oeis.org/A284005)

## Inversion and what counts as a duplicate

Let $j\preceq n$ mean that the one-bits of $j$ are a subset of those of $n$. First-kind tours on $S$ are partitioned by their rightward-departure sets $R\subseteq S$. This gives the two transforms

$$A(n)=\sum_{j\preceq n}E(j),\qquad
E(n)=\sum_{j\preceq n}(-1)^{\operatorname{wt}(n)-\operatorname{wt}(j)}A(j).$$

The second follows from inclusion–exclusion, or by summing $(1-1)^{|S\setminus R|}$ separately for each tour. The condition $j\preceq n$ is also the condition that $\binom nj$ is odd: over the field of two elements, $(1+x)^n$ is the product of $(1+x^{2^i})$ over the set bits $i$. This proves the forward-transform conjecture in A284005 and the inverse-transform conjecture in A329369.

For the set-theoretic question, place all lists on the same padded board. A tour with rightward-departure set $R\subseteq S$ occurs on exactly $2^{|S|-|R|}$ submask boards. The tours that occur **exactly once** are precisely the second-kind tours on $S$ ending on white. Thus “delete duplicates” gives the claimed answer when **all copies** of each multiply occurring tour are removed. Ordinary deduplication leaving one copy of each tour gives all $A(n)$ first-kind tours instead. At $n=6$ the two counts are 18 and 7. [2021 question](https://mathoverflow.net/questions/408765)

## Prescribe the endpoint

For $n>0$ fix the end cell $q$. If $q=1$, the cycle bijection forces $\pi(1)=1$. All other black cells are governed by the usual rules; cell 1 was exempt as the final cell. Thus the two counts are $A(g)$ and $E(g)$ for $g=n-2^{\lfloor\log_2 n\rfloor}$, the original mask with its first black cell turned white.

If $q>1$, the relation $\pi(q)=1$ forces $\pi(1)>1$. Interchange the two images $\pi(1)$ and $\pi(q)$, to obtain $\sigma$. Now $\sigma(1)=1$ and row $q$ is free. All other images are unchanged. This is a bijection: interchange the two images to go back. The change from an unrestricted endpoint row to an unrestricted row in the new mask works for either original color of $q$. For a rook of the first kind, $q$ can simply be colored black in the new mask. For the second kind, the two disjoint possibilities are $\sigma(q)\le q$ and $\sigma(q)>q$; these give the exact-excedance masks with $q$ white and black, respectively. For $q=m$ only $\sigma(q)\le q$ is possible, so the counts for either extreme endpoint agree.

Explicitly, number endpoints by $k=m+1-q$ from the right. At $1<k<m$ put $h=2^{k-2}$, $\epsilon=\lfloor n/h\rfloor\bmod2$, $g_0=g-h\epsilon$ and $g_1=g+h(1-\epsilon)$. Then

$$T_1(n,k)=A(g_1),\qquad T_2(n,k)=E(g_0)+E(g_1).$$

At $k=1$ and $k=m$ the answers are $A(g)$ and $E(g)$. These are both formulas asked for on MathOverflow. The recurrence for $E$ quoted in that question is the standard recurrence for exact excedance sets (Proposition 2.1 and the boundary rules in Ehrenborg–Steingrímsson, as recorded in A329369). Summing $T_1(n,k)$ over the endpoints also proves Kurkov's 2019 sum formula in A284005. [Endpoint question](https://mathoverflow.net/questions/402635) · [Exact excedance recurrence](https://www.ms.uky.edu/~jrge/papers/Excedance.pdf) · [OEIS A284005](https://oeis.org/A284005)

One further identity marked conjectural in A284005 follows immediately from its defining recurrence. If $r=\operatorname{wt}(n)$, then $A(2^k n)=(1+r)^k A(n)$, whereas $A(2^m(2n+1))=(2+r)^{m+1}A(n)$. Expanding $(2+r)^{m+1}$ about $1+r$ proves the proposed sum $\sum_{k=0}^{m+1}\binom{m+1}{k}A(2^kn)$. These formulas include $n=0$.

## Evidence and prior work

The record-minimum cycle transformation is a classical Foata-type transformation. The underlying correspondence between excedance sets and descent-bottom sets and the inclusion–exclusion counting method are discussed explicitly in the 2000 paper by Ehrenborg and Steingrímsson. Their related paper studies refined endpoint statistics for alternating excedances. The signed numerical identity was already displayed in the 2021 MathOverflow post. The contribution here is a direct solution of the rook questions, in particular the endpoint transposition and the exact multiplicity interpretation. A check of the Stack Exchange API for question IDs 402635 and 408765 returned zero answers for both. A bounded search by sequence and question identifiers does not establish priority. [Excedance sets](https://www.ms.uky.edu/~jrge/papers/Excedance.pdf) · [Genocchi refinement](https://www.ms.uky.edu/~jrge/Papers/Genocchi.pdf)

The [Python check](check_rook.py) enumerates visitation orders and computes the numerical recurrences separately. The written proof applies to every board size. Lean 4.19.0 verifies both endpoint bijections **on the permutation side**, including the first-cell color and all unchanged row conditions. The tour-to-cycle correspondence, binomial identities, and translation into the two OEIS functions are proved above in ordinary mathematics. [Lean file](RookEndpoints.lean)
