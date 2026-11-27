import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Data.Real.Basic

/-! In the first admissible dimension the limiting density is a quartic
cardinal spline. These are its two derivatives in the truncated-power formula
of the manuscript. All inequalities below hold throughout real intervals. -/

namespace FiveRowProfile

private def signedSum (x : ℝ) (k : ℕ) : ℝ :=
  max x 0 ^ k - 5 * max (x-1) 0 ^ k + 10 * max (x-2) 0 ^ k -
  10 * max (x-3) 0 ^ k + 5 * max (x-4) 0 ^ k - max (x-5) 0 ^ k

noncomputable def slope (x : ℝ) : ℝ := signedSum x 3 / 6
noncomputable def curvature (x : ℝ) : ℝ := signedSum x 2 / 2

private theorem middle (x : ℝ) (hx : 2 ≤ x) (hy : x ≤ 3) (k : ℕ) (hk : k ≠ 0) :
    signedSum x k = x ^ k - 5 * (x-1) ^ k + 10 * (x-2) ^ k := by
  simp [signedSum, max_eq_left (show 0 ≤ x by linarith),
    max_eq_left (show 0 ≤ x-1 by linarith), max_eq_left (show 0 ≤ x-2 by linarith),
    max_eq_right (show x-3 ≤ 0 by linarith), max_eq_right (show x-4 ≤ 0 by linarith),
    max_eq_right (show x-5 ≤ 0 by linarith), zero_pow hk]

/-- Negative margin of the limiting second difference on [9/4,11/4]. -/
theorem central_curvature {x : ℝ} (hx : 9/4 ≤ x) (hy : x ≤ 11/4) :
    curvature x ≤ -(17/16) := by
  rw [curvature, middle x (by linarith) (by linarith) 2 (by decide)]
  nlinarith [mul_nonneg (show 0 ≤ x-9/4 by linarith) (show 0 ≤ 11/4-x by linarith)]

/-- Positive margin of the limiting first difference on [1,9/4]. -/
theorem left_slope {x : ℝ} (hx : 1 ≤ x) (hy : x ≤ 9/4) : 1/16 ≤ slope x := by
  by_cases h : x ≤ 2
  · have c := pow_le_pow_left₀ (show 0 ≤ x-1 by linarith) (show x-1 ≤ x/2 by linarith) 3
    have d := pow_le_pow_left₀ (show (0 : ℝ) ≤ 1 by exact zero_le_one) hx 3
    simp [slope, signedSum, max_eq_left (show 0 ≤ x by linarith),
      max_eq_left (show 0 ≤ x-1 by linarith), max_eq_right (show x-2 ≤ 0 by linarith),
      max_eq_right (show x-3 ≤ 0 by linarith), max_eq_right (show x-4 ≤ 0 by linarith),
      max_eq_right (show x-5 ≤ 0 by linarith)]
    nlinarith
  · rw [slope, middle x (by linarith) (by linarith) 3 (by decide)]
    have hc := pow_le_pow_left₀ (show 0 ≤ 5/2-x by linarith) (show 5/2-x ≤ 1/2 by linarith) 2
    have hprod := mul_nonneg (show 0 ≤ 5/2-x by linarith)
      (show 0 ≤ (1/4) - (5/2-x)^2 by nlinarith)
    nlinarith

end FiveRowProfile
