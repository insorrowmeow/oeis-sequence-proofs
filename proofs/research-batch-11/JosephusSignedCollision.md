# The signed first collision in the Flavius Josephus sieve

In round $s=1,2,\ldots$ delete every $(s+1)$-st entry of the remaining increasing list of positive integers. Write $a(j)$ for the $j$-th number that survives forever. The question asks how to read the fate of $n$ from the two trajectories starting at $n$ and $n-1$. [MathOverflow 418146, March 2022](https://mathoverflow.net/questions/418146/conjecture-on-a-sieve-of-flavius-josephus), [OEIS A000960](https://oeis.org/A000960), [OEIS A278528](https://oeis.org/A278528), [OEIS A278538](https://oeis.org/A278538).

Write $B_0(t)=t$ and $B_s(t)=|B_{s-1}(t)-s-(B_{s-1}(t)\bmod s)|$ for $s>0$. For each $n\ge1$ there is a least $q$ with $B_q(n)=B_q(n-1)$. If $n$ is deleted in round $s$, then $q=s+1$ and $B_s(n)-B_s(n-1)=s$. If $n=a(s)$, then $q=s+1$ and the same difference is $-s$. This proves both assertions in the question and gives $q$ explicitly.

## The rank invariant

Let $R_s(t)$ count the remaining integers at most $t$ after round $s$. Thus $R_0(t)=t$ and

$$R_s(t)=R_{s-1}(t)-\left\lfloor R_{s-1}(t)/(s+1)\right\rfloor.$$

Before round $s$, say that $n$ is active if it has survived all previous rounds and has rank $r=R_{s-1}(n)\ge s$. In this case $R_{s-1}(n-1)=r-1$. There are three possibilities.

* If $r=s$, every future round leaves the first $s$ entries fixed. Hence $n=a(s)$.
* If $(s+1)\mid r$, round $s$ deletes $n$.
* Otherwise $r>s$ and $n$ remains active in round $s+1$. Indeed $r\ge s+2$ and $r-\lfloor r/(s+1)\rfloor\ge s+1$, since the first $s+2$ entries already supply $s+1$ survivors.

Round 1 starts with $n$ active. Since $r\le n$ and $s$ increases, the process reaches one of the first two cases by round $n$.

As long as $n$ is active before round $s$, we claim that for **both** $t=n,n-1$,

$$B_s(t)=s\,|R_{s-1}(t)-s|. \tag{1}$$

For $s=1$ this is $B_1(t)=|t-1|$. To advance from one active round to the next, $r>s$, so $u=R_{s-1}(t)\ge s$ for each of the two arguments. Equation (1) then reads $B_s(t)=s(u-s)$. The recurrence gives

$$\frac{B_{s+1}(t)}{s+1}=\left|\left\lfloor\frac{s(u-s)}{s+1}\right\rfloor-1\right|=\left|u-\left\lfloor\frac{u}{s+1}\right\rfloor-(s+1)\right|=|R_s(t)-(s+1)|.$$

The middle identity follows by writing $s(u-s)=(s+1)(u-s-1)+(2s+1-u)$ or, equivalently, by using $\lceil (u-s)/(s+1)\rceil=\lfloor u/(s+1)\rfloor$. This proves (1).

## The first collision

In each active round with $r>s$, (1) gives difference $+s$. In a terminal round with $r=s$, it gives $B_s(n)=0$, $B_s(n-1)=s$, and difference $-s$. Round zero had difference 1, so no collision has occurred yet.

In the survivor case $0$ and $s$ have equal quotient on division by $s+1$, hence the two $B_{s+1}$ values agree. In the deletion case $r$ is a multiple of $s+1$. The two ranks $r,r-1$ therefore give equal counts $R_s(n)=R_s(n-1)$. The algebra used to advance (1) still applies for this one transition, because both old ranks are at least $s$ even though $n$ has just been removed. Thus $B_{s+1}(n)=B_{s+1}(n-1)$ here as well. This proves the claimed value of $q$ and the signed classification.

## Verification

[JosephusSignedCollision.lean](JosephusSignedCollision.lean) defines the recurrence from the question and models the sieve by the rank transitions above. `outcome_collision` proves the first equality time and signed difference for every sieve outcome. `signed_first_collision` also proves existence for every positive input. Lean 4.19.0 checked the file. The interpretation of the rank process as deleting positions from the infinite ordered list is given in the first paragraph of the rank argument. An independent check generated the surviving lists directly and matched their deletion rounds and final ranks with the raw trajectories for all $1\le n\le20{,}000$.
