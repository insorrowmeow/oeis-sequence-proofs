import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Exact interval margins for the first height beyond the prior cases
k = 5,6,7. The truncated-power formulas are the derivatives in (2) of
the manuscript, multiplied by 6! and 5!, respectively. -/

namespace EightRowProfile

def signedSum (x : ℝ) (d : ℕ) : ℝ :=
  max x 0 ^ d - 8 * max (x-1) 0 ^ d + 28 * max (x-2) 0 ^ d -
  56 * max (x-3) 0 ^ d + 70 * max (x-4) 0 ^ d - 56 * max (x-5) 0 ^ d +
  28 * max (x-6) 0 ^ d - 8 * max (x-7) 0 ^ d + max (x-8) 0 ^ d

private theorem left_piece (u : ℝ) (h : 0 ≤ u) (h' : u ≤ 1) :
    1 ≤ 1 + 6*u + 15*u^2 + 20*u^3 + 15*u^4 + 6*u^5 - 7*u^6 := by
  have h6 : u^6 ≤ u^2 := pow_le_pow_of_le_one h h' (by decide)
  linarith [pow_nonneg h 2, pow_nonneg h 3, pow_nonneg h 4, pow_nonneg h 5]

private theorem second_piece (u : ℝ) (h : 0 ≤ u) (h' : u ≤ 1) :
    1 ≤ 56 + 144*u + 120*u^2 - 60*u^4 - 36*u^5 + 21*u^6 := by
  have h4 : u^4 ≤ u^2 := pow_le_pow_of_le_one h h' (by decide)
  have h5 : u^5 ≤ u^2 := pow_le_pow_of_le_one h h' (by decide)
  linarith [pow_nonneg h 2, pow_nonneg h 6]

private theorem third_piece (u : ℝ) (h : 1/4 ≤ u) (h' : u ≤ 1) :
    1 ≤ 480*u - 320*u^3 + 120*u^5 - 35*u^6 := by
  have h0 : 0 ≤ u := by linarith
  have h3 : u^3 ≤ u^1 := pow_le_pow_of_le_one h0 h' (by decide)
  have h6 : u^6 ≤ u^5 := pow_le_pow_of_le_one h0 h' (by decide)
  simp only [pow_one] at h3
  linarith [pow_nonneg h0 5]

/-- g'_8(x) ≥ 1/720 throughout [1,15/4]. -/
theorem slope_margin {x : ℝ} (hx : 1 ≤ x) (hx' : x ≤ 15/4) : 1 ≤ signedSum x 6 := by
  by_cases h2 : x ≤ 2
  · have h := left_piece (x-1) (by linarith) (by linarith)
    simp [signedSum,
      max_eq_left (show 0 ≤ x by linarith),
      max_eq_left (show 0 ≤ x-1 by linarith),
      max_eq_right (show x-2 ≤ 0 by linarith),
      max_eq_right (show x-3 ≤ 0 by linarith),
      max_eq_right (show x-4 ≤ 0 by linarith),
      max_eq_right (show x-5 ≤ 0 by linarith),
      max_eq_right (show x-6 ≤ 0 by linarith),
      max_eq_right (show x-7 ≤ 0 by linarith),
      max_eq_right (show x-8 ≤ 0 by linarith)]
    nlinarith
  by_cases h3 : x ≤ 3
  · have h := second_piece (x-2) (by linarith) (by linarith)
    simp [signedSum,
      max_eq_left (show 0 ≤ x by linarith),
      max_eq_left (show 0 ≤ x-1 by linarith),
      max_eq_left (show 0 ≤ x-2 by linarith),
      max_eq_right (show x-3 ≤ 0 by linarith),
      max_eq_right (show x-4 ≤ 0 by linarith),
      max_eq_right (show x-5 ≤ 0 by linarith),
      max_eq_right (show x-6 ≤ 0 by linarith),
      max_eq_right (show x-7 ≤ 0 by linarith),
      max_eq_right (show x-8 ≤ 0 by linarith)]
    nlinarith
  · have h := third_piece (4-x) (by linarith) (by linarith)
    simp [signedSum,
      max_eq_left (show 0 ≤ x by linarith),
      max_eq_left (show 0 ≤ x-1 by linarith),
      max_eq_left (show 0 ≤ x-2 by linarith),
      max_eq_left (show 0 ≤ x-3 by linarith),
      max_eq_right (show x-4 ≤ 0 by linarith),
      max_eq_right (show x-5 ≤ 0 by linarith),
      max_eq_right (show x-6 ≤ 0 by linarith),
      max_eq_right (show x-7 ≤ 0 by linarith),
      max_eq_right (show x-8 ≤ 0 by linarith)]
    nlinarith

private theorem middle_bound (u : ℝ) (h : 0 ≤ u) (h' : u ≤ 1/4) :
    -80 + 160*u^2 - 100*u^4 + 35*u^5 ≤ -60 := by
  have h2 := pow_le_pow_left₀ h h' 2
  have h5 : u^5 ≤ u^2 := pow_le_pow_of_le_one h (by linarith) (by decide)
  nlinarith [sq_nonneg (u^2)]

/-- g''_8(x) ≤ -1/2 throughout [15/4,17/4]. -/
theorem curvature_margin {x : ℝ} (hx : 15/4 ≤ x) (hx' : x ≤ 17/4) :
    signedSum x 5 ≤ -60 := by
  by_cases h4 : x ≤ 4
  · have h := middle_bound (4-x) (by linarith) (by linarith)
    simp [signedSum,
      max_eq_left (show 0 ≤ x by linarith),
      max_eq_left (show 0 ≤ x-1 by linarith),
      max_eq_left (show 0 ≤ x-2 by linarith),
      max_eq_left (show 0 ≤ x-3 by linarith),
      max_eq_right (show x-4 ≤ 0 by linarith),
      max_eq_right (show x-5 ≤ 0 by linarith),
      max_eq_right (show x-6 ≤ 0 by linarith),
      max_eq_right (show x-7 ≤ 0 by linarith),
      max_eq_right (show x-8 ≤ 0 by linarith)]
    nlinarith
  · have h := middle_bound (x-4) (by linarith) (by linarith)
    simp [signedSum,
      max_eq_left (show 0 ≤ x by linarith),
      max_eq_left (show 0 ≤ x-1 by linarith),
      max_eq_left (show 0 ≤ x-2 by linarith),
      max_eq_left (show 0 ≤ x-3 by linarith),
      max_eq_left (show 0 ≤ x-4 by linarith),
      max_eq_right (show x-5 ≤ 0 by linarith),
      max_eq_right (show x-6 ≤ 0 by linarith),
      max_eq_right (show x-7 ≤ 0 by linarith),
      max_eq_right (show x-8 ≤ 0 by linarith)]
    nlinarith

end EightRowProfile
