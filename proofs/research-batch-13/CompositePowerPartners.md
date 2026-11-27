# Odd composite partners for powers of two

Ali Sada asks whether every odd composite integer belongs to a pair of distinct odd composites whose sum is a power of two. In fact, every odd integer $c\ge5$ has arbitrarily large odd composite partners. [OEIS A401106](https://oeis.org/A401106)

Let $a=c-2$, an odd integer greater than one. Euler’s theorem gives $2^{\varphi(a)}\equiv1\pmod a$. For every positive $t$ set $n=1+t\varphi(a)$ and $d=2^n-c$. Then $d\equiv2-c\equiv0\pmod a$. As $t$ grows, $d$ is an odd integer exceeding both $c$ and any prescribed bound. Its proper divisor $a$ makes it composite. By construction $c+d=2^n$.

[Lean proof for all bounds](PowerSumPartners.lean)
