# Two sharp bounds for partitions of the nonempty powerset

Partition the nonempty subsets of $[n]$ into exactly $n$ nonempty color classes. A point *sees* a color when it belongs to some set of that color. Suppose each point sees at most $m$ colors. Let $f_n(m)$ be the minimum number of unordered pairs of disjoint sets of the same color. In 2023 Fabius Wiesner conjectured $f_n(n-1)=1$ and asked for the other values. [MathOverflow question](https://mathoverflow.net/questions/455610/lower-bound-for-couples-of-disjoint-sets-in-some-partitions-of-the-power-set)

For every $n\ge3$,

$$
 f_n(n-1)=1,\qquad
 f_n(2)=D_n-2^{n-2}+n,
 \qquad
 D_n=\frac{3^n-2^{n+1}+1}{2}-n(2^{n-1}-1)+\binom n2.
$$

Here $D_n$ counts unordered pairs of disjoint subsets of $[n]$ both of size at least two.

## Each point may see at most $n-1$ colors

Suppose no two disjoint sets have the same color. The $n$ singleton sets must have different colors. Name each color by its singleton point. A set of color $a$ must contain $a$, since it must meet $\{a\}$.

Start with the whole ground set, record its color, delete the point naming that color, and repeat until one point $j$ remains. Including the final singleton, this records $n$ distinct colors. Every recorded set contains $j$, so $j$ sees all $n$ colors. This contradicts the local cap. At least one monochromatic disjoint pair is therefore necessary.

On three points $a,b,c$, take the three color classes

$$
 \{\{a\},\{b\},\{a,b\}\},\qquad
 \{\{c\}\},\qquad
 \{\{a,c\},\{b,c\},\{a,b,c\}\}.
$$

Every point misses a color, and $\{\{a\},\{b\}\}$ is the only disjoint pair within a class. To extend the partition, order the $n-3$ additional points. Color every set containing an additional point by its first such point. The new classes are intersecting and nonempty. Each old point still misses an old color, and each new point misses all the old colors. Thus the minimum equals one. For $n=2$, the proposed cap $m=1$ admits no partition into two nonempty classes, since the color of the full set already meets both points.

## Each point may see at most two colors

Call the color of $[n]$ the full color. Each point sees that color and can belong to the support of at most one other color, where a support is the union of all sets of a color. The other $n-1$ supports are therefore pairwise disjoint and nonempty. They either comprise $n-1$ singleton supports with one unused point, or comprise $n-2$ singleton supports and one two-point support $P=\{a,b\}$.

In the first case all sets of size at least two have the full color. The unused point's singleton also has the full color and is disjoint from the set of the other $n-1\ge2$ points. There are at least $D_n+1$ monochromatic disjoint pairs.

In the second case every set of size at least two, except possibly $P$, has the full color. Removing $P$ from the family of all sets of size at least two removes

$$
 h=2^{n-2}-1-(n-2)
$$

disjoint pairs, one for each subset of size at least two of the complement of $P$. This gives $D_n-h$ forced pairs. At least one further pair involves a singleton. If $\{a\}$ and $\{b\}$ both have the color supported on $P$, they form the additional pair. Otherwise one of them, say $\{a\}$, has the full color. For $x\notin P$, the forced full-color set $\{b,x\}$ is disjoint from $\{a\}$. Hence the lower bound is $D_n-h+1$ in both support patterns.

Attain the bound by giving $\{a\},\{b\},P$ one color, giving each remaining singleton its own color, and giving every remaining nonempty set the full color. Each point sees at most two colors. The pairs consist of the $D_n-h$ full-color pairs and the single pair of singletons in the class supported on $P$.

For the formula for $D_n$, assign each point to the first set, the second set or neither. Removing cases where one set is empty and forgetting the order yields $(3^n-2^{n+1}+1)/2$ pairs. Each singleton has $2^{n-1}-1$ nonempty disjoint partners. Subtract these for all $n$ singletons and add back $\binom n2$ pairs of singletons counted twice. Substituting $h$ gives the claimed expression.

## Verification and scope

Lean 4.19.0 checks both bounds for the $m=n-1$ conjecture. The lower-bound theorem applies to every finite nonempty ground type. The upper-bound construction works on $\mathrm{Fin}(3)\sqcup\beta$, with $\beta=\mathrm{Fin}(n-3)$ for a ground set of size $n$. It uses every color, makes each point miss a color, and characterizes the unique unordered pair of disjoint nonempty sets with the same color. [Lean source](PowersetSingleDefect.lean)

The $m=2$ formula is proved above. An independent enumeration of admissible partitions up to color relabeling gave minima $1,3,22,120,521$ for $n=3,4,5,6,7$. [Enumeration script](check_powerset_two_colors.py)

The general extremal problem for intermediate $m$ remains open in this note. The MathOverflow page had no posted answer when checked. Its linked Math Stack Exchange post was unavailable through the public API, and the search did not establish publication priority.
