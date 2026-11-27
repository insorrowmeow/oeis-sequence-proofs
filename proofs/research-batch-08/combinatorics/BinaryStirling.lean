import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace BinaryStirling

def falling (x : ℚ) : ℕ → ℚ
  | 0 => 1
  | j+1 => (x-j)*falling x j

private theorem falling_succ (x : ℚ) (j : ℕ) : falling x (j+1)=(x-j)*falling x j := rfl

private theorem shift (x : ℚ) (i : ℕ) : falling x (i+1)=x*falling (x-1) i := by
  induction i with
  | zero => simp [falling]
  | succ i ih => rw [falling_succ x (i+1),ih,falling_succ (x-1) i]; push_cast; ring

theorem fall_mul (x : ℚ) (j : ℕ) :
    x*falling x j=falling x (j+1)+j*falling x j := by rw [falling]; ring

theorem fall_difference (x : ℚ) (j : ℕ) :
    falling x (j+1)-falling (x-1) (j+1)=(j+1)*falling (x-1) j := by
  rw [shift x j,falling_succ (x-1) j]
  ring

/-- Contribution of a single old coefficient multiplying (x-1)_(j+1).
    Multiplying its transformed polynomial by x-1 clears the common factor. -/
theorem even_basis (x : ℚ) (j : ℕ) :
    (x-1)*x^2*(falling (x-1) (j+1)-falling (x-2) (j+1)) =
      x*(j+1)*falling x (j+2) := by
  have hd := fall_difference (x-1) j
  rw [show x-1-1=x-2 by ring] at hd
  rw [hd,shift x (j+1), shift (x-1) j,show x-1-1=x-2 by ring]
  ring

theorem even_row_identity (x : ℚ) (v : ℕ → ℚ) (d : ℕ) :
    (x-1)*x^2* (∑ j ∈ Finset.range d, v j*
      (falling (x-1) (j+1)-falling (x-2) (j+1))) =
      ∑ j ∈ Finset.range d, v j*(x*(j+1)*falling x (j+2)) := by
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j _
  rw [← even_basis]
  ring

/-- Coefficient comparison in the even-row identity, solved for the next
    A358612 coefficient, including the denominator j-1. -/
theorem even_coefficient {j prev next old lower : ℚ} (hj : j ≠ 1) :
    prev+(j-1)*next=j*(j-1)*old+(j-2)*lower ↔
      next=j*old+lower-(prev+lower)/(j-1) := by
  have hn : j-1≠0 := sub_ne_zero.mpr hj
  constructor <;> intro h <;> field_simp [hn] at h ⊢ <;> linarith

end BinaryStirling
