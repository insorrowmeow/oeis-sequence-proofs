# The in-place algorithm for labeled mobiles (A032188)

The algorithm in MathOverflow 492609 computes every coefficient of the exponential generating function for series-reduced labeled mobiles. The question was posted on May 14, 2025. The Stack Exchange API returned zero answers when checked. [Original algorithm](https://mathoverflow.net/questions/492609/fast-and-simple-algorithm-for-a032188) · [OEIS A032188](https://oeis.org/A032188)

Let \(Y(z)=2z+\log(1-z)\) and let \(A\) be its compositional inverse at zero. Then \(Y(0)=0\), \(Y'(0)=1\), and the defining equation of A032188 is \(Y(A(x))=x\). Its \(i\)th positive-index term is \(A^{(i)}(0)\).

Before the outer loop at index \(i\), write the current vector starting at position \(i\) as the series \(F_i(z)=\sum_{l\ge0}f_lz^l\), where \(f_l=\nu_{i+l}\). Let \(G_i(z)=\sum_{l\ge0}g_lz^l\) encode the same positions just after that loop. The index \(i\) itself stays fixed. For every \(l\ge1\), the accumulator is \(g_0+\cdots+g_{l-1}\) because the entries to the left have already been updated. The two cases together say

\[
 g_l=(l+1)f_l+\sum_{q=0}^{l-1} g_q,\qquad l\ge0.
\]

Summing over \(l\) yields

\[
 G_i=(zF_i)'+\frac{z}{1-z}G_i,
 \qquad G_i=\frac{1-z}{1-2z}(zF_i)'.
\]

The next iteration starts one slot to the right, so \(zF_{i+1}=G_i-F_i(0)\). Put \(H_i=zF_i\) and introduce the differential operator \(D=(Y'(z))^{-1}d/dz\). Then

\[
 H_1=z,\quad F_i(0)=(DH_i)(0),\quad H_{i+1}=DH_i-(DH_i)(0).
\]

For formal series \(H\), composition with \(A\) converts \(D\) into ordinary differentiation, since \(A'(x)Y'(A(x))=1\). Constants disappear upon taking the next derivative. Therefore \(F_i(0)=(D^i z)(0)=A^{(i)}(0)\). This is precisely the value left in slot \(i\). The calculation with infinite series applies to each finite input vector: any updated coordinate depends only on the old prefix ending at that coordinate, so extending the vector cannot affect an earlier entry.
