import Analytic
import Mathlib.RingTheory.PowerSeries.Inverse

/-! The two rational generating functions in equations (4.4) and (5.2) of
Gray, Payne, Swisher and Watson, specialized to the critical modulus `2 * s`.
We work over real formal series so their coefficients use the same field as
the asymptotic statements. -/

namespace CriticalPerimeter

open PowerSeries
noncomputable section

private abbrev x : PowerSeries ℝ := PowerSeries.X

/-- Generating function for the difference-condition class, with s = d+1. -/
def gapSeries (s a : ℕ) : PowerSeries ℝ :=
  x ^ a * (1 - x - x ^ s)⁻¹

/-- Generating function for two residue classes modulo 2s. -/
def residueSeries (s u v : ℕ) : PowerSeries ℝ :=
  (x ^ u * (1 - x) + x ^ v) * (denominator s x)⁻¹

private theorem constant_den (s : ℕ) (hs : s ≠ 0) :
    constantCoeff ℝ (denominator s x) ≠ 0 := by
  simp [denominator, x, hs]

/-- Subtraction over a common denominator as an identity of formal series. -/
theorem series_difference (s a u v : ℕ) (hs : s ≠ 0) :
    gapSeries s a - residueSeries s u v =
      numerator s a u v x * (denominator s x)⁻¹ := by
  have hd := PowerSeries.inv_mul_cancel (denominator s x) (constant_den s hs)
  have hg : (1 - x - x ^ s)⁻¹ * (1 - x - x ^ s) = 1 :=
    PowerSeries.inv_mul_cancel _ (by simp [x, hs])
  have hf : denominator s x = (1-x-x^s) * (1-x+x^s) := by
    unfold denominator
    ring
  apply (PowerSeries.eq_mul_inv_iff_mul_eq (constant_den s hs)).mpr
  rw [sub_mul]
  have hl : residueSeries s u v * denominator s x = x ^ u * (1-x) + x ^ v := by
    unfold residueSeries
    rw [mul_assoc, hd, mul_one]
  have hh : gapSeries s a * denominator s x = x ^ a * (1-x+x^s) := by
    unfold gapSeries
    rw [hf, ← mul_assoc, mul_assoc (x ^ a) _ _, hg, mul_one]
  rw [hl, hh]
  unfold numerator
  ring

/-- With the aligned residue classes, the full formal series are equal. -/
theorem aligned_series (s a : ℕ) (hs : s ≠ 0) :
    gapSeries s a = residueSeries s a (a+s) := by
  apply sub_eq_zero.mp
  rw [series_difference s a a (a+s) hs]
  have h : numerator s a a (a+s) x = 0 := by
    unfold numerator
    rw [pow_add]
    ring
  rw [h, zero_mul]

/-- Equality holds coefficientwise for every perimeter, including zero. -/
theorem aligned_coefficient (s a n : ℕ) (hs : s ≠ 0) :
    coeff ℝ n (gapSeries s a) = coeff ℝ n (residueSeries s a (a+s)) :=
  congrArg (coeff ℝ n) (aligned_series s a hs)

end
end CriticalPerimeter
