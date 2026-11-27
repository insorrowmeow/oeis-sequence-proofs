# First occurrences in the lexicographically largest variant of A402288

Among positive words of length $n$ containing no earlier row as a subsequence, minimize the largest letter, then choose the **lexicographically largest** such word. [Ferudun's OEIS entry](https://oeis.org/A402288) records $t_k=1+3\cdot2^{k-4}$ for $4\le k\le14$, where $t_k$ is the first row containing $k$. It reports a proof through $8$ and computations through $14$. We extend this observation to **every $k\ge4$**. The original sequence uses the opposite tie-breaking rule.

Let $j^a$ denote $a$ consecutive copies of a letter. At the first row $t_j$ which requires a new letter $j$, the pure word $j^{t_j}$ is admissible and lexicographically largest over the new alphabet. Hence all later admissible words have at most $t_j-1$ copies of $j$. The rows $1,22,333,4444$ follow directly: after each of the first three pure words the respective total capacities of all used letters are $0,1,3$, below the next length. This gives the induction base $t_4=4$.

**Induction.** Suppose we have reached the pure row $k^t$, that the letters smaller than $k$ have total capacity $t-1$, and that every earlier mixed row has a descent (some larger letter precedes a smaller one). Form the nondecreasing word $S$ with exactly $t_j-1$ copies of each $j<k$. Its length is $t-1$. No earlier row over the smaller alphabet embeds in $S$: pure rows exceed a capacity, and a mixed row with a descent cannot be a subsequence of a nondecreasing word.

For each $t+1\le n\le2t-2$, put $b_n=2t-n,\ m=n-t+1,\ c=n-t-1$. We prove in increasing order of $n$ that row $n$ uses alphabet up to $k$, starts with at least $b_n$ copies of $k$, and later contains a smaller letter. Let $U$ be the first $m$ letters of $S$; $m\le t-1$. Consider
$$
 W=k^{b_n}\,U\,k^c .
$$
Its length is $n$ and $b_n+c=t-1$. A previous pure row cannot embed, by the capacities, nor can a previous mixed row over the smaller alphabet, since all its letters would have to come from $U$. If a mixed row $i$ from the current stage satisfied $t<i<n$, then by induction it begins with at least $b_i>b_n$ copies of $k$, followed later by a smaller letter. The latter letter would have to lie in $U$, before which at most $b_n$ copies of $k$ are available. Thus $W$ is admissible.

Using only letters smaller than $k$ would give length at most $t-1<n$. The new row accordingly has largest letter $k$, and by lexicographic maximality starts with at least as many $k$'s as $W$. It must eventually use a smaller letter because the pure row $k^t$ is forbidden. This proves the inner induction and supplies the descent needed at future stages.

The total capacity up to $k$ is now $(t-1)+(t-1)=2t-2$, so length $2t-1$ forces the new pure row $(k+1)^{2t-1}$. Its smaller letters have total capacity $2t-2$, restoring the outer induction hypotheses. Therefore $t_{k+1}=2t_k-1$ for $k\ge4$, equivalently $t_k=1+3\cdot2^{k-4}$.

[Lean](GreedyLargestRows.lean) verifies the subsequence obstruction for arbitrary prefixes and middle words, the lengths and capacities in the witness, and the closed form's recurrence. The greedy and epoch inductions are written above. The conclusion is an all-index extension for the variant. The exact first-6 row of the lexicographically smallest rule is a separate problem.
