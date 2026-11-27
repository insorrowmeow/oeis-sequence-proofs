# A bijection for Mathar’s second conjecture in A152661

For every $n\ge2$, let $A(n)$ count permutations of $1,\ldots,n$ whose first two entries have the same parity. Let $B(m)$ count all occurrences of adjacent even-then-odd pairs across the permutations of $1,\ldots,m$. R. J. Mathar conjectured in April 2015 that $A(n)=2B(n-1)$. [A152661](https://oeis.org/A152661) · [A077613](https://oeis.org/A077613)

Take the first two entries of a counted permutation, record their order, and write their values in increasing order $u<v$. Send the unordered same-parity pair to the unordered opposite-parity pair $\{u,v-1\}$ in $1,\ldots,n-1$. Indeed, $v-u\ge2$, so $u<v-1$. This map is invertible, since for an opposite-parity pair $c<d$ its inverse is $c,d+1$.

The original pair has two possible orders and the tail has $(n-2)!$ arrangements. On the other side, orient the pair even-then-odd and regard it as one marked block. This block and the other $n-3$ symbols have $(n-2)!$ arrangements. Counting the marked block counts an occurrence, including when a permutation has several such pairs. Thus $A(n)=2B(n-1)$ for $n\ge3$. At $n=2$ both sides vanish.

This is a short proof of a relation also implied by factorial formulas already available in the two entries. A public formalization of the **first**, separate recurrence conjecture explicitly lists this second identity outside its scope. This note makes no claim of historical priority. [Earlier recurrence proof](https://www.trureturing.org/research/oeis-a152661-mathar-first-recurrence/)
