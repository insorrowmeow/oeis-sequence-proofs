# A400792 is a permutation

[OEIS A400792](https://oeis.org/A400792) starts at 1 and repeatedly chooses the least unused positive integer $k$ for which the number of smaller previous terms coprime to $k$, minus the number of larger previous terms sharing a factor with $k$, equals one. We prove that every positive integer occurs exactly once.

For a finite prefix with set of values $S$ and an unused $k>1$, write its score as
$$
 D_S(k)=\#\{x\in S:x<k\}-\#\{x\in S:\gcd(x,k)>1\}.
$$
This is the score in the definition: subtracting the smaller noncoprime terms removes those terms from the first count. A next term always exists: any multiple of all previously used terms that exceeds their maximum is coprime only to 1 among them, so its score is one.

**Invariant.** As long as $k$ is unused, $D_S(k)\ge1$. Initially its score is one. A new term can lower the score only by one, and only if it is larger than $k$ and noncoprime to it. When the score is one, $k$ itself is eligible, so the greedy rule cannot choose a larger term. This proves the invariant by induction. In particular, a permanently missing $k$ can share a factor with at most $k-2$ terms of the entire sequence: in every prefix there are at most $k-1$ smaller positive integers and the second count is strictly less than the first.

**First force the even numbers.** The second term is 2. There are infinitely many new record highs, since the infinite sequence has distinct positive terms. At a record the score counts just the earlier terms coprime to the new value. The term 1 already accounts for the unique allowed coprime term. Hence every record after 2 shares a factor with 2 and is even. If any even $k$ were missing, it would share a factor with infinitely many even records, contradicting the invariant. Thus every positive even number occurs.

**Now force every integer.** If $k>1$ were missing, the distinct even numbers $2k,4k,6k,\ldots$ would all occur and share a factor with $k$. This is the same contradiction. The first term is 1 and the construction excludes repeats, completing the proof.

[Lean](CoprimeGreedy.lean) verifies the score invariant for every prefix obtained by the least-eligible rule and the finite bound that the number of noncoprime terms is strictly less than $k$. The record argument and final surjectivity deduction are proved above. The separate empirical questions about ordering of primes and primorials are outside this result.
