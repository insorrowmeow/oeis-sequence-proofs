# Two carryless products define the same set of inputs

In a carryless product $m\otimes n$, multiply the binary digit polynomials over the two-element field, then read the coefficients as bits. Antti Karttunen conjectured in December 2025 that $7n=11\otimes n$ and $5n=13\otimes n$ hold for exactly the same nonnegative integers. The entry reports testing the interval through $2^{25}$. [OEIS A115770](https://oeis.org/A115770)

**Theorem.** The conditions are equivalent for every $n\ge0$.

For ordinary multiplier $s$ and carryless multiplier $m$, consider the residual equation $s n+c=(m\otimes n)\mathbin{\mathrm{xor}}h$. Read the least significant bit $b$ and put $n=2t+b$. Let $u=c+sb$ and $v=h\mathbin{\mathrm{xor}}(mb)$. If their low bits differ, equality is impossible. Otherwise deleting these bits gives the same residual equation at $t$ with new pair $(\lfloor u/2\rfloor,\lfloor v/2\rfloor)$. At $t=0$ it succeeds exactly when $c=h$.

Track the two residual equations in parallel, starting with $(c,h)=(0,0)$ for both and retaining a failure symbol for either side once its low bits disagree. The initial joint state and its successors form a set of 15 states. In all 15, both sides have the same answer at input zero. Reading either bit keeps the joint state in this set. Induction on the number of input bits proves equivalence for all inputs, including zero.

**A direct description of the actual numbers.** Apart from zero, they are exactly the integers whose binary runs of ones have length at least three and whose zero runs between two runs of ones also have length at least three. Trailing zeros are unrestricted. For example $455=(111000111)_2$ qualifies, while $231=(11100111)_2$ does not.

To see this from the certificate, number its states from 0 to 14 as in the file. Removing the states from which acceptance is unreachable leaves $0,1,3,7,11,12$. From state 0 one may read arbitrary zeros. Entering a run of ones requires $0\to1\to3\to7$ on three consecutive ones. More ones loop at 7. Leaving it by zeros follows $7\to11\to12\to0$; another run can start only from 0. Termination is permitted at 0, 7, 11 or 12. This reads bits from least significant to most significant and gives the stated description.

The transition table and its complete arithmetic interpretation are in [Carryless.lean](Carryless.lean). Lean 4.19 verifies the table, both directions of each transition, and the unrestricted equivalence. The Python checker independently reconstructs the states. Priority is undetermined.
