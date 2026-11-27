# Four weights suffice at unbounded relative shifts

This separate calculation concerns Conjecture 4 of Gatzweiler and Krattenthaler. Its qualitative disproof predates this work. The CoPEER example has $m=22$, $n=21$ and eight factors counted with multiplicities. A separate five-factor family uses $m=33t$, $n=30t$. Both examples have bounded $m/n$. The construction below gives a negative coefficient for arbitrarily large $m/n$ with just four distinct factors. The known sufficient condition $m\ge n^2$ remains compatible with these examples. [Original conjecture](https://link.springer.com/article/10.1007/s11139-025-01285-2) · [CoPEER example](https://github.com/qqliu/CoPEER/blob/105523fdaf018b62eaf2883347724dfe79935611/mathematics/discoveries/entries/number-theory/fake-gaussian-positivity-counterexample.md) · [Five-factor family](https://github.com/1337isnot1337/solved-conjectures/blob/a354c349b80c70bb575ffc0230d17c3ced5ec7f7/results/gatzweiler-krattenthaler/proof.md) · [Sufficient condition, Corollary 1.8](https://arxiv.org/pdf/2603.22226#page=4)

## Construction

For every odd integer $s\ge 3$, set

$$
x=2s^2,\quad r=x+2,\quad y=r+2s,\quad
n=y,\quad m=sr-r-2s,\quad F=sr-r-s=m+s.
$$

Use the four indices $S=\{s,x,r,y\}$, each with multiplicity one. They satisfy $0<s<x<r<y=n$. The shift satisfies $m=(s-2)n+2(s+1)$, so $m\ge n$ and $m/n$ is unbounded. Direct substitution gives

$$
m+r=sx,\qquad m+x=(s-1)y,\qquad m+y=sr.
$$

Let $G(d,h)=\sum_{i=0}^{h-1}q^{id}$. The elementary identity

$$
\frac{(1-q^{sr})(1-q^F)}{(1-q^s)(1-q^r)}
= G(s,r-1)G(r,s-1)-q^F
$$

follows on multiplying through by the denominator and using $(r-1)s=F+r$, $(s-1)r=F+s$. Consequently the four-factor quotient is the polynomial

$$
\prod_{j\in S}\frac{1-q^{m+j}}{1-q^j}
=\bigl(G(s,r-1)G(r,s-1)-q^F\bigr)G(x,s)G(y,s-1).
$$

Write $H=\{as+br:a,b\in\mathbb Z_{\ge0}\}$. Since $s$ is odd, $\gcd(s,r)=\gcd(s,2)=1$. If $F=as+br$ then $(a+1)s+(b+1)r=sr$, which forces $s$ to divide $b+1$. This would give $(b+1)r\ge sr$, a contradiction. Thus $F\notin H$. All four indices belong to $H$, so the product of the four geometric polynomials contributes zero in degree $F$. The remaining term contributes exactly $-1$, because the last two geometric polynomials have constant coefficient one. This proves $[q^F]=-1$ for every parameter.

With $s=3$ one gets $S=\{3,18,20,26\}$, $m=34$, and $[q^{37}]=-1$. More generally $m/n^{3/2}\to1/\sqrt{2}$ along the family. This gives a lower bound along these values of $n$ for any uniform threshold above which nonnegativity always holds.

## Formal checks and status

[UnboundedShift.lean](UnboundedShift.lean) proves the parameter inequalities, coprimality, polynomial identity after multiplication by the actual four-factor denominator, and the coefficient $-1$ for all $s=2k+3$. The ordered positive indices ensure the denominator is nonzero. [FakeGaussian.lean](FakeGaussian.lean) also verifies the separate numerical example $m=22$, $S=\{6,7,14,18,20\}$ and $[q^{29}]=-1$, using the fraction field of integer polynomials.

The comparison above concerns the two cited public counterexamples. Priority for the four-factor unbounded-ratio construction has not been established.
