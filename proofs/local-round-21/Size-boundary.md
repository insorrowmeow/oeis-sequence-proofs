# The size cutoff for reciprocal prime-indexed partition weights

Local research note, 27 November 2026

Lagarias and Sun suggested from Figure 6 that the cumulative size statistic differs from $e^\gamma(\log n+\log\log n)$ by a bounded amount. We determine the loss caused by restricting the sum of the parts, including its leading coefficient. The question appears after (3.12) in §3.2.4. Remark 5.5 also asks about the coefficient of $\log\log n$. [Lagarias and Sun, *Asymptotics of reciprocal supernorm partition statistics*, Ramanujan J. 65 (2024), 487–520](https://doi.org/10.1007/s11139-024-00893-8)

## Result

Write $p_j$ for the $j$th prime, starting with $p_1=2$. A partition with $a_j$ copies of part $j$ has weight $\prod_j p_j^{-a_j}$. Let $C_{\mathrm{size}}(n)$ be the sum of the weights for total size $\sum j a_j\le n$, including the empty partition of weight one. Let $H_n=C_{\max}(n)$ impose only that each part is at most $n$. Put $L=\log n$.

**Theorem.** As $n\to\infty$ through the integers,

$$
 H_n-C_{\mathrm{size}}(n)\sim\frac{e^\gamma\pi^2}{12L}.
 \tag{1}
$$

Consequently

$$
 C_{\mathrm{size}}(n)= e^\gamma\left(L+\log L+
      \frac{\log L-1-\pi^2/12}{L}\right)+o(1/L).
 \tag{2}
$$

In particular the remainder in the Figure 6 question tends to zero. It is positive for all sufficiently large $n$. Omitting the empty partition from both ensembles leaves (1) unchanged and subtracts one from (2).

## The probability representation

Put $q_j=1/p_j$. For $1\le j\le n$, let $G_j$ be independent nonnegative geometric variables with $\Pr(G_j=k)=(1-q_j)q_j^k$ for $k\ge0$. The product of the geometric series is $H_n=\prod_{j\le n}(1-q_j)^{-1}$. Thus every multiplicity vector has probability exactly its partition weight divided by $H_n$. Since a partition of size at most $n$ already has all parts at most $n$,

$$
 \frac{H_n-C_{\mathrm{size}}(n)}{H_n}
 =\Pr\left(\sum_{j=1}^n jG_j>n\right).
 \tag{3}
$$

## Reducing the event to two distinct parts

Use the integer cutoffs $b=\lfloor n/L^6\rfloor$, $t=\lceil n/L^3\rceil$ and $N=n-t$. In what follows $n$ is large enough that $1\le b<N/2$. Write $\lambda=\sum_{b<j\le n}q_j$ and

$$
 P(b,s)=\sum_{\substack{b<i<j\le s\\i+j>s}}q_iq_j .
$$

The prime number theorem gives $p_j\sim j\log j$. Uniformly on $b<j\le n$, $L j q_j=1+o(1)$, because $b\to\infty$ and $\log b/L\to1$. The harmonic sum over this interval is $O(\log(n/b))=O(\log L)$. Hence $\lambda=O(\log L/L)$.

For a lower bound, require exactly one copy of each of $i,j$ and zero copies at all other indices above $b$, with $i+j>n$. Such events for different pairs are disjoint and the small indices are unrestricted. The resulting probability is $P(b,n)\prod_{j>b}^{n}(1-q_j)$, at least $(1-\lambda)P(b,n)$.

For an upper bound, discard four exceptional events.

| Event | Upper bound on its probability |
| --- | --- |
| Small parts have total size $>t$ | $b/t$, by Markov's inequality, since $\sum_{j\le b} j\,\mathbb E G_j=\sum_{j\le b}j/(p_j-1)\le b$ |
| Some occupied index exceeds $N$ | $\sum_{N<j\le n}q_j\le t/N$ |
| A part above $b$ occurs twice or more | $\sum_{j>b}q_j^2\le 1/b$ |
| At least three distinct indices above $b$ are occupied | $\sum_{b<i<j<k\le n}q_iq_jq_k\le\lambda^3/6$ |

Here $p_j\ge j+1$ and $\sum_{j>b}j^{-2}\le 1/b$. Each bound in the table is $o(L^{-2})$. Outside these events there are at most two large parts, both distinct and at most $N$. If the total size exceeds $n=N+t$, their sum must exceed $N$. One part alone cannot do so. Summing the occupancy probabilities for these pairs gives

$$
 (1-\lambda)P(b,n)
 \ \le\ \Pr\left(\sum jG_j>n\right)
 \ \le\ P(b,N)+o(L^{-2}).
 \tag{4}
$$

## Evaluating the pair sum

For $s=n$ and $s=N$, uniformity of $Lj q_j$ on $(b,n]$ permits replacement of each $q_iq_j$ by $(1+o(1))/(L^2ij)$ in the nonnegative sum. The ordered sum over the full triangle has the exact identity

$$
 \sum_{\substack{1\le i,j\le s\\i+j>s}}\frac1{ij}
 =\sum_{k=1}^s\frac1{k^2}.
 \tag{5}
$$

Indeed the complementary triangle has mass
$\sum_{k=2}^s\sum_{i=1}^{k-1}1/[i(k-i)]=2\sum_{k=2}^s H_{k-1}^{\rm harm}/k$ by partial fractions. Expanding $(H_s^{\rm harm})^2$ and removing its diagonal gives exactly the latter sum, where $H_s^{\rm harm}=\sum_{i=1}^s1/i$.

At most $2b/(s-b)$ of the mass on the left of (5) has $i\le b$ or $j\le b$. For each $i\le b$ there are exactly $i$ admissible values of $j$, all larger than $s-b$. The diagonal has mass at most $\sum_{i>s/2}1/i^2=O(1/s)$. After deleting the two strips and the diagonal, divide by two to keep just the pairs $i<j$. Since $b/s\to0$, the Basel identity now gives

$$
 L^2P(b,n),\ L^2P(b,N)\ \longrightarrow\
 \frac12\sum_{k=1}^\infty\frac1{k^2}=\frac{\pi^2}{12}.
$$

Equation (4) gives the same normalized limit for the probability, and (3) together with $H_n\sim e^\gamma L$ gives (1).

## Deduction of the size expansion

The classical expansion of Cipolla gives
$p_n/n=L+\log L-1+O(\log L/L)$. Hence
$$
 \log p_n=L+\log L+\frac{\log L-1}{L}
             +O\!\left(\frac{(\log L)^2}{L^2}\right).
$$
The effective reciprocal Mertens estimate in Lagarias and Sun, Lemma 4.3(2), gives $H_n=e^\gamma\log p_n+O(1/L^2)$. Subtract (1). The error displayed for $\log p_n$ is $o(1/L)$, yielding (2). [Axler, *New Estimates for the nth Prime Number*, equation (1.2)](https://cs.uwaterloo.ca/journals/JIS/VOL22/Axler/axler17.pdf) · [Lagarias and Sun, Lemma 4.3](https://doi.org/10.1007/s11139-024-00893-8)

## Relation to prior results

The question about boundedness is an unnumbered suggestion after Figure 6. The sharp equivalent (1) strengthens the suggestion. Boundedness itself also follows from the first moment: the prime number theorem gives $\sum_{j\le n}j/(p_j-1)=O(n/\log n)$ (split the sum at $\sqrt n$), so Markov's inequality in (3) gives $H_n-C_{\mathrm{size}}(n)=O(1)$. The rare-pair argument is needed here to identify the much smaller loss and its coefficient.

Ma and Zhang's preprint and an earlier public Lean formalization establish an asymptotic for the weight at **exactly** size $n$. The formalization also proves first-moment inequalities for the cumulative weight. The fixed-size result alone does not specify the term at order $1/\log n$ in (2). A targeted literature check on 27 November 2026 found no earlier proof of (1) in this prime-indexed size ensemble. [Ma and Zhang](https://zenodo.org/records/24578337) · [Public size formalization and its inputs](https://the-omega-institute.github.io/trureturing-mdbook/Blueprint/D5/S3/Arith/Partitions/SupernormSizeAsymptotic.html)

## Reproducing the checks

Run `python check_lean.py` with Lean and mathlib v4.19.0. From a separate mathlib project, run `lake env python /path/to/check_lean.py` with the actual path. `python verify_size.py` independently checks the partition definition, normalized overflow, finite sandwiches and the triangle identity in exact rational arithmetic for every $1\le n\le18$.

| Lean theorem | Statement | Published inputs supplied as hypotheses |
| --- | --- | --- |
| `SizeResult.overflow_limit` | $(\log n)^2$ times the overflow probability tends to $\pi^2/12$ | $p_n/(n\log n)\to 1$ |
| `SizeResult.size_gap_limit` | Formula (1), expressed as a limit for the original partition sum | Same prime asymptotic, and $H_n/\log n\to e^\gamma$ |
| `SizeResult.size_expansion` | Formula (2), expressed as a limit for its normalized remainder | $p_n/n-\log n-\log\log n\to-1$ and $\lvert H_n-e^\gamma\log p_n\rvert=O(1/\log^2 n)$ |
| `SizeResult.figure_six` | The centered remainder tends to zero, is eventually positive and is asymptotic to $e^\gamma\log\log n/\log n$ | Same two stronger prime estimates |

The finite statistic uses the genuine $n$th prime and a finite set of decreasing lists of positive parts with total size at most $n$. The code proves the bijection with multiplicity vectors. It proves the marginal, pair and triple bounds, derives both cutoff limits, and uses mathlib's Basel theorem. The finite triple bound in Lean uses $\lambda^3$. This gives the same limit as $\lambda^3/6$ in the written proof. A fresh build of all 16 local Lean modules passed. The three final declarations report only `propext`, `Classical.choice` and `Quot.sound`. [Final Lean declarations](SizeResult.lean)
