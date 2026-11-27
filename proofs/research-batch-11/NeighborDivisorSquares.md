# Infinitely many double exceptions in OEIS A399610

[OEIS A399610](https://oeis.org/A399610) asks whether infinitely many integers $k$ have both $d(k-1)+d(k)$ and $d(k)+d(k+1)$ square, where $d$ is the largest proper divisor. The entry also asks whether there are further terms with composite $k+1$ beyond Hugo Pfoertner's $29057286$.

**Theorem.** There are arbitrarily large such $k$ with **both** neighbors composite. One example is $k=64129416966$, giving squares $211874^2$ and $203042^2$.

Use $k=210h+6$. The least prime divisors of $k-1,k,k+1$ are $5,2,7$, respectively: their residues modulo 210 are exactly $5,6,7$. Thus the respective largest proper divisors are $42h+1,105h+3,30h+1$. We seek simultaneous solutions to
$$
x^2=147h+4,\qquad y^2=135h+4.
$$
The seed $(x,y,h)=(2,2,0)$ works. Elimination gives $(7y)^2-5(3x)^2=16$. Multiplying $7y+3x\sqrt5$ by the norm-one unit $(9+4\sqrt5)^4=51841+23184\sqrt5$ yields
$$
X=51841x+54096y,\qquad Y=49680x+51841y.
$$
Put $H=h+18282240x^2+38154976xy+19907328y^2$. Direct expansion gives $X^2=147H+4$ and $Y^2=135H+4$ under the two original equations. All iterates are positive in $x,y$, and $H>h$. Their indices $210H+6$ grow without bound; both neighbors have proper divisors exceeding 1. The first iteration has $H=305378176$ and gives the stated numerical example.

[Lean proof](NeighborDivisorSquares.lean) checks the complete unboundedness theorem using the mathematical definition of largest proper divisor, including maximality among all proper divisors. For every bound $B$, its final theorem produces $k>B$, three largest proper divisors and both square roots, with nontrivial proper divisors of both neighbors. The Pell calculation explains the coefficients; the formal verification uses exact identities and induction.
