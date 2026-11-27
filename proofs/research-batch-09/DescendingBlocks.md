# The decreasing runs of A399084

[OEIS A399084](https://oeis.org/A399084) starts at $0,1$. From the current value $v$, go to $v-1$ if it is unused, and otherwise to $v+\lfloor\sqrt v\rfloor$. The entry conjectures that the lengths of the maximal decreasing runs start with five ones and then follow $m,1,m,1$ for every $m=2,3,\ldots$.

**Proof.** Put $s_m=m^2+m-2$. At index $s_m$ the current value is $s_m$ and the visited values are exactly $[0,s_m]$. This holds for $m=2$, since the sequence starts $0,1,2,3,4$. To propagate the assertion write $s=s_m$. The square root rounds down to $m$ throughout $[s,s+m+2]$, since $s\ge m^2$ and $s+m+2=(m+1)^2-1$.

The next $2m+2$ values, in order, are
$$
 \underbrace{s+m,\ s+m-1,\ldots,s+1}_{m},\quad s+m+1,\quad
 \underbrace{s+2m+1,\ s+2m,\ldots,s+m+2}_{m},\quad s+2m+2 .
$$
Indeed, at $s$ the predecessor has already occurred and the upward jump has length $m$. The sequence descends through unused values to $s+1$. Its predecessor is $s$, forcing a jump of length $m$ to the fresh singleton $s+m+1$. The predecessor of this singleton is the first term of the preceding run. Hence it jumps by $m$ once more, and the same reasoning forces the second descent and its final singleton. All four jump origins lie in the stated square-root interval. After these steps the visited set is $[0,s+2m+2]$, and $s+2m+2=s_{m+1}$, proving the induction. All boundaries between the displayed runs are strict ascents, including the boundary with the next stage. This proves the conjecture for all indices.

**Consequence.** The permutation is its own inverse: its one-line notation reverses each of the two length-$m$ index intervals, fixes the two singleton positions, and fixes indices 0 through 4.

[Lean verification](DescendingBlocks.lean) proves the greedy transitions for launch, descent and final jump, the visited-set update during descent and at the final jump, the square-root bounds, and the identity between successive stage boundaries. The assembly of these lemmas into the induction on all stages and the involution consequence are proved in the text.
