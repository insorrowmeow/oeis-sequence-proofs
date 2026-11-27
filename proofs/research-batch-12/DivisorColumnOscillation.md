# Arbitrarily large rises and drops in every divisor-triangle column

Hartmut F. W. Höft observed that the positive entries in each column of the divisor triangle seem to be nonmonotone. Fix any column $k\ge1$ and list its positive entries $v_1,v_2,\ldots$ in order of increasing row. Then

$$
 \limsup_{j\to\infty}\frac{v_{j+1}}{v_j}
 =\limsup_{j\to\infty}\frac{v_j}{v_{j+1}}=\infty.
$$

In particular, rises and drops by arbitrarily large factors occur even between consecutive positive entries of each fixed column. [Observation and row definitions, OEIS A400412](https://oeis.org/A400412) · [Earlier triangle with a different symbol for an empty entry, A384704](https://oeis.org/A384704)

The row $i$ records integers with exactly $i$ odd divisors. The column $k$ records integers whose ordered divisors have exactly $k$ blocks, with a break whenever two successive divisors have ratio strictly greater than two. $T(i,k)$ is the least such integer if any exists.

### Realizing a prescribed number of blocks

Call an integer dense when its divisors form one block. For dense $m$, the intervals $[d,2d]$ over $d\mid m$ cover all of $[1,2m]$. If $\ell\le2m$ is prime, the divisors of $m\ell$ are $D(m)\cup\ell D(m)$, including when $\ell\mid m$. The two covered intervals overlap, proving $m\ell$ dense as well. In particular $2\cdot3^a$ is dense for $a\ge0$, and $2\cdot3^a5^c$ is dense whenever $a\ge1,\ c\ge0$.

For any dense $m\ge2$, choose a prime $q$ strictly between $2m$ and $4m$ by Bertrand's postulate. The divisors of $m q^{k-1}$ form the $k$ ordered copies $q^jD(m)$, $0\le j<k$. Every copy is a single block, and between copies the ratio of successive endpoints is $q/m>2$. The number of odd divisors is $k$ times the number for $m$. The resulting witness is at most $4^{k-1}m^k$. The same construction covers $k=1$.

### An expensive row between two cheap rows

Fix $b=2k$. For a prime $p>b$ tending to infinity, write $p=bh+r$, where $1\le r<b$, and take $p$ sufficiently large that $h\ge2$. Consider rows

$$
 i_-=kbh,\qquad i_0=kp,\qquad i_+=kb(h+1).
$$

All three have positive entries in column $k$. At $i_0$ apply the construction to $m=2\cdot 3^{p-1}$. On the other hand, if any candidate for row $kp$ has odd part $u=\prod_\ell\ell^{e_\ell}$, then $p\mid \prod_\ell(e_\ell+1)$. One $e_\ell$ is at least $p-1$, and $\ell\ge3$. Consequently

$$
 T(i_0,k)\ge3^{p-1}.
$$

At $i_-$ use $m_h=2\cdot3^{h-1}5^{b-1}$; at $i_+$ use $m_{h+1}$. These are dense, with $bh$ and $b(h+1)$ odd divisors respectively. Both are at most $2\cdot5^{b-1}3^h$. It follows, with $C_k=4^{k-1}(2\cdot5^{b-1})^k$, that

$$
 \max(T(i_-,k),T(i_+,k))\le C_k3^{kh}\le C_k3^{p/2}.
$$

Thus the middle entry exceeds each outside entry by a factor at least $3^{p/2-1}/C_k$, tending to infinity. Each of the two intervals of rows has length at most $kb=2k^2$. On the left, the product of successive ratios of positive entries telescopes to the ratio of the middle to the left entry. At least one factor is at least $(3^{p/2-1}/C_k)^{1/(2k^2)}$ for sufficiently large $p$. On the right apply the same argument to the inverse ratios. Since the three rows tend to infinity, both asserted limit superiors follow.

Lean proves the lower bound $3^{p-1}\le m$ for every positive odd integer $m$ and prime $p$ dividing the cardinality of its actual finite set of divisors. The constructions and the unbounded ratios are proved above. [Lean file](DivisorColumnOscillation.lean)
