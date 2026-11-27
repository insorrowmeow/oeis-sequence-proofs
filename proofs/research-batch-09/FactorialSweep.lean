import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace FactorialSweep
open Finset

def carry (v : ℕ → ℚ) : ℕ → ℚ
  | 0 => v 0
  | j+1 => (j+1 : ℕ)*carry v j + v (j+1)

theorem normalized (v : ℕ → ℚ) (j : ℕ) :
    carry v j = (j.factorial : ℚ) *
      ∑ h ∈ range (j+1), v h / (h.factorial : ℚ) := by
  induction j with
  | zero => simp [carry]
  | succ j ih =>
    rw [carry, ih]
    conv_rhs => rw [sum_range_succ]
    rw [mul_add, show ((j+1).factorial : ℚ) * (v (j+1) / (j+1).factorial) =
      v (j+1) by
        have hn : ((j+1).factorial : ℚ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero (j+1)
        field_simp [hn]]
    rw [Nat.factorial_succ, Nat.cast_mul]
    ring

def sweep (v : ℕ → ℚ) (j : ℕ) := (j+1 : ℕ)*carry v j + carry v (j+1)

theorem row (v : ℕ → ℚ) (j : ℕ) :
    sweep v j = v (j+1) + 2*((j+1).factorial : ℚ) *
        ∑ h ∈ range (j+1), v h / (h.factorial : ℚ) := by
  simp only [sweep, carry, normalized v j, Nat.factorial_succ, Nat.cast_mul]
  ring

/-- Derivative and left multiplication can alternate on arbitrary coefficients. -/
theorem conjugate {α : Type*} (D H : α → α) (e : α) (he : D e = e) (n : ℕ) :
    D ((H ∘ D)^[n] e) = (D ∘ H)^[n] e := by
  induction n with
  | zero => exact he
  | succ n ih =>
    rw [Function.iterate_succ_apply', Function.iterate_succ_apply']
    exact congrArg (D ∘ H) ih

end FactorialSweep
