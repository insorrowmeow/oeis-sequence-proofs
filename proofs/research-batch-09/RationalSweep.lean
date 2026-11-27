import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace RationalSweep
open Finset

/-- Value sitting in the current vector cell before it updates the next cell. -/
def carry (i : ℕ) (v : ℕ → ℕ) : ℕ → ℕ
  | 0 => v 0
  | j+1 => i*carry i v j + v (j+1)

def sweep (i : ℕ) (v : ℕ → ℕ) (j : ℕ) := i*carry i v j + carry i v (j+1)

theorem convolution (i : ℕ) (v : ℕ → ℕ) (j : ℕ) :
    carry i v j = ∑ h ∈ range (j+1), i^(j-h)*v h := by
  induction j with
  | zero => simp [carry]
  | succ j ih =>
    rw [carry, ih, mul_sum]
    conv_rhs => rw [sum_range_succ]
    simp only [Nat.sub_self, pow_zero, one_mul]
    congr 1
    apply sum_congr rfl
    intro h hh
    have le : h ≤ j := Nat.le_of_lt_succ (mem_range.mp hh)
    rw [show j+1-h=j-h+1 by omega, pow_succ]
    ring

theorem rowFormula (i : ℕ) (v : ℕ → ℕ) (j : ℕ) :
    sweep i v j = v (j+1) + 2*(∑ h ∈ range (j+1), i^(j-h+1)*v h) := by
  simp only [sweep, carry, convolution i v j, pow_succ]
  have e : (∑ h ∈ range (j+1), i^(j-h)*i*v h) =
      i*(∑ h ∈ range (j+1), i^(j-h)*v h) := by
    rw [mul_sum]
    apply sum_congr rfl
    intros; ring
  rw [e]; ring

def nextSeries (i : ℕ) (v : ℕ → ℕ) : ℕ → ℕ
  | 0 => v 0
  | j+1 => sweep i v j

/-- Coefficient equation for (1-i*x) nextSeries = (1+i*x) v,
written without subtraction so it holds in natural numbers. -/
theorem rationalStep (i : ℕ) (v : ℕ → ℕ) (j : ℕ) :
    nextSeries i v (j+1) = i*nextSeries i v j + v (j+1) + i*v j := by
  cases j with
  | zero => simp [nextSeries, sweep, carry]; ring
  | succ j => simp [nextSeries, sweep, carry]; ring

end RationalSweep
