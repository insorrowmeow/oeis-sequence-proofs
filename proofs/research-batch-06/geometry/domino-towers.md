# Domino towers of fixed excess area

In [OEIS A333650](https://oeis.org/A333650) Peter Kagey and Peter Luschny conjectured the first three nontrivial diagonals of the array \(T(n,h)\) counting towers of \(n\) dominoes and height \(h\). We prove the three identities and give an algorithm for every fixed difference \(d=n-h\). We use the standard staggered model: a row is a finite nonempty set \(S\) of brick positions, the base is contiguous, and the next row is a nonempty subset of \(S\cup(S+1)\). The shift of the coordinate system between successive rows converts the two possible half-brick supports into increments zero and one. Towers are identified by horizontal translation. See [Haupt, Introduction](https://cs.uwaterloo.ca/journals/JIS/VOL24/Haupt/haupt4.pdf) for the model.

## Finite determination

Define
\[
D_d(x)=\sum_{h\ge1} T(h+d,h)x^{h-1}.
\]
Then \(D_d(x)=P_d(x)/(1-2x)^{d+1}\) with an integral polynomial \(P_d\) of degree at most \(2d\).

Mark each row containing multiple bricks. If there are \(q\) marked rows and \(m\) maximal runs of singleton rows then \(q\le d\) and \(m\le q+1\). Compress each singleton run to its first row. Each time a singleton-to-singleton step is removed, shift the whole portion above it horizontally to preserve the offset at the next retained interface. No restrictions couple nonconsecutive layers, and the normalized base remains contiguous. The result is a reduced tower whose height is \(q+m\); there are only finitely many such towers for a given \(d\).

Conversely, above each retained singleton insert any word in the two possible singleton-to-singleton steps. Shift the portion above the word by the displacement of the newly inserted steps. These choices independently reconstruct every original tower exactly once. Hence a given reduced tower contributes
\[
x^{q+m-1}(1-2x)^{-m}.
\]
This includes \(m=0\). After multiplication by \((1-2x)^{d+1}\), its degree is at most \(q+d\le2d\). Summation proves the claim. In particular \(2d+1\) initial counts determine the *whole* diagonal.

## The three conjectured diagonals

To obtain the finite counts, start with one contiguous base of each length \(1,\ldots,d+1\). Store the top row relative to its leftmost brick, the excess \(e\) already used, and the number of partial towers. For each nonempty subset \(U\subseteq S\cup(S+1)\) with \(|U|-1\le d-e\), add this number to the next state \((e+|U|-1,U-\min U)\). The total over states of excess \(d\) gives \(T(h+d,h)\). This recurrence enumerates each tower exactly once by removing its top layer.

| \(d\) | Required initial coefficients for \(D_d\) | \(P_d(x)\) |
|---:|---|---|
| 1 | \(1,4,11\) | \(1-x^2\) |
| 2 | \(1,7,24,70,193\) | \(1+x-6x^2+2x^3+5x^4\) |
| 3 | \(1,12,52,168,497,1412,3879\) | \(1+4x-20x^2+8x^3+33x^4-4x^5-33x^6\) |

The last column follows by convolving the middle column with the coefficients of \((1-2x)^{d+1}\). The degree bound proves that the remaining coefficients vanish. The rational functions coincide with [A339252](https://oeis.org/A339252), [A339254](https://oeis.org/A339254) and [A339029](https://oeis.org/A339029), respectively, with index \(h-1\), exactly as proposed. For example the next diagonal has
\[
P_4(x)=1+10x-50x^2+21x^3+127x^4-26x^5-234x^6-22x^7+229x^8.
\]
The [Python implementation](domino_towers.py) computes the finite counts and the exact numerators through \(d=6\).

[Domino.lean](Domino.lean) gives a second, induction-based proof of all three diagonals. It constructs every allowed next row by enumerating all nonempty subsets of the supported sites, checks exhaustiveness of the thirteen reachable states and each transition multiplicity, and proves the closed formulas at every height by induction. With index \(m=h-1\ge3\), the three expressions are \(2^{m-3}(10+6m)\), \(2^{m-5}(70+43m+9m^2)\), and \(2^{m-7}(588+367m+84m^2+9m^3)\); the Lean statement clears small powers of two and also checks the three initial heights separately. The identification of staggered physical towers with their successive row sets is explained above. The all-\(d\) degree bound and asymptotic below are written proofs.

The denominator has exact order \(d+1\) at \(x=1/2\). The only contributions with \(m=d+1\) have \(q=d\), all marked rows contain two bricks, the ends are singleton, and every two marked rows are separated by a singleton. Starting from a singleton the next two-brick row must use both available sites; above it a singleton can occupy any of three positions. Thus there are \(3^d\) reduced towers of this type, each contributing \(x^{2d}/(1-2x)^{d+1}\). In particular \(P_d(1/2)=(3/4)^d\), and as \(h\) grows with \(d\) fixed,
\[
T(h+d,h)\sim 2^{h-1}(3/4)^d\,h^d/d!.
\]

## Height two

For a base of length \(b\), the second layer occupies any nonempty subset of its \(b+1\) possible sites. Thus the number with \(n\ge2\) bricks is
\[
\sum_{b=1}^{n-1}\binom{b+1}{n-b}=F_{n+2}-1,
\]
where \(F_0=0,F_1=1\). This is the binomial formula for Fibonacci numbers: \(F_{n+2}\) counts compositions of \(n+1\) with parts one and two, and there are \(\binom{n+1-j}{j}\) with \(j\) twos. Here \(j=n-b\) and the excluded \(j=0\) accounts for the subtraction. This elementary height-two count is already implicit in [Luschny's A339494](https://oeis.org/A339494); it is separate from the three diagonal conjectures.
