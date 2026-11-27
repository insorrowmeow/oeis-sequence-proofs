import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace InvolutionPoles

-- Read the trailing principal determinants from the bottom of a Jacobi
-- matrix upwards. The first determinant is the empty determinant, equal to 1.
def continuant (diag edge : ℕ → ℝ) : ℕ → ℝ
  | 0 => 1
  | 1 => diag 0
  | n+2 => diag (n+1) * continuant diag edge (n+1) -
      edge n ^ 2 * continuant diag edge n

theorem cofactor_nonzero_at_zero (diag edge : ℕ → ℝ)
    (he : ∀ i, edge i ≠ 0) (n : ℕ)
    (h : continuant diag edge (n+1) = 0) : continuant diag edge n ≠ 0 := by
  induction n with
  | zero => simp [continuant]
  | succ n ih =>
    intro hz
    rw [continuant, hz, mul_zero, zero_sub, neg_eq_zero] at h
    have hprev := (mul_eq_zero.mp h).resolve_left (pow_ne_zero 2 (he n))
    exact ih hz hprev

-- The derivative of each scaled tail diagonal has this numerator
-- after multiplication by the positive factor s^(2*i+3).
theorem tail_sign (s : ℝ) (hs : 0 < s) (h1 : s < 1) (i : ℕ) :
    (1-s^2) * s^(2*i+1) - 4*(1-s^2)*s^2 -
      (2*(i:ℝ)+2)*(1-s^2)^2 < 0 := by
  by_cases hi : i = 0
  · subst i
    simp
    have hpos : 0 < 1-s^2 := by nlinarith [mul_pos (sub_pos.mpr h1) (by linarith : 0 < 1+s)]
    nlinarith [mul_pos hpos (show 0 < 2-s+2*s^2 by nlinarith [sq_nonneg s])]
  · have hpow : s^(2*i+1) ≤ s^2 := by
      exact pow_le_pow_of_le_one hs.le h1.le (by omega)
    have hpos : 0 < 1-s^2 := by nlinarith [mul_pos (sub_pos.mpr h1) (by linarith : 0 < 1+s)]
    have hprod := mul_le_mul_of_nonneg_left hpow hpos.le
    have hsq := mul_pos hpos (sq_pos_of_pos hs)
    have hz : 0 ≤ (2*(i:ℝ)+2)*(1-s^2)^2 := by positivity
    linarith

end InvolutionPoles
