# A bound for the sum-and-halve recurrence

James McMahon and Vincenzo Manto observed that the ratio of their sequence to its index stays between 1 and approximately 3.66. They also observed essentially the same range for trajectories with different initial values. We prove an exact bound for all indices and all positive integer seeds. [OEIS A400485](https://oeis.org/A400485)

Start at $a_1=s\ge1$. To obtain $a_{n+1}$, form $b=a_n+n+1$. Keep $b$ when it is odd and halve it when it is even. For the original seed $s=1$,
$$
 n\le a_n\le 11n/3\qquad(n\ge1).
$$
For every positive seed the lower bound holds from the start and the upper bound holds, for example, from $n=3s+1$ onwards.

To see the upper bound, assign a coefficient $c$ to each parity state.

| Parity of index | Parity of value | $c$ |
|---|---|---:|
| even | even | 5 |
| even | odd | 11 |
| odd | even | 7 |
| odd | odd | 8 |

Suppose $3a_n\le c n+e$ for some nonnegative integer excess $e$, and let $c'$ be the coefficient of the next state. When $b$ is odd, the table gives $c'\ge c+3$. When $b$ is even, it gives $2c'\ge c+3$ for either parity of $b/2$. Thus in both cases
$$
 3a_{n+1}\le c'(n+1)+\max(0,e-1).
$$
Indeed before halving, $3b\le(c+3)(n+1)+e-c$. Each $c$ is positive, so a positive integral excess drops by at least one in both cases. At index one we may start with $e=\max(0,3s-c(1,s))$. This is zero for $s=1$, giving the four bounds from the first index. Every positive seed exhausts its initial excess in finitely many steps. For the lower bound, $a_n\ge n$ implies $b\ge2n+1$; if halving occurs, evenness gives $b\ge2n+2$.

The factor $11/3$ is an upper bound. The literal decimal $3.66$ is crossed by the original sequence, for instance $a_{2426}=8883$. The conjectural wording in the entry is approximate. The proof does not determine the limit superior for that particular seed.

[Lean 4.19 verification of the original recurrence, all parity transitions and both bounds](ParityEnvelope.lean)
