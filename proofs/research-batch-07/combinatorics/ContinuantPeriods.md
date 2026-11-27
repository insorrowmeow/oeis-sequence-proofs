# Periods of the continuant sequence A001040

For every \(N\ge1\), the least positive period of A001040 modulo \(N\) is either \(N\) or \(2N\). If \(N\) is odd, the even-index subsequence has least positive period exactly \(N\). These are the two conjectures in the MathOverflow question posted by joro on February 4, 2025. The Stack Exchange API returned zero answers when checked. [Question 487169](https://mathoverflow.net/questions/487169/on-the-period-of-an-n-1an-1an-2-modulo-n) · [OEIS A001040](https://oeis.org/A001040)

Let \(a_0=0\), \(a_1=1\), and \(a_{j+1}-a_{j-1}=j a_j\). The recurrence extends uniquely to all integer indices: it determines either neighboring term from the other two. Reflection preserves it, and at \(j=0\) it gives \(a_{-1}=a_1\). Thus \(a_{-j}=a_j\) for every \(j\).

Reduce terms modulo \(N\). The sequences \(a_{N+j}\) and \(a_{N-j}\), viewed as functions of \(j\), both satisfy the same centered recurrence with coefficient \(j\). They agree at \(j=0\), and \(a_{N+1}-a_{N-1}=Na_N\equiv0\) gives agreement at \(j=1\). Uniqueness gives \(a_{N+j}=a_{N-j}\) at all indices. Combining the reflections about 0 and \(N\) gives \(a_{2N+j}=a_j\).

If \(P\) is any positive period of \(a_j\), then \(a_P=0\), \(a_{P+1}=1\), and \(a_{P+2}=1\) modulo \(N\). The recurrence at \(P+1\) gives \(1-0=(P+1)\cdot1\), so \(N\mid P\). Since \(2N\) is a period, the least positive one lies in \(\{N,2N\}\).

Now put \(b_j=a_{2j}\), so \(N\) is a period of \(b_j\). Let \(p\) be any positive period of \(b\) on the nonnegative indices. As \(b\) already has period \(N\) on all integer indices, \(p\) is also a period on all indices: translate any two desired indices sufficiently far by a multiple of \(N\). Therefore \(b_p=b_0=0\) and \(b_{p-1}=b_{p+1}=1\) modulo \(N\), using \(b_{-1}=a_2=1\). Write \(u=a_{2p+1}\). The recurrence at \(2p\) gives \(u=a_{2p-1}\). At the two adjacent indices it gives

\[
 (2p+1)u=1,\qquad (2p-1)u=-1\pmod N.
\]

The first equality makes \(u\) invertible. Adding gives \(4pu=0\), hence \(N\mid 4p\). For odd \(N\) this implies \(N\mid p\), proving the second conjecture.

**Computational question.** For a fixed modulus, reducing \(m\) modulo \(2N\) gives a table-lookup algorithm after precomputing the \(2N\) residues. Without precomputation one can simply run that many recurrence steps, or fewer if the residue of \(m\) is small. With \(N\) fixed, reading and reducing a binary index uses \(O(\log(m+2))\) bit operations. If the intended complexity is uniform over input moduli, the table requires \(O(N)\) modular operations and the argument gives no polylogarithmic guarantee in the joint input size.

Lean proves both periodicity conjectures for all moduli and indices from the displayed recurrence. The final statements are `first_conjecture` and `least_even_period`. [Lean proof](ContinuantPeriods.lean)
