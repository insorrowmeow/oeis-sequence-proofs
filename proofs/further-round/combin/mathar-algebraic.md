# Four recurrences for algebraic generating functions

R. J. Mathar proposed linear recurrences for A173993 in October 2014, A174013 in January 2013, and A174015 and A174016 in November 2012. All four hold throughout their natural ranges. Three arise from one generating function with a parameter. [A173993](https://oeis.org/A173993) · [A174013](https://oeis.org/A174013) · [A174015](https://oeis.org/A174015) · [A174016](https://oeis.org/A174016)

## The triangle

Let $F_t(x)$ have the periodic Stieltjes fraction with successive numerators $tx,x,-x,tx,x,-x,\ldots$ under the convention $1/(1-b_0/(1-b_1/(\cdots)))$. Coefficientwise convergence follows because every numerator is divisible by $x$. Periodicity gives

$$F_t=\frac{1}{1-tx/(1-x/(1+xF_t))}.$$

Clearing units gives

$$x(1-tx)F_t^2+[1-(t+2)x]F_t=1-x.$$

This determines each coefficient of $F_t$ from earlier ones, starting with 1. It is the row-polynomial generating function of Deléham's triangle A198379. In the triangle's DELTA construction the left sequence repeats $0,1,-1$ and the right sequence repeats $1,0,0$, giving the fraction above. For A174014 the corresponding parameter is $1+t$. The column, row and antidiagonal specializations of A174014 give $F_1,F_2,F_{1+x}$ for A174015, A174016 and A174013 respectively. Mathar previously derived the radical generating function for the whole triangle in Example 20. [A198379](https://oeis.org/A198379) · [A174014](https://oeis.org/A174014) · [Mathar, *Properties of Deléham’s DELTA Transformation*](https://oeis.org/A084938/a084938.pdf)

Writing $b_n=[x^n]F_t$ for constant $t$, we obtain for every $n\ge4$ the following polynomial identity in $t$:

$$\begin{aligned}
0={}&(n+1)b_n-3tn\,b_{n-1}+3t^2(n-1)b_{n-2}\\
&+\big[(4t-t^3)n+2t^3-14t\big]b_{n-3}
+2t^2(7-2n)b_{n-4}.
\end{aligned}$$

Substitution of $t=1,2$ gives Mathar's printed recurrences term for term. In particular the coefficient of $b_{n-3}$ reduces to $3(n-4)$ and $-12$, respectively. A further substitution $t=-1$ followed by multiplication of $b_n$ by $(-1)^n$ gives the corresponding row evaluation reported in A168505. [A168505](https://oeis.org/A168505)

## Derivation and finite polynomial certificates

Write $F=\sum_{n\ge0}a_nx^n=(V\pm\sqrt D)/W$ in the formal Laurent series over the rationals. Define $L_D(Z)=2DZ'-D'Z$. Since $(WF-V)^2=D$, differentiation and multiplication by $WF-V$ give

$$2DWF'+L_D(W)F=L_D(V).$$

For a candidate recurrence $\sum_{j=0}^k(s_j n+c_j)a_{n-j}=0$ define $A=\sum s_jx^j$ and $B=\sum(js_j+c_j)x^j$. The coefficient of $x^n$ in $xAF'+BF$ is exactly its left-hand side for $n\ge k$. It now suffices to check two polynomial identities

$$2DWB=xA\,L_D(W),\qquad 2DWR=xA\,L_D(V).$$

They imply $xAF'+BF=R$ by cancellation in an integral domain. Hence $\deg R<k$ proves the conjecture for every $n\ge k$.

For the triangle polynomial use $W=2x(1-tx)$, $V=(t+2)x-1$, $D=(1-tx)^2+4tx^3$. These follow by squaring the displayed quadratic equation in completed-square form. Directly,

$$A=(1-tx)D,\quad B=\tfrac14 L_D(W),\quad R=1-tx+3tx^2-t(t+2)x^3.$$

Substitution gives the recurrence above. The accompanying Lean file checks the universal coefficient recurrence over every rational parameter $t$ for every formal power series satisfying that exact completed-square equation. Its theorem includes the two constant specializations. The written fraction-to-equation calculation identifies this series with the OEIS source. The nonconstant substitution $t=1+x$ must be made **before** differentiation.

For A174013 take $W=2x(1-x-x^2)$, $V=x^2+3x-1$ and $D=1-2x-x^2+6x^3+5x^4$. For A173993 take $W=2x(1-4x+3x^2)$, $V=-2x^2+4x-1$ and $D=(1-2x)(1-2x-4x^2+4x^3)$. These are the generating functions recorded in the entries. The following vectors list the coefficients of their recurrences in increasing order of lag.

| Entry | $s_j$ | $c_j$ | Coefficients of $R$, starting at degree zero |
| --- | --- | --- | --- |
| A174013 | $1,1,-12,9,36,-11,-49,-20$ | $1,0,12,-24,-138,22,253,120$ | $1,3,-1,12,-6,-24$ |
| A173993 | $1,-8,19,0,-56,68,-24$ | $1,-2,-5,-36,208,-286,120$ | $1,-6,15,-20,10$ |

In each row the two polynomial identities hold using the displayed $V,W,D,s,c,R$. The companion script multiplies the polynomials with exact arithmetic, checks the first identity, and divides to recover $R$ in the second. Both remainders are zero. This proves the two printed recurrences for $n\ge7$ and $n\ge6$, respectively. [Exact verification](check.py) · [Lean derivation for constant parameters](RowRecurrence.lean)

## Earlier formulas and scope

The same certificate verifies Mathar's five-lag formula in A171416. In that case his recurrence is already the sum of Michael Somos's four-lag recurrence at $n$ and at $n-1$, so this is a check on an existing consequence. A157100 has an earlier public Lean proof. These examples contribute no separate claims to this note. [A171416](https://oeis.org/A171416) · [Prior A157100 proof](https://www.trureturing.org/research/oeis-a157100-five-term-recurrence/)

The four formulas proved here are elementary consequences of published generating functions. The original entries still mark them as conjectural. Searches by their sequence IDs located the known generating functions and triangle analysis. Historical priority for the individual recurrences or their derivation is undetermined.
