import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Linarith

namespace AlexanderssonRows

noncomputable section

open Polynomial
abbrev R := Polynomial ℤ
local notation "t" => (X : R)

/-- Row-reversed second-order Eulerian polynomials, with A201637 indexing. -/
def eulerian : ℕ → R
  | 0 => 1
  | j+1 => ((j : R) * (1+t) + t) * eulerian j +
      t * (1-t) * derivative (eulerian j)

/-- n applications of the shifted difference f(s+1) - t f(s). -/
def block : ℕ → ℕ → R
  | 0, s => eulerian s
  | n+1, s => block n (s+1) - t * block n s

def row (n : ℕ) := block n 0

private theorem binomial_step (n : ℕ) (f : ℕ → R) :
    ∑ j ∈ Finset.range (n+2), ((n+1).choose j:R)*f j =
      (∑ j ∈ Finset.range (n+1), (n.choose j:R)*f (j+1)) +
      ∑ j ∈ Finset.range (n+1), (n.choose j:R)*f j := by
  conv_lhs => rw [Finset.sum_range_succ']
  simp only [Nat.choose_succ_succ, Nat.cast_add, add_mul, Finset.sum_add_distrib,
    Nat.choose_zero_right, Nat.cast_one, one_mul]
  have h : (∑ j ∈ Finset.range (n+1), (n.choose (j+1):R)*f (j+1)) + f 0 =
      ∑ j ∈ Finset.range (n+1), (n.choose j:R)*f j := by
    conv_lhs => rw [Finset.sum_range_succ]
    conv_rhs => rw [Finset.sum_range_succ']
    simp
  linear_combination h

/-- Explicit signed binomial transform in the definition of A395454. -/
theorem binomial_transform (n s : ℕ) :
    block n s = ∑ j ∈ Finset.range (n+1),
      (n.choose j:R)*(-t)^(n-j)*eulerian (s+j) := by
  induction n generalizing s with
  | zero => simp [block]
  | succ n ih =>
    change block n (s+1) - t*block n s = _
    rw [ih (s+1), ih s]
    simp_rw [mul_assoc]
    rw [binomial_step, Finset.mul_sum]
    apply congrArg₂ (· + ·)
    · apply Finset.sum_congr rfl
      intro j hj
      simp [Nat.add_assoc, Nat.add_comm 1 j]
    · rw [← Finset.sum_neg_distrib]
      apply Finset.sum_congr rfl
      intro j hj
      have h : n+1-j = (n-j)+1 := by
        have := Finset.mem_range.mp hj
        omega
      rw [h, pow_succ]
      ring

theorem block_one (s : ℕ) :
    block 1 s = (s : R)*(1+t)*block 0 s + t*(1-t)*derivative (block 0 s) := by
  simp only [block, eulerian]
  ring

theorem block_recurrence (n s : ℕ) :
    block (n+2) s = ((s : R) + n + 1)*(1+t)*block (n+1) s +
      t*(1-t)*derivative (block (n+1) s) + 2*((n : R)+1)*t*block n s := by
  induction n generalizing s with
  | zero =>
    change block 1 (s+1) - t*block 1 s = _
    conv_lhs => rw [block_one (s+1), block_one s]
    simp only [Nat.cast_zero, Nat.cast_succ, zero_add, add_zero]
    change _ = ((s:R)+1)*(1+t)*(block 0 (s+1) - t*block 0 s) +
      t*(1-t)*derivative (block 0 (s+1) - t*block 0 s) + 2*1*t*block 0 s
    simp only [map_sub, derivative_mul, derivative_X]
    ring
  | succ n ih =>
    change block (n+2) (s+1) - t*block (n+2) s = _
    conv_lhs => rw [ih (s+1), ih s]
    change _ = ((s:R)+(n+1:ℕ)+1)*(1+t)*(block (n+1) (s+1) - t*block (n+1) s) +
      t*(1-t)*derivative (block (n+1) (s+1) - t*block (n+1) s) +
      2*((n+1:ℕ)+1:R)*t*(block n (s+1) - t*block n s)
    simp only [Nat.cast_succ, map_sub, derivative_mul, derivative_X]
    have hb : block (n+1) s = block n (s+1) - t*block n s := rfl
    linear_combination 2*t*hb

theorem corrected (n : ℕ) :
    row (n+2) = ((n:R)+1)*(1+t)*row (n+1) + t*(1-t)*derivative (row (n+1)) +
      2*((n:R)+1)*t*row n := by
  simpa only [row, Nat.cast_zero, zero_add] using block_recurrence n 0

theorem row_zero : row 0 = 1 := rfl
theorem row_one : row 1 = 0 := by
  simp [row, block, eulerian]

private def mass (n : ℕ) : ℤ := (row n).eval 1

private theorem mass_rec (n : ℕ) :
    mass (n+2) = 2*((n:ℤ)+1)*(mass (n+1)+mass n) := by
  simp only [mass, corrected, eval_add, eval_mul, eval_sub, eval_natCast, eval_ofNat,
    eval_one, eval_X, sub_self, mul_zero, zero_mul, add_zero, mul_one]
  ring

private theorem mass_positive_pair (n : ℕ) :
    0 ≤ mass (n+1) ∧ 0 < mass (n+1) + mass n := by
  induction n with
  | zero => simp [mass, row_zero, row_one]
  | succ n ih =>
    rw [mass_rec]
    have hn : 0 < 2*((n:ℤ)+1) := by positivity
    have hp := mul_pos hn ih.2
    exact ⟨le_of_lt hp, add_pos_of_pos_of_nonneg hp ih.1⟩

/-- With the published coefficients, equality fails in every row of index >= 2. -/
theorem printed_fails_every_row (n : ℕ) :
    row (n+2) ≠ (n:R)*(1+t)*row (n+1) + t*(1-t)*derivative (row (n+1)) +
      2*(n:R)*t*row n := by
  intro h
  have he := congrArg (fun p : R => p.eval 1) h
  simp only [eval_add, eval_mul, eval_sub, eval_natCast, eval_ofNat, eval_one, eval_X, sub_self,
    mul_zero, zero_mul, add_zero, mul_one] at he
  change mass (n+2) = _ at he
  rw [mass_rec] at he
  change _ = (n:ℤ)*(1+1)*mass (n+1) + 2*(n:ℤ)*mass n at he
  nlinarith [he, (mass_positive_pair n).2]

theorem printed_counterexample :
    row 2 ≠ ((2:R)-2)*(1+t)*row 1 + t*(1-t)*derivative (row 1) +
      (2*2-4)*t*row 0 := by
  rw [corrected 0, row_zero, row_one]
  norm_num

#print axioms corrected
#print axioms binomial_transform
#print axioms printed_fails_every_row
#print axioms printed_counterexample

end
end AlexanderssonRows
