# The numerator of an arithmetic Cauchy–Hankel determinant

Paul Barry proposed that the reduced numerators of the Hankel determinants built from $1/(pj+1)$ are powers of the prime $p$, with an explicit exponent. This also gives the separate entry at $p=2$. We prove the following form allowing composite common difference. [A122251](https://oeis.org/A122251) · [A122249](https://oeis.org/A122249)

Let $b,c$ be coprime positive integers, $n\ge0$, and $V_n=\prod_{k=1}^n k!$. The reduced numerator of the positive rational number

$$D_n=\det_{0\le i,j\le n}\frac{1}{c+b(i+j)}$$

is exactly

$$b^{n(n+1)}\prod_{q\mid b,\ q\ {\rm prime}}q^{2v_q(V_n)}.$$

Indeed the classical Cauchy determinant formula gives

$$D_n=\frac{b^{n(n+1)}V_n^2}{\prod_{i,j=0}^n(c+b(i+j))}.$$

Any prime dividing $b$ is absent from the denominator. For any prime $q\nmid b$ and any $h=q^t$, $t\ge1$, write $C_r$ for the number of integers in $[0,n]$ congruent to $r$ modulo $h$. Each $C_r$ is either $\lfloor(n+1)/h\rfloor$ or its successor. The number of factors in the product of squared Vandermonde differences $V_n^2=\prod_{i<j}(j-i)^2$ divisible by $h$, counting the two copies individually, is $\sum_r C_r(C_r-1)$. For the denominator it is $\sum_r C_r C_{\sigma(r)}$, where $\sigma(r)=-r-cb^{-1}\pmod h$. Since $C_{\sigma(r)}\ge C_r-1$ termwise, the denominator count is at least as large. Sum over $t$ to see that the reduced numerator contains no factor $q$.

For $b=p$ prime and $c=1$, Legendre's formula gives the exponent $n(n+1)+2\sum_{k=1}^n\sum_{j\ge1}\lfloor k/p^j\rfloor$. Adding the $j=0$ summands absorbs $n(n+1)$ and yields precisely Barry's proposed expression $(p^2)^{\sum_{k=1}^n\sum_{j=0}^n\lfloor k/p^j\rfloor}$. At $n=0$ the reduced numerator of $1/c$ is 1.

Earlier work evaluates the unreduced determinant of generalized Hilbert matrices. The arithmetic cancellation argument above starts from that classical evaluation. Historical priority of the reduced formula has not been established. [Earlier generalized Hilbert determinant, §3](https://homepage.divms.uiowa.edu/~rcurto/invariant.pdf) · [Berg, §4](https://web.math.ku.dk/~berg/manus/filbert.pdf)
