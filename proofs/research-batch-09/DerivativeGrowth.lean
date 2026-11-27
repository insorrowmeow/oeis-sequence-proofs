import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace DerivativeGrowth

-- t = x(1-x)p'/p; c = 2x-1; z = (x(1-x))² Σ 1/(x-r)².
theorem sign_of_gap (c t z : ℝ) (hc : 1/2 < c) (hp : 0 < t)
    (ht : t < 1) (hz : 0 ≤ z) (h : 0 ≤ (1-t)^2-c*t-z) :
    0 < c*t+z-t^2 := by
  have hhalf : t < 1/2 := by
    by_contra! hn
    have hprod := mul_pos (sub_pos.mpr hc) hp
    have hbound := mul_nonneg (sub_nonneg.mpr hn) (sub_nonneg.mpr ht.le)
    nlinarith
  nlinarith [mul_pos (sub_pos.mpr (lt_trans hhalf hc)) hp]

end DerivativeGrowth
