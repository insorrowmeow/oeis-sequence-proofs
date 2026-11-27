# Four recurrences for the odd rule on triangular tiles

Start with one ON triangle. At each tick, a triangular tile is ON exactly when an odd number of its three edge-neighbors were ON. Let $a(n)$ count the ON tiles at time $n$. We establish all four recurrences listed as conjectures in the entry submitted by Alexey Kovba; Andrei Zabolotskii contributed the three even-index identities in August 2016. [A275667](https://oeis.org/A275667)

Use two integer coordinates for each orientation of triangle. Label the three downward neighbors of the upward tile at $(i,j)$ by $(i,j),(i+1,j),(i,j+1)$. The reverse offsets describe the neighbors of a downward tile. Counting paths modulo two is polynomial multiplication in $\mathbb F_2[x^{\pm1},y^{\pm1}]$. Put $B=1+x+y$, $\bar B=1+x^{-1}+y^{-1}$, $F=B\bar B$. Write $|P|$ for the number of nonzero monomials. Then

$$a(2m)=|F^m|=:H_m,\qquad a(2m+1)=|B F^m|.$$

In this ring, squaring doubles both exponents, preserving the number of occupied sites. The three terms of either $B$ or $\bar B$ have distinct exponent pairs modulo 2. Hence $|B P^2|=|\bar B P^2|=3|P|$ for every $P$. Applying this to $BF^{2m}$ and to $BF^{2m+1}=\bar B(BF^m)^2$ gives **$a(2t+1)=3a(t)$** for both parities of $t$.

Put $D_m=|(1+x)F^m|$. To compute $|Q P^2|$, partition the support of $Q$ by the parities of its two coordinates. In each class remove its common residue, halve both coordinates and multiply the resulting polynomial by $P$. Sum the four support sizes. Distinct parity classes cannot cancel one another.

For $Q=F$, the four resulting pieces are a singleton and three pairs along the directions $(1,0),(0,1),(1,-1)$, up to translations. These directions give equal support counts against $P=F^m$: the exponent swaps $(i,j)\mapsto(j,i)$ and $(i,j)\mapsto(i,-i-j)$ permute the six nonzero neighbors of $F$. For $Q=(1+x)F$, the classes $(0,0),(1,0)$ are singletons and the other two classes are horizontal adjacent pairs. Applying these facts and squaring gives

$$H_{2m}=H_m,\quad H_{2m+1}=H_m+3D_m,\quad
D_{2m}=2H_m,\quad D_{2m+1}=2H_m+2D_m.$$

It follows that $H_{4m+1}=7H_m$ and $H_{4m+3}=3H_{2m+1}+4H_m$. In the source indices these are precisely

$$a(4t)=a(2t),\qquad
a(8t+2)=3a(4t)+4a(2t),\qquad
a(8t+6)=3a(4t+2)+4a(2t).$$

With $a(0)=1$ the four recurrences determine every index. The binary-index recursion also gives $a(2^k-1)=3^k$ by iterating the odd rule. The even subsequence and its polynomial description were already recorded in A247666. Polynomial decomposition for odd-rule automata predates these observations. Targeted searches did not establish priority for the specialization. [A247666](https://oeis.org/A247666) · [Ekhad, Sloane and Zeilberger](https://arxiv.org/abs/1503.01796)
