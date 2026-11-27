# Exactly \(F_k\) double eigenvalues on the Fibonacci-weighted cycle of length \(4F_k\)

[OEIS A401899](https://oeis.org/A401899) asks for the number \(a(n)\) of distinct eigenvalues of the Laplacian of the cycle whose first \(n\) edges have the weights of the infinite Fibonacci word. The letters \(A,B\) have weights 1 and 2. The entry conjectures the exact formula \(a(4F_k)=3F_k\) for \(k\ge4\), and proposes a separate description of exceptions at other lengths.

**Theorem.** For every \(k\ge4\), exactly \(F_k\) eigenvalues at length \(4F_k\) have multiplicity two and all other eigenvalues are simple. This proves the stated infinite-family formula. It holds also for any two distinct positive real edge weights.

## Transfer matrices and Fibonacci blocks

Let \(w_i>0\) be the weight of edge \(i\to i+1\), \(r_i=1/w_i\), and \(p_{i-1}=w_{i-1}(u_i-u_{i-1})\). The eigenvalue equation is \(p_i=p_{i-1}-\lambda u_i\), followed by \(u_{i+1}=u_i+r_i p_i\). The column state \((u_i,p_{i-1})^\top\) is thus multiplied by the transpose of
\[
 M_r=\begin{pmatrix}1-\lambda r&-\lambda\\r&1\end{pmatrix},\qquad \det M_r=1 .
\]
Use the transposes to multiply matrices in word order: \(M_{UV}=M_U M_V\) is the transpose of the monodromy. The cycle's eigenspace has dimension two exactly when this product is the identity; it always has dimension at most two. The Laplacian is real symmetric, so these dimensions are algebraic multiplicities.

Let \(\sigma(A)=AB,\ \sigma(B)=A\). The infinite word begins \((ABA)^2(BAA)^2\). Applying \(\sigma^{k-4}\) gives a prefix \(X^2Y^2\), with \(X=PQP,\ Y=QPP,\ P=\sigma^{k-4}(A),\ Q=\sigma^{k-4}(B)\). Both \(X,Y\) have length \(L=F_k\), since \(|\sigma^j(A)|=F_{j+2}\), \(|\sigma^j(B)|=F_{j+1}\). Below the same letters denote the transfer matrices. Write \(U=P,\ V=QP\). Then \(X=UV,\ Y=VU\), with common trace \(t\). If \(t=0\), Cayley–Hamilton gives \(X^2=Y^2=-I\). The full product equals \(I\).

## Exclusion of any other double eigenvalue

Suppose \(X^2Y^2=I\) and \(t\ne0\). Cayley–Hamilton gives \(X^2=tX-I\) and \(Y^{-2}=(t^2-1)I-tY\). Comparing shows \(X+Y=tI\), hence \(Y=X^{-1}\). From \(UVVU=I\) we get \(V^2=U^{-2}\).

If this common square is nonscalar, its centralizer in the full two-by-two matrix algebra is commutative. Indeed a nonscalar matrix \(S\) has a vector \(v\) for which \(v,Sv\) are independent, and a matrix commuting with \(S\) is determined by its value on \(v\), hence is of the form \(aI+bS\). Both \(U,V\) then commute. If the common square is scalar, a nonscalar determinant-one matrix with scalar square has trace zero and square \(-I\), again by Cayley–Hamilton. Consequently either \(U,V\) commute (in particular if either is scalar), or both have trace zero.

The first case implies \(P,Q\) commute because \(U=P,\ V=QP\). The substitution on matrix pairs is \((P_0,Q_0)\mapsto(P_0Q_0,P_0)\). Commutation of an updated pair implies commutation of the preceding pair, by cancellation of \(P_0\). Thus at the base the two letter matrices must commute. Their upper-left entries in the two product orders differ by \(\lambda(r_A-r_B)\). With distinct weights this forces \(\lambda=0\), whose eigenspace on a connected positively weighted cycle consists only of constants (use the sum-of-squares energy). It cannot be a double eigenvalue.

In the second case the triple \((x,y,z)=(\operatorname{tr}P,\operatorname{tr}Q,\operatorname{tr}(PQ))\) has \(x=z=0\) because \(\operatorname{tr}V=\operatorname{tr}(QP)=z\). Under substitution the triple updates as \((x,y,z)\mapsto(z,x,xz-y)\); the inverse is \((a,b,c)\mapsto(b,ab-c,a)\). Having at least two zero entries is preserved by that inverse. At the base the triple is
\[
 2-\lambda r_A,\quad 2-\lambda r_B,\quad
 2-2\lambda(r_A+r_B)+\lambda^2 r_A r_B .
\]
The first two cannot vanish simultaneously. If either vanishes, the last equals \(-2\). The base triple thus cannot contain two zeros. This excludes the second case, establishing that double eigenvalues occur exactly at \(t(\lambda)=0\).

## Counting the roots without a genericity assumption

Take the length-\(L\) block \(X\) and impose the complex boundary condition \(u_{i+L}=\mathrm i u_i\), with the weights periodically extended. The resulting \(L\)-dimensional Laplacian is Hermitian: the wrap-around entries use the conjugate phases \(\mathrm i\) and \(-\mathrm i\), and all interior weights are real. The two-state recurrence identifies its eigenspace with the \(\mathrm i\)-eigenspace of the untransposed monodromy. Since its determinant is one, whenever \(\mathrm i\) is an eigenvalue the other is \(-\mathrm i\), and the eigenspace is one-dimensional. Hence the twisted problem has exactly \(L\) distinct real eigenvalues. They are exactly the zeros of \(\operatorname{tr} X\), since a determinant-one two-by-two matrix has eigenvalue \(\mathrm i\) exactly when its trace is zero.

There are therefore exactly \(L\) double eigenvalues on the \(4L\)-cycle. The number of distinct eigenvalues is \(4L-L=3L\). The assertion in the entry about all other lengths is a separate question.

## Formal and computational checks

[FibonacciBlocks.lean](FibonacciBlocks.lean) gives the prefix of the actual infinite word for all indices. [Transfer.lean](Transfer.lean) formalizes the trace criterion for determinant-one matrices, its specialization to distinct edge weights, and the exclusion of a second zero under Fibonacci substitution. The argument via the twisted Hermitian spectrum is written above.

The [optional exact scan](check_spectrum.py), run at limit 10,000, reports only lengths 33, 53 and 106 outside the \(4F_k\) family with repeated eigenvalues. In all three cases the polynomial GCD over the integers is \(x-1\). The program multiplies the integral matrices \(w M_{1/w}\). After division by the accumulated weight product the resulting matrix is the monodromy transpose. Any double eigenvalue annihilates all four entries of its difference from identity. For weights 1 and 2 its monic minimal polynomial has integer coefficients, since it is an eigenvalue of an integral matrix. Consequently a nonconstant common factor must remain nonconstant after reduction modulo 65537, and the weight product is invertible there. All surviving candidates outside the family are checked over the integers. This finite scan supplies evidence about other lengths.
