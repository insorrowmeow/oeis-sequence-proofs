# The first column of the R-recursion for yoke-chains

The [MathOverflow question](https://mathoverflow.net/questions/481674/r-recursion-for-a006351) asks whether its triangular recursion gives $R(n,0)=a(n+1)$ for [A006351](https://oeis.org/A006351). The answer is yes.

Use the positive-index exponential generating function $Y(x)=\sum_{j\ge1}a(j)x^j/j!$. The known inverse series $2\log(1+y)-y$ for $Y$ gives $Y(0)=0$ and $Y'=H(Y)$, where $H(y)=(1+y)/(1-y)$.

For row $n$, set $F_n(y)=\sum_{q\ge0}R(n,q)y^q$ and $G_n=(1+y)F_n$. The recursion states precisely
$$
(1-y)F_{n+1}=G_n'.
$$
Indeed, on the right the coefficient at degree $q$ is $(q+1)(R(n,q+1)+R(n,q))$. On the left it is $R(n+1,q)-R(n+1,q-1)$ when $q>0$, and $R(n+1,0)$ when $q=0$. These give both clauses of the recursion.

Thus $G_{n+1}=HG_n'$, and the initial row of ones gives $G_0=H$. We claim $Y^{(n+1)}=G_n(Y)$. At $n=0$ this is the equation for $Y'$. Differentiating the claim gives $G_n'(Y)Y'=(HG_n')(Y)=G_{n+1}(Y)$, proving the induction in the formal power series ring over the rationals. Evaluation at zero now gives $a(n+1)=G_n(0)=R(n,0)$ for every $n\ge0$.

**Verification scope.** [YokeRows.lean](YokeRows.lean) verifies the row transformation coefficient by coefficient for any row, its iteration, and extraction of the first column. The identification with the OEIS generating function via the chain rule is proved above on paper. No priority claim is made.
