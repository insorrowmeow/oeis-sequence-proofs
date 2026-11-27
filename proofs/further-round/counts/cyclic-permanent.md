# Two recurrences for a signed cyclic permanent

Let $a_n$ be the sequence A195422, with $a_1=-3$, $a_2=2$, $a_3=2$, $a_4=-8$. In 2016 R. J. Mathar proposed two scalar recurrences. Both hold, starting at $n=4$ and $n=5$ respectively. [OEIS statement and Kräuter's sum](https://oeis.org/A195422) · [Kräuter, 1984, equation (3.12)](https://www.mat.univie.ac.at/~slc/opapers/sc11kraeuter.pdf)

For the first recurrence put

$$R_n=(2-n)a_n+(n^2-4n+6)a_{n-1}+2(n^2-2n+3)a_{n-2}+8(n-1)a_{n-3}.$$

For the second put

$$Q_n=a_n-na_{n-1}-8a_{n-2}+4(n-4)a_{n-3}+16a_{n-4}.$$

We derive $Q_n=0$ as coefficients of a formal differential equation. The identity $(n-2)Q_n=2R_{n-1}-R_n$ follows by expanding. Since $R_4=0$ from the displayed initial terms, the two claims follow.

## A formal series for two weighted diagonals

For $n\ge2$ take the $n$ by $n$ matrix of ones and replace entries on its main diagonal by $1+s$ and on its cyclic superdiagonal by $1+t$. Choosing the added weights $s,t$ at a set of positions contributes zero unless its rows and columns are distinct. A valid set of $k$ positions contributes its weight times $(n-k)!$. The available positions alternate between the two weights on a bipartite cycle of length $2n$, and a valid choice is a matching.

Let $P_n(x)$ enumerate these matchings, giving uncovered vertices a factor $y$ where $x=y^2$, and each chosen edge its own weight. A size-$k$ matching then contributes its weight times $x^{n-k}$. The linear functional $\mathcal L(x^j)=j!$ recovers the desired permanent.

Set $A(v)=\left(\begin{smallmatrix}y&v\\1&0\end{smallmatrix}\right)$. The trace of $(A(s)A(t))^n$ equals $P_n(x)$: in a closed sequence of states 0 and 1, a transition $0\to0$ has weight $y$, and a transition $0\to1$ of weight $v$ must immediately be followed by $1\to0$ of weight 1. These adjacent pairs encode the selected cycle edges. This argument includes both perfect matchings. Put $P_0=2$ and $P_1=x+s+t$ as algebraic initial values. The trace and determinant of $A(s)A(t)$ are $x+s+t$ and $st$. The two by two Cayley–Hamilton identity therefore gives

$$P_{n+2}=(x+s+t)P_{n+1}-st P_n.$$

Set $v=st$, $H=1-(s+t)z+vz^2$ and $G=1-vz^2$. Summing the recurrence gives $\sum P_n z^n=1+G/(H-xz)$. In the case $s=t=-2$, the size-$k$ matchings on $2n$ cycle vertices are $\frac{2n}{2n-k}\binom{2n-k}{k}$: mark a starting place and count cyclic tilings with $k$ dimers and $2n-2k$ monomers, dividing by their $2n-k$ possible tile starts. Thus $\mathcal L(P_n)$ is also exactly the finite sum specified in A195422, including its convention at $n=1$.

With $F(u)=\sum_{j\ge0}j!u^j$, define $B(z)=1+\sum_{n\ge1}\mathcal L(P_n)z^n$. Applying $\mathcal L$ coefficientwise shows

$$B(z)=\frac{G}{H}F(z/H).$$

The factorial recurrence is equivalent to $u^2F'(u)+(u-1)F(u)=-1$. Substitution and the identity $(z/H)'=G/H^2$ give the following single scalar equation for the whole two-parameter family:

$$z^2G B'(z)+(-1+z+2vz^2+vz^3-v^2z^4)B(z)=-G^3/H.$$

All compositions have zero constant term in their substituted variable and all displayed denominators have invertible constant term. These manipulations need no analytic convergence. When $s=t=-2$, $v=4$ and $-G^3/H=-(1-2z)^3(1+2z)$ has degree four. Equating coefficients of $z^n$ for $n\ge5$ gives exactly $-Q_n=0$.

A 2021 paper already proves a coupled system for the permanent with **arbitrary** entries on both exceptional diagonals, covering these matrices; its ordinary ménage specialization has a scalar order-four recurrence. The result above supplies a direct derivation of the two scalar expressions printed in the OEIS. It is not evidence that an algorithm for these permanents, or the family of matrices, was previously unknown. [Earlier results, Proposition 2 and Remark 6](https://pmc.ncbi.nlm.nih.gov/articles/PMC8624399/)
