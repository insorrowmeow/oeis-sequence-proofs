# A refinement for the ordinary norm

With $N(\lambda)=\prod_i\lambda_i$, let $W(n)$ be the sum of $1/N(\lambda)$ over partitions of perimeter $n$. Ma and Zhang, Corollary 4, obtained $W(n)=n-H_{n-1}+O((\log n)^2/n)$, where $H_k=\sum_{i=1}^ki^{-1}$. The following normalized comparison saves a logarithm in their error bound. [Preprint](https://doi.org/10.5281/zenodo.24578337) · [Original question in Appendix A](https://doi.org/10.1007/s11139-024-00893-8)

**Proposition.** As $n\to\infty$,

$$
 W(n)=n-H_{n-1}+O(\log n/n)=n-\log n-\gamma+O(\log n/n).
$$

Work with $n\ge2$, so only nonempty partitions contribute. Fix the maximum $m$ and remove one copy of it. The residual partition has $t=n-m$ parts. Once the multiplicities of $2,\ldots,m$ are chosen with total at most $t$, all remaining entries must be ones. Introduce independent $G_j$ with $\Pr(G_j=s)=(1-1/j)j^{-s}$ for $j\ge2,\ s\ge0$, and put $S_m=\sum_{j=2}^mG_j$, with $S_1=0$. The normalizing product is $\prod_{j=2}^m(1-1/j)=1/m$, exactly the factor for the deleted part. Thus
$$
 W(n)=\sum_{t=0}^{n-1}\Pr(S_{n-t}\le t),\qquad
 n-W(n)=\sum_{t=0}^{n-1}\Pr(S_{n-t}>t).
$$

Use the same variables $G_j$ for all $m$. Then $S_m$ increases in $m$ almost surely and $\mathbb E S_m=H_{m-1}$. For $R=3/2$,
$$
 \mathbb E R^{S_m}=\prod_{j=2}^m\frac{j-1}{j-3/2}
 \le \prod_{j=2}^m\frac{j}{j-1}=m.
$$
Each factor inequality is equivalent to $j\ge2$. Hence $\Pr(S_m>t)\le mR^{-t}$.

Take $L=\lceil 10\log n\rceil$, $M=n-L$ for sufficiently large $n$. Replacing $S_{n-t}$ by $S_n$ bounds the deficit above by $\sum_{t\ge0}\Pr(S_n>t)=H_{n-1}$. Restricting to $t\le L$ and replacing $S_{n-t}$ by $S_M$ bounds it below by $H_{M-1}-2nR^{-L}$. Finally $H_{n-1}-H_{M-1}=O(L/n)$, $nR^{-L}=O(n^{-3})$, and $H_{n-1}=\log n+\gamma+O(1/n)$. This proves the proposition. This supplementary calculation is a written argument.
