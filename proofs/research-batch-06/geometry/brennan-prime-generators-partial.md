# Eventual uniqueness in two prime generators proposed by Joel Brennan

Brennan's generators adjoin a prime to a finite set S. Choose the smallest positive squarefree product P of primes from S for which P+1, respectively P−1, has an unknown prime factor. Adjoin the least such prime. Both entries conjecture that the choice of the least prime is redundant at every step. The minus generator starts at S={2,3} and requires P−1≥2. [A359504](https://oeis.org/A359504), [A359505](https://oeis.org/A359505)

**Partial result.** Both sequences contain every prime, and both satisfy Brennan's uniqueness assertion at all sufficiently late steps. A separate finite computation proves it at every step at which the least missing prime is at most 10,000,000. The possible intervening range has no explicit upper endpoint here.

## Local witness criterion

Write q for the least prime outside S, and δ for the shift, +1 or −1. Suppose a squarefree integer b with all prime factors below q satisfies

$$1<b<q^2-1,\qquad b\equiv-\delta\pmod q.$$

It is an available product, and q divides b+δ. Hence the chosen P satisfies P≤b. Two unknown factors, even counted with multiplicity, would imply P+δ≥q². This proves uniqueness whenever there is a witness.

For every sufficiently large prime q both signs have witnesses. Theorem 1.4 of Munsch and Shparlinski bounds the smallest squarefree q-smooth representative of every residue class by q raised to the power 3/2+o(1). Their proof in Section 5.3 constructs a representative with two distinct prime factors, so the witness for the residue 1 is also greater than one. The prime q cannot divide a representative of a nonzero residue. For sufficiently large q, the bound is strictly below q²−1. [Munsch and Shparlinski, Theorem 1.4 and Section 5.3](https://arxiv.org/pdf/1710.04705)

## All primes eventually occur

The full product of the seen primes, shifted by δ, has a new prime factor, ensuring unlimited distinct terms. If the least missing prime stayed at a fixed q indefinitely, a single available product b>1 in the appropriate residue would force P≤b at every subsequent step. Only finitely many distinct primes are at most b+1. It suffices to exhibit such a persistent product.

For δ=+1 the first four terms cover 2,3,5,7. For q≥11, Theorem 1 of Booker and Pomerance gives a squarefree q-smooth representative of −1. All its prime factors are below q and hence already seen. Their Corollary 7 concerns a different selection rule that first minimizes the new prime across all products. [Booker and Pomerance, Theorem 1 and Corollary 7](https://arxiv.org/html/1607.01557)

For δ=−1, if q stayed missing indefinitely, infinitely many seen primes would lie in one nonzero residue class r modulo q. Choose q−1 distinct such primes. Their product b is greater than 1 and is congruent to 1 modulo q by Fermat's theorem. Once they have appeared, b is an available persistent product. Thus q tends to infinity for either sign, proving the eventual assertion in time order.

## Exact finite range

For each prime 13≤q≤10,000,000 and each sign, the accompanying Python script finds coprime squarefree x,y with 2≤x<q, 1≤y<q and xy congruent to the specified sign modulo q. The product xy gives the required witness. The sieve checks every prime in the interval. The largest first x needed was 46 for residue +1 and 47 for residue −1. Among primes starting at 11, q=11 for residue +1 is the only failure of this particular search. Direct enumeration up through the first occurrence of 11 for each generator covers all the small exceptions. Running `python brennan_witnesses.py` reproduces both checks.

The proof uses published analytic estimates and a Python computation for the finite range. There is no Lean proof of the two global conjectures in this note. The asymptotic bound and finite test do not meet at an established cutoff, so neither global conjecture is counted as solved.
