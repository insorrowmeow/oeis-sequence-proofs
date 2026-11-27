import Mathlib.Algebra.Polynomial.Roots
import Mathlib.RingTheory.PowerSeries.Basic

namespace Voloshyn
open PowerSeries

noncomputable section
variable {K : Type*} [Field K]

/-- One plus z times the generating series of positive-indexed rows. -/
def rowBranch (rows : ℕ → Polynomial K) (z : K) : PowerSeries K :=
  mk fun n => match n with
    | 0 => 1
    | m+1 => z*(rows (m+1)).eval z

@[simp] theorem rowBranch_succ (rows : ℕ → Polynomial K) (z : K) (m : ℕ) :
    coeff K (m+1) (rowBranch rows z)=z*(rows (m+1)).eval z := by
  simp [rowBranch]

/-- Polynomial specialization holds at the two exceptional weight values as well. -/
theorem row_polynomial_eq [Infinite K] (p q : Polynomial K)
    (h : ∀ z : K, z≠0 → z≠1 → z*p.eval z=z*q.eval z) : p=q := by
  apply Polynomial.eq_of_infinite_eval_eq
  have finitePair : ({0,1} : Set K).Finite := (Set.finite_singleton 1).insert 0
  apply finitePair.infinite_compl.mono
  intro z hz
  have hn : z≠0 ∧ z≠1 := by simpa using hz
  exact mul_left_cancel₀ hn.1 (h z hn.1 hn.2)

#print axioms row_polynomial_eq
end
end Voloshyn
