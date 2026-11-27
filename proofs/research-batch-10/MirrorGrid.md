# A product formula for labeled rectangular single-loop mirror placements

Let $T(n,k)$ be the number of single-loop placements of the two-sided mirrors of [A400778](https://oeis.org/A400778) on an $n$-by-$k$ rectangular array of dots, with $n,k\ge1$. Each interior side independently has a mirror or is left open; all exterior sides reflect. Rotations and reflections of a placement are counted separately whenever their labeled edge subsets differ. This is the edge-aligned specialization of [Jablan's mirror-curve setting](https://archive.bridgesmathart.org/2001/bridges2001-233.pdf), summed over mirror counts. His broader model also permits mirrors perpendicular to an edge at its midpoint.

**Theorem.** With $b=(n-1)(k-1)$,
$$
T(n,k)=4^b\prod_{1\le i<n/2}\prod_{1\le j<k/2}
\left(1-\cos^2(\pi i/n)\cos^2(\pi j/k)\right).
$$
Consequently $T(n,k)\le4^b$, with equality exactly when $\min(n,k)\le2$. The five fixed-width conjectures for widths 2 through 6 are also verified for every length below.

## Orienting the mirror curves

Take the ordinary rectangular grid graph $G$ on the dots, embedded in the plane. Make a ribbon graph by taking a disk at each vertex and prescribing the **plane** cyclic order of its edges on black disks and the **reverse** order on white disks, using the grid's checkerboard coloring. Join disks along selected edges by untwisted bands in this oriented rotation system. A band is selected exactly at a midpoint without a mirror. To see the boundary correspondence, orient each disk rim by its chosen order. In the absence of a band each of the two incoming arcs leaves along the same disk; this is reflection. A band exchanges their outgoing arcs. On opposite sides of a vertical interface, a clockwise disk on the left runs from its upper quadrant to its lower quadrant and a counterclockwise disk on the right also runs from upper to lower. Exchanging the exits gives straight-through transmission. Rotating this local picture handles horizontal interfaces and reversing both orientations leaves the two pairings unchanged. Thus the boundary curves are precisely the optical loops. An isolated disk contributes a loop. A single loop requires the spanning ribbon subgraph to be connected, and conversely connected spanning subgraphs with one boundary component give exactly the desired placements.

## A cycle-basis determinant

Use one counterclockwise facial cycle for each of the $b$ bounded unit grid faces, always counterclockwise **in the original plane**. These form an integral basis of the graph cycle lattice: recursively subtract the winding coefficient on faces, or use the unique integral 2-chain filling a grid cycle in the grid rectangle. Write $C$ for their signed edge-incidence rows and $J$ for their skew-symmetric oriented intersection matrix in the full ribbon surface (the surface retracts onto the graph). Then
$$
T(n,k)=\det(J+CC^\mathsf{T}).
$$
Here is a derivation. In $\det(J+\sum_e t_e c_e c_e^\mathsf{T})$ each edge variable occurs at most linearly, by multilinearity in columns, where $c_e$ is column $e$ of $C$. For a set $D$ of deleted edges its monomial coefficient is
$$
\det\begin{pmatrix}J&C_D\\-C_D^\mathsf{T}&0\end{pmatrix}.
$$
For example, this follows by expanding $\det\left(\begin{smallmatrix}J&C\\-C^\mathsf{T}&\operatorname{diag}(z_e)\end{smallmatrix}\right)$ first by its diagonal variables and then by the Schur complement, putting $t_e=z_e^{-1}$.

If $G-D$ is disconnected, the map from cycles to their coordinates on $D$ has deficient rank: conservation across a cut whose edges all lie in $D$ supplies a dependence. Otherwise take a spanning tree of $G-D$ and its fundamental cycle basis for $G$. The cycles for edges in $D$ give an identity block on $D$; all the other cycles form an integral basis of cycles in $G-D$. Changing basis is unimodular. Expanding the bordered determinant on the identity block leaves the determinant of the restriction of $J$ to cycles in $G-D$, with positive sign (each hyperbolic pair in the bordered block has determinant one). Intersections can be computed inside that subgraph's regular neighborhood, which embeds in the full surface, so this restriction is precisely its surface intersection form. For a connected orientable surface of genus $g$ with $h$ boundary components, the standard handle and boundary basis gives $g$ symplectic pairs and a radical of rank $h-1$. Thus the coefficient is one for a single boundary and zero otherwise, including determinant one in rank zero. Setting all $t_e=1$ proves the identity. Related general determinant theory: [the critical group of orientable ribbon graphs, Matrix–Quasi-tree Theorem](https://pure.royalholloway.ac.uk/files/66272519/The_critical_group_of_orientable_ribbon_graphs-3.pdf).

## Computing the face matrix

The Gram matrix $CC^\mathsf{T}$ has diagonal four, entry minus one across each common grid edge, and zero elsewhere. For $J$, faces meeting only at a vertex have zero intersection: their two pairs of halfedges do not alternate in the plane cyclic order, nor in its reverse, so their arcs inside that disk can be made disjoint. Disjoint faces also have zero intersection.

Two edge-adjacent faces have intersection of magnitude one. Take a thin disk neighborhood of their shared edge, including small pieces of the disks at its ends. The two face paths have four distinct terminals on this neighborhood. In the original planar rotation, their terminals do not alternate and the paths can be made disjoint. At exactly one end of the shared edge the rotation has been reversed. This reverses the order of the two external terminals at that end relative to the band attachment. At the other end the order stays the same. Thus the terminals now alternate, and the paths can be routed with exactly one transverse intersection inside the neighborhood. The rest of the two paths are disjoint. This proves $J_{fg}=\pm1$.

The sign is invariant under oriented rotations/translations of a shared edge and its attached two faces that respect the checkerboard colors and the order $f,g$; the small crossing just described determines it locally, even at the grid boundary. Equivalently, orient a shared edge in the direction in which the first face $f$ traverses it. All ordered face pairs with a black starting vertex are isomorphic in this local oriented picture. Interchanging the faces reverses the edge, switches this color, and negates $J_{fg}$. Therefore $J+CC^\mathsf T=4I-2A$, where one color of the checkerboard of **faces** has horizontal outgoing neighbors and the other has vertical outgoing neighbors. Indeed the starting corners for the two horizontal steps of a counterclockwise face boundary have one color, and its two vertical steps start in the other color. Missing exterior neighbors contribute no off-diagonal entry. The global sign convention may transpose $A$, which preserves the determinant.

## Diagonalization

Put $u=n-1,v=k-1$. The matrix $A$ is bipartite, hence $\det(I-A/2)=\det(I+A/2)$. Two successive steps from any face consist of one horizontal and one vertical unit step, their order dictated by the starting color. Thus $A^2=P_u\otimes P_v$, with $P_j$ the undirected adjacency matrix of the path of length $j-1$ on $j$ vertices. Each allowable diagonal neighbor is reached in exactly one way, because rectangular intervals contain the intermediate face. The sine eigenvectors of $P_u,P_v$ yield
$$
 \det(I-A/2)^2=\det(I-A^2/4)
 =\prod_{i=1}^{n-1}\prod_{j=1}^{k-1}(1-\cos(\pi i/n)\cos(\pi j/k)).
$$
Pair $i$ with $n-i$ and $j$ with $k-j$. A quadruple contributes $(1-\cos^2(\pi i/n)\cos^2(\pi j/k))^2$, and unpaired middle indices have cosine zero. The positive square root is selected since a spanning tree is always a one-boundary subgraph. This proves the stated product, including the empty determinant when a side is one. Every displayed nonempty factor is strictly between zero and one, giving the precise equality statement.

## An independent all-length proof for the five strip recurrences

[MirrorFaceSteps.lean](MirrorFaceSteps.lean) verifies the entrywise two-step adjacency identity used above. It proves that every two-step route has a unit displacement in each coordinate and that every such diagonal pair of vertices inside the rectangle has precisely one intermediate vertex inside it. The determinant and surface-topology arguments are provided in the written proof.

[Exact Python certificate](mirror_transfer.py) uses only permutations and integer arithmetic. Cut at the $n$ east-facing ports of a partial strip. Until a closed component has formed, each such port leads by a directed strand to another; the state is their successor permutation. Adding a cell appends its four-port cycle. At a seam with a preceding cell either retain the two successors (mirror) or transpose them (transmission), then suppress all ports which have become internal. Discard any state in which an entire cycle disappears in this operation, since it is permanently sealed while the frontier still contains the new east port. Exterior ports are suppressed without any exchange. Each possible placement is generated once. After the last strip, closing the right border leaves the cycles of the frontier permutation, so the acceptance test is exactly that it has one cycle. Invert the frontier permutation at every strip boundary to normalize alternating column orientations; this is reversal of all strand directions, and ensures a single time-independent linear update $L$ on at most $n!$ states after the first column.

For $n=2,3,4,5,6$, the certificate checks $n!$ consecutive zeros of each proposed recurrence residual starting at its claimed first index. This proves every later zero by Cayley–Hamilton: for $s$ at or after that index, each term in the scalar residual is a fixed linear functional of $L^{s-s_0}$ times a fixed vector, so the residual itself satisfies the same monic characteristic recurrence of degree $n!$. In width three the checked recurrence is $t_k=16t_{k-1}-16t_{k-2}$ with first values $1,16$, exactly $4^{k-1}\mathrm{A001353}(k)$ since that sequence starts $0,1$ and satisfies $a_k=4a_{k-1}-a_{k-2}$. Width two starts at 1 and multiplies by 4. The remaining three recurrence coefficient lists and starting indices are given verbatim in the certificate. These results are backed by written mathematics and reproducible exact code. No external peer review or global priority check has been established.
