# The seed-one orbit of OEIS A400113

Vincenzo Manto and James C. McMahon define $a(1)=1$. For $n\ge2$, if $a(n-1)$ is odd, add $n$. If it is even, take $\lfloor|a(n-1)-n|/2\rfloor$. Their entry suggests $1/6\le a(n)/n\le7/3$ for $n\ge10$. Both constants are optimal. [OEIS A400113](https://oeis.org/A400113), [source entry in the OEIS database](https://github.com/oeis/oeisdata/blob/main/seq/A400/A400113.seq)

## Exact orbit

The first six values are $1,3,6,1,6,0$. For every $k\ge1$ the next table gives the entire orbit.

| Index | Value |
|---|---:|
| $6k$ | $2k-2$ |
| $6k+1$ | $2k+1$ |
| $6k+2$ | $8k+3$ |
| $6k+3$ | $14k+6$ |
| $6k+4$ | $4k+1$ |
| $6k+5$ | $10k+6$ |

**Proof.** The base is $a(6)=0$. Assuming $a(6k)=2k-2$, the first update gives $\lfloor((6k+1)-(2k-2))/2\rfloor=2k+1$. This is odd, so the next value is $2k+1+6k+2=8k+3$. Another odd step gives $14k+6$. The next index is $6k+4$, so halving the absolute difference gives $4k+1$. The odd step gives $10k+6$. Finally $((10k+6)-(6k+6))/2=2k=2(k+1)-2$. This proves the induction.

## Sharp bounds

Subtract $n$ from $6a(n)$ and subtract $3a(n)$ from $7n$. In the same residue order, the respective differences are

$$
\begin{aligned}
6a(n)-n&=(6k-12,\ 6k+5,\ 42k+16,\ 78k+33,\ 18k+2,\ 54k+31),\\
7n-3a(n)&=(36k+6,\ 36k+4,\ 18k+5,\ 3,\ 30k+25,\ 12k+17).
\end{aligned}
$$

For $n\ge10$, residue zero requires $k\ge2$, so the first difference is nonnegative. The second is strictly positive. Thus $1/6\le a(n)/n<7/3$. The lower endpoint is attained exactly at $n=12$. Along $n=6k+3$ the ratio is $7/3-1/n$, giving supremum $7/3$. The five subsequential limits are $1/3,2/3,4/3,5/3,7/3$.

## Verification and scope

Lean 4.19.0 checks the recurrence for every positive index, the six formulas by induction, both ratio bounds, equality at $n=12$, and the identity $3a(6k+3)+3=7(6k+3)$ for $k\ge1$. The OEIS entry also suggests eventual merger for every seed $a(1)>1$. That is a separate question and remains open here. [Lean proof](SixPhaseOrbit.lean)
