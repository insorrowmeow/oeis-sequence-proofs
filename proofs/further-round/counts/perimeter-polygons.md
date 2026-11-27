# Counting perimeter-magic triangles and squares up to rotation

In March 2025 R. J. Mathar conjectured two interpretations of existing integer sequences. In each polygon the corners and side midpoints carry positive integers. Every side has the same sum, and equivalence is by rotations. A reflected arrangement can therefore contribute a second orbit. The labels may repeat. The claims concern triangles of side sum $n+2$ and squares of side sum $n+3$. [Triangle, A175287](https://oeis.org/A175287) · [Square, A084569](https://oeis.org/A084569) · [Mathar's enumeration software](https://zenodo.org/records/15001366)

Subtract 1 from each label. For an original sum $S$, set $t=S-3$. The adjusted corner labels $x_i$ must satisfy $x_i\ge0$ and $x_i+x_{i+1}\le t$, with cyclic indices. These conditions suffice, because the adjusted midpoint on each edge must equal $t-x_i-x_{i+1}$. This correspondence commutes with rotations.

## Triangles

Let $H(t)$ be the number of rotation classes of admissible triples. Increasing $t-1$ to $t$ adds precisely the classes for which the largest pair sum is $t$. Order the three corners in nondecreasing order as $a\le b\le c$. The layer condition is $b+c=t$. If $b<c$, each $a<b$ gives two cyclic orders, and $a=b$ gives one. The contribution from this $b$ is $2b+1$. If $b=c$, every $a=0,\dots,b$ gives one cyclic order.

For $t=2k+1$ this counts $\sum_{b=0}^k(2b+1)=(k+1)^2$ new classes. For $t=2k$ the count is $\sum_{b=0}^{k-1}(2b+1)+(k+1)=k^2+k+1$. Thus $H(t)-H(t-1)=\lceil(t+1)^2/4\rceil$, starting with $H(-1)=0$. At the proposed sum $S=n+2$ we have $t=n-1$, giving

$$H(n-1)=\sum_{j=0}^n\lceil j^2/4\rceil.$$

This proves the defining partial-sum formula of A175287, including $n=0$, when the sum of a positive triple cannot be 2.

## Squares

The identity rotation fixes all labeled squares. If the maximum of two specified opposite corners is $m$, these two corners have $2m+1$ ordered choices. Each of the other two corners independently ranges from 0 to $t-m$. Consequently the identity fixes

$$L(t)=\sum_{m=0}^t(2m+1)(t-m+1)^2
=\frac{(t+1)(t+2)(t^2+3t+3)}6.$$

For instance the last expression follows from the convolution generating function $(1+z)^2/(1-z)^5$. A half-turn fixes exactly the words $u,v,u,v$ with $u+v\le t$, giving $(t+1)(t+2)/2$ choices. Either quarter-turn fixes the constant words, giving $\lfloor t/2\rfloor+1$ choices. Burnside's lemma gives the orbit count

$$\frac14\left(L(t)+\frac{(t+1)(t+2)}2+2(\lfloor t/2\rfloor+1)\right)
=\frac{t^4+6t^3+17t^2+30t+21+3(-1)^t}{24}.$$

For the square $t=n$. This is the closed form of A084569. Equivalently its generating function is $(1-z+2z^2)/((1+z)(1-z)^5)$. The defining partial sums can also be recovered directly: the generating function of $i+(-1)^i$ is $z/(1-z)^2+1/(1+z)$, and three successive partial sums divide this by $(1-z)^3$. [A084569](https://oeis.org/A084569) · [A084570](https://oeis.org/A084570)

## Any number of sides

For $h\ge3$ and $t\ge0$ let $M_{ij}=1$ if $i+j\le t$ and $0$ otherwise, for $0\le i,j\le t$. The number of rotation classes on an $h$-gon of sum $t+3$ is

$$\frac1h\sum_{d\mid h}\varphi(h/d)\operatorname{tr}(M^d).$$

In fact a rotation by $s$ positions fixes precisely the repetitions of a valid cyclic word of length $\gcd(h,s)$. Its count, including for lengths one and two, is the indicated trace. Averaging over all $s$ proves the formula.

There is a finite trigonometric evaluation of the trace as $\sum_{j=1}^{q}\lambda_j^d$, where $q=t+1$, $\theta_j=(2j-1)\pi/(2q+1)$, and $\lambda_j=(-1)^{j-1}/(2\sin(\theta_j/2))$. To verify this, apply $M$ to the vector with entries $\cos((i+1/2)\theta_j)$. The sum of its first $q-i$ entries equals $\sin((q-i)\theta_j)/(2\sin(\theta_j/2))$. Since $(q+1/2)\theta_j=(j-1/2)\pi$, this is $\lambda_j\cos((i+1/2)\theta_j)$. The $q$ eigenvalues have distinct absolute values and hence give the full spectrum.

The labeled corner configurations are exactly the lattice points in a dilate of the graph polytope of a cycle. Spectral enumeration of these labeled points predates the 2025 conjectures. Applying the rotational average to the labeled counts gives the perimeter-magic orbit formula above. [The Ehrhart and face polynomials of the graph polytope of a cycle, 2024](https://doi.org/10.1016/j.ejc.2023.103906)

Both OEIS entries describe the polygon interpretations as conjectures. The formulas for the integer sequences themselves, Burnside's lemma and the transfer-matrix method predate this note. Mathar's software already enumerated the polygon objects. A targeted source search did not establish historical priority for these interpretations or for the general enumeration.

The triangle theorem is formalized in [Triangles.lean](Triangles.lean). The general-index theorem `PerimeterTriangle.a175287_full` counts the canonical six-label representatives, and supplementary lemmas prove existence and uniqueness of corner representatives under rotation and uniqueness of their three midpoints. The square and the arbitrary-polygon result have written proofs. [Independent enumerations](verify.py)
