import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace KageyA334386

private theorem split_three (u : ℤ) :
    ∃ a : ℤ, u = 3*a ∨ u = 3*a+1 ∨ u = 3*a+2 := by
  exact ⟨u/3, by omega⟩

private theorem reduce_three {u v w : ℤ} (h : 2*u^2 = 3*(v^2+w^2)) :
    ∃ a b c : ℤ, u=3*a ∧ v=3*b ∧ w=3*c := by
  obtain ⟨a, ha⟩ := split_three u
  obtain ⟨b, hb⟩ := split_three v
  obtain ⟨c, hc⟩ := split_three w
  refine ⟨a,b,c,?_⟩
  rcases ha with ha|ha|ha <;> rcases hb with hb|hb|hb <;> rcases hc with hc|hc|hc <;>
    rw [ha,hb,hc] at h ⊢ <;> ring_nf at h ⊢ <;> first | exact ⟨trivial,trivial,trivial⟩ | omega

/-- The homogeneous equation forced by a half-turn admits only the zero integral solution. -/
theorem anisotropic (u v w : ℤ) (h : 2*u^2 = 3*(v^2+w^2)) : u=0 ∧ v=0 ∧ w=0 := by
  generalize ht : u.natAbs = t
  induction t using Nat.strong_induction_on generalizing u v w with
  | h t ih =>
    obtain ⟨a,b,c,ha,hb,hc⟩ := reduce_three h
    by_cases zero : a=0
    · subst a
      have hu : u=0 := by omega
      rw [hu] at h
      exact ⟨hu,by nlinarith [sq_nonneg w, sq_nonneg v],
        by nlinarith [sq_nonneg v, sq_nonneg w]⟩
    · have pos : 0 < a.natAbs := Int.natAbs_pos.mpr zero
      have lt : a.natAbs < t := by
        rw [← ht,ha,Int.natAbs_mul]
        change a.natAbs < 3*a.natAbs
        omega
      rw [ha,hb,hc] at h
      have small : 2*a^2 = 3*(b^2+c^2) := by nlinarith only [h]
      obtain ⟨h0,_,_⟩ := ih a.natAbs lt a b c small rfl
      exact (zero h0).elim

/-- If an equilateral triangle in the sum-constant hyperplane has its apex fixed
    and its other two vertices exchanged by (12)(34), the exchanged points coincide. -/
theorem half_turn (a b e f c d : ℤ) (plane : a+b+e+f=2*c+2*d)
    (equilateral : 2*(a-b)^2+2*(e-f)^2 = (a-c)^2+(b-c)^2+(e-d)^2+(f-d)^2) :
    a=b ∧ e=f := by
  have hf : f=2*c+2*d-a-b-e := by omega
  rw [hf] at equilateral
  have equation : 2*(2*c-a-b)^2 = 3*((a-b)^2+(e-f)^2) := by
    rw [hf]
    nlinarith only [equilateral]
  obtain ⟨_,h1,h2⟩ := anisotropic _ _ _ equation
  omega

#print axioms half_turn

end KageyA334386
