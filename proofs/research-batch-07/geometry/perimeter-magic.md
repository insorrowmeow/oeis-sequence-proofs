# Enumerating perimeter-magic squares with distinct labels

Richard J. Mathar conjectured a recurrence of order 34 for eight distinct positive numbers placed at the corners and side midpoints of a square. Each side has sum n, and rotations and reflections identify placements. Let a(n) be the count, extended by zero below the first nonempty case n=12. The conjectured recurrence holds for every n≥35 under this extension. [OEIS A380962](https://oeis.org/A380962)

**Generating function.** Let T be the polynomial in ascending coefficient order

```
[1,2,3,2,0,-3,-6,-8,-9,-7,-3,4,10,15,16,14,8,0,
 -8,-14,-16,-15,-10,-4,3,7,9,8,6,3,0,-2,-3,-2,-1].
```

Then Σ a(n)qⁿ = q¹² H(q)/T(q), where the coefficients of H in ascending order are

```
[3,15,50,127,267,481,793,1173,1625,2079,2520,2826,
 3045,3038,2906,2580,2187,1673,1231,796,491,236,98].
```

The denominator is exactly the polynomial of the conjectured recurrence. The numerator ends at degree 34.

## Canonical coordinates

The two pairs of opposite corners may be interchanged, and either pair may be reversed independently. These operations constitute the eight symmetries of the square. Write the pairs as {a,a+u} and {b,b+v}, where u,v>0. Their gaps must differ, since equal gaps would give two equal side labels. Order the pairs by u<v. Every labeling up to symmetry now has unique coordinates. The edges join all four possible cross pairs. Their midpoints therefore carry the numbers in x+E, where

$$E=\{0,u,v,u+v\},\qquad x=n-a-b-u-v.$$

Thus a,b,x are positive, n=a+b+x+u+v, and the four side labels are distinct.

Set A=a−x, B=b−x, D=A−B. All eight labels are distinct precisely when A, B and D avoid, respectively,

$$F_A=E-\{0,u\},\qquad F_B=E-\{0,v\},\qquad F_D=\{0,v\}-\{0,u\}.$$

Here U−V denotes the set of all pairwise differences, with multiplicities discarded. The first two exclusions compare corners with sides, and the third compares the two opposite corner pairs.

## Inclusion–exclusion with fixed gaps

Suppressing the factor q^(u+v), the unrestricted choice of three positive integers contributes q³/(1−q)³. A single forbidden difference f contributes q^(3+|f|)/((1−q)(1−q²)), with negative sign. For two differences fixed, first express them as A=h, B=k. The admissible triples have x≥1−min(0,h,k) and hence give

$$\frac{q^{3+h+k-3\min(0,h,k)}}{1-q^3}.$$

Include every intersection of two different families, and subtract the ones satisfying all three. Events within one family are disjoint. The program incorporates the triple subtraction into the sum over the first two families. This counts each invalid labeling with total weight zero.

## Summation over the gaps

All forms involved are homogeneous linear functions of u,v. Each decision to merge equal forbidden differences, test a triple collision, take an absolute value or choose a minimum compares two forms. Their difference has coefficients of absolute value at most four. For example, a pair A,D becomes (A,A−D), and the triple test is A−B−D=0. Consequently all decisions are constant in the interiors cut out by the following primitive rays, written as (u,v):

```
(0,1), (1,4), (1,3), (1,2), (2,3), (3,4), (1,1).
```

This list includes all reduced fractions u/v in [0,1] with denominator at most four. Each successive pair r,s has determinant of absolute value one. Every integer point in the open cone then has a unique expression ir+js with i,j≥1, by the integer inverse of the matrix with columns r,s. On each interior the exponent has the form 3+L(u,v). Geometric summation gives q^(3+L(r)+L(s))/((1−q^L(r))(1−q^L(s))) in place of q^(3+L). On an interior ray r use q^(3+L(r))/(1−q^L(r)). The extreme rays are excluded. Signs and the factors from summing a,b,x accompany each term.

## Exact computation

`perimeter_magic.py` constructs the resulting 153 distinct rational summands and adds them with integer polynomial arithmetic. Exact division after multiplication by T yields the numerator given above. This computation is an identity of polynomials. The method does not fit a recurrence to a finite list of counts.

`PerimeterMagic.lean` separately constructs the 922 summands before collecting like terms. It checks every denominator against the common product J of 29 factors (1−q^k) and checks the cleared identity by evaluation at B=2⁴⁸. To see why one evaluation suffices, the ℓ¹ coefficient norm of each partial product of J is at most 2²⁹. The coefficient norm of T is 222 and that of q¹²H is 30240. The norm of the cleared discrepancy is at most 2²⁹(922·222+30240), strictly smaller than B. If a nonzero integer polynomial with this bound vanished at B, reduce modulo B after removing its lowest nonzero power. Its first nonzero coefficient would be a nonzero multiple of B, contradicting the bound. The canonical-coordinate bijection, the inclusion–exclusion argument and this coefficient-bound deduction are written above.

Mathar's 2025 program enumerates perimeter-magic polygons for specified sums and symmetries. The triangle version A380853 already has a known generating function. [Mathar's program](https://zenodo.org/records/15001366), [triangle analogue](https://oeis.org/A380853)
