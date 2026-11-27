# Every nonnegative integer appears in the Angelini–Shannon spiral

Fill the square lattice in outward spiral order, starting at zero. At each site use the least unused nonnegative integer sharing at least one decimal digit with each already filled neighbor, including diagonal neighbors. The shared digit may differ from one neighbor to the next. Eric Angelini and Scott R. Shannon conjectured in 2022 that all nonnegative integers occur. The following proof also bounds the displacement of every label. [OEIS A358048](https://oeis.org/A358048)

**Theorem.** For the spiral indexed from zero, the labels form a permutation of the nonnegative integers. In fact, with $\alpha=\log_{10}9<1$, its $n$-th label satisfies $a(n)=n+O((n+1)^\alpha)$.

**A general form.** Fix an enumeration of the vertices of a countably infinite graph of maximum degree $D<\infty$. One may prescribe a finite initial segment of distinct nonnegative labels and then fill the subsequent vertices in order by the same least-unused shared-digit rule. The resulting list contains each nonnegative integer exactly once and has the same displacement bound, with constants allowed to depend on $D$ and the seed. Prescribed vertices need not share digits with one another for this conclusion about subsequent greedy choices.

## Proof

A label containing all ten digits can follow any finite set of earlier neighbors. Call such a label universal. For $X\ge 1$, at most $O(X^\alpha)$ integers in $[0,X]$ are nonuniversal. Indeed, among $j$-digit integers avoiding a specified digit there are at most $9^j$ possibilities, by counting strings with leading zeros allowed at that fixed length. Sum over the ten possible missing digits and over $1\le j\le \lfloor\log_{10}X\rfloor+1$, and count zero separately. The geometric sum is $O(X^\alpha)$.

List the universal integers increasingly as $p_1,p_2,\ldots$. Their density is one, and $p_k=k+O(k^\alpha)$. For detail, at least $X+1-O(X^\alpha)$ integers up to $X$ are universal, so $p_k\le 2k$ for all sufficiently large $k$. At $X=p_k$, exactly $k$ of the $p_k+1$ integers are universal, giving $p_k+1-k=O(p_k^\alpha)=O(k^\alpha)$.

When $i$ vertices are already labeled, at least one of $p_1,\ldots,p_{i+1}$ is unused. It is eligible, so the next greedy label exists and is at most $p_{i+1}$. Consequently all labels of the first $N$ vertices are at most $N+O(N^\alpha)$, absorbing any fixed seed values into the bound. Since labels are distinct, only $O(N^\alpha)$ of those first $N$ vertices can carry nonuniversal labels.

A greedy step will be called unrestricted when every already labeled neighbor is universal, including the case of no earlier neighbors. At such a step every unused nonnegative integer is eligible. Each of the other greedy steps among the first $N$ vertices has an earlier nonuniversal neighbor among those same vertices. One nonuniversal vertex can account for at most $D$ such steps. Hence at least $N-O(N^\alpha)$ of the first $N$ steps are unrestricted, after also allowing for the fixed seeds.

Each unrestricted step uses the least unused label. After $g$ such steps the labels $0,\ldots,g-1$ have all been used, by induction, even when there are other steps between them. As $g\to\infty$, this proves surjectivity. The rule gives injectivity. After $N$ steps the next label is at least $N-O(N^\alpha)$ and is at most $p_{N+1}=N+O(N^\alpha)$. This proves the displacement bound. The spiral graph has $D=8$, as required.

## A two-predecessor entry with two possible readings

Enrique Navarrete's entry begins with $0,1$ and asks for the least unused positive integer sharing a digit with each of its preceding two terms. If the same digit position may serve both predecessors, the rule is an instance of the theorem, with edges joining indices at distance one or two. Its result is a permutation. But the fifth term then equals 12: the digit 1 matches both 10 and 11. The published table and example instead give 100. There is no explicit permutation conjecture in the entry. [OEIS A303605](https://oeis.org/A303605)

A second reading requires **two distinct digit positions in the candidate**, one per predecessor. This produces all 60 published values. The two positions may hold the same digit. Under this rule the set of labels appearing is exactly $\{0,1\}\cup\{10,11,12,\ldots\}$. The other one-digit numbers cannot appear, because they have only one position.

For the converse, a candidate with all ten digits each occurring at least twice is always eligible. Such candidates have natural density one: at length $j$ the number containing a given digit at most once is at most $9^j+j9^{j-1}$. Summing over digits and lengths gives $O(X^\alpha\log(2X))=o(X)$ exceptions through $X$. As before all labels used in the first $N$ steps are therefore $O(N)$, and only $o(N)$ of those labels lack some digit. All but $o(N)$ steps have two universal predecessors, as every nonuniversal label affects at most the next two choices. At any such step, every unused number of at least two digits is admissible: assign its first position to one predecessor and its second to the other. The least remaining eligible number of at least two digits is then used. Infinitely many such steps guarantee coverage. The finite data distinguish the two readings but do not by themselves determine the author's intended rule for all indices.

## Status and reproducibility

The claims above have written proofs. The companion script generates the 71 spiral terms and compares both readings of the two-predecessor rule to its 60 printed terms. The source explicitly calls the A358048 permutation statement conjectural. Searches by sequence identifiers, authors, and description did not locate an earlier proof of this spiral statement. This is a bounded priority check.
