# Fixed polyominoes of width two less than their area

R. J. Mathar's [OEIS A308359](https://oeis.org/A308359) defines \(T(n,w)\) as the number of edge-connected \(n\)-cell polyominoes of width \(w\), identifying only translates. The entry conjectures \(T(n,n-2)=8n^2-51n+86\) for \(n\ge5\). We count these shapes using their columns.

Width here is the horizontal span, consistently with the data, the examples, and the row sums over all fixed polyominoes. The entry's comment imposing \(w\le h\) contradicts its own term \(T(n,n)=1\) for \(n>1\), since this is the horizontal bar of height one. Mathar's accompanying [enumeration paper](https://vixra.org/pdf/1905.0474v3.pdf) provides further context on the bounding-box counts.

Put \(w=n-2\ge3\). Each of the \(w\) consecutive columns must contain a cell. The two cells in excess of the width therefore give either one triple column or two double columns. Every column in either case is a vertical interval. Here are the details of this connectivity step.

* A maximal run of consecutive nonsingleton columns must be connected on its own. Any path leaving this run on the left must pass through its left neighboring singleton cell, and there is exactly one edge from that cell to the run; the same holds on the right. A path outside cannot cross from the left side to the right side without traversing the run. Thus each excursion may be erased.
* An isolated nonsingleton column must consequently be an interval. In a run of two double columns, if one has a gap it has no vertical edge. If the other also has a gap there are at most two horizontal edges in all. If the other is contiguous the two columns overlap at at most one row, so there is at most one horizontal and one vertical edge. Four connected cells require at least three edges.

For a fixed sequence of interval heights \(h_1,\dots,h_w\), translate the first column's bottom to zero. The number of placements is

\[
\prod_{i=1}^{w-1}(h_i+h_{i+1}-1).
\]

To see this, the next column's bottom must range from the current bottom minus \(h_{i+1}-1\) to the current top. This condition on successive columns is necessary and sufficient for connectivity.

One triple column gives \(9(w-2)+6\) shapes, as its contribution is nine in the interior or three at either endpoint. For two double columns, put \(d_1=d_w=2\) and \(d_i=4\) in the interior. For distinct nonadjacent locations \(i,j\) the placement count is \(d_i d_j\). Adjacent double columns contribute \(3d_i d_{i+1}/4\), because their common boundary contributes three placements instead of the four accounted for in the product.

Now \(\sum_i d_i=4w-4\) and \(\sum_i d_i^2=16w-24\). The adjacent overcount \(\frac14\sum_i d_i d_{i+1}\) is \(4w-8\), including \(w=3\): two endpoint pairs each contribute two and the \(w-3\) interior pairs contribute four each. Thus the two-double contribution is

\[
\tfrac12((4w-4)^2-(16w-24))-(4w-8)=8w^2-28w+28.
\]

Adding the one-triple contribution gives \(8w^2-19w+16\). Substitution of \(w=n-2\) proves \(8n^2-51n+86\).

## Any fixed difference between area and width

More generally, for each fixed \(d\ge1\), \(T(w+d,w)\) agrees with a polynomial in \(w\) of degree \(d\) and leading coefficient \(4^d/d!\) for \(w\ge2d+1\).

Partition a shape into maximal runs of columns with at least two cells and the intervening singleton columns. Each nonsingleton run is connected by the excursion argument above. If there are \(k\) such runs with total width \(c\), then \(k\le c\le d\). There are only finitely many ordered choices of their translation classes for fixed \(d\), because their total area is \(c+d\le2d\). Also specify which of the two ends have singleton columns, and write \(e\) for the number of such ends.

There are \(m=k-1+e\) positive singleton runs; each lies at one height. For each incidence between a nonsingleton run and a singleton run, select one of the cells on the appropriate end column for attachment. These selections are independent: following the blocks from left to right determines each successive vertical translation uniquely. Thus these choices introduce a constant factor independent of \(w\). The remaining length \(w-c\) is distributed among the \(m\) positive singleton runs in \(\binom{w-c-1}{m-1}\) ways. If \(m=0\), then \(w=c\) and this case is absent in the indicated range. For \(w\ge2d+1\) we always have \(w-c\ge m\) when \(m>0\).

Each binomial is a polynomial in \(w\) of degree \(m-1\le d\). Equality requires \(k=c=d\) and both ends singleton. Each nonsingleton run is then exactly one vertical domino. It offers two left attachment levels and two right attachment levels, giving a total factor \(4^d\) against a degree-\(d\) binomial with leading coefficient \(1/d!\). This proves the assertion.

## Verification

[verify.py](verify.py) independently generates every fixed polyomino up to area ten by adding boundary-adjacent cells and quotienting by translations. The [Lean proof](Polyomino.lean) establishes the formula for all \(n\ge5\) from a weighted enumeration of interval-column placements: for every allowed next excess \(q\), a column of height \(h\) has \(h+q\) possible offsets to the next column of height \(1+q\). The reduction from edge-connected cell sets to these placements is proved in the text.
