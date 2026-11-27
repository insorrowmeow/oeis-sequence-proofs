# The growth rate of Sykora's Gray-code recurrence

Set $g(x)=x\mathbin{\mathrm{xor}}\lfloor x/2\rfloor$ and $T(x,y)=g(g(x)+g(y))$. Start with $a(1)=a(2)=1$ and use $a(n+2)=T(a(n),a(n+1))$. In 2015 Stanislav Sykora conjectured that $(a(2n)/a(n))^{1/n}$ tends to $\sqrt 2$, even though the ratios of neighboring terms keep fluctuating. [OEIS A265386](https://oeis.org/A265386)

**Theorem.** The proposed limit is $\sqrt 2$. More precisely, for every $j\ge12$ both $a(2j-1)$ and $a(2j)$ have exactly $j$ binary digits. The consecutive ratios alternate between two disjoint intervals: $a(2j)/a(2j-1)<640/978<0.655$, whereas $a(2j+1)/a(2j)>1956/640>3.05$.

**Why prefixes suffice.** Write $[x]_k=\lfloor x/2^k\rfloor$. Shifting discards the same low bits on both sides of the Gray operation, so $[g(x)]_k=g([x]_k)$. Addition satisfies $[x+y]_k=[x]_k+[y]_k+c$, where $c$ is either 0 or 1.

For the pair $x=a(2j-1), y=a(2j)$ retain the prefixes $u=[x]_{j-10}, v=[y]_{j-10}$. One pair later the cutoff is one bit higher. The next prefixes have the form

$$w=g(g(u)+g(v)+c),\qquad
(u',v')=\left(\lfloor w/2\rfloor,\ \lfloor g(g(v)+g(w)+d)/2\rfloor\right),$$

where $c,d\in\{0,1\}$. Allowing all four combinations includes the true transition even when the discarded bits force some carries to agree.

At $j=12$ the pair is $(4072,2505)$ and its prefix is $(1018,626)$. Start with that single prefix. For each prefix added, insert its four successors until there are none left to insert. The set has 140 elements. The companion Python program constructs the set and verifies all 560 transitions. The Lean proof stores an explicit finite set, verifies its closure in the kernel and proves by induction that every actual prefix belongs to it. Its coordinate bounds are

$$978\le u<1024,\qquad544\le v<640.$$

Multiplication by $2^{j-10}$ gives the asserted inequalities, using the next pair's lower bound for the ratio across a pair boundary. Both terms lie in $[2^{j-1},2^j)$. Hence $\log a(n)=\tfrac n2\log2+O(1)$. Taking the difference at $2n$ and $n$, dividing by $n$ and exponentiating gives the limit.

Lean checks the original initial values and recurrence, the bounds for all indices and the real limit. The sharper numerical bounds on the two kinds of consecutive ratios follow in the paragraph above. A targeted prior-art search by sequence number and definition located the OEIS conjecture; historical priority remains undetermined.

## The two neighboring conjectures

Sykora proposed limit 2 for both adjacent entries. Let $A_1=A_2=B_1=B_2=1$ and

$$A_{n+2}=g(A_n+A_{n+1}),\qquad B_{n+2}=g(B_n)+g(B_{n+1}).$$

Induction gives $A_n=g(B_n)$, since this holds at 1 and 2. Hence $B_{n+2}=A_n+A_{n+1}$. [A265385](https://oeis.org/A265385) · [A265387](https://oeis.org/A265387)

For $j\ge3$, discard $j-3$ low bits from both $A_{j-1},A_j$. The retained pair is always $(1,3)$. The starting pair is literally $(1,3)$. At the next cutoff, the pair becomes $(\lfloor3/2\rfloor,\lfloor g(1+3+c)/2\rfloor)$ for some $c=0,1$. Both $g(4)=6$ and $g(5)=7$ halve to 3 after rounding down. This proves the invariant. Therefore $3\cdot2^{j-3}\le A_j<4\cdot2^{j-3}$. The identity for $B_{n+2}$ gives $9\cdot2^{j-5}\le B_j<12\cdot2^{j-5}$ for $j\ge5$. Both have $\log a(n)=n\log2+O(1)$ and consequently $(a(2n)/a(n))^{1/n}\to2$. These estimates establish the precise limits posed in the two entries. The approximate percentages for neighboring-term fluctuations are separate empirical observations.
