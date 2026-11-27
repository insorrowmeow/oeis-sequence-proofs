# The widths with Hussain's binary valuation law

Let $G_b(x)=1+x+\cdots+x^{b-1}$ for a positive integer $b$. Write $s(k)$ for the number of ones in the binary representation of a nonnegative integer $k$, and $v_2(N)$ for the exponent of two in a positive integer $N$.

**Theorem.** The equality

$$
v_2\left([x^{(b-1)m}]G_b(x)^{2m}\right)=s((b-1)m)
$$

holds for every integer $m\ge0$ if and only if $b$ is a power of two including $b=1$.

In particular, the widths 4, 8, 16, 32 and all their successive doublings obey exactly the same law. For example, at $b=32,m=3$ the middle degree is 93, whose binary representation is 1011101. The coefficient has valuation five.

Sajid Khan Hussain proposed the case $b=16$ in November 2026. A public proof in Lean for that width is already reported by the TrureTuring project. Its accompanying problem page leaves the applicability to other geometric lengths open. The theorem above answers that extension for every width. Historical priority for the general classification is undetermined. [OEIS A402341](https://oeis.org/A402341) · [Earlier width-16 formalization and scope](https://the-omega-institute.github.io/trureturing-mdbook/Problems/oeis-a402341-hussain-central-coefficient-valuation.html)

## Which widths can work?

At $m=1$, the middle coefficient of $G_b^2$ is $b$. Write $b=2^r h$ with $h$ odd. The binary expansion of $b-1=2^r(h-1)+(2^r-1)$ has $s(h-1)+r$ ones. Since $v_2(b)=r$, the proposed equality holds here precisely when $h=1$. This rules out every other width with a single exponent.

## A divisibility lemma

Use monic polynomials of the form

$$
P(u)=\sum_{j=0}^{\lfloor D/2\rfloor}c_j u^{D-2j},\qquad c_0=1 .
$$

Say that $P$ satisfies the weak bound if $2^{s(j)}\mid c_j$ for $j>0$, and the strict bound if $2^{1+s(j)}\mid c_j$ for $j>0$. Zero coefficients satisfy both bounds. Binary digit sums satisfy $s(i+j)\le s(i)+s(j)$ because each carry decreases the digit sum. Consequently a product of weakly bounded polynomials obeys the weak bound, by expanding its coefficients as sums of products. A product of strictly bounded polynomials obeys the strict bound, since at every positive index at least one factor contributes a positive index.

If $P$ satisfies the weak bound, $P^2$ satisfies the strict bound. At index $k>0$, each unordered pair $i<j$ with $i+j=k$ contributes $2c_i c_j$, divisible by $2^{1+s(k)}$. A diagonal summand occurs only if $k=2j$, where $j>0$. Its coefficient $c_j^2$ is divisible by $2^{2s(j)}$, and $2s(j)\ge1+s(j)=1+s(2j)$. All contributions satisfy the desired bound.

## The geometric polynomial for each dyadic width

Set $u=t+t^{-1}$ and define integer polynomials $D_0(u)=u$, $D_{h+1}(u)=D_h(u)^2-2$. Direct induction gives $D_h(t+t^{-1})=t^{2^h}+t^{-2^h}$. Each $D_h$ is monic of degree $2^h$ and satisfies the weak bound. For the induction step the square obeys the strict bound just proved. Subtracting 2 changes the constant coefficient at index $2^h$, and its required weak divisor is only $2^{s(2^h)}=2$.

For $b=2^r$, let $P_r(u)=\prod_{h=0}^{r-1} D_h(u)$, of degree $b-1$. The empty product handles $b=1$. By binary expansion,

$$
P_r(t+t^{-1})=t^{-(b-1)}\prod_{h=0}^{r-1}(1+t^{2\cdot2^h})
=t^{-(b-1)}G_b(t^2).
$$

The product bound gives the weak bound for $P_r$. Its square satisfies the strict bound. Thus $(P_r^2)^m$ satisfies the strict bound for all $m\ge1$. The case $m=0$ is immediate.

## Extracting the middle coefficient

Put $H=(b-1)m$. The coefficient of interest is the constant term of $P_r(t+t^{-1})^{2m}$, whose leading monomial in $u$ is $u^{2H}$. For $j\ge0$, the constant term of $u^{2j}=(t+t^{-1})^{2j}$ is $\binom{2j}{j}$. Its binary valuation equals $s(j)$, since $v_2(j!)=\sum_{a\ge1}\lfloor j/2^a\rfloor=j-s(j)$.

The leading monomial therefore contributes a term of valuation $s(H)$. At index $d>0$, the contribution is a multiple of $2^{1+s(d)+s(H-d)}$ by the strict coefficient bound. This is divisible by $2^{1+s(H)}$. The sum has valuation exactly $s(H)$, proving sufficiency.

The companion script computes the central coefficients directly by multiplying the original geometric polynomials. It uses neither the change of variables nor the divisibility lemma. The general proof above is written mathematics. The linked Lean theorem covers width 16.
